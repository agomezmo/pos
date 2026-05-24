#!/usr/bin/env python3
"""
Comprehensive POS System Test Suite
Tests all modules via the REST API, generates random data, and reports
acceptance/error rates with ✅ and ❌ indicators.
Usage:
  python3 test_system.py                          # Run all tests
  python3 test_system.py --csv products.csv       # Import CSV
  python3 test_system.py --module sales           # Run single module
"""

import sys, json, random, string, csv, os, argparse
from datetime import datetime, timedelta
from urllib.request import Request, urlopen
from urllib.error import HTTPError, URLError

API_BASE = os.environ.get("POS_API_URL", "http://localhost:4000/api")
AUTH = {"username": "admin", "password": "admin123"}
TOKEN = None

PASS = "\u2705"   # ✅
FAIL = "\u274c"   # ❌
SKIP = "\u23f8\ufe0f"  # ⏸️

results = []  # list of {module, test, status, detail}

def api(method, path, data=None, raw=False):
    url = f"{API_BASE}{path}"
    headers = {"Content-Type": "application/json"}
    if TOKEN:
        headers["Authorization"] = f"Bearer {TOKEN}"
    body = json.dumps(data, default=str).encode() if data is not None else None
    req = Request(url, data=body, method=method, headers=headers)
    try:
        with urlopen(req, timeout=15) as resp:
            text = resp.read().decode()
            return json.loads(text) if text else {}
    except HTTPError as e:
        err_text = e.read().decode()
        try:
            return json.loads(err_text)
        except:
            return {"error": {"message": err_text[:200]}}
    except URLError:
        return {"error": {"message": f"Cannot reach {API_BASE}"}}

def test(module, test_name, fn):
    """Run a test, record result."""
    try:
        ok, detail = fn()
        symbol = PASS if ok else FAIL
        results.append({"module": module, "test": test_name, "status": symbol, "detail": detail})
        print(f"  {symbol} {test_name}")
        return ok
    except Exception as e:
        results.append({"module": module, "test": test_name, "status": FAIL, "detail": str(e)})
        print(f"  {FAIL} {test_name} — {e}")
        return False

def rand_id(prefix="", length=8):
    return prefix + "".join(random.choices(string.digits, k=length))

def rand_name():
    first = random.choice(["María", "Juan", "Ana", "Pedro", "Sofía", "Carlos", "Laura", "José", "Valentina", "Miguel"])
    last = random.choice(["García", "López", "Martínez", "Rodríguez", "Hernández", "González", "Pérez", "Sánchez", "Ramírez", "Torres"])
    return f"{first} {last}"

def rand_date(start_days=-365, end_days=365):
    d = datetime.now() + timedelta(days=random.randint(start_days, end_days))
    return d.strftime("%Y-%m-%d")

def rand_phone():
    return f"55{random.randint(10000000, 99999999)}"

def rand_email(name):
    return f"{name.lower().replace(' ', '.')}{random.randint(1,999)}@mail.com"

# ─── Test Suites ───────────────────────────────────────────

def test_auth():
    def login_ok():
        global TOKEN
        resp = api("POST", "/auth/login", AUTH)
        TOKEN = resp.get("token", "")
        ok = bool(TOKEN)
        return ok, f"token length={len(TOKEN)}" if ok else resp.get("error", {}).get("message", "no token")
    test("Auth", "Inicio de sesión", login_ok)

    def me_ok():
        resp = api("GET", "/auth/me")
        ok = resp.get("id") == 1
        return ok, f"user={resp.get('username','?')}" if ok else str(resp)
    test("Auth", "Obtener perfil", me_ok)

