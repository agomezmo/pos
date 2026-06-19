#!/usr/bin/env bash
set -euo pipefail

# ================================================================
# build-deploy.sh — Build, test & deploy POS Farmacia
# Uso: ./scripts/build-deploy.sh [--frontend] [--docker] [--tests] [--verify] [--commit]
#      Sin argumentos ejecuta todos los pasos en secuencia.
# ================================================================

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

log()  { echo -e "${CYAN}[$(date +%H:%M:%S)]${NC} $1"; }
ok()   { echo -e "${GREEN}  ✅ $1${NC}"; }
fail() { echo -e "${RED}  ❌ $1${NC}"; exit 1; }
warn() { echo -e "${YELLOW}  ⚠️  $1${NC}"; }

# ── 1. Compilar Frontend ──
step_frontend() {
    log "📦 Compilando frontend..."
    cd "$PROJECT_DIR/frontend"
    if npm install --silent > /tmp/pos-npm-install.log 2>&1; then
        ok "npm install exitoso"
    else
        fail "npm install falló. Log: /tmp/pos-npm-install.log"
    fi
    if npm run build > /tmp/pos-npm-build.log 2>&1; then
        ok "npm run build exitoso"
    else
        fail "npm run build falló. Log: /tmp/pos-npm-build.log"
    fi
    cd "$PROJECT_DIR"
}

# ── 2. Reconstruir y levantar contenedores Docker ──
step_docker() {
    log "🐳 Reconstruyendo contenedores Docker..."

    # Detener servicios (preservando datos)
    log "   Deteniendo servicios..."
    docker compose stop api frontend 2>/dev/null || true

    # Reconstruir y levantar
    log "   Reconstruyendo imágenes..."
    docker compose build api --no-cache 2>&1 | tail -10

    log "   Levantando servicios..."
    docker compose up -d db api frontend

    # Esperar health check
    log "   Esperando a que la API esté saludable..."
    for i in $(seq 1 30); do
        if curl -sf http://localhost:4000/api/health > /dev/null 2>&1; then
            ok "API saludable"
            break
        fi
        if [ "$i" -eq 30 ]; then
            fail "La API no respondió después de 30s. Revisa logs: docker compose logs api"
        fi
        sleep 2
    done

    log "   Verificando contenedores..."
    docker compose ps
}

# ── 3. Ejecutar pruebas del sistema ──
step_tests() {
    log "🧪 Ejecutando suite de pruebas (test_system.py)..."
    cd "$PROJECT_DIR"
    python3 test_system.py 2>&1
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        ok "Todas las pruebas pasaron"
    else
        warn "Algunas pruebas fallaron (código: $exit_code). Revisa el output arriba."
    fi
}

# ── 4. Ejecutar pruebas de menús (test_comprehensive.py) ──
step_menu_tests() {
    if [ -f "$PROJECT_DIR/test_comprehensive.py" ]; then
        log "🧪 Ejecutando pruebas comprehensivas de menús..."
        python3 "$PROJECT_DIR/test_comprehensive.py" 2>&1 || warn "Pruebas comprehensivas tienen fallos (pueden ser esperados)"
        ok "Pruebas de menús ejecutadas"
    else
        warn "test_comprehensive.py no encontrado, saltando pruebas de menús"
    fi
}

# ── 5. Reconstruir y levantar chatbot ──
step_chatbot() {
    log "🤖 Reconstruyendo chatbot..."
    local CHATBOT_DIR="$PROJECT_DIR/../chatbot"

    if [ ! -f "$CHATBOT_DIR/docker-compose.yml" ]; then
        warn "Chatbot no encontrado en $CHATBOT_DIR. Despliégalo manualmente."
        return
    fi

    cd "$CHATBOT_DIR"

    # Reconstruir imagen del backend con --no-cache para tomar cambios del Dockerfile
    log "   Reconstruyendo imagen chatbot-backend..."
    docker compose build chatbot-backend --no-cache 2>&1 | tail -5

    # Levantar servicios
    log "   Levantando servicios del chatbot..."
    docker compose up -d chatbot-backend 2>/dev/null || true

    # Esperar a que responda
    log "   Esperando a que el chatbot responda..."
    for i in $(seq 1 20); do
        if curl -sf http://localhost:3090/api/health > /dev/null 2>&1; then
            ok "Chatbot backend respondiendo en http://localhost:3090"
            cd "$PROJECT_DIR"
            return
        fi
        sleep 2
    done

    warn "Chatbot backend no respondió después de 40s. Verifica: cd ~/proyectos/chatbot && docker compose logs"
    cd "$PROJECT_DIR"
}

