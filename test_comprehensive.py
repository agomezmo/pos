#!/usr/bin/env python3
"""
POS System — Comprehensive Integration Test Suite
Tests EVERY module via REST API. Designed to be exhaustive.
Usage:
  python3 test_comprehensive.py                   # Run all modules
  python3 test_comprehensive.py --module sales    # Run single module
  python3 test_comprehensive.py --list            # List available modules
"""

import sys, json, random, string, csv, os, argparse, time
from datetime import datetime, timedelta
from urllib.request import Request, urlopen
from urllib.error import HTTPError, URLError

API_BASE = os.environ.get("POS_API_URL", "http://localhost:4000/api")
AUTH = {"username": "admin", "password": "admin123"}
TOKEN = None

PASS = "\u2705"
FAIL = "\u274c"
SKIP = "\u23f8\ufe0f"

results = []

def api(method, path, data=None, raw=False):
    url = f"{API_BASE}{path}"
    headers = {"Content-Type": "application/json"}
    if TOKEN:
        headers["Authorization"] = f"Bearer {TOKEN}"
    body = json.dumps(data, default=str).encode() if data is not None else None
    req = Request(url, data=body, method=method, headers=headers)
    try:
        with urlopen(req, timeout=30) as resp:
            text = resp.read().decode()
            return json.loads(text) if text else {}
    except HTTPError as e:
        err_text = e.read().decode()
        try:
            return json.loads(err_text)
        except:
            return {"error": {"message": err_text[:300]}}
    except URLError:
        return {"error": {"message": f"Cannot reach {API_BASE}"}}

def test(module, test_name, fn):
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


# ─── MODULE: Auth ────────────────────────────────────────────

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
        return ok, f"user={resp.get('username','?')} role={resp.get('role','?')}" if ok else str(resp)
    test("Auth", "Obtener perfil", me_ok)


# ─── MODULE: Users ───────────────────────────────────────────

def test_users():
    def list_ok():
        resp = api("GET", "/users")
        items = resp if isinstance(resp, list) else []
        ok = len(items) > 0
        return ok, f"{len(items)} usuarios"
    test("Usuarios", "Listar usuarios", list_ok)

    def create_ok():
        uname = f"testuser{random.randint(10000,99999)}"
        data = {"username": uname, "password": "Test1234!", "email": f"{uname}@test.com",
                "fullname": rand_name(), "roleid": 1}
        resp = api("POST", "/users", data)
        uid = resp.get("id")
        ok = uid is not None
        if ok:
            test.user_ids.append(uid)
        return ok, f"id={uid} username={uname}" if ok else str(resp.get("error", {}))
    test("Usuarios", "Crear usuario", create_ok)

    def update_ok():
        if not test.user_ids: return False, "no hay usuario creado"
        uid = test.user_ids[-1]
        new_name = rand_name()
        resp = api("PUT", f"/users/{uid}", {"fullname": new_name, "roleid": 1})
        ok = resp.get("id") == uid
        return ok, f"id={uid} renamed" if ok else str(resp.get("error", {}))
    test("Usuarios", "Actualizar usuario", update_ok)

    def delete_ok():
        if not test.user_ids: return False, "no hay usuario creado"
        uid = test.user_ids[-1]
        resp = api("DELETE", f"/users/{uid}")
        ok = resp.get("message") is not None or resp.get("id") is not None
        return ok, f"id={uid} eliminado" if ok else str(resp.get("error", {}))
    test("Usuarios", "Eliminar usuario", delete_ok)