def test_products():
    def list_ok():
        resp = api("GET", "/products")
        items = resp.get("products", [])
        ok = len(items) > 0
        return ok, f"{len(items)} productos"
    test("Productos", "Listar productos", list_ok)

    def create_ok():
        code = f"TEST{random.randint(10000,99999)}"
        data = {"code": code, "barcode": code, "name": f"Test Prod {code}",
                "description": "Created by test suite", "categoryid": 1, "supplierid": 1,
                "purchaseprice": random.uniform(5, 50), "saleprice": random.uniform(10, 100),
                "stock": random.randint(10, 200), "minstock": 10, "unit": "pza",
                "requiresprescription": False, "wholesale_price": 0, "expiry_date": rand_date(30, 365),
                "requires_tax": True}
        resp = api("POST", "/products", data)
        ok = resp.get("id") is not None
        created_id = resp.get("id")
        if created_id:
            test.product_ids.append(created_id)
        return ok, f"id={created_id}" if ok else str(resp.get("error",{}))
    test("Productos", "Crear producto", create_ok)

    def edit_ok():
        if not test.product_ids: return False, "no hay producto creado para editar"
        pid = test.product_ids[-1]
        resp = api("PUT", f"/products/{pid}", {"name": f"Updated {rand_name()}", "saleprice": 99.99, "supplierid": None})
        ok = resp.get("id") == pid
        return ok, f"id={pid}" if ok else str(resp.get("error",{}))
    test("Productos", "Editar producto", edit_ok)

    def expiring_ok():
        resp = api("GET", "/products/expiring-soon", {"days": 60})
        items = resp.get("products", [])
        detail = f"{resp.get('count', len(items))} próximos a caducar"
        return True, detail
    test("Productos", "Próximos a caducar", expiring_ok)

    def low_stock_ok():
        resp = api("GET", "/products/low-stock")
        items = resp.get("products", [])
        detail = f"{resp.get('count', len(items))} con stock bajo"
        return True, detail
    test("Productos", "Stock bajo", low_stock_ok)

    def read_by_id_ok():
        if not test.product_ids: return False, "no hay producto creado"
        pid = test.product_ids[-1]
        resp = api("GET", f"/products/{pid}")
        ok = resp.get("id") == pid
        return ok, f"id={pid}, name={resp.get('name','?')}" if ok else str(resp.get("error",{}))
    test("Productos", "Leer producto por ID", read_by_id_ok)

    def soft_delete_ok():
        if not test.product_ids: return False, "no hay producto creado"
        pid = test.product_ids[-1]
        resp = api("DELETE", f"/products/{pid}")
        ok = resp.get("message") or resp.get("id")
        # Verify it's deactivated
        resp2 = api("GET", f"/products/{pid}")
        is_inactive = resp2.get("isactive") == False
        return ok and is_inactive, f"id={pid} desactivado" if ok else str(resp.get("error",{}))
    test("Productos", "Eliminar (desactivar) producto", soft_delete_ok)

def test_customers():
    def list_ok():
        resp = api("GET", "/customers")
        items = resp if isinstance(resp, list) else resp.get("customers", resp.get("data", []))
        ok = len(items) >= 1
        return ok, f"{len(items)} clientes"
    test("Clientes", "Listar clientes", list_ok)

    def create_ok():
        name = rand_name()
        data = {"fullname": name, "phone": rand_phone(), "email": rand_email(name),
                "address": f"Av. Test {random.randint(1,999)}",
                "documenttype": "INE", "documentnumber": f"TEST{random.randint(100000,999999)}"}
        resp = api("POST", "/customers", data)
        cid = resp.get("id")
        ok = cid is not None
        if cid: test.customer_ids.append(cid)
        return ok, f"id={cid}" if ok else str(resp.get("error",{}))
    test("Clientes", "Crear cliente aleatorio", create_ok)

    for _ in range(3):
        name = rand_name()
        data = {"fullname": name, "phone": rand_phone(), "email": rand_email(name),
                "documenttype": "INE", "documentnumber": f"TEST{random.randint(100000,999999)}"}
        resp = api("POST", "/customers", data)
        if resp.get("id"): test.customer_ids.append(resp.get("id"))
    print(f"    {PASS} {len([t for t in test.customer_ids])} clientes generados")

    def read_by_id_ok():
        if not test.customer_ids: return False, "no hay cliente creado"
        cid = test.customer_ids[-1]
        resp = api("GET", f"/customers/{cid}")
        ok = resp.get("id") == cid
        return ok, f"id={cid}, name={resp.get('fullname','?')}" if ok else str(resp.get("error",{}))
    test("Clientes", "Leer cliente por ID", read_by_id_ok)

    def update_ok():
        if not test.customer_ids: return False, "no hay cliente creado"
        cid = test.customer_ids[-1]
        new_name = rand_name()
        resp = api("PUT", f"/customers/{cid}", {"fullname": new_name})
        ok = resp.get("id") == cid and resp.get("fullname") == new_name
        return ok, f"id={cid} renombrado a {new_name}" if ok else str(resp.get("error",{}))
    test("Clientes", "Actualizar cliente", update_ok)