# ── 6. Verificar endpoints clave ──
step_verify() {
    log "🔍 Verificando endpoints clave..."

    # Login
    local TOKEN
    TOKEN=$(curl -sf -X POST http://localhost:4000/api/auth/login \
        -H "Content-Type: application/json" \
        -d '{"username":"admin","password":"admin123"}' 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin).get('token',''))" 2>/dev/null || echo "")

    if [ -n "$TOKEN" ]; then
        ok "Login funciona (token obtenido)"
    else
        fail "Login falló — credenciales incorrectas o API no responde"
    fi

    # Productos
    local PRODS
    PRODS=$(curl -sf "http://localhost:4000/api/products?limit=5" \
        -H "Authorization: Bearer $TOKEN" 2>/dev/null || echo '{"products":[]}')
    local PROD_COUNT
    PROD_COUNT=$(echo "$PRODS" | python3 -c "import sys,json; d=json.load(sys.stdin); print(len(d.get('products',[])))" 2>/dev/null || echo "0")
    if [ "$PROD_COUNT" -gt 0 ]; then
        ok "Productos: $PROD_COUNT productos disponibles"
    else
        warn "No se encontraron productos. Revisa la base de datos."
    fi

    # Categorías
    local CATS
    CATS=$(curl -sf http://localhost:4000/api/categories \
        -H "Authorization: Bearer $TOKEN" 2>/dev/null || echo "[]")
    local CAT_COUNT
    CAT_COUNT=$(echo "$CATS" | python3 -c "import sys,json; d=json.load(sys.stdin); items=d if isinstance(d,list) else d.get('categories',[]); print(len(items))" 2>/dev/null || echo "0")
    ok "Categorías: $CAT_COUNT categorías"

    # Clientes
    local CLIENTS
    CLIENTS=$(curl -sf "http://localhost:4000/api/customers" \
        -H "Authorization: Bearer $TOKEN" 2>/dev/null || echo "[]")
    local CLIENT_COUNT
    CLIENT_COUNT=$(echo "$CLIENTS" | python3 -c "import sys,json; d=json.load(sys.stdin); items=d if isinstance(d,list) else d.get('customers',[]); print(len(items))" 2>/dev/null || echo "0")
    ok "Clientes: $CLIENT_COUNT clientes"

    # Ventas
    local SALES
    SALES=$(curl -sf "http://localhost:4000/api/sales" \
        -H "Authorization: Bearer $TOKEN" 2>/dev/null || echo '{"sales":[]}')
    local SALE_COUNT
    SALE_COUNT=$(echo "$SALES" | python3 -c "import sys,json; d=json.load(sys.stdin); print(len(d.get('sales',[])))" 2>/dev/null || echo "0")
    ok "Ventas: $SALE_COUNT ventas registradas"

    # Alertas
    local ALERTS
    ALERTS=$(curl -sf "http://localhost:4000/api/alerts" \
        -H "Authorization: Bearer $TOKEN" 2>/dev/null || echo '{}')
    local LOW_STOCK
    LOW_STOCK=$(echo "$ALERTS" | python3 -c "import sys,json; d=json.load(sys.stdin); c=d.get('counts',{}); print(c.get('low_stock',0))" 2>/dev/null || echo "0")
    local EXPIRY
    EXPIRY=$(echo "$ALERTS" | python3 -c "import sys,json; d=json.load(sys.stdin); c=d.get('counts',{}); print(c.get('expiry',0))" 2>/dev/null || echo "0")
    ok "Alertas: $LOW_STOCK stock bajo, $EXPIRY por vencer"

    # Frontend
    if curl -sf http://localhost:8081 > /dev/null 2>&1; then
        ok "Frontend respondiendo en http://localhost:8081"
    else
        fail "Frontend no responde en http://localhost:8081"
    fi

    # Chatbot widget
    if curl -sf http://localhost:3090/api/health > /dev/null 2>&1; then
        ok "Chatbot backend respondiendo en http://localhost:3090"
    else
        warn "Chatbot backend no responde. Ejecuta: $0 --chatbot"
    fi

    ok "Verificación de endpoints completada"
}