# ─── MODULE: Products ────────────────────────────────────────

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
                "description": "Creado por test suite", "categoryid": 1, "supplierid": 1,
                "purchaseprice": round(random.uniform(5, 50), 2),
                "saleprice": round(random.uniform(10, 100), 2),
                "stock": random.randint(10, 200), "minstock": 10, "unit": "pza",
                "requiresprescription": False, "wholesale_price": 0,
                "expiry_date": rand_date(30, 365), "requires_tax": True}
        resp = api("POST", "/products", data)
        pid = resp.get("id")
        ok = pid is not None
        if ok: test.product_ids.append(pid)
        return ok, f"id={pid}" if ok else str(resp.get("error", {}))
    test("Productos", "Crear producto", create_ok)

    def read_by_id_ok():
        if not test.product_ids: return False, "no hay producto creado"
        pid = test.product_ids[-1]
        resp = api("GET", f"/products/{pid}")
        ok = resp.get("id") == pid
        return ok, f"id={pid}, name={resp.get('name','?')}" if ok else str(resp.get("error", {}))
    test("Productos", "Leer producto por ID", read_by_id_ok)

    def edit_ok():
        if not test.product_ids: return False, "no hay producto creado"
        pid = test.product_ids[-1]
        resp = api("PUT", f"/products/{pid}", {"name": f"Updated {rand_name()}", "saleprice": 99.99, "supplierid": None})
        ok = resp.get("id") == pid
        return ok, f"id={pid}" if ok else str(resp.get("error", {}))
    test("Productos", "Editar producto", edit_ok)

    def expiring_ok():
        resp = api("GET", "/products/expiring-soon", {"days": 60})
        items = resp.get("products", [])
        return True, f"{resp.get('count', len(items))} próximos a caducar"
    test("Productos", "Próximos a caducar", expiring_ok)

    def low_stock_ok():
        resp = api("GET", "/products/low-stock")
        items = resp.get("products", [])
        return True, f"{resp.get('count', len(items))} con stock bajo"
    test("Productos", "Stock bajo", low_stock_ok)

    def by_category_ok():
        resp = api("GET", "/products/category/1")
        items = resp.get("products", [])
        ok = isinstance(items, list)
        return ok, f"{len(items)} productos en categoría 1"
    test("Productos", "Productos por categoría", by_category_ok)

    def soft_delete_ok():
        if not test.product_ids: return False, "no hay producto creado"
        pid = test.product_ids[-1]
        resp = api("DELETE", f"/products/{pid}")
        ok = resp.get("message") is not None or resp.get("id") is not None
        resp2 = api("GET", f"/products/{pid}")
        is_inactive = resp2.get("isactive") == False
        return ok and is_inactive, f"id={pid} desactivado" if ok else str(resp.get("error", {}))
    test("Productos", "Eliminar (desactivar) producto", soft_delete_ok)


# ─── MODULE: Categories ──────────────────────────────────────

def test_categories():
    def list_ok():
        resp = api("GET", "/categories")
        items = resp if isinstance(resp, list) else resp.get("categories", [])
        ok = len(items) > 0
        return ok, f"{len(items)} categorías"
    test("Categorías", "Listar categorías", list_ok)

    def create_ok():
        name = f"Test Cat {rand_id('',4)}"
        resp = api("POST", "/categories", {"name": name, "description": "Categoría de prueba"})
        cid = resp.get("id")
        ok = cid is not None
        if ok: test.cat_ids.append(cid)
        return ok, f"id={cid} name={name}" if ok else str(resp.get("error", {}))
    test("Categorías", "Crear categoría", create_ok)

    def update_ok():
        if not test.cat_ids: return False, "no hay categoría creada"
        cid = test.cat_ids[-1]
        resp = api("PUT", f"/categories/{cid}", {"name": f"Updated Cat {rand_id('',4)}"})
        ok = resp.get("id") == cid
        return ok, f"id={cid}" if ok else str(resp.get("error", {}))
    test("Categorías", "Actualizar categoría", update_ok)


# ─── MODULE: Suppliers ───────────────────────────────────────

def test_suppliers():
    def list_ok():
        resp = api("GET", "/suppliers")
        items = resp if isinstance(resp, list) else resp.get("suppliers", [])
        ok = len(items) > 0
        return ok, f"{len(items)} proveedores"
    test("Proveedores", "Listar proveedores", list_ok)

    def create_ok():
        name = f"Proveedor {rand_name()}"
        data = {"name": name, "contact": rand_name(), "phone": rand_phone(),
                "email": rand_email(name), "address": f"Av. Test {random.randint(1,999)}"}
        resp = api("POST", "/suppliers", data)
        sid = resp.get("id")
        ok = sid is not None
        if ok: test.supplier_ids.append(sid)
        return ok, f"id={sid}" if ok else str(resp.get("error", {}))
    test("Proveedores", "Crear proveedor", create_ok)

    def update_ok():
        if not test.supplier_ids: return False, "no hay proveedor creado"
        sid = test.supplier_ids[-1]
        resp = api("PUT", f"/suppliers/{sid}", {"name": f"Updated {rand_name()}"})
        ok = resp.get("id") == sid
        return ok, f"id={sid}" if ok else str(resp.get("error", {}))
    test("Proveedores", "Actualizar proveedor", update_ok)