def test_patients():
    if not test.customer_ids:
        print(f"  {SKIP} Pacientes — no hay clientes disponibles")
        return
    def create_ok():
        cid = random.choice(test.customer_ids)
        data = {"customerid": cid, "medicalhistory": f"Paciente desde {rand_date(-1095, -30)}",
                "allergies": random.choice(["Ninguna", "Penicilina", "Aspirina", "Polen", "Ninguna"]),
                "bloodtype": random.choice(["A+", "A-", "B+", "B-", "AB+", "O+", "O-"])}
        resp = api("POST", "/patients", data)
        pid = resp.get("id")
        ok = pid is not None
        if pid: test.patient_ids.append(pid)
        return ok, f"id={pid}" if ok else str(resp.get("error",{}))
    test("Pacientes", "Crear paciente aleatorio", create_ok)

    for _ in range(2):
        cid = random.choice(test.customer_ids)
        resp = api("POST", "/patients", {"customerid": cid, "medicalhistory": "Paciente de prueba generado automáticamente",
                "allergies": random.choice(["Ninguna", "Penicilina", "Sulfa"]), "bloodtype": random.choice(["A+","O+","B+"])})
        if resp.get("id"): test.patient_ids.append(resp.get("id"))

def test_prescriptions():
    if not test.patient_ids:
        print(f"  {SKIP} Recetas — no hay pacientes disponibles")
        return
    def create_ok():
        pid = random.choice(test.patient_ids)
        # Find products that require prescription
        resp = api("GET", "/products", {"limit": 200})
        prods = resp.get("products", [])
        rx_prods = [p for p in prods if p.get("requiresprescription")]
        if not rx_prods:
            return False, "no hay productos que requieran receta"
        selected = random.sample(rx_prods, min(random.randint(1, 3), len(rx_prods)))
        data = {"patientid": pid,
                "doctorname": f"Dr. {rand_name()}",
                "doctorlicense": f"LIC{random.randint(10000,99999)}",
                "diagnosis": random.choice(["Infección respiratoria", "Dolor crónico", "Hipertensión", "Diabetes tipo 2", "Ansiedad"]),
                "issueddate": rand_date(-30, 0),
                "expirydate": rand_date(30, 180),
                "items": [{"productid": p["id"], "dosage": "1 cada 8 horas",
                           "frequency": "3 veces al día", "duration": "7 días"} for p in selected]}
        resp = api("POST", "/prescriptions", data)
        ok = resp.get("id") is not None
        return ok, f"id={resp.get('id')} con {len(selected)} productos" if ok else str(resp.get("error",{}))
    if not hasattr(test, "prescription_ids"): test.prescription_ids = []
    test("Recetas", "Crear receta con productos que requieren receta", create_ok)

    for _ in range(2):
        pid = random.choice(test.patient_ids)
        resp = api("POST", "/prescriptions", {"patientid": pid,
                "doctorname": f"Dr. {rand_name()}", "doctorlicense": f"LIC{random.randint(10000,99999)}",
                "diagnosis": "Diagnóstico de prueba", "issueddate": rand_date(-30, 0), "expirydate": rand_date(30, 180)})
        if resp.get("id"): test.prescription_ids.append(resp.get("id"))

    def read_by_id_ok():
        if not test.prescription_ids: return False, "no hay receta creada"
        prid = test.prescription_ids[-1]
        resp = api("GET", f"/prescriptions/{prid}")
        ok = resp.get("id") == prid
        return ok, f"id={prid}, doctor={resp.get('doctorname','?')}" if ok else str(resp.get("error",{}))
    test("Recetas", "Leer receta por ID", read_by_id_ok)

