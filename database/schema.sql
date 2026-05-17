--
-- PostgreSQL database schema - Pharmacy POS System
-- Generated from full_dump.sql - cleaned
--
CREATE TABLE public.alerts (
    id SERIAL,
    type character varying(30) NOT NULL,
    title character varying(200) NOT NULL,
    message character varying(500),
    referencetype character varying(50),
    referenceid integer,
    isread boolean DEFAULT false,
    userid integer,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.appointments (
    id SERIAL,
    patientid integer NOT NULL,
    userid integer,
    appointmentdate timestamp without time zone NOT NULL,
    status character varying(20) DEFAULT 'Scheduled'::character varying NOT NULL,
    notes text,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.cashregisters (
    id SERIAL,
    name character varying(100) NOT NULL,
    location character varying(200),
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.cashregistersessions (
    id SERIAL,
    cashregisterid integer NOT NULL,
    userid integer NOT NULL,
    openingamount numeric(18,2) DEFAULT 0,
    closingamount numeric(18,2),
    openingnotes character varying(200),
    closingnotes character varying(200),
    openedat timestamp without time zone DEFAULT now(),
    closedat timestamp without time zone,
    status character varying(20) DEFAULT 'Open'::character varying NOT NULL
);

CREATE TABLE public.cat_clave_prod_serv (
    id SERIAL,
    codigo character varying(8) NOT NULL,
    descripcion character varying(500) NOT NULL,
    ivatasa numeric(5,2) DEFAULT 16.00,
    iepstasa numeric(5,2) DEFAULT 0,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.cat_clave_unidad (
    id SERIAL,
    codigo character varying(3) NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion character varying(255),
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.cat_forma_pago (
    id SERIAL,
    codigo character varying(2) NOT NULL,
    descripcion character varying(255) NOT NULL,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.cat_metodo_pago (
    id SERIAL,
    codigo character varying(3) NOT NULL,
    descripcion character varying(255) NOT NULL,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.cat_regimen_fiscal (
    id SERIAL,
    codigo character varying(3) NOT NULL,
    descripcion character varying(255) NOT NULL,
    personafisica boolean DEFAULT true,
    personamoral boolean DEFAULT true,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.cat_uso_cfdi (
    id SERIAL,
    codigo character varying(3) NOT NULL,
    descripcion character varying(255) NOT NULL,
    personafisica boolean DEFAULT true,
    personamoral boolean DEFAULT true,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.categories (
    id SERIAL,
    name character varying(100) NOT NULL,
    description character varying(200),
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.companyinfo (
    id SERIAL,
    name character varying(200) NOT NULL,
    address character varying(200),
    phone character varying(20),
    email character varying(100),
    logourl character varying(500),
    taxid character varying(20),
    receiptfooter character varying(300),
    rfc character varying(13),
    codigopostal character varying(5),
    certificadosat text,
    certificadokey text,
    certificadopassword character varying(255),
    regimenfiscalcode character varying(3),
    seriefactura character varying(5) DEFAULT 'F'::character varying,
    folioactual integer DEFAULT 0,
    regimenfiscalid integer
);

CREATE TABLE public.customers (
    id SERIAL,
    documenttype character varying(20),
    documentnumber character varying(20),
    fullname character varying(100) NOT NULL,
    phone character varying(20),
    email character varying(100),
    address character varying(200),
    birthdate date,
    createdat timestamp without time zone DEFAULT now(),
    updatedat timestamp without time zone,
    rfc character varying(13),
    razonsocial character varying(255),
    codigopostal character varying(5),
    regimenfiscalid integer,
    usocfdiid integer
);

CREATE TABLE public.expense_categories (
    id SERIAL,
    name character varying(100) NOT NULL,
    description text
);

CREATE TABLE public.expenses (
    id SERIAL,
    category character varying(100) NOT NULL,
    description character varying(500) NOT NULL,
    amount numeric(18,2) NOT NULL,
    paymentmethod character varying(30),
    reference character varying(100),
    userid integer,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.factura_items (
    id SERIAL,
    facturaid integer NOT NULL,
    saleitemid integer,
    productoid integer,
    cantidad numeric(18,6) DEFAULT 1 NOT NULL,
    claveprodserv character varying(8) DEFAULT '51101700'::character varying NOT NULL,
    claveunidad character varying(3) DEFAULT 'H87'::character varying NOT NULL,
    unidad character varying(20) DEFAULT 'Pieza'::character varying NOT NULL,
    noidentificacion character varying(50),
    descripcion character varying(1000) NOT NULL,
    valorunitario numeric(18,2) DEFAULT 0 NOT NULL,
    descuento numeric(18,2) DEFAULT 0,
    importe numeric(18,2) DEFAULT 0 NOT NULL,
    ivatasa numeric(5,2) DEFAULT 16.00,
    ivabase numeric(18,2) DEFAULT 0,
    ivaimporte numeric(18,2) DEFAULT 0,
    iepstasa numeric(5,2) DEFAULT 0,
    iepsbase numeric(18,2) DEFAULT 0,
    iepsimporte numeric(18,2) DEFAULT 0,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.factura_relaciones (
    id SERIAL,
    facturaid integer NOT NULL,
    tiporelacion character varying(2) NOT NULL,
    uuidrelacionado character varying(36) NOT NULL,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.facturas (
    id SERIAL,
    saleid integer NOT NULL,
    uuid character varying(36),
    folio character varying(20) NOT NULL,
    serie character varying(5) DEFAULT 'F'::character varying,
    emisorrfc character varying(13) NOT NULL,
    emisornombre character varying(255) NOT NULL,
    emisorregimenfiscal character varying(3) NOT NULL,
    emisorcodigopostal character varying(5),
    receptorrfc character varying(13) NOT NULL,
    receptornombre character varying(255) NOT NULL,
    receptorusocfdi character varying(3) NOT NULL,
    receptorcodigopostal character varying(5),
    subtotal numeric(18,2) DEFAULT 0 NOT NULL,
    descuento numeric(18,2) DEFAULT 0,
    iva numeric(18,2) DEFAULT 0 NOT NULL,
    ieps numeric(18,2) DEFAULT 0,
    total numeric(18,2) DEFAULT 0 NOT NULL,
    formapago character varying(2) DEFAULT '01'::character varying NOT NULL,
    metodopago character varying(3) DEFAULT 'PUE'::character varying NOT NULL,
    moneda character varying(3) DEFAULT 'MXN'::character varying NOT NULL,
    tipocambio numeric(18,6) DEFAULT 1,
    lugarexpedicion character varying(5),
    fechaemision timestamp without time zone DEFAULT now() NOT NULL,
    fechatimbrado timestamp without time zone,
    xmltimbrado text,
    xmlcadenaoriginal text,
    satcfdihash character varying(64),
    estado character varying(20) DEFAULT 'Pendiente'::character varying NOT NULL,
    motivocancelacion character varying(500),
    createdby integer,
    createdat timestamp without time zone DEFAULT now(),
    updatedat timestamp without time zone
);

CREATE TABLE public.inventorymovements (
    id SERIAL,
    productid integer NOT NULL,
    type character varying(10) NOT NULL,
    quantity integer NOT NULL,
    referencetype character varying(50),
    referenceid integer,
    notes character varying(500),
    userid integer,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.loginlogs (
    id SERIAL,
    userid integer,
    ipaddress character varying(50),
    action character varying(20) NOT NULL,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.patients (
    id SERIAL,
    customerid integer NOT NULL,
    medicalhistory text,
    allergies text,
    bloodtype character varying(5),
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.payments (
    id SERIAL,
    saleid integer NOT NULL,
    amount numeric(18,2) NOT NULL,
    paymentmethod character varying(30) NOT NULL,
    reference character varying(100),
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.prescriptionitems (
    id SERIAL,
    prescriptionid integer NOT NULL,
    productid integer NOT NULL,
    dosage character varying(200),
    frequency character varying(100),
    duration character varying(50),
    notes text
);

CREATE TABLE public.prescriptions (
    id SERIAL,
    patientid integer NOT NULL,
    doctorname character varying(100) NOT NULL,
    doctorlicense character varying(30),
    diagnosis text,
    notes text,
    issueddate timestamp without time zone NOT NULL,
    expirydate timestamp without time zone,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.products (
    id SERIAL,
    code character varying(50) NOT NULL,
    barcode character varying(50),
    name character varying(200) NOT NULL,
    description character varying(500),
    categoryid integer NOT NULL,
    supplierid integer,
    purchaseprice numeric(18,2) DEFAULT 0,
    saleprice numeric(18,2) DEFAULT 0,
    stock integer DEFAULT 0,
    minstock integer DEFAULT 0,
    unit character varying(20) DEFAULT ''::character varying,
    isactive boolean DEFAULT true,
    requiresprescription boolean DEFAULT false,
    createdat timestamp without time zone DEFAULT now(),
    updatedat timestamp without time zone,
    wholesale_price numeric(18,2) DEFAULT 0,
    expiry_date timestamp without time zone,
    requires_tax boolean DEFAULT true
);

CREATE TABLE public.returnitems (
    id SERIAL,
    returnid integer NOT NULL,
    productid integer NOT NULL,
    quantity integer NOT NULL,
    unitprice numeric(18,2) DEFAULT 0,
    subtotal numeric(18,2) DEFAULT 0
);

CREATE TABLE public.returns (
    id SERIAL,
    saleid integer NOT NULL,
    userid integer,
    reason character varying(500) NOT NULL,
    total numeric(18,2) DEFAULT 0,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.roles (
    id SERIAL,
    name character varying(50) NOT NULL,
    description character varying(200),
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.saleitems (
    id SERIAL,
    saleid integer NOT NULL,
    productid integer NOT NULL,
    quantity integer NOT NULL,
    unitprice numeric(18,2) DEFAULT 0,
    discount numeric(18,2) DEFAULT 0,
    subtotal numeric(18,2) DEFAULT 0
);

CREATE TABLE public.sales (
    id SERIAL,
    receiptnumber character varying(20) NOT NULL,
    userid integer NOT NULL,
    customerid integer,
    subtotal numeric(18,2) DEFAULT 0,
    tax numeric(18,2) DEFAULT 0,
    discount numeric(18,2) DEFAULT 0,
    total numeric(18,2) DEFAULT 0,
    paymentmethod character varying(30) NOT NULL,
    paymentstatus character varying(20) DEFAULT 'Completed'::character varying NOT NULL,
    notes character varying(500),
    cashregistersessionid integer,
    createdat timestamp without time zone DEFAULT now(),
    amountreceived numeric(18,2) DEFAULT 0,
    change numeric(18,2) DEFAULT 0
);

CREATE TABLE public.suppliers (
    id SERIAL,
    name character varying(100) NOT NULL,
    contactname character varying(100),
    phone character varying(20),
    email character varying(100),
    address character varying(200),
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.systemsettings (
    id SERIAL,
    key character varying(100) NOT NULL,
    value text NOT NULL,
    description character varying(200)
);

CREATE TABLE public.taxrates (
    id SERIAL,
    name character varying(100) NOT NULL,
    rate numeric(5,2) NOT NULL,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);

CREATE TABLE public.users (
    id SERIAL,
    username character varying(50) NOT NULL,
    passwordhash text NOT NULL,
    email character varying(100),
    fullname character varying(100) NOT NULL,
    roleid integer NOT NULL,
    isactive boolean DEFAULT true,
    lastlogin timestamp without time zone,
    createdat timestamp without time zone DEFAULT now(),
    updatedat timestamp without time zone
);

ALTER TABLE public.alerts OWNER TO postgres;

ALTER TABLE public.appointments OWNER TO postgres;

ALTER TABLE public.cashregisters OWNER TO postgres;

ALTER TABLE public.cashregistersessions OWNER TO postgres;

ALTER TABLE public.cat_clave_prod_serv OWNER TO postgres;

ALTER TABLE public.cat_clave_unidad OWNER TO postgres;

ALTER TABLE public.cat_forma_pago OWNER TO postgres;

ALTER TABLE public.cat_metodo_pago OWNER TO postgres;

ALTER TABLE public.cat_regimen_fiscal OWNER TO postgres;

ALTER TABLE public.cat_uso_cfdi OWNER TO postgres;

ALTER TABLE public.categories OWNER TO postgres;

ALTER TABLE public.companyinfo OWNER TO postgres;

ALTER TABLE public.customers OWNER TO postgres;

ALTER TABLE public.expense_categories OWNER TO postgres;

ALTER TABLE public.expenses OWNER TO postgres;

ALTER TABLE public.factura_items OWNER TO postgres;

ALTER TABLE public.factura_relaciones OWNER TO postgres;

ALTER TABLE public.facturas OWNER TO postgres;

ALTER TABLE public.inventorymovements OWNER TO postgres;

ALTER TABLE public.loginlogs OWNER TO postgres;

ALTER TABLE public.patients OWNER TO postgres;

ALTER TABLE public.payments OWNER TO postgres;

ALTER TABLE public.prescriptionitems OWNER TO postgres;

ALTER TABLE public.prescriptions OWNER TO postgres;

ALTER TABLE public.products OWNER TO postgres;

ALTER TABLE public.returnitems OWNER TO postgres;

ALTER TABLE public.returns OWNER TO postgres;

ALTER TABLE public.roles OWNER TO postgres;

ALTER TABLE public.saleitems OWNER TO postgres;

ALTER TABLE public.sales OWNER TO postgres;

ALTER TABLE public.suppliers OWNER TO postgres;

ALTER TABLE public.systemsettings OWNER TO postgres;

ALTER TABLE public.taxrates OWNER TO postgres;

ALTER TABLE public.users OWNER TO postgres;



































ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.cashregisters
    ADD CONSTRAINT cashregisters_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.cashregistersessions
    ADD CONSTRAINT cashregistersessions_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.cat_clave_prod_serv
    ADD CONSTRAINT cat_clave_prod_serv_codigo_key UNIQUE (codigo);

ALTER TABLE ONLY public.cat_clave_prod_serv
    ADD CONSTRAINT cat_clave_prod_serv_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.cat_clave_unidad
    ADD CONSTRAINT cat_clave_unidad_codigo_key UNIQUE (codigo);

ALTER TABLE ONLY public.cat_clave_unidad
    ADD CONSTRAINT cat_clave_unidad_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.cat_forma_pago
    ADD CONSTRAINT cat_forma_pago_codigo_key UNIQUE (codigo);

ALTER TABLE ONLY public.cat_forma_pago
    ADD CONSTRAINT cat_forma_pago_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.cat_metodo_pago
    ADD CONSTRAINT cat_metodo_pago_codigo_key UNIQUE (codigo);

ALTER TABLE ONLY public.cat_metodo_pago
    ADD CONSTRAINT cat_metodo_pago_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.cat_regimen_fiscal
    ADD CONSTRAINT cat_regimen_fiscal_codigo_key UNIQUE (codigo);

ALTER TABLE ONLY public.cat_regimen_fiscal
    ADD CONSTRAINT cat_regimen_fiscal_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.cat_uso_cfdi
    ADD CONSTRAINT cat_uso_cfdi_codigo_key UNIQUE (codigo);

ALTER TABLE ONLY public.cat_uso_cfdi
    ADD CONSTRAINT cat_uso_cfdi_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.companyinfo
    ADD CONSTRAINT companyinfo_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_documentnumber_key UNIQUE (documentnumber);

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.expense_categories
    ADD CONSTRAINT expense_categories_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.factura_items
    ADD CONSTRAINT factura_items_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.factura_relaciones
    ADD CONSTRAINT factura_relaciones_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.inventorymovements
    ADD CONSTRAINT inventorymovements_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.loginlogs
    ADD CONSTRAINT loginlogs_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.prescriptionitems
    ADD CONSTRAINT prescriptionitems_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_code_key UNIQUE (code);

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.returnitems
    ADD CONSTRAINT returnitems_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.returns
    ADD CONSTRAINT returns_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.saleitems
    ADD CONSTRAINT saleitems_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_receiptnumber_key UNIQUE (receiptnumber);

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.systemsettings
    ADD CONSTRAINT systemsettings_key_key UNIQUE (key);

ALTER TABLE ONLY public.systemsettings
    ADD CONSTRAINT systemsettings_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.taxrates
    ADD CONSTRAINT taxrates_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);

CREATE INDEX idx_factura_items_facturaid ON public.factura_items USING btree (facturaid);

CREATE INDEX idx_factura_relaciones_facturaid ON public.factura_relaciones USING btree (facturaid);

CREATE INDEX idx_facturas_estado ON public.facturas USING btree (estado);

CREATE INDEX idx_facturas_fecha_emision ON public.facturas USING btree (fechaemision);

CREATE INDEX idx_facturas_rfc_receptor ON public.facturas USING btree (receptorrfc);

CREATE INDEX idx_facturas_saleid ON public.facturas USING btree (saleid);

CREATE INDEX idx_facturas_uuid ON public.facturas USING btree (uuid);