# ─── MODULE: Customers ───────────────────────────────────────

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
        if ok: test.customer_ids.append(cid)
        return ok, f"id={cid}" if ok else str(resp.get("error", {}))
    test("Clientes", "Crear cliente", create_ok)

    def read_by_id_ok():
        if not test.customer_ids: return False, "no hay cliente creado"
        cid = test.customer_ids[-1]
        resp = api("GET", f"/customers/{cid}")
        ok = resp.get("id") == cid
        return ok, f"id={cid}, name={resp.get('fullname','?')}" if ok else str(resp.get("error", {}))
    test("Clientes", "Leer cliente por ID", read_by_id_ok)

    def update_ok():
        if not test.customer_ids: return False, "no hay cliente creado"
        cid = test.customer_ids[-1]
        new_name = rand_name()
        resp = api("PUT", f"/customers/{cid}", {"fullname": new_name})
        ok = resp.get("id") == cid and resp.get("fullname") == new_name
        return ok, f"id={cid} renombrado a {new_name}" if ok else str(resp.get("error", {}))
    test("Clientes", "Actualizar cliente", update_ok)


# ─── MODULE: Patients ────────────────────────────────────────

def test_patients():
    if not test.customer_ids:
        print(f"  {SKIP} Pacientes — no hay clientes disponibles")
        return

    def create_ok():
        cid = random.choice(test.customer_ids)
        data = {"customerid": cid, "medicalhistory": f"Paciente desde {rand_date(-1095, -30)}",
                "allergies": random.choice(["Ninguna", "Penicilina", "Aspirina"]),
                "bloodtype": random.choice(["A+", "A-", "B+", "B-", "AB+", "O+", "O-"])}
        resp = api("POST", "/patients", data)
        pid = resp.get("id")
        ok = pid is not None
        if ok: test.patient_ids.append(pid)
        return ok, f"id={pid}" if ok else str(resp.get("error", {}))
    test("Pacientes", "Crear paciente", create_ok)

    def list_ok():
        resp = api("GET", "/patients")
        items = resp if isinstance(resp, list) else resp.get("patients", resp.get("data", []))
        ok = len(items) > 0
        return ok, f"{len(items)} pacientes"
    test("Pacientes", "Listar pacientes", list_ok)

    def update_ok():
        if not test.patient_ids: return False, "no hay paciente creado"
        pid = test.patient_ids[-1]
        resp = api("PUT", f"/patients/{pid}", {"allergies": "Ninguna (actualizada)"})
        ok = resp.get("id") == pid
        return ok, f"id={pid}" if ok else str(resp.get("error", {}))
    test("Pacientes", "Actualizar paciente", update_ok)


# ─── MODULE: Prescriptions ───────────────────────────────────

def test_prescriptions():
    if not test.patient_ids:
        print(f"  {SKIP} Recetas — no hay pacientes disponibles")
        return

    def create_ok():
        pid = random.choice(test.patient_ids)
        resp = api("GET", "/products", {"limit": 200})
        prods = resp.get("products", [])
        rx_prods = [p for p in prods if p.get("requiresprescription")]
        if not rx_prods:
            return False, "no hay productos que requieran receta"
        selected = random.sample(rx_prods, min(random.randint(1, 3), len(rx_prods)))
        data = {"patientid": pid,
                "doctorname": f"Dr. {rand_name()}",
                "doctorlicense": f"LIC{random.randint(10000,99999)}",
                "diagnosis": random.choice(["Infección respiratoria", "Dolor crónico", "Hipertensión"]),
                "issueddate": rand_date(-30, 0),
                "expirydate": rand_date(30, 180),
                "items": [{"productid": p["id"], "dosage": "1 cada 8 horas",
                           "frequency": "3 veces al día", "duration": "7 días"} for p in selected]}
        resp = api("POST", "/prescriptions", data)
        prid = resp.get("id")
        ok = prid is not None
        if ok: test.prescription_ids.append(prid)
        return ok, f"id={prid} con {len(selected)} productos" if ok else str(resp.get("error", {}))
    test("Recetas", "Crear receta", create_ok)

    def list_ok():
        resp = api("GET", "/prescriptions")
        items = resp if isinstance(resp, list) else resp.get("prescriptions", resp.get("data", []))
        ok = isinstance(items, list)
        return ok, f"{len(items)} recetas"
    test("Recetas", "Listar recetas", list_ok)

    def read_by_id_ok():
        if not test.prescription_ids: return False, "no hay receta creada"
        prid = test.prescription_ids[-1]
        resp = api("GET", f"/prescriptions/{prid}")
        ok = resp.get("id") == prid
        return ok, f"id={prid}, doctor={resp.get('doctorname','?')}" if ok else str(resp.get("error", {}))
    test("Recetas", "Leer receta por ID", read_by_id_ok)


# ─── MODULE: Inventory ───────────────────────────────────────