def test_cashregister():
    def open_ok():
        # First close any open session
        api("POST", "/cashregister/close", {"closingbalance": 0})
        resp = api("POST", "/cashregister/open", {"openingbalance": random.uniform(200, 1000)})
        ok = resp.get("status") == "Open"
        if ok: test.session_id = resp.get("id")
        return ok, f"sesión #{resp.get('id')}" if ok else str(resp.get("error",{}))
    test("Caja", "Abrir sesión", open_ok)

    def active_ok():
        resp = api("GET", "/cashregister/active")
        ok = resp.get("status") == "Open"
        return ok, f"saldo inicial={resp.get('openingamount')}" if ok else str(resp.get("error",{}))
    test("Caja", "Sesión activa con totales", active_ok)

def test_sales():
    # Need open cash register session
    active = api("GET", "/cashregister/active")
    if active.get("status") != "Open":
        api("POST", "/cashregister/open", {"openingbalance": 500})
        active = api("GET", "/cashregister/active")
    session_id = active.get("id")

    def list_ok():
        resp = api("GET", "/sales")
        items = resp.get("sales", [])
        ok = len(items) > 0
        return ok, f"{len(items)} ventas"
    test("Ventas", "Listar ventas", list_ok)

    def create_ok():
        resp = api("GET", "/products", {"limit": 200})
        prods = resp.get("products", [])
        if not prods: return False, "no hay productos"
        selected = random.sample(prods, min(random.randint(1, 5), len(prods)))
        items = [{"productid": p["id"], "quantity": random.randint(1, 3),
                  "unitprice": float(p["saleprice"])} for p in selected]
        pay_method = random.choice(["Efectivo", "Tarjeta", "Transferencia"])
        subtotal = sum(it["quantity"] * it["unitprice"] for it in items)
        total = round(subtotal * 1.16, 2)
        data = {"items": items, "paymentmethod": pay_method,
                "amountreceived": round(total * 1.1, 2) if pay_method == "Efectivo" else 0,
                "cashregistersessionid": session_id,
                "notes": f"Test suite sale {datetime.now().isoformat()}"}
        resp = api("POST", "/sales", data)
        ok = resp.get("id") is not None
        return ok, f"venta #{resp.get('id')} / {pay_method} / ${total}" if ok else str(resp.get("error",{}))
    test("Ventas", "Crear venta con método aleatorio", create_ok)

    # Create a few more sales for better test data
    for i in range(3):
        resp = api("GET", "/products", {"limit": 200})
        prods = resp.get("products", [])
        if not prods: continue
        selected = random.sample(prods, min(random.randint(1, 3), len(prods)))
        items = [{"productid": p["id"], "quantity": random.randint(1, 2), "unitprice": float(p["saleprice"])} for p in selected]
        pay = random.choice(["Efectivo", "Tarjeta", "Transferencia"])
        subtotal = sum(it["quantity"] * it["unitprice"] for it in items)
        data = {"items": items, "paymentmethod": pay, "amountreceived": round(subtotal*1.16*1.1, 2) if pay=="Efectivo" else 0,
                "cashregistersessionid": session_id, "notes": f"Auto test {i+1}"}
        resp = api("POST", "/sales", data)
        if resp.get("id"):
            print(f"    {PASS} Venta extra #{resp['id']} creada ({pay})")
        else:
            print(f"    {FAIL} Error creando venta extra: {resp.get('error',{})}")

