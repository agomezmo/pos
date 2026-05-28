#!/usr/bin/env python3
"""Generate CSV sample files with 100+ records for Farmacia POS."""

import csv, random, os

CATEGORIES = ["Antibióticos", "Analgésicos", "Vitaminas", "Cuidado Personal",
              "Dermatológicos", "Cardiovasculares", "Gastrointestinales",
              "Respiratorios", "Neurológicos", "Oftálmicos", "Pediatría", "Varios"]
ADJ = ["Genérico", "Marca A", "Marca B", "Premium", "Económico",
       "Pediatrico", "Adulto Mayor", "Deportivo", "Natural", "Plus"]
NOUNS = [
    "Paracetamol 500mg", "Ibuprofeno 400mg", "Amoxicilina 500mg",
    "Omeprazol 20mg", "Losartán 50mg", "Metformina 850mg",
    "Atorvastatina 10mg", "Enapril 10mg", "Aspirina 100mg",
    "Diclofenaco 75mg", "Naproxeno 250mg", "Ranitidina 300mg",
    "Salbutamol Inhalador", "Loratadina 10mg", "Cetirizina 10mg",
    "Dexametasona 8mg", "Prednisona 25mg", "Clindamicina 300mg",
    "Ciprofloxacino 500mg", "Azitromicina 500mg", "Vitamina C 1g",
    "Complejo B", "Vitamina D 1000UI", "Calcio 600mg + D3",
    "Hierro 150mg", "Ácido Fólico 5mg", "Melatonina 5mg",
    "Bisacodilo 5mg", "Lactulosa 15ml", "Hidrocortisona Crema 1%",
    "Clotrimazol Crema 1%", "Ketoconazol Champú 2%", "Miconazol Polvo",
    "Carbón Activado 500mg", "Electrolitos Orales Sobre",
    "Jarabe para Tos 120ml", "Aceite de Higado de Bacalao",
    "Ginkgo Biloba 60mg", "Omega 3 1000mg", "Glucomanano 500mg",
]


def generate_products(n=120):
    rows = []
    seen = set()
    while len(rows) < n:
        adj = random.choice(ADJ)
        noun = random.choice(NOUNS)
        name = f"{adj} {noun}"
        if name in seen:
            continue
        seen.add(name)
        code = f"FAR-{random.randint(10000, 99999)}"
        cat = random.choice(CATEGORIES)
        purchase = round(random.uniform(10, 800), 2)
        price = round(purchase * random.uniform(1.25, 2.0), 2)
        wholesale = round(price * 0.90, 2)
        stock = random.choices(
            [random.randint(0, 5), random.randint(5, 50), random.randint(50, 500)],
            weights=[15, 40, 45],
        )[0]
        min_stock = random.choice([1, 2, 3, 5, 10, 15])
        unit = random.choice(["PZA", "CAJA", "FRASCO", "TUBO", "SOBRE", "ML"])
        active = random.choices(["1", "0"], weights=[90, 10])[0]
        requires_prescription = random.choices(["1", "0"], weights=[30, 70])[0]
        rows.append([
            code, name, cat, f"{purchase:.2f}", f"{price:.2f}", f"{wholesale:.2f}",
            str(stock), str(min_stock), unit, active, requires_prescription,
        ])
    return rows


FIRST_NAMES = [
    "Juan", "María", "Carlos", "Ana", "Luis", "Sofía", "José", "Laura",
    "Pedro", "Fernanda", "Miguel", "Isabel", "Francisco", "Gabriela",
    "Jorge", "Verónica", "Ricardo", "Patricia", "Daniel", "Carmen",
    "Alejandro", "Rosa", "Manuel", "Elena", "Javier", "Diana",
    "Alberto", "Claudia", "Rafael", "Silvia",
]
LAST_NAMES = [
    "García", "López", "Martínez", "Rodríguez", "Hernández", "Pérez",
    "González", "Mendoza", "Castillo", "Ramos", "Cruz", "Ortega",
    "Vargas", "Reyes", "Guzmán", "Morales", "Ortiz", "Delgado",
    "Flores", "Sánchez", "Torres", "Rivera", "Díaz", "Chávez", "Ruiz",
]
DOC_TYPES = ["INE", "Pasaporte", "Cédula"]
BLOOD_TYPES = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]
ALLERGIES_LIST = [
    "Ninguna", "Penicilina", "Sulfa", "Aspirina", "Ibuprofeno",
    "Codeína", "Yodo", "Látex", "Polen", "Ninguna",
    "Ninguna", "Penicilina", "Sulfa",
]
DOCTOR_NAMES = [
    "Dr. López Martínez", "Dra. García Hernández", "Dr. Pérez Rodríguez",
    "Dra. Sánchez Castillo", "Dr. Cruz Mendoza", "Dra. Ramos Ortega",
    "Dr. Morales Reyes", "Dra. Delgado Flores",
]
DIAGNOSIS = [
    "Hipertensión arterial", "Diabetes tipo 2", "Infección respiratoria",
    "Infección urinaria", "Amigdalitis bacteriana", "Otitis media",
    "Rinitis alérgica", "Gastritis crónica", "Artritis reumatoide",
    "Lumbalgia", "Cefalea tensional", "Ansiedad generalizada",
    "Insomnio crónico", "Hipotiroidismo", "Asma bronquial",
    "EPOC", "Dislipidemia", "Osteoporosis",
]