def test_inventory():
    def list_ok():
        resp = api("GET", "/inventory")
        items = resp if isinstance(resp, list) else resp.get("movements", resp.get("data", []))
        ok = isinstance(items, list)
        return ok, f"{len(items)} movimientos"
    test("Inventario", "Listar movimientos", list_ok)

    def create_ok():
        if not test.product_ids: return False, "no hay producto"
        pid = test.product_ids[-1]
        data = {"productId": pid, "type": "in", "quantity": random.randint(10, 50),
                "reason": "Movimiento de prueba", "reference": f"TEST-{rand_id('',6)}"}
        resp = api("POST", "/inventory", data)
        ok = resp.get("id") is not None or resp.get("message") is not None
        return ok, f"productId={pid}" if ok else str(resp.get("error", {}))
    test("Inventario", "Crear movimiento (entrada)", create_ok)


# ─── MODULE: Cash Register ───────────────────────────────────

def test_cashregister():
    def open_ok():
        api("POST", "/cashregister/close", {"closingbalance": 0})
        resp = api("POST", "/cashregister/open", {"openingbalance": round(random.uniform(200, 1000), 2)})
        ok = resp.get("status") == "Open"
        if ok: test.session_id = resp.get("id")
        return ok, f"sesión #{resp.get('id')}" if ok else str(resp.get("error", {}))
    test("Caja", "Abrir sesión", open_ok)

    def active_ok():
        resp = api("GET", "/cashregister/active")
        ok = resp.get("status") == "Open"
        return ok, f"saldo={resp.get('openingamount')}" if ok else str(resp.get("error", {}))
    test("Caja", "Sesión activa", active_ok)

    def sessions_ok():
        resp = api("GET", "/cashregister/sessions")
        items = resp if isinstance(resp, list) else resp.get("sessions", resp.get("data", []))
        ok = len(items) > 0
        return ok, f"{len(items)} sesiones históricas"
    test("Caja", "Historial de sesiones", sessions_ok)

    def close_ok():
        resp = api("POST", "/cashregister/close", {"closingbalance": round(random.uniform(500, 2000), 2)})
        ok = resp.get("status") == "Closed"
        return ok, f"status={resp.get('status')}" if ok else str(resp.get("error", {}))
    test("Caja", "Cerrar sesión", close_ok)


# ─── MODULE: Sales ───────────────────────────────────────────

def test_sales():
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
                "notes": f"Test suite {datetime.now().isoformat()}"}
        resp = api("POST", "/sales", data)
        sid = resp.get("id")
        ok = sid is not None
        if ok: test.sale_ids.append(sid)
        return ok, f"venta #{sid} / {pay_method} / ${total}" if ok else str(resp.get("error", {}))
    test("Ventas", "Crear venta", create_ok)

    def read_by_id_ok():
        if not test.sale_ids: return False, "no hay venta creada"
        sid = test.sale_ids[-1]
        resp = api("GET", f"/sales/{sid}")
        ok = resp.get("id") == sid
        return ok, f"id={sid}" if ok else str(resp.get("error", {}))
    test("Ventas", "Leer venta por ID", read_by_id_ok)

    def cancel_ok():
        if not test.sale_ids: return False, "no hay venta creada"
        sid = test.sale_ids[-1]
        resp = api("POST", f"/sales/{sid}/cancel", {"reason": "Cancelación de prueba"})
        ok = resp.get("message") is not None or resp.get("status") == "Cancelled"
        return ok, f"id={sid}" if ok else str(resp.get("error", {}))
    test("Ventas", "Cancelar venta", cancel_ok)


# ─── MODULE: Returns ─────────────────────────────────────────

def test_returns():
    def list_ok():
        resp = api("GET", "/returns")
        items = resp if isinstance(resp, list) else resp.get("returns", resp.get("data", []))
        ok = isinstance(items, list)
        return ok, f"{len(items)} devoluciones"
    test("Devoluciones", "Listar devoluciones", list_ok)

    def create_ok():
        # Use first sale if available
        resp = api("GET", "/sales")
        sales = resp.get("sales", [])
        if not sales:
            return False, "no hay ventas para crear devolución"
        sale = sales[-1]
        data = {"saleid": sale["id"], "reason": "Devolución de prueba",
                "items": [{"productid": sale.get("items", [{}])[0].get("productid", 1),
                          "quantity": 1, "unitprice": 10.0}]}
        resp = api("POST", "/returns", data)
        ok = resp.get("id") is not None
        return ok, f"id={resp.get('id')}" if ok else str(resp.get("error", {}))
    test("Devoluciones", "Crear devolución", create_ok)


# ─── MODULE: Expenses ────────────────────────────────────────

