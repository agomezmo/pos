-- Ferretería "El Constructor" - Seed Data
-- Hardware Store POS seed

-- Company Info
INSERT INTO public.companyinfo (id, name, address, phone, email, taxid, receiptfooter, rfc, regimenfiscalcode, seriefactura, folioactual, regimenfiscalid)
VALUES (1, 'Ferretería El Constructor', 'Av. Industrial 500, Ciudad de México', '55-1234-5678', 'contacto@elconstructor.mx', '12345678901', '¡Gracias por su compra!', 'EKU9003173C9', '601', 'F', 0, 1)
ON CONFLICT (id) DO NOTHING;

-- Users
INSERT INTO public.users (id, username, passwordhash, email, fullname, roleid, isactive)
VALUES
  (1, 'admin', '$2b$10$8Ob1aHw.9VHx0OfXK7nP5ebL0NMIBRPu/7dhlYFtnYf1X4UhqUdBS', 'admin@elconstructor.com', 'Admin Principal', 1, true),
  (2, 'cajero', '$2b$10$UILL0MQ0o1GzVfei2yNg3.VIC5NXDMb9LXiYsV6EOjcQAKWJuZzPG', 'cajero@elconstructor.com', 'Cajero Principal', 2, true)
ON CONFLICT (id) DO NOTHING;

-- System Settings
INSERT INTO public.systemsettings (id, key, value, description) VALUES
  (1, 'company_name', 'Ferretería El Constructor', 'Nombre de la empresa'),
  (2, 'tax_rate', '16', 'Porcentaje de impuesto por defecto'),
  (3, 'currency', 'MXN', 'Moneda del sistema'),
  (4, 'receipt_footer', '¡Gracias por su compra!', 'Texto del pie de recibo'),
  (5, 'low_stock_threshold', '5', 'Cantidad mínima para alerta de stock bajo')
ON CONFLICT (id) DO NOTHING;

-- Expense Categories
INSERT INTO public.expense_categories (id, name, description) VALUES
  (1, 'Servicios', 'Pagos de servicios básicos: luz, agua, internet'),
  (2, 'Alquiler', 'Pago de alquiler del local'),
  (3, 'Salarios', 'Salarios del personal'),
  (4, 'Insumos', 'Compra de insumos y materiales'),
  (5, 'Mantenimiento', 'Mantenimiento de equipos e instalaciones'),
  (6, 'Publicidad', 'Gastos de marketing y publicidad')
ON CONFLICT (id) DO NOTHING;

-- Tax Rates
INSERT INTO public.taxrates (id, name, rate, isactive) VALUES
  (1, 'IVA', 16.00, true)
ON CONFLICT (id) DO NOTHING;

-- CFDI Catalogs (reusable across businesses)
INSERT INTO public.cat_clave_prod_serv (id, codigo, descripcion, ivatasa, iepstasa) VALUES
  (1, '31161600', 'Clavos, tornillos y pernos', 16.00, 0.00),
  (2, '31161700', 'Herramientas manuales', 16.00, 0.00),
  (3, '31161800', 'Herramientas eléctricas', 16.00, 0.00),
  (4, '31161900', 'Material eléctrico', 16.00, 0.00),
  (5, '31162000', 'Tuberías y conexiones', 16.00, 0.00),
  (6, '31162100', 'Pinturas y recubrimientos', 16.00, 0.00),
  (7, '31162200', 'Material de plomería', 16.00, 0.00),
  (8, '31162300', 'Ferretería en general', 16.00, 0.00),
  (9, '31162400', 'Equipo de seguridad industrial', 16.00, 0.00),
  (10, '31162500', 'Jardinería y exteriores', 16.00, 0.00),
  (11, '31162600', 'Material de construcción', 16.00, 0.00),
  (12, '31162700', 'Cerraduras y herrajes', 16.00, 0.00),
  (13, '31162800', 'Equipo de medición', 16.00, 0.00),
  (14, '31162900', 'Adhesivos y selladores', 16.00, 0.00),
  (15, '31163000', 'Lubricantes y aceites', 16.00, 0.00)