def generate_customers(n=120):
    rows = []
    seen = set()
    while len(rows) < n:
        first = random.choice(FIRST_NAMES)
        last1 = random.choice(LAST_NAMES)
        last2 = random.choice(LAST_NAMES)
        name = f"{first} {last1} {last2}"
        if name in seen:
            continue
        seen.add(name)
        rfc_letters = (last1[0:2] + first[0] + last2[0]).upper()
        rfc_date = f"{random.randint(50, 99)}{random.randint(1, 12):02d}{random.randint(1, 28):02d}"
        rfc = f"{rfc_letters}{rfc_date}{random.choice(['XXX', 'HDF', 'MDF', 'ABC', 'XYZ'])}"
        doc_type = random.choice(DOC_TYPES)
        doc_num = f"{random.choice([chr(c) for c in range(65, 91)])}{random.randint(100000000, 999999999)}"
        phone = f"555-{random.randint(1000, 9999)}"
        email = f"{first.lower()}.{last1.lower()}@email.com"
        address = f"Calle {random.choice(['Principal', 'Central', 'Norte', 'Sur', 'Oriente', 'Poniente'])} #{random.randint(1, 999)}"
        rows.append([name, doc_type, doc_num, phone, email, address, rfc])
    return rows


def generate_patients(n_customers=100):
    rows = []
    for i in range(1, n_customers + 1):
        blood = random.choice(BLOOD_TYPES)
        allergies = random.choice(ALLERGIES_LIST)
        history = random.choice([
            "Paciente sano", "Hipertensión controlada", "Diabetes tipo 2",
            "Asma leve", "Alergias estacionales", "Hipotiroidismo",
            "Artritis", "Gastritis crónica", "Migraña frecuente",
            "Ansiedad", "Colesterol elevado", "Paciente sano",
            "Paciente sano", "Obesidad G1", "Insomnio",
        ])
        rows.append([str(i), blood, allergies, history])
    return rows


def generate_prescriptions(n=100):
    # Use customer IDs as patient IDs (1..n_customers)
    rows = []
    for i in range(1, n + 1):
        patient_id = random.randint(1, 100)
        doctor = random.choice(DOCTOR_NAMES)
        license_num = f"MED{random.randint(10000, 99999)}"
        diagnosis = random.choice(DIAGNOSIS)
        issue = f"2026-{random.randint(1, 6):02d}-{random.randint(1, 28):02d}"
        expiry = f"2026-{random.randint(7, 12):02d}-{random.randint(1, 28):02d}"
        # 1-3 medication items
        num_items = random.randint(1, 3)
        items = []
        for _ in range(num_items):
            prod_id = random.randint(1, 120)
            dosage = random.choice([
                "1 tableta", "1 cápsula", "1 cucharada", "2 tabletas",
                "1 inhalación", "1 aplicación",
            ])
            freq = random.choice([
                "C/8h", "C/12h", "C/24h", "C/6h", "C/4h",
                "Cada 12 horas", "Cada 8 horas",
            ])
            duration = random.choice(["7 días", "10 días", "14 días", "30 días", "60 días"])
            qty = random.choice([7, 10, 14, 20, 30, 60, 90])
            items.append(f"{prod_id}|{dosage}|{freq}|{duration}|{qty}")
        medications = ";".join(items)
        notes = random.choices([
            "", "Tomar con alimentos", "No suspender tratamiento",
            "Evitar alcohol", "Tomar en ayunas",
        ], weights=[50, 20, 10, 10, 10])[0]
        rows.append([str(patient_id), doctor, license_num, diagnosis,
                     issue, expiry, notes, medications])
    return rows


def write_csv(path, headers, data):
    os.makedirs(os.path.dirname(path) or ".", exist_ok=True)
    with open(path, "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(headers)
        w.writerows(data)
    print(f"  ✓ {path} ({len(data)} records)")


if __name__ == "__main__":
    base = os.path.dirname(os.path.abspath(__file__))

    print("Generating productos.csv …")
    prods = generate_products(120)
    write_csv(os.path.join(base, "productos.csv"),
              ["code", "name", "category", "purchase_price", "sale_price",
               "wholesale_price", "stock", "min_stock", "unit", "is_active",
               "requires_prescription"],
              prods)

    print("Generating clientes.csv …")
    custs = generate_customers(120)
    write_csv(os.path.join(base, "clientes.csv"),
              ["full_name", "document_type", "document_number", "phone",
               "email", "address", "rfc"],
              custs)

    print("Generating pacientes.csv …")
    pats = generate_patients(120)
    write_csv(os.path.join(base, "pacientes.csv"),
              ["customer_id", "blood_type", "allergies", "medical_history"],
              pats)

    print("Generating recetas.csv …")
    rx = generate_prescriptions(120)
    write_csv(os.path.join(base, "recetas.csv"),
              ["patient_id", "doctor_name", "doctor_license", "diagnosis",
               "issue_date", "expiry_date", "notes", "medications"],
              rx)