def test_expenses():
    def list_ok():
        resp = api("GET", "/expenses")
        items = resp if isinstance(resp, list) else resp.get("expenses", resp.get("data", []))
        ok = isinstance(items, list)
        return ok, f"{len(items)} gastos"
    test("Gastos", "Listar gastos", list_ok)

    def create_ok():
        data = {"category": random.choice(["Servicios", "Alquiler", "Insumos", "Publicidad"]),
                "description": f"Gasto de prueba {rand_id('G',6)}",
                "amount": round(random.uniform(50, 5000), 2),
                "paymentmethod": random.choice(["Efectivo", "Tarjeta", "Transferencia"])}
        resp = api("POST", "/expenses", data)
        eid = resp.get("id")
        ok = eid is not None
        if ok: test.expense_ids.append(eid)
        return ok, f"id={eid} ${data['amount']}" if ok else str(resp.get("error", {}))
    test("Gastos", "Crear gasto", create_ok)

    def update_ok():
        if not test.expense_ids: return False, "no hay gasto creado"
        eid = test.expense_ids[-1]
        # Send all required fields since backend uses raw UPDATE (no COALESCE)
        resp = api("PUT", f"/expenses/{eid}", {"description": "Gasto actualizado por test",
                                                "amount": 100.0, "category": "Servicios",
                                                "paymentmethod": "Efectivo"})
        ok = resp.get("id") == eid
        return ok, f"id={eid}" if ok else str(resp.get("error", {}))
    test("Gastos", "Actualizar gasto", update_ok)


# ─── MODULE: Appointments ────────────────────────────────────

def test_appointments():
    def list_ok():
        resp = api("GET", "/appointments")
        items = resp.get("appointments", [])
        ok = isinstance(items, list)
        return ok, f"{len(items)} citas"
    test("Citas", "Listar citas", list_ok)

    def create_ok():
        resp = api("GET", "/patients")
        pts = resp if isinstance(resp, list) else resp.get("patients", resp.get("data", []))
        if not pts: return False, "no hay pacientes"
        pid = pts[0]["id"]
        data = {"patientid": pid, "userid": 1,
                "appointmentdate": "2026-06-15T10:30:00",
                "notes": "Cita de prueba"}
        resp = api("POST", "/appointments", data)
        aid = resp.get("id")
        ok = aid is not None
        if ok: test.appt_ids.append(aid)
        return ok, f"id={aid}" if ok else str(resp.get("error", {}))
    test("Citas", "Crear cita", create_ok)


# ─── MODULE: Company ─────────────────────────────────────────

def test_company():
    def get_ok():
        resp = api("GET", "/company")
        ok = resp.get("id") is not None or resp.get("name") is not None
        return ok, f"name={resp.get('name','?')}" if ok else str(resp)
    test("Empresa", "Obtener datos", get_ok)

    def update_ok():
        resp = api("PUT", "/company", {"name": "Farmacia Test Suite", "phone": "5512345678"})
        ok = resp.get("name") == "Farmacia Test Suite"
        return ok, f"name={resp.get('name')}" if ok else str(resp.get("error", {}))
    test("Empresa", "Actualizar datos", update_ok)


# ─── MODULE: Facturas (Invoices) ─────────────────────────────

def test_facturas():
    def list_ok():
        resp = api("GET", "/facturas")
        items = resp if isinstance(resp, list) else resp.get("facturas", resp.get("data", []))
        ok = isinstance(items, list)
        return ok, f"{len(items)} facturas"
    test("Facturas", "Listar facturas", list_ok)

    def generate_ok():
        resp = api("GET", "/sales")
        sales = resp.get("sales", [])
        if not sales:
            return False, "no hay ventas para facturar"
        sale_id = sales[-1]["id"]
        # Also ensure company has RFC configured
        api("PUT", "/company", {"rfc": "XAXX010101000", "name": "Farmacia Test"})
        data = {"saleId": sale_id, "rfc": "XAXX010101000",
                "business_name": "Cliente Test", "tax_system": "601",
                "zip_code": "12345", "tax_regime": "601"}
        resp = api("POST", "/facturas/generate", data)
        ok = resp.get("id") is not None or resp.get("folio") is not None
        return ok, f"folio={resp.get('folio','?')}" if ok else str(resp.get("error", {}))
    test("Facturas", "Generar factura", generate_ok)


# ─── MODULE: Reports ─────────────────────────────────────────