ON CONFLICT (codigo) DO NOTHING;

-- Categories
INSERT INTO public.categories (id, name, description) VALUES
  (1, 'Herramientas Manuales', 'Martillos, desarmadores, llaves, pinzas, etc.'),
  (2, 'Herramientas Eléctricas', 'Taladros, esmeriles, sierras, etc.'),
  (3, 'Material Eléctrico', 'Cables, interruptores, contactos, fusibles'),
  (4, 'Plomería', 'Tuberías, conexiones, válvulas, llaves de agua'),
  (5, 'Pinturas', 'Pinturas vinílicas, esmaltes, selladores, brochas'),
  (6, 'Construcción', 'Cemento, varilla, block, cal, yeso'),
  (7, 'Ferretería General', 'Clavos, tornillos, bisagras, cerraduras'),
  (8, 'Seguridad Industrial', 'Cascos, guantes, arneses, lentes'),
  (9, 'Jardinería', 'Mangueras, aspersores, tijeras, macetas')
ON CONFLICT (id) DO NOTHING;

-- Suppliers
INSERT INTO public.suppliers (id, name, contactname, phone, email, address) VALUES
  (1, 'Distribuidora de Herramientas MX', 'Roberto García', '55-1111-0000', 'roberto@dhmx.mx', 'Av. Ferrocarril 100, CDMX'),
  (2, 'Materiales Eléctricos del Centro', 'Laura Martínez', '55-2222-1111', 'laura@melectrica.mx', 'Calle Corrientes 200, CDMX'),
  (3, 'Aceros y Construcción SA', 'Pedro López', '55-3333-2222', 'pedro@acerosconstruccion.mx', 'Blvd. Acero 300, Monterrey'),
  (4, 'Pinturas y Recubrimientos del Valle', 'Sofía Hernández', '55-4444-3333', 'sofia@pinturasvalle.mx', 'Av. Colores 400, CDMX'),
  (5, 'Proveedora Industrial Nacional', 'Jorge Sánchez', '55-5555-4444', 'jorge@proveedoraindustrial.mx', 'Calle Industria 500, Guadalajara')
ON CONFLICT (id) DO NOTHING;