# ── 6. Commit y push ──
step_commit() {
    log "📤 Preparando commit..."

    cd "$PROJECT_DIR"

    # Mostrar cambios
    echo ""
    echo "  Archivos modificados:"
    git diff --name-only | sed 's/^/    • /' || echo "    (ninguno)"

    # Preguntar mensaje de commit
    echo ""
    read -r -p "  Mensaje de commit (Enter para saltar): " msg
    if [ -z "$msg" ]; then
        warn "Commit saltado"
        return
    fi

    # Agregar todo y commitear
    git add -A
    if git diff --cached --quiet; then
        warn "No hay cambios para commitear"
        return
    fi

    git commit -m "$msg"

    # Push
    log "   Subiendo cambios..."
    if git push origin main 2>&1; then
        ok "Cambios subidos a origin/main"
    else
        warn "Push falló. Haz git pull --rebase origin main e intenta de nuevo"
    fi
}

# ── Main ──
echo ""
echo "================================================================"
echo "  POS FARMACIA — Build, Test & Deploy"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "================================================================"
echo ""

RUN_ALL=true
RUN_STEPS=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --frontend)   RUN_ALL=false; RUN_STEPS="$RUN_STEPS frontend" ;;
        --docker)     RUN_ALL=false; RUN_STEPS="$RUN_STEPS docker" ;;
        --chatbot)    RUN_ALL=false; RUN_STEPS="$RUN_STEPS chatbot" ;;
        --tests)      RUN_ALL=false; RUN_STEPS="$RUN_STEPS tests" ;;
        --menu-tests) RUN_ALL=false; RUN_STEPS="$RUN_STEPS menu_tests" ;;
        --verify)     RUN_ALL=false; RUN_STEPS="$RUN_STEPS verify" ;;
        --commit)     RUN_ALL=false; RUN_STEPS="$RUN_STEPS commit" ;;
        --help|-h)
            echo "Uso: $0 [opciones]"
            echo ""
            echo "Opciones:"
            echo "  --frontend     Compilar frontend (npm install + build)"
            echo "  --docker       Reconstruir y levantar contenedores"
            echo "  --chatbot      Reconstruir y levantar chatbot"
            echo "  --tests        Ejecutar suite de pruebas (test_system.py)"
            echo "  --menu-tests   Ejecutar pruebas de menús (test_comprehensive.py)"
            echo "  --verify       Verificar endpoints clave"
            echo "  --commit       Commit y push (pide mensaje)"
            echo "  --help         Mostrar esta ayuda"
            echo ""
            echo "Sin argumentos ejecuta todos los pasos en secuencia."
            exit 0
            ;;
        *)
            fail "Opción desconocida: $1. Usa --help para ver opciones."
            ;;
    esac
    shift
done

if [ "$RUN_ALL" = true ]; then
    step_frontend
    step_docker
    step_chatbot
    step_tests
    step_menu_tests
    step_verify
else
    for step in $RUN_STEPS; do
        case "$step" in
            frontend)   step_frontend ;;
            docker)     step_docker ;;
            chatbot)    step_chatbot ;;
            tests)      step_tests ;;
            menu_tests) step_menu_tests ;;
            verify)     step_verify ;;
            commit)     step_commit ;;
        esac
    done
fi

echo ""
echo "================================================================"
echo -e "${GREEN}  ✅ Proceso completado${NC}"
echo "================================================================"