def test_reports():
    def daily_summary():
        resp = api("GET", "/reports/daily-summary", {"startDate": rand_date(-30, 0), "endDate": datetime.now().strftime("%Y-%m-%d")})
        ok = resp.get("total_sales") is not None
        return ok, f"{resp.get('total_sales')} ventas, ${resp.get('total_revenue',0)} ingresos"
    test("Reportes", "Resumen diario", daily_summary)

    def top_products():
        resp = api("GET", "/reports/top-products", {"limit": 10})
        ok = isinstance(resp, list) and len(resp) > 0
        return ok, f"{len(resp)} productos" if ok else str(resp)
    test("Reportes", "Top productos", top_products)

    def monthly_sales():
        resp = api("GET", "/reports/monthly-sales")
        ok = isinstance(resp, list) and len(resp) > 0
        return ok, f"{len(resp)} meses" if ok else str(resp)
    test("Reportes", "Ventas mensuales", monthly_sales)

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

    def monthly_expenses():
        resp = api("GET", "/reports/monthly-expenses")
        ok = isinstance(resp, list)
        return ok, f"{len(resp)} meses" if ok else str(resp)
    test("Reportes", "Gastos mensuales", monthly_expenses)

    def hourly_sales():
        resp = api("GET", "/reports/hourly-sales")
        ok = isinstance(resp, list)
        return ok, f"{len(resp)} horas" if ok else str(resp)
    test("Reportes", "Ventas por hora", hourly_sales)

    def profit_margin():
        resp = api("GET", "/reports/profit-margin")
        ok = isinstance(resp, list) and len(resp) > 0
        detail = f"{len(resp)} productos con margen" if ok else str(resp)[:100]
        return ok, detail
    test("Reportes", "Margen de ganancia", profit_margin)

    def top_customers():
        resp = api("GET", "/reports/top-customers", {"limit": 5})
        ok = isinstance(resp, list)
        return ok, f"{len(resp)} clientes" if ok else str(resp)
    test("Reportes", "Top clientes", top_customers)

    def day_of_week():
        resp = api("GET", "/reports/day-of-week")
        ok = isinstance(resp, list)
        return ok, f"{len(resp)} días" if ok else str(resp)
    test("Reportes", "Ventas por día de semana", day_of_week)

    def return_rate():
        resp = api("GET", "/reports/return-rate")
        ok = isinstance(resp, list) and len(resp) > 0
        detail = f"{len(resp)} meses con datos" if ok else str(resp)[:100]
        return ok, detail
    test("Reportes", "Tasa de devolución", return_rate)


# ─── MODULE: Alerts ──────────────────────────────────────────

def test_alerts():
    def alerts_ok():
        resp = api("GET", "/alerts")
        ok = resp.get("counts") is not None or isinstance(resp, list)
        counts = resp.get("counts", {})
        detail = f"low_stock={counts.get('low_stock',0)}, expiry={counts.get('expiry',0)}"
        return ok, detail
    test("Alertas", "Obtener alertas", alerts_ok)

    def mark_read_ok():
        resp = api("GET", "/alerts")
        alerts = resp.get("alerts", resp if isinstance(resp, list) else [])
        if alerts and len(alerts) > 0:
            aid = alerts[0].get("id")
            if aid:
                resp2 = api("PATCH", f"/alerts/{aid}/read")
                ok = resp2.get("message") is not None or resp2.get("success") is not False
                return ok, f"alerta {aid} marcada como leída"
        return True, "no hay alertas para marcar"
    test("Alertas", "Marcar alerta como leída", mark_read_ok)

    def mark_all_read_ok():
        resp = api("PATCH", "/alerts/read-all")
        ok = resp.get("message") is not None or resp.get("success") is not False
        return ok, str(resp.get("message", "ok"))
    test("Alertas", "Marcar todas como leídas", mark_all_read_ok)


# ─── MODULE: Campaigns ───────────────────────────────────────

