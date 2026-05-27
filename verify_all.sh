#!/usr/bin/env bash
# verify_all.sh — Verificación rápida post-reinicio
# Ubicación: ~/proyectos/pos/verify_all.sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "========================================"
echo "  VERIFICACIÓN POST-REINICIO"
echo "  $(date)"
echo "========================================"

# 1. Docker daemon
echo ""
echo "--- Docker daemon ---"
if docker info >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Docker está corriendo${NC}"
else
    echo -e "${RED}❌ Docker NO está corriendo${NC}"
    echo "   Intenta: sudo systemctl start docker"
    exit 1
fi

# 2. Contenedores
echo ""
echo "--- Contenedores ---"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# 3. Verificar contenedores
RUNNING=$(docker ps --filter "status=running" --format "{{.Names}}" | wc -l)
if [ "$RUNNING" -eq 10 ]; then
    echo -e "${GREEN}✅ Los 10 contenedores están corriendo${NC}"
else
    echo -e "${YELLOW}⚠️  Solo $RUNNING/10 contenedores corriendo${NC}"
    echo "   Ejecutando docker compose up..."

    # POS Farmacia
    cd ~/proyectos/pos && docker compose up -d --remove-orphans 2>/dev/null

    # Billar AI
    cd ~/proyectos/billar && docker compose up -d --remove-orphans 2>/dev/null

    # POS Ferreteria (con recuperación si el DB falla por montaje)
    cd ~/proyectos/pos-ferreteria
    if ! docker compose up -d --remove-orphans 2>/tmp/verify-ferreteria.log; then
        if grep -q "not a directory" /tmp/verify-ferreteria.log 2>/dev/null; then
            echo -e "${YELLOW}   Reparando contenedor DB de Ferretería...${NC}"
            docker rm -f pos_ferreteria_db 2>/dev/null
            docker compose up -d --remove-orphans 2>&1
        fi
    fi
    docker restart pos_ferreteria_api pos_ferreteria_auth_me 2>/dev/null
    sleep 8
fi

# 4. Pruebas HTTP
echo ""
echo "--- Pruebas HTTP ---"
test_endpoint() {
    local name=$1 url=$2
    local code=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "$url" 2>/dev/null || echo "000")
    if [ "${code:0:1}" = "2" ] || [ "$code" = "302" ] || [ "$code" = "301" ]; then
        echo -e "${GREEN}✅ $name — HTTP $code${NC}"
    else
        echo -e "${RED}❌ $name — HTTP $code${NC}"
    fi
}
test_endpoint "Billar AI" "http://localhost:8080/"
test_endpoint "POS Farmacia" "http://localhost:8081/"
test_endpoint "POS Ferreteria" "http://localhost:8082/"
test_endpoint "Farmacia API" "http://localhost:4000/api/health"

# 5. Login POS Farmacia
echo ""
echo "--- API POS Farmacia ---"
TOKEN=$(curl -s -X POST http://localhost:4000/api/auth/login \
    -H "Content-Type: application/json" \
    -d '{"username":"admin","password":"admin123"}' | python3 -c "import sys,json;d=json.loads(sys.stdin.read());print(d.get('token',''))" 2>/dev/null)
if [ -n "$TOKEN" ]; then
    echo -e "${GREEN}✅ Login OK${NC}"
    ALERTS=$(curl -s http://localhost:4000/api/alerts -H "Authorization: Bearer $TOKEN" | python3 -c "import sys,json;d=json.loads(sys.stdin.read());c=d.get('counts',{});print(f'Stock bajo: {c.get(\"low_stock\",0)}, Por vencer: {c.get(\"expiry\",0)}')")
    echo "   Alertas: $ALERTS"
else
    echo -e "${RED}❌ Login Farmacia falló${NC}"
fi

# 6. Login POS Ferreteria
echo ""
echo "--- API POS Ferreteria ---"
FERR_TOKEN=$(curl -s -X POST http://localhost:5002/api/auth/login \
    -H "Content-Type: application/json" \
    -d '{"username":"admin","password":"admin123","database":"hardware_store"}' | python3 -c "import sys,json;d=json.loads(sys.stdin.read());print(d.get('token',''))" 2>/dev/null)
if [ -n "$FERR_TOKEN" ]; then
    echo -e "${GREEN}✅ Login OK${NC}"
else
    echo -e "${RED}❌ Login Ferreteria falló${NC}"
fi

echo ""
echo "========================================"
echo "  VERIFICACIÓN COMPLETADA"
echo "========================================"