-- Products - Ferretería
INSERT INTO public.products (id, code, barcode, name, description, categoryid, supplierid, purchaseprice, saleprice, stock, minstock, unit, requiresprescription) VALUES
  (1, 'FER001', '7501000000001', 'Martillo 16oz mango fibra', 'Martillo de uña con mango de fibra de vidrio', 1, 1, 45.00, 85.00, 50, 10, 'Unidad', false),
  (2, 'FER002', '7501000000002', 'Desarmador plano 1/4x6', 'Desarmador de punta plana con mango ergonómico', 1, 1, 12.00, 25.00, 100, 20, 'Unidad', false),
  (3, 'FER003', '7501000000003', 'Desarmador cruz #2x6', 'Desarmador Phillips #2 con mango ergonómico', 1, 1, 12.00, 25.00, 100, 20, 'Unidad', false),
  (4, 'FER004', '7501000000004', 'Pinza de corte 8"', 'Pinza de corte diagonal con mango aislado', 1, 1, 35.00, 68.00, 40, 8, 'Unidad', false),
  (5, 'FER005', '7501000000005', 'Pinza de presión 10"', 'Pinza de presión recta con ajuste rápido', 1, 1, 42.00, 80.00, 35, 8, 'Unidad', false),
  (6, 'FER006', '7501000000006', 'Llave ajustable 10"', 'Llave perica con graduación fina', 1, 1, 55.00, 105.00, 30, 6, 'Unidad', false),
  (7, 'FER007', '7501000000007', 'Juego llaves Allen 1.5-10mm', 'Juego de 9 llaves Allen métricas', 1, 2, 28.00, 55.00, 45, 10, 'Juego', false),
  (8, 'FER008', '7501000000008', 'Flexómetro 5m', 'Cinta métrica con freno y clip', 1, 1, 18.00, 38.00, 60, 15, 'Unidad', false),
  (9, 'FER009', '7501000000009', 'Nivel de burbuja 24"', 'Nivel de aluminio con 3 burbujas', 1, 1, 32.00, 62.00, 25, 5, 'Unidad', false),
  (10, 'FER010', '7501000000010', 'Cincel 3/4x8"', 'Cincel de acero para concreto', 1, 1, 15.00, 30.00, 40, 8, 'Unidad', false),
  (11, 'FER011', '7501000000011', 'Taladro percutor 1/2" 650W', 'Taladro eléctrico con velocidad variable', 2, 1, 350.00, 650.00, 15, 3, 'Unidad', false),
  (12, 'FER012', '7501000000012', 'Esmeril angular 4.5" 850W', 'Esmeril angular para corte y desbaste', 2, 1, 380.00, 720.00, 12, 3, 'Unidad', false),
  (13, 'FER013', '7501000000013', 'Sierra circular 7.25" 1200W', 'Sierra circular con guía láser', 2, 1, 450.00, 850.00, 10, 2, 'Unidad', false),
  (14, 'FER014', '7501000000014', 'Rotomartillo SDS 800W', 'Rotomartillo con función cincel', 2, 1, 520.00, 980.00, 8, 2, 'Unidad', false),
  (15, 'FER015', '7501000000015', 'Lijadora orbital 1/3 250W', 'Lijadora orbital con recolector de polvo', 2, 1, 280.00, 530.00, 10, 2, 'Unidad', false),
  (16, 'FER016', '7501000000016', 'Disco corte metal 4.5" x10', 'Paquete de discos de corte para metal', 2, 2, 45.00, 85.00, 30, 6, 'Paquete', false),
  (17, 'FER017', '7501000000017', 'Broca concreto 1/4" x6"', 'Broca de carburo para concreto', 2, 2, 8.00, 16.00, 80, 20, 'Unidad', false),
  (18, 'FER018', '7501000000018', 'Juego brocas metal 1/16-1/2"', 'Juego de 13 brocas para metal HSS', 2, 2, 35.00, 68.00, 25, 5, 'Juego', false),
  (19, 'FER019', '7501000000019', 'Cable eléctrico THW #12 x100m', 'Cable de cobre para instalaciones eléctricas', 3, 2, 280.00, 520.00, 20, 4, 'Rollo', false),
  (20, 'FER020', '7501000000020', 'Cable eléctrico THW #10 x100m', 'Cable de cobre calibre 10 para alta carga', 3, 2, 380.00, 720.00, 15, 3, 'Rollo', false),
  (21, 'FER021', '7501000000021', 'Interruptor sencillo 15A', 'Interruptor de luz estándar blanco', 3, 2, 12.00, 25.00, 100, 25, 'Unidad', false),
  (22, 'FER022', '7501000000022', 'Contacto doble polarizado', 'Contacto doble con tierra', 3, 2, 15.00, 30.00, 80, 20, 'Unidad', false),
  (23, 'FER023', '7501000000023', 'Fusible cartucho 15A x5', 'Paquete de fusibles de cartucho 15A', 3, 2, 10.00, 20.00, 50, 10, 'Paquete', false),
  (24, 'FER024', '7501000000024', 'Pastilla termomagnética 20A', 'Interruptor termomagnético de 1 polo', 3, 2, 35.00, 68.00, 30, 6, 'Unidad', false),
  (25, 'FER025', '7501000000025', 'Cinta aislante negra x20m', 'Cinta aislante vinílica de alta calidad', 3, 2, 8.00, 18.00, 120, 30, 'Unidad', false),
  (26, 'FER026', '7501000000026', 'Tubo PVC 1/2" x3m', 'Tubo de PVC para instalaciones hidráulicas', 4, 3, 25.00, 48.00, 60, 12, 'Unidad', false),
  (27, 'FER027', '7501000000027', 'Tubo PVC 3/4" x3m', 'Tubo de PVC para instalaciones hidráulicas', 4, 3, 32.00, 60.00, 50, 10, 'Unidad', false),
  (28, 'FER028', '7501000000028', 'Codo PVC 1/2" 90°', 'Codo de PVC para tubería de 1/2"', 4, 3, 3.00, 7.00, 200, 50, 'Unidad', false),
  (29, 'FER029', '7501000000029', 'Válvula esfera 1/2" bronce', 'Válvula de paso recto tipo esfera', 4, 3, 45.00, 85.00, 30, 6, 'Unidad', false),
  (30, 'FER030', '7501000000030', 'Llave agua jardín 1/2"', 'Llave de nariz para jardín', 4, 3, 38.00, 72.00, 25, 5, 'Unidad', false),
  (31, 'FER031', '7501000000031', 'Sellador teflón 1/2"x12m', 'Cinta de teflón para sellado de roscas', 4, 3, 5.00, 12.00, 150, 40, 'Unidad', false),
  (32, 'FER032', '7501000000032', 'Pintura vinílica blanca 4L', 'Pintura vinílica lavable para interior', 5, 4, 85.00, 160.00, 40, 8, 'Cubeta', false),
  (33, 'FER033', '7501000000033', 'Esmalte sintético negro 1L', 'Esmalte sintético brillante para metal', 5, 4, 55.00, 105.00, 25, 5, 'Litro', false),
  (34, 'FER034', '7501000000034', 'Brocha plana 2"', 'Brocha de cerdas sintéticas 2 pulgadas', 5, 4, 8.00, 18.00, 80, 20, 'Unidad', false),
  (35, 'FER035', '7501000000035', 'Rodillo para pintura 9"', 'Rodillo de felpa para pintura con mango', 5, 4, 15.00, 30.00, 40, 10, 'Unidad', false),
  (36, 'FER036', '7501000000036', 'Thinner estándar 1L', 'Disolvente para esmaltes y lacas', 5, 4, 22.00, 42.00, 30, 6, 'Litro', false),
  (37, 'FER037', '7501000000037', 'Cemento gris 50kg', 'Cemento Portland para construcción', 6, 3, 95.00, 180.00, 60, 10, 'Bulto', false),
  (38, 'FER038', '7501000000038', 'Varilla corrugada 3/8" x6m', 'Varilla de acero para refuerzo de concreto', 6, 3, 55.00, 105.00, 40, 8, 'Unidad', false),
  (39, 'FER039', '7501000000039', 'Block hueco 10x20x40', 'Block de concreto para muros', 6, 3, 12.00, 24.00, 200, 50, 'Unidad', false),
  (40, 'FER040', '7501000000040', 'Cal de construcción 20kg', 'Cal hidratada para morteros y acabados', 6, 3, 28.00, 55.00, 30, 6, 'Bulto', false),
  (41, 'FER041', '7501000000041', 'Yeso estándar 20kg', 'Yeso para acabados interiores', 6, 3, 32.00, 62.00, 25, 5, 'Bulto', false),
  (42, 'FER042', '7501000000042', 'Arena triturada 1m³', 'Arena para construcción', 6, 3, 120.00, 230.00, 10, 2, 'Metro', false),
  (43, 'FER043', '7501000000043', 'Clavo 2.5" acero x1kg', 'Clavo común para madera', 7, 5, 15.00, 30.00, 50, 10, 'Kilogramo', false),
  (44, 'FER044', '7501000000044', 'Tornillo madera #8x1.5" x100', 'Tornillo para madera con punta fina', 7, 5, 12.00, 25.00, 80, 20, 'Caja', false),
  (45, 'FER045', '7501000000045', 'Tornillo concreto 1/4"x2" x50', 'Tornillo para concreto con cabeza hexagonal', 7, 5, 18.00, 35.00, 50, 10, 'Caja', false),
  (46, 'FER046', '7501000000046', 'Bisagra metálica 3"x3"', 'Bisagra recta para puerta, 2 piezas', 7, 5, 10.00, 22.00, 60, 15, 'Par', false),
  (47, 'FER047', '7501000000047', 'Cerrojo puerta 2"', 'Cerrojo de seguridad para puerta', 7, 5, 28.00, 55.00, 25, 5, 'Unidad', false),
  (48, 'FER048', '7501000000048', 'Lija agua #180 x10', 'Paquete de lijas al agua de grano fino', 7, 5, 8.00, 16.00, 60, 15, 'Paquete', false),
  (49, 'FER049', '7501000000049', 'Alambre recocido #18 x1kg', 'Alambre para atar y amarre', 7, 5, 18.00, 35.00, 30, 6, 'Kilogramo', false),
  (50, 'FER050', '7501000000050', 'Casco seguridad industrial', 'Casco de polietileno con suspensión ajustable', 8, 5, 35.00, 68.00, 40, 8, 'Unidad', false),
  (51, 'FER051', '7501000000051', 'Guantes carnaza soldador', 'Guantes de carnaza para soldadura', 8, 5, 28.00, 55.00, 30, 6, 'Par', false),
  (52, 'FER052', '7501000000052', 'Lentes seguridad antiempaño', 'Lentes de policarbonato con protección UV', 8, 5, 12.00, 25.00, 50, 10, 'Unidad', false),
  (53, 'FER053', '7501000000053', 'Arnes seguridad cuerpo completo', 'Arné de seguridad con puntos de anclaje', 8, 5, 180.00, 350.00, 10, 2, 'Unidad', false),
  (54, 'FER054', '7501000000054', 'Tapones auditivos x100', 'Tapones auditivos desechables de espuma', 8, 5, 25.00, 48.00, 20, 4, 'Caja', false),
  (55, 'FER055', '7501000000055', 'Manguera jardín 1/2" x15m', 'Manguera de PVC reforzada para jardín', 9, 5, 55.00, 105.00, 20, 4, 'Unidad', false),
  (56, 'FER056', '7501000000056', 'Aspersor giratorio jardín', 'Aspersor de impacto para jardín', 9, 5, 28.00, 55.00, 25, 5, 'Unidad', false),
  (57, 'FER057', '7501000000057', 'Tijera podar ramas 24"', 'Tijera de podar con mango largo', 9, 5, 42.00, 80.00, 15, 3, 'Unidad', false),
  (58, 'FER058', '7501000000058', 'Maceta plástica 30cm', 'Maceta redonda de plástico para exteriores', 9, 5, 8.00, 18.00, 60, 15, 'Unidad', false),
  (59, 'FER059', '7501000000059', 'Tierra negra 20kg', 'Tierra preparada para jardinería', 9, 5, 15.00, 30.00, 40, 8, 'Bulto', false),
  (60, 'FER060', '7501000000060', 'Fertilizante granulado 1kg', 'Fertilizante de liberación lenta para plantas', 9, 5, 22.00, 42.00, 25, 5, 'Kilogramo', false)
ON CONFLICT (id) DO NOTHING;

-- Reset sequences
SELECT setval('categories_id_seq', (SELECT COALESCE(MAX(id), 0) FROM categories));
SELECT setval('products_id_seq', (SELECT COALESCE(MAX(id), 0) FROM products));
SELECT setval('suppliers_id_seq', (SELECT COALESCE(MAX(id), 0) FROM suppliers));
SELECT setval('users_id_seq', (SELECT COALESCE(MAX(id), 0) FROM users));
SELECT setval('companyinfo_id_seq', (SELECT COALESCE(MAX(id), 0) FROM companyinfo));
SELECT setval('cat_clave_prod_serv_id_seq', (SELECT COALESCE(MAX(id), 0) FROM cat_clave_prod_serv));