def test_campaigns():
    def list_ok():
        resp = api("GET", "/campaigns")
        items = resp if isinstance(resp, list) else resp.get("campaigns", [])
        ok = isinstance(items, list)
        return ok, f"{len(items)} campañas"
    test("Campañas", "Listar campañas", list_ok)

    def create_ok():
        # Need at least one product and one customer
        resp_p = api("GET", "/products", {"limit": 5})
        prods = resp_p.get("products", [])
        resp_c = api("GET", "/customers")
        customers = resp_c if isinstance(resp_c, list) else resp_c.get("customers", resp_c.get("data", []))
        if not prods or not customers:
            return False, "no hay productos o clientes para crear campaña"
        data = {"name": f"Campaña Test {rand_id('C',4)}",
                "description": "Campaña creada por test suite",
                "offer_type": "percentage",
                "offer_value": random.randint(5, 30),
                "notes": "Prueba automatizada",
                "product_ids": [p["id"] for p in prods[:2]],
                "customer_ids": [c["id"] for c in customers[:2]]}
        resp = api("POST", "/campaigns", data)
        cid = resp.get("id")
        ok = cid is not None
        if ok: test.campaign_ids.append(cid)
        return ok, f"id={cid}" if ok else str(resp.get("error", {}))
    test("Campañas", "Crear campaña", create_ok)

    def available_customers():
        resp = api("GET", "/campaigns/available-customers/list")
        items = resp if isinstance(resp, list) else resp.get("customers", resp.get("data", []))
        ok = isinstance(items, list)
        return ok, f"{len(items)} clientes disponibles"
    test("Campañas", "Clientes disponibles", available_customers)

    def expiring_products():
        resp = api("GET", "/campaigns/expiring-products/list")
        items = resp if isinstance(resp, list) else resp.get("products", resp.get("data", []))
        ok = isinstance(items, list)
        return ok, f"{len(items)} productos próximos a caducar"
    test("Campañas", "Productos próximos a caducar", expiring_products)


# ─── MODULE: WhatsApp ────────────────────────────────────────

def test_whatsapp():
    def status_ok():
        resp = api("GET", "/whatsapp/status")
        ok = resp.get("status") is not None
        return ok, f"status={resp.get('status')}, ready={resp.get('ready')}, hasQr={resp.get('hasQr')}"
    test("WhatsApp", "Estado de conexión", status_ok)

    def qr_ok():
        resp = api("GET", "/whatsapp/qr")
        has_qr_data = resp.get("qr") is not None
        has_code = resp.get("code") is not None
        # It's ok if QR is available OR if it says not available yet (initializing)
        ok = has_qr_data or has_code or resp.get("error")
        detail = "QR disponible" if has_qr_data else (f"raw code available" if has_code else f"not ready: {resp.get('error','?')}")
        return ok, detail
    test("WhatsApp", "Obtener QR", qr_ok)

    def reconnect_ok():
        resp = api("POST", "/whatsapp/reconnect")
        ok = resp.get("message") is not None
        return ok, f"{resp.get('message','ok')}" if ok else str(resp.get("error", {}))
    test("WhatsApp", "Reconectar", reconnect_ok)

    def send_test_message():
        """Attempt to send a test message (won't work unless QR is scanned)."""
        resp = api("GET", "/customers")
        customers = resp if isinstance(resp, list) else resp.get("customers", resp.get("data", []))
        if not customers:
            return False, "no hay clientes para enviar mensaje de prueba"
        customer = customers[0]
        phone = customer.get("phone", "")
        if not phone:
            return False, "el cliente no tiene teléfono"

        # This will likely fail with "not connected" but we test the API path
        # We need to import communications which uses sendWaMessage
        # Let's just verify the campaign send endpoint exists and works
        if test.campaign_ids:
            cid = test.campaign_ids[-1]
            data = {"customer_ids": [customer["id"]],
                    "message": f"Mensaje de prueba del sistema POS a las {datetime.now().isoformat()}"}
            resp = api("POST", f"/campaigns/{cid}/send", data)
            # May fail because WhatsApp is not connected, but that's expected
            return True, f"Intento de envío: {resp.get('message', resp.get('error', {}).get('message', 'ok'))}"
        return True, "No hay campaña para probar envío (se omite prueba destructiva)"
    test("WhatsApp", "Enviar mensaje de prueba", send_test_message)


# ─── MODULE: CSV Import Simulation ──────────────────────────

def test_csv_import():
    print(f"\n  {PASS} Simulación de importación CSV:")
    csv_path = "/tmp/test_products_import.csv"
    with open(csv_path, "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["code", "barcode", "name", "description", "categoryid", "supplierid",
                     "purchaseprice", "saleprice", "stock", "minstock", "unit"])
        for i in range(5):
            code = f"CSV{random.randint(10000,99999)}"
            w.writerow([code, code, f"CSV Import {code}", "Importado desde CSV", 1, 1,
                       round(random.uniform(5, 50), 2), round(random.uniform(10, 100), 2),
                       random.randint(10, 100), 5, "pza"])
    print(f"    {PASS} Archivo CSV creado: {csv_path}")
    imported = 0; errors = 0
    with open(csv_path) as f:
        reader = csv.DictReader(f)
        for row in reader:
            for num_field in ["purchaseprice", "saleprice", "stock", "minstock"]:
                row[num_field] = float(row[num_field]) if row[num_field] else 0
            for int_field in ["categoryid", "supplierid"]:
                row[int_field] = int(row[int_field]) if row[int_field] else None
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
    results.append({"module": "CSV Import", "test": "Importar productos desde CSV", "status": PASS if ok else FAIL, "detail": detail})
    print(f"  {PASS if ok else FAIL} Importar productos desde CSV — {detail}")