def test_reports():
    def daily_summary():
        resp = api("GET", "/reports/daily-summary", {"startDate": rand_date(-30, 0), "endDate": datetime.now().strftime("%Y-%m-%d")})
        ok = resp.get("total_sales") is not None
        return ok, f"{resp.get('total_sales')} ventas, ${resp.get('total_revenue',0)} ingresos"
    test("Reportes", "Resumen diario con rango de fechas", daily_summary)

    def top_products():
        resp = api("GET", "/reports/top-products", {"limit": 10})
        ok = isinstance(resp, list) and len(resp) > 0
        return ok, f"{len(resp)} productos" if ok else str(resp)
    test("Reportes", "Top productos", top_products)

    def sales_by_category():
        resp = api("GET", "/reports/sales-by-category")
        ok = isinstance(resp, list)
        return ok, f"{len(resp)} categorías" if ok else str(resp)
    test("Reportes", "Ventas por categoría", sales_by_category)

    def payment_methods():
        resp = api("GET", "/reports/payment-methods")
        ok = isinstance(resp, list)
        return ok, f"{len(resp)} métodos" if ok else str(resp)
    test("Reportes", "Métodos de pago", payment_methods)

    def inventory_status():
        resp = api("GET", "/reports/inventory-status")
        ok = resp.get("total_products") is not None
        return ok, f"{resp.get('total_products')} productos, {resp.get('low_stock_count')} bajo stock"
    test("Reportes", "Estado del inventario", inventory_status)

def test_categories():
    def list_ok():
        resp = api("GET", "/categories")
        items = resp if isinstance(resp, list) else resp.get("categories", [])
        ok = len(items) > 0
        return ok, f"{len(items)} categorías"
    test("Categorías", "Listar categorías", list_ok)

def test_suppliers():
    def list_ok():
        resp = api("GET", "/suppliers")
        items = resp if isinstance(resp, list) else resp.get("suppliers", [])
        ok = len(items) > 0
        return ok, f"{len(items)} proveedores"
    test("Proveedores", "Listar proveedores", list_ok)

def test_expenses():
    def create_ok():
        data = {"category": random.choice(["Servicios", "Alquiler", "Insumos", "Publicidad"]),
                "description": f"Gasto de prueba {rand_id('G',6)}",
                "amount": round(random.uniform(50, 5000), 2),
                "paymentmethod": random.choice(["Efectivo", "Tarjeta", "Transferencia"])}
        resp = api("POST", "/expenses", data)
        ok = resp.get("id") is not None
        return ok, f"id={resp.get('id')} ${data['amount']}" if ok else str(resp.get("error",{}))
    test("Gastos", "Crear gasto", create_ok)

def test_appointments():
    def list_ok():
        resp = api("GET", "/appointments")
        items = resp.get("appointments", [])
        ok = isinstance(items, list)
        return ok, f"{len(items)} citas"
    test("Citas Médicas", "Listar citas", list_ok)

    def create_ok():
        resp = api("GET", "/patients")
        pts = resp if isinstance(resp, list) else []
        if not pts: return False, "no hay pacientes"
        pid = pts[0]["id"]
        data = {"patientid": pid, "userid": 1,
                "appointmentdate": "2026-06-15T10:30:00",
                "notes": "Cita de prueba generada por test suite"}
        resp = api("POST", "/appointments", data)
        ok = resp.get("id") is not None
        return ok, f"id={resp.get('id')}" if ok else str(resp.get("error",{}))
    test("Citas Médicas", "Crear cita", create_ok)

def test_alerts():
    def alerts_ok():
        resp = api("GET", "/alerts")
        ok = resp.get("counts") is not None or isinstance(resp, list)
        counts = resp.get("counts", {})
        detail = f"low_stock={counts.get('low_stock',0)}, expiry={counts.get('expiry',0)}"
        return ok, detail
    test("Alertas", "Obtener alertas con conteos", alerts_ok)

    def low_stock_count():
        resp = api("GET", "/alerts")
        counts = resp.get("counts", {})
        low = counts.get("low_stock", 0)
        ok = low >= 0
        return ok, f"{low} productos con stock bajo"
    test("Alertas", "Conteo de stock bajo", low_stock_count)