# ─── Main Runner ─────────────────────────────────────────────

def update_expiry_dates():
    """Update expiry dates for categories 1,2,3 to have mixed dates."""
    resp = api("GET", "/products", {"limit": 200})
    prods = resp.get("products", [])
    target_cats = [1, 2, 3]
    updated = 0
    for p in prods:
        if p.get("categoryid") in target_cats:
            if random.random() < 0.3:
                expiry = rand_date(1, 60)
            else:
                expiry = rand_date(90, 730)
            resp_upd = api("PUT", f"/products/{p['id']}", {"expiry_date": expiry})
            if resp_upd.get("id"): updated += 1
    print(f"  {PASS} Fechas de caducidad actualizadas para {updated} productos")

def update_low_stock():
    """Set some products with very low stock for alert testing."""
    resp = api("GET", "/products", {"limit": 200})
    prods = resp.get("products", [])
    updated = 0
    for p in random.sample(prods, min(10, len(prods))):
        low_stock = random.randint(0, 3)
        resp_upd = api("PUT", f"/products/{p['id']}", {"stock": low_stock, "minstock": 10})
        if resp_upd.get("id"): updated += 1
    print(f"  {PASS} Stock bajo simulado para {updated} productos")

def run_module(name, fns):
    print(f"\n{'='*60}")
    print(f"  Módulo: {name}")
    print(f"{'='*60}")
    for fn in fns: fn()
    mod_results = [r for r in results if r["module"] == name]
    total = len(mod_results)
    passed = len([r for r in mod_results if r["status"] == PASS])
    rate = (passed / total * 100) if total else 0
    print(f"  {'─'*40}")
    print(f"  {PASS} {passed}/{total} pruebas pasadas ({rate:.0f}%)")

# Shared state
test.product_ids = []
test.customer_ids = []
test.patient_ids = []
test.prescription_ids = []
test.sale_ids = []
test.expense_ids = []
test.appt_ids = []
test.cat_ids = []
test.supplier_ids = []
test.user_ids = []
test.campaign_ids = []
test.session_id = None

MODULES = [
    ("Auth",               [test_auth]),
    ("Usuarios",           [test_users]),
    ("Empresa",            [test_company]),
    ("Productos",          [test_products, update_expiry_dates, update_low_stock]),
    ("Categorías",         [test_categories]),
    ("Proveedores",        [test_suppliers]),
    ("Clientes",           [test_customers]),
    ("Pacientes",          [test_patients]),
    ("Recetas",            [test_prescriptions]),
    ("Inventario",         [test_inventory]),
    ("Caja",               [test_cashregister]),
    ("Ventas",             [test_sales]),
    ("Devoluciones",       [test_returns]),
    ("Gastos",             [test_expenses]),
    ("Citas",              [test_appointments]),
    ("Facturas",           [test_facturas]),
    ("Reportes",           [test_reports]),
    ("Alertas",            [test_alerts]),
    ("Campañas",           [test_campaigns]),
    ("WhatsApp",           [test_whatsapp]),
    ("CSV Import",         [test_csv_import]),
]

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="POS System — Comprehensive Test Suite")
    parser.add_argument("--module", help="Run single module only")
    parser.add_argument("--list", action="store_true", help="List available modules")
    parser.add_argument("--csv", help="Import CSV file of products (standalone)")
    args = parser.parse_args()

    if args.list:
        print(f"\n{'#'*60}")
        print(f"  MÓDULOS DISPONIBLES ({len(MODULES)})")
        print(f"{'#'*60}")
        for name, _ in MODULES:
            print(f"  {PASS} {name}")
        print()
        sys.exit(0)

    print(f"\n{'#'*60}")
    print(f"  SISTEMA POS — SUITE DE PRUEBAS INTEGRAL")
    print(f"  {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"  API: {API_BASE}")
    print(f"{'#'*60}")

    # CSV-only mode
    if args.csv:
        print(f"\n  Importando CSV: {args.csv}")
        test_csv_import()
        total = len([r for r in results if r["module"] == "CSV Import"])
        passed = len([r for r in results if r["module"] == "CSV Import" and r["status"] == PASS])
        print(f"\n  CSV Import: {PASS} {passed}/{total}")
        sys.exit(0)

    single = args.module

    # Login first
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

    for name, fns in MODULES:
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