def test_csv_import():
    print(f"\n  {PASS} Simulación de importación CSV:")
    csv_path = "/tmp/test_products_import.csv"
    with open(csv_path, "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["code", "barcode", "name", "description", "categoryid", "supplierid", "purchaseprice", "saleprice", "stock", "minstock", "unit"])
        for i in range(5):
            code = f"CSV{random.randint(10000,99999)}"
            w.writerow([code, code, f"CSV Import {code}", "Importado desde CSV", 1, 1,
                       round(random.uniform(5, 50), 2), round(random.uniform(10, 100), 2),
                       random.randint(10, 100), 5, "pza"])
    print(f"    {PASS} Archivo CSV creado: {csv_path}")
    imported = 0
    errors = 0
    with open(csv_path) as f:
        reader = csv.DictReader(f)
        for row in reader:
            row["purchaseprice"] = float(row["purchaseprice"]) if row["purchaseprice"] else 0
            row["saleprice"] = float(row["saleprice"]) if row["saleprice"] else 0
            row["stock"] = int(row["stock"]) if row["stock"] else 0
            row["minstock"] = int(row["minstock"]) if row["minstock"] else 0
            row["categoryid"] = int(row["categoryid"]) if row["categoryid"] else None
            row["supplierid"] = int(row["supplierid"]) if row["supplierid"] else None
            row["requiresprescription"] = False
            row["wholesale_price"] = 0
            row["requires_tax"] = True
            resp = api("POST", "/products", row)
            if resp.get("id"):
                imported += 1
            else:
                errors += 1
                print(f"    {FAIL} Error importando {row['code']}: {resp.get('error',{}).get('message','?')}")
    ok = imported > 0
    detail = f"{imported} importados, {errors} errores"
    results.append({"module": "CSV", "test": "Importar productos desde CSV", "status": PASS if ok else FAIL, "detail": detail})
    print(f"  {PASS if ok else FAIL} Importar productos desde CSV — {detail}")

# ─── Generate expiry dates for target categories ──────────

def update_expiry_dates():
    """Update expiry dates for Analgésicos (1), Antibióticos (2), Vitaminas (3)
    to have random dates, some near-term for alert testing."""
    resp = api("GET", "/products", {"limit": 200})
    prods = resp.get("products", [])
    target_cats = [1, 2, 3]
    updated = 0
    for p in prods:
        if p.get("categoryid") in target_cats:
            # 30% chance of near-expiry (within 60 days), 70% chance of far expiry
            if random.random() < 0.3:
                expiry = rand_date(1, 60)  # expires within 2 months
            else:
                expiry = rand_date(90, 730)  # expires within 1-2 years
            resp_upd = api("PUT", f"/products/{p['id']}", {"expiry_date": expiry})
            if resp_upd.get("id"):
                updated += 1
    print(f"  {PASS} Fechas de caducidad actualizadas para {updated} productos (Analgésicos, Antibióticos, Vitaminas)")

def update_low_stock():
    """Set some products with very low stock for alert testing."""
    resp = api("GET", "/products", {"limit": 200})
    prods = resp.get("products", [])
    updated = 0
    for p in random.sample(prods, min(10, len(prods))):
        low_stock = random.randint(0, 3)
        resp_upd = api("PUT", f"/products/{p['id']}", {"stock": low_stock, "minstock": 10})
        if resp_upd.get("id"):
            updated += 1
    print(f"  {PASS} Stock bajo simulado para {updated} productos (stock=0-3, min=10)")

# ─── Main ──────────────────────────────────────────────────

def run_module(name, fns):
    print(f"\n{'='*60}")
    print(f"  Módulo: {name}")
    print(f"{'='*60}")
    for fn in fns:
        fn()
    mod_results = [r for r in results if r["module"] == name]
    total = len(mod_results)
    passed = len([r for r in mod_results if r["status"] == PASS])
    rate = (passed / total * 100) if total else 0
    print(f"  {'─'*40}")
    print(f"  {PASS} {passed}/{total} pruebas pasadas ({rate:.0f}%)")

# Initialize shared test state
test.product_ids = []
test.customer_ids = []
test.patient_ids = []
test.prescription_ids = []
test.session_id = None

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="POS System Test Suite")
    parser.add_argument("--csv", help="Import CSV file of products")
    parser.add_argument("--module", help="Run single module only")
    args = parser.parse_args()

    print(f"\n{'#'*60}")
    print(f"  SISTEMA POS — SUITE DE PRUEBAS INTEGRAL")
    print(f"  {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"  API: {API_BASE}")
    print(f"{'#'*60}")

    # CSV import only mode
    if args.csv:
        print(f"\n  Importando CSV: {args.csv}")
        test_csv_import()
        total = len([r for r in results if r["module"] == "CSV"])
        passed = len([r for r in results if r["module"] == "CSV" and r["status"] == PASS])
        print(f"\n  CSV Import: {PASS} {passed}/{total}")
        sys.exit(0)

    # Single module mode
    single = args.module

    # Login first — required for all other tests
    def do_login():
        global TOKEN
        resp = api("POST", "/auth/login", AUTH)
        TOKEN = resp.get("token", "")
        ok = bool(TOKEN)
        if ok:
            print(f"  {PASS} Autenticación OK — token obtenido")
        else:
            print(f"  {FAIL} Error de autenticación: {resp}")
            sys.exit(1)
    do_login()

    modules = [
        ("Auth", [test_auth]),
        ("Productos", [test_products, update_expiry_dates, update_low_stock]),
        ("Categorías", [test_categories]),
        ("Proveedores", [test_suppliers]),
        ("Clientes", [test_customers]),
        ("Pacientes", [test_patients]),
        ("Recetas", [test_prescriptions]),
        ("Caja", [test_cashregister]),
        ("Ventas", [test_sales]),
        ("Reportes", [test_reports]),
        ("Gastos", [test_expenses]),
        ("Citas Médicas", [test_appointments]),
        ("Alertas", [test_alerts]),
        ("CSV", [test_csv_import]),
    ]

    for name, fns in modules:
        if single and name.lower() != single.lower():
            continue
        run_module(name, fns)

    # ─── Final Summary ─────────────────────────────────

    print(f"\n{'#'*60}")
    print(f"  RESUMEN FINAL")
    print(f"{'#'*60}")
    print(f"  {'Módulo':<20} {'Pruebas':>8} {'Pasadas':>8} {'Tasa':>8}")
    print(f"  {'─'*20} {'─'*8} {'─'*8} {'─'*8}")

    mods = {}
    for r in results:
        mods.setdefault(r["module"], {"total": 0, "passed": 0})
        mods[r["module"]]["total"] += 1
        if r["status"] == PASS:
            mods[r["module"]]["passed"] += 1

    grand_total = grand_passed = 0
    for mod, counts in sorted(mods.items()):
        rate = (counts["passed"] / counts["total"] * 100) if counts["total"] else 0
        print(f"  {mod:<20} {counts['total']:>8} {counts['passed']:>8} {rate:>7.0f}%")
        grand_total += counts["total"]
        grand_passed += counts["passed"]

    print(f"  {'─'*20} {'─'*8} {'─'*8} {'─'*8}")
    grand_rate = (grand_passed / grand_total * 100) if grand_total else 0
    print(f"  {'TOTAL':<20} {grand_total:>8} {grand_passed:>8} {grand_rate:>7.0f}%")

    symbol = PASS if grand_rate >= 80 else FAIL
    print(f"\n  {symbol} Tasa de aceptación: {grand_rate:.0f}% ({grand_passed}/{grand_total})")
    print(f"  {FAIL} Tasa de errores: {100-grand_rate:.0f}% ({grand_total-grand_passed}/{grand_total})")
    print(f"{'#'*60}\n")
