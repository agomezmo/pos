--
-- PostgreSQL database dump
--

\restrict 2td9imDRcuE9w8HGCs985yFcqTIjoU52tlubCS6rFHHwObqqxdjAdydoj0YpdjR

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 15.17 (Debian 15.17-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alerts (
    id integer NOT NULL,
    type character varying(30) NOT NULL,
    title character varying(200) NOT NULL,
    message character varying(500),
    referencetype character varying(50),
    referenceid integer,
    isread boolean DEFAULT false,
    userid integer,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.alerts OWNER TO postgres;

--
-- Name: alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alerts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alerts_id_seq OWNER TO postgres;

--
-- Name: alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alerts_id_seq OWNED BY public.alerts.id;


--
-- Name: appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointments (
    id integer NOT NULL,
    patientid integer NOT NULL,
    userid integer,
    appointmentdate timestamp without time zone NOT NULL,
    status character varying(20) DEFAULT 'Scheduled'::character varying NOT NULL,
    notes text,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.appointments OWNER TO postgres;

--
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appointments_id_seq OWNER TO postgres;

--
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


--
-- Name: cashregisters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cashregisters (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    location character varying(200),
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.cashregisters OWNER TO postgres;

--
-- Name: cashregisters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cashregisters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cashregisters_id_seq OWNER TO postgres;

--
-- Name: cashregisters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cashregisters_id_seq OWNED BY public.cashregisters.id;


--
-- Name: cashregistersessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cashregistersessions (
    id integer NOT NULL,
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


ALTER TABLE public.cashregistersessions OWNER TO postgres;

--
-- Name: cashregistersessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cashregistersessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cashregistersessions_id_seq OWNER TO postgres;

--
-- Name: cashregistersessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cashregistersessions_id_seq OWNED BY public.cashregistersessions.id;


--
-- Name: cat_clave_prod_serv; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cat_clave_prod_serv (
    id integer NOT NULL,
    codigo character varying(8) NOT NULL,
    descripcion character varying(500) NOT NULL,
    ivatasa numeric(5,2) DEFAULT 16.00,
    iepstasa numeric(5,2) DEFAULT 0,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.cat_clave_prod_serv OWNER TO postgres;

--
-- Name: cat_clave_prod_serv_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cat_clave_prod_serv_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cat_clave_prod_serv_id_seq OWNER TO postgres;

--
-- Name: cat_clave_prod_serv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cat_clave_prod_serv_id_seq OWNED BY public.cat_clave_prod_serv.id;


--
-- Name: cat_clave_unidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cat_clave_unidad (
    id integer NOT NULL,
    codigo character varying(3) NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion character varying(255),
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.cat_clave_unidad OWNER TO postgres;

--
-- Name: cat_clave_unidad_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cat_clave_unidad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cat_clave_unidad_id_seq OWNER TO postgres;

--
-- Name: cat_clave_unidad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cat_clave_unidad_id_seq OWNED BY public.cat_clave_unidad.id;


--
-- Name: cat_forma_pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cat_forma_pago (
    id integer NOT NULL,
    codigo character varying(2) NOT NULL,
    descripcion character varying(255) NOT NULL,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.cat_forma_pago OWNER TO postgres;

--
-- Name: cat_forma_pago_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cat_forma_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cat_forma_pago_id_seq OWNER TO postgres;

--
-- Name: cat_forma_pago_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cat_forma_pago_id_seq OWNED BY public.cat_forma_pago.id;


--
-- Name: cat_metodo_pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cat_metodo_pago (
    id integer NOT NULL,
    codigo character varying(3) NOT NULL,
    descripcion character varying(255) NOT NULL,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.cat_metodo_pago OWNER TO postgres;

--
-- Name: cat_metodo_pago_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cat_metodo_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cat_metodo_pago_id_seq OWNER TO postgres;

--
-- Name: cat_metodo_pago_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cat_metodo_pago_id_seq OWNED BY public.cat_metodo_pago.id;


--
-- Name: cat_regimen_fiscal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cat_regimen_fiscal (
    id integer NOT NULL,
    codigo character varying(3) NOT NULL,
    descripcion character varying(255) NOT NULL,
    personafisica boolean DEFAULT true,
    personamoral boolean DEFAULT true,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.cat_regimen_fiscal OWNER TO postgres;

--
-- Name: cat_regimen_fiscal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cat_regimen_fiscal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cat_regimen_fiscal_id_seq OWNER TO postgres;

--
-- Name: cat_regimen_fiscal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cat_regimen_fiscal_id_seq OWNED BY public.cat_regimen_fiscal.id;


--
-- Name: cat_uso_cfdi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cat_uso_cfdi (
    id integer NOT NULL,
    codigo character varying(3) NOT NULL,
    descripcion character varying(255) NOT NULL,
    personafisica boolean DEFAULT true,
    personamoral boolean DEFAULT true,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.cat_uso_cfdi OWNER TO postgres;

--
-- Name: cat_uso_cfdi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cat_uso_cfdi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cat_uso_cfdi_id_seq OWNER TO postgres;

--
-- Name: cat_uso_cfdi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cat_uso_cfdi_id_seq OWNED BY public.cat_uso_cfdi.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200),
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: companyinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companyinfo (
    id integer NOT NULL,
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


ALTER TABLE public.companyinfo OWNER TO postgres;

--
-- Name: companyinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companyinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companyinfo_id_seq OWNER TO postgres;

--
-- Name: companyinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companyinfo_id_seq OWNED BY public.companyinfo.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    documenttype character varying(20) NOT NULL,
    documentnumber character varying(20) NOT NULL,
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


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: expense_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expense_categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text
);


ALTER TABLE public.expense_categories OWNER TO postgres;

--
-- Name: expense_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.expense_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expense_categories_id_seq OWNER TO postgres;

--
-- Name: expense_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.expense_categories_id_seq OWNED BY public.expense_categories.id;


--
-- Name: expenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expenses (
    id integer NOT NULL,
    category character varying(100) NOT NULL,
    description character varying(500) NOT NULL,
    amount numeric(18,2) NOT NULL,
    paymentmethod character varying(30),
    reference character varying(100),
    userid integer,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.expenses OWNER TO postgres;

--
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.expenses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expenses_id_seq OWNER TO postgres;

--
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.expenses_id_seq OWNED BY public.expenses.id;


--
-- Name: factura_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factura_items (
    id integer NOT NULL,
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


ALTER TABLE public.factura_items OWNER TO postgres;

--
-- Name: factura_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.factura_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.factura_items_id_seq OWNER TO postgres;

--
-- Name: factura_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.factura_items_id_seq OWNED BY public.factura_items.id;


--
-- Name: factura_relaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factura_relaciones (
    id integer NOT NULL,
    facturaid integer NOT NULL,
    tiporelacion character varying(2) NOT NULL,
    uuidrelacionado character varying(36) NOT NULL,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.factura_relaciones OWNER TO postgres;

--
-- Name: factura_relaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.factura_relaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.factura_relaciones_id_seq OWNER TO postgres;

--
-- Name: factura_relaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.factura_relaciones_id_seq OWNED BY public.factura_relaciones.id;


--
-- Name: facturas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.facturas (
    id integer NOT NULL,
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


ALTER TABLE public.facturas OWNER TO postgres;

--
-- Name: facturas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.facturas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.facturas_id_seq OWNER TO postgres;

--
-- Name: facturas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.facturas_id_seq OWNED BY public.facturas.id;


--
-- Name: inventorymovements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventorymovements (
    id integer NOT NULL,
    productid integer NOT NULL,
    type character varying(10) NOT NULL,
    quantity integer NOT NULL,
    referencetype character varying(50),
    referenceid integer,
    notes character varying(500),
    userid integer,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.inventorymovements OWNER TO postgres;

--
-- Name: inventorymovements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventorymovements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventorymovements_id_seq OWNER TO postgres;

--
-- Name: inventorymovements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inventorymovements_id_seq OWNED BY public.inventorymovements.id;


--
-- Name: loginlogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loginlogs (
    id integer NOT NULL,
    userid integer,
    ipaddress character varying(50),
    action character varying(20) NOT NULL,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.loginlogs OWNER TO postgres;

--
-- Name: loginlogs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.loginlogs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.loginlogs_id_seq OWNER TO postgres;

--
-- Name: loginlogs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.loginlogs_id_seq OWNED BY public.loginlogs.id;


--
-- Name: patients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patients (
    id integer NOT NULL,
    customerid integer NOT NULL,
    medicalhistory text,
    allergies text,
    bloodtype character varying(5),
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.patients OWNER TO postgres;

--
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patients_id_seq OWNER TO postgres;

--
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patients_id_seq OWNED BY public.patients.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    saleid integer NOT NULL,
    amount numeric(18,2) NOT NULL,
    paymentmethod character varying(30) NOT NULL,
    reference character varying(100),
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_id_seq OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: prescription_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prescription_items (
    id integer NOT NULL,
    prescriptionid integer,
    productid integer,
    dosage character varying(100),
    frequency character varying(100),
    duration character varying(100),
    notes text
);


ALTER TABLE public.prescription_items OWNER TO postgres;

--
-- Name: prescription_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prescription_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prescription_items_id_seq OWNER TO postgres;

--
-- Name: prescription_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prescription_items_id_seq OWNED BY public.prescription_items.id;


--
-- Name: prescriptionitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prescriptionitems (
    id integer NOT NULL,
    prescriptionid integer NOT NULL,
    productid integer NOT NULL,
    dosage character varying(200),
    frequency character varying(100),
    duration character varying(50),
    notes text
);


ALTER TABLE public.prescriptionitems OWNER TO postgres;

--
-- Name: prescriptionitems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prescriptionitems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prescriptionitems_id_seq OWNER TO postgres;

--
-- Name: prescriptionitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prescriptionitems_id_seq OWNED BY public.prescriptionitems.id;


--
-- Name: prescriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prescriptions (
    id integer NOT NULL,
    patientid integer NOT NULL,
    doctorname character varying(100) NOT NULL,
    doctorlicense character varying(30),
    diagnosis text,
    notes text,
    issueddate timestamp without time zone NOT NULL,
    expirydate timestamp without time zone,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.prescriptions OWNER TO postgres;

--
-- Name: prescriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prescriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prescriptions_id_seq OWNER TO postgres;

--
-- Name: prescriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prescriptions_id_seq OWNED BY public.prescriptions.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
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


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: return_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.return_items (
    id integer NOT NULL,
    returnid integer,
    productid integer,
    quantity integer NOT NULL,
    unitprice numeric(18,2) DEFAULT 0,
    subtotal numeric(18,2) DEFAULT 0
);


ALTER TABLE public.return_items OWNER TO postgres;

--
-- Name: return_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.return_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.return_items_id_seq OWNER TO postgres;

--
-- Name: return_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.return_items_id_seq OWNED BY public.return_items.id;


--
-- Name: returnitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.returnitems (
    id integer NOT NULL,
    returnid integer NOT NULL,
    productid integer NOT NULL,
    quantity integer NOT NULL,
    unitprice numeric(18,2) DEFAULT 0,
    subtotal numeric(18,2) DEFAULT 0
);


ALTER TABLE public.returnitems OWNER TO postgres;

--
-- Name: returnitems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.returnitems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.returnitems_id_seq OWNER TO postgres;

--
-- Name: returnitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.returnitems_id_seq OWNED BY public.returnitems.id;


--
-- Name: returns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.returns (
    id integer NOT NULL,
    saleid integer NOT NULL,
    userid integer,
    reason character varying(500) NOT NULL,
    total numeric(18,2) DEFAULT 0,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.returns OWNER TO postgres;

--
-- Name: returns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.returns_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.returns_id_seq OWNER TO postgres;

--
-- Name: returns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.returns_id_seq OWNED BY public.returns.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(200),
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: saleitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.saleitems (
    id integer NOT NULL,
    saleid integer NOT NULL,
    productid integer NOT NULL,
    quantity integer NOT NULL,
    unitprice numeric(18,2) DEFAULT 0,
    discount numeric(18,2) DEFAULT 0,
    subtotal numeric(18,2) DEFAULT 0
);


ALTER TABLE public.saleitems OWNER TO postgres;

--
-- Name: saleitems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.saleitems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.saleitems_id_seq OWNER TO postgres;

--
-- Name: saleitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.saleitems_id_seq OWNED BY public.saleitems.id;


--
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales (
    id integer NOT NULL,
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


ALTER TABLE public.sales OWNER TO postgres;

--
-- Name: sales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_id_seq OWNER TO postgres;

--
-- Name: sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sales_id_seq OWNED BY public.sales.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    contactname character varying(100),
    phone character varying(20),
    email character varying(100),
    address character varying(200),
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suppliers_id_seq OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- Name: systemsettings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.systemsettings (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    value text NOT NULL,
    description character varying(200)
);


ALTER TABLE public.systemsettings OWNER TO postgres;

--
-- Name: systemsettings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.systemsettings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.systemsettings_id_seq OWNER TO postgres;

--
-- Name: systemsettings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.systemsettings_id_seq OWNED BY public.systemsettings.id;


--
-- Name: taxrates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taxrates (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    rate numeric(5,2) NOT NULL,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.taxrates OWNER TO postgres;

--
-- Name: taxrates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taxrates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taxrates_id_seq OWNER TO postgres;

--
-- Name: taxrates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.taxrates_id_seq OWNED BY public.taxrates.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
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


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: alerts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts ALTER COLUMN id SET DEFAULT nextval('public.alerts_id_seq'::regclass);


--
-- Name: appointments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- Name: cashregisters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cashregisters ALTER COLUMN id SET DEFAULT nextval('public.cashregisters_id_seq'::regclass);


--
-- Name: cashregistersessions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cashregistersessions ALTER COLUMN id SET DEFAULT nextval('public.cashregistersessions_id_seq'::regclass);


--
-- Name: cat_clave_prod_serv id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_clave_prod_serv ALTER COLUMN id SET DEFAULT nextval('public.cat_clave_prod_serv_id_seq'::regclass);


--
-- Name: cat_clave_unidad id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_clave_unidad ALTER COLUMN id SET DEFAULT nextval('public.cat_clave_unidad_id_seq'::regclass);


--
-- Name: cat_forma_pago id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_forma_pago ALTER COLUMN id SET DEFAULT nextval('public.cat_forma_pago_id_seq'::regclass);


--
-- Name: cat_metodo_pago id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_metodo_pago ALTER COLUMN id SET DEFAULT nextval('public.cat_metodo_pago_id_seq'::regclass);


--
-- Name: cat_regimen_fiscal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_regimen_fiscal ALTER COLUMN id SET DEFAULT nextval('public.cat_regimen_fiscal_id_seq'::regclass);


--
-- Name: cat_uso_cfdi id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_uso_cfdi ALTER COLUMN id SET DEFAULT nextval('public.cat_uso_cfdi_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: companyinfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companyinfo ALTER COLUMN id SET DEFAULT nextval('public.companyinfo_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: expense_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expense_categories ALTER COLUMN id SET DEFAULT nextval('public.expense_categories_id_seq'::regclass);


--
-- Name: expenses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses ALTER COLUMN id SET DEFAULT nextval('public.expenses_id_seq'::regclass);


--
-- Name: factura_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_items ALTER COLUMN id SET DEFAULT nextval('public.factura_items_id_seq'::regclass);


--
-- Name: factura_relaciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_relaciones ALTER COLUMN id SET DEFAULT nextval('public.factura_relaciones_id_seq'::regclass);


--
-- Name: facturas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas ALTER COLUMN id SET DEFAULT nextval('public.facturas_id_seq'::regclass);


--
-- Name: inventorymovements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventorymovements ALTER COLUMN id SET DEFAULT nextval('public.inventorymovements_id_seq'::regclass);


--
-- Name: loginlogs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loginlogs ALTER COLUMN id SET DEFAULT nextval('public.loginlogs_id_seq'::regclass);


--
-- Name: patients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients ALTER COLUMN id SET DEFAULT nextval('public.patients_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: prescription_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription_items ALTER COLUMN id SET DEFAULT nextval('public.prescription_items_id_seq'::regclass);


--
-- Name: prescriptionitems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptionitems ALTER COLUMN id SET DEFAULT nextval('public.prescriptionitems_id_seq'::regclass);


--
-- Name: prescriptions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions ALTER COLUMN id SET DEFAULT nextval('public.prescriptions_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: return_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_items ALTER COLUMN id SET DEFAULT nextval('public.return_items_id_seq'::regclass);


--
-- Name: returnitems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returnitems ALTER COLUMN id SET DEFAULT nextval('public.returnitems_id_seq'::regclass);


--
-- Name: returns id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returns ALTER COLUMN id SET DEFAULT nextval('public.returns_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: saleitems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saleitems ALTER COLUMN id SET DEFAULT nextval('public.saleitems_id_seq'::regclass);


--
-- Name: sales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales ALTER COLUMN id SET DEFAULT nextval('public.sales_id_seq'::regclass);


--
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- Name: systemsettings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.systemsettings ALTER COLUMN id SET DEFAULT nextval('public.systemsettings_id_seq'::regclass);


--
-- Name: taxrates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxrates ALTER COLUMN id SET DEFAULT nextval('public.taxrates_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: alerts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alerts (id, type, title, message, referencetype, referenceid, isread, userid, createdat) FROM stdin;
\.


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointments (id, patientid, userid, appointmentdate, status, notes, createdat) FROM stdin;
\.


--
-- Data for Name: cashregisters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cashregisters (id, name, location, isactive, createdat) FROM stdin;
\.


--
-- Data for Name: cashregistersessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cashregistersessions (id, cashregisterid, userid, openingamount, closingamount, openingnotes, closingnotes, openedat, closedat, status) FROM stdin;
\.


--
-- Data for Name: cat_clave_prod_serv; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cat_clave_prod_serv (id, codigo, descripcion, ivatasa, iepstasa, isactive, createdat) FROM stdin;
1	51101700	Medicamentos	16.00	0.00	t	2026-05-14 12:12:18.881971
2	51101701	Antibióticos	16.00	0.00	t	2026-05-14 12:12:18.881971
3	51101702	Analgésicos	16.00	0.00	t	2026-05-14 12:12:18.881971
4	51101703	Antiinflamatorios	16.00	0.00	t	2026-05-14 12:12:18.881971
5	51101704	Vitaminas y suplementos	16.00	0.00	t	2026-05-14 12:12:18.881971
6	51101705	Medicamentos controlados	16.00	0.00	t	2026-05-14 12:12:18.881971
7	51101706	Antialérgicos	16.00	0.00	t	2026-05-14 12:12:18.881971
8	51101707	Medicamentos gastrointestinales	16.00	0.00	t	2026-05-14 12:12:18.881971
9	51101708	Medicamentos cardiovasculares	16.00	0.00	t	2026-05-14 12:12:18.881971
10	51101709	Medicamentos respiratorios	16.00	0.00	t	2026-05-14 12:12:18.881971
11	51101710	Medicamentos tópicos	16.00	0.00	t	2026-05-14 12:12:18.881971
12	51101711	Medicamentos oftálmicos	16.00	0.00	t	2026-05-14 12:12:18.881971
13	51101712	Medicamentos oncológicos	16.00	0.00	t	2026-05-14 12:12:18.881971
14	50410000	Equipo y material médico quirúrgico	16.00	0.00	t	2026-05-14 12:12:18.881971
15	50420000	Equipo de primeros auxilios	16.00	0.00	t	2026-05-14 12:12:18.881971
16	42200000	Productos de cuidado personal y belleza	16.00	0.00	t	2026-05-14 12:12:18.881971
17	42203000	Cosméticos	16.00	0.00	t	2026-05-14 12:12:18.881971
18	42203500	Productos de higiene personal	16.00	0.00	t	2026-05-14 12:12:18.881971
19	50180000	Servicios de farmacia	16.00	0.00	t	2026-05-14 12:12:18.881971
20	81100000	Servicios profesionales de salud	16.00	0.00	t	2026-05-14 12:12:18.881971
21	01000000	Productos agrícolas (productos naturales)	0.00	0.00	t	2026-05-14 12:12:18.881971
22	55101500	Alimentos y bebidas	16.00	0.00	t	2026-05-14 12:12:18.881971
23	90111600	Artículos de papelería	16.00	0.00	t	2026-05-14 12:12:18.881971
\.


--
-- Data for Name: cat_clave_unidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cat_clave_unidad (id, codigo, nombre, descripcion, isactive, createdat) FROM stdin;
1	H87	Pieza	Pieza	t	2026-05-14 12:12:18.881971
2	EA	Elemento	Elemento	t	2026-05-14 12:12:18.881971
3	KGM	Kilogramo	Kilogramo	t	2026-05-14 12:12:18.881971
4	GRM	Gramo	Gramo	t	2026-05-14 12:12:18.881971
5	MLT	Mililitro	Mililitro	t	2026-05-14 12:12:18.881971
6	LTR	Litro	Litro	t	2026-05-14 12:12:18.881971
7	MGM	Miligramo	Miligramo	t	2026-05-14 12:12:18.881971
8	C62	Unidad	Unidad	t	2026-05-14 12:12:18.881971
9	XPK	Paquete	Paquete	t	2026-05-14 12:12:18.881971
10	XBX	Caja	Caja	t	2026-05-14 12:12:18.881971
11	DZN	Docena	Docena	t	2026-05-14 12:12:18.881971
\.


--
-- Data for Name: cat_forma_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cat_forma_pago (id, codigo, descripcion, isactive, createdat) FROM stdin;
1	01	Efectivo	t	2026-05-14 12:12:18.881971
2	02	Cheque nominativo	t	2026-05-14 12:12:18.881971
3	03	Transferencia electrónica de fondos	t	2026-05-14 12:12:18.881971
4	04	Tarjeta de crédito	t	2026-05-14 12:12:18.881971
5	05	Monedero electrónico	t	2026-05-14 12:12:18.881971
6	06	Dinero electrónico	t	2026-05-14 12:12:18.881971
7	08	Vales de despensa	t	2026-05-14 12:12:18.881971
8	12	Dación en pago	t	2026-05-14 12:12:18.881971
9	13	Pago por subrogación	t	2026-05-14 12:12:18.881971
10	14	Pago por consignación	t	2026-05-14 12:12:18.881971
11	15	Condonación	t	2026-05-14 12:12:18.881971
12	17	Compensación	t	2026-05-14 12:12:18.881971
13	23	Novación	t	2026-05-14 12:12:18.881971
14	24	Confusión	t	2026-05-14 12:12:18.881971
15	25	Remisión de deuda	t	2026-05-14 12:12:18.881971
16	26	Prescripción o caducidad	t	2026-05-14 12:12:18.881971
17	27	A satisfacción del acreedor	t	2026-05-14 12:12:18.881971
18	28	Tarjeta de débito	t	2026-05-14 12:12:18.881971
19	29	Tarjeta de servicio	t	2026-05-14 12:12:18.881971
20	30	Aplicación de anticipos	t	2026-05-14 12:12:18.881971
21	31	Intermediario pagos	t	2026-05-14 12:12:18.881971
22	99	Por definir	t	2026-05-14 12:12:18.881971
\.


--
-- Data for Name: cat_metodo_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cat_metodo_pago (id, codigo, descripcion, createdat) FROM stdin;
1	PUE	Pago en una sola exhibición	2026-05-14 12:12:18.881971
2	PPD	Pago en parcialidades o diferido	2026-05-14 12:12:18.881971
\.


--
-- Data for Name: cat_regimen_fiscal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cat_regimen_fiscal (id, codigo, descripcion, personafisica, personamoral, isactive, createdat) FROM stdin;
1	601	General de Ley Personas Morales	f	t	t	2026-05-14 12:12:18.881971
2	603	Personas Morales con Fines no Lucrativos	f	t	t	2026-05-14 12:12:18.881971
3	605	Sueldos y Salarios e Ingresos Asimilados a Salarios	t	f	t	2026-05-14 12:12:18.881971
4	606	Arrendamiento	t	f	t	2026-05-14 12:12:18.881971
5	607	Régimen de Enajenación o Adquisición de Bienes	t	f	t	2026-05-14 12:12:18.881971
6	608	Demás ingresos	t	f	t	2026-05-14 12:12:18.881971
7	610	Residentes en el Extranjero sin Establecimiento Permanente en México	t	t	t	2026-05-14 12:12:18.881971
8	611	Ingresos por Dividendos (Socios y Accionistas)	t	f	t	2026-05-14 12:12:18.881971
9	612	Personas Físicas con Actividades Empresariales y Profesionales	t	f	t	2026-05-14 12:12:18.881971
10	614	Ingresos por intereses	t	f	t	2026-05-14 12:12:18.881971
11	615	Régimen de los ingresos por obtención de premios	t	f	t	2026-05-14 12:12:18.881971
12	616	Sin obligaciones fiscales	t	f	t	2026-05-14 12:12:18.881971
13	620	Régimen Simplificado de Confianza	t	f	t	2026-05-14 12:12:18.881971
14	621	Régimen de Incorporación Fiscal	t	f	t	2026-05-14 12:12:18.881971
15	622	Actividades Agrícolas, Ganaderas, Silvícolas y Pesqueras	t	t	t	2026-05-14 12:12:18.881971
16	623	Opcional para Grupos de Sociedades	f	t	t	2026-05-14 12:12:18.881971
17	624	Coordinados	t	f	t	2026-05-14 12:12:18.881971
18	625	Régimen de las Actividades Empresariales con ingresos a través de Plataformas Tecnológicas	t	f	t	2026-05-14 12:12:18.881971
\.


--
-- Data for Name: cat_uso_cfdi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cat_uso_cfdi (id, codigo, descripcion, personafisica, personamoral, isactive, createdat) FROM stdin;
1	G01	Adquisición de mercancías	t	t	t	2026-05-14 12:12:18.881971
2	G03	Gastos en general	t	t	t	2026-05-14 12:12:18.881971
3	D01	Honorarios médicos, dentales y gastos hospitalarios	t	f	t	2026-05-14 12:12:18.881971
4	D02	Gastos médicos por incapacidad o discapacidad	t	f	t	2026-05-14 12:12:18.881971
5	D03	Gastos funerales	t	f	t	2026-05-14 12:12:18.881971
6	D04	Donativos	t	f	t	2026-05-14 12:12:18.881971
7	D05	Intereses reales efectivamente pagados por créditos hipotecarios	t	f	t	2026-05-14 12:12:18.881971
8	D06	Aportaciones voluntarias al SAR	t	f	t	2026-05-14 12:12:18.881971
9	D07	Primas por seguros de gastos médicos	t	f	t	2026-05-14 12:12:18.881971
10	D08	Gastos de transportación escolar obligatoria	t	f	t	2026-05-14 12:12:18.881971
11	D09	Depósitos en cuentas para el ahorro	t	f	t	2026-05-14 12:12:18.881971
12	D10	Pagos por servicios educativos (colegiaturas)	t	f	t	2026-05-14 12:12:18.881971
13	I01	Construcciones	f	t	t	2026-05-14 12:12:18.881971
14	I02	Mobiliario y equipo de oficina	f	t	t	2026-05-14 12:12:18.881971
15	I03	Equipo de transporte	f	t	t	2026-05-14 12:12:18.881971
16	I04	Equipo de cómputo y accesorios	f	t	t	2026-05-14 12:12:18.881971
17	I05	Dados de baja	f	t	t	2026-05-14 12:12:18.881971
18	I06	Comunicaciones telefónicas	f	t	t	2026-05-14 12:12:18.881971
19	I07	Comunicaciones satelitales	f	t	t	2026-05-14 12:12:18.881971
20	I08	Otra maquinaria y equipo	f	t	t	2026-05-14 12:12:18.881971
21	P01	Por definir	t	t	t	2026-05-14 12:12:18.881971
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, description, isactive, createdat) FROM stdin;
1	Analgésicos	Medicamentos para el alivio del dolor	t	2026-05-14 06:37:15.241084
2	Antibióticos	Medicamentos para infecciones bacterianas	t	2026-05-14 06:37:15.241084
3	Vitaminas	Suplementos vitamínicos y minerales	t	2026-05-14 06:37:15.241084
4	Cuidado Personal	Productos de cuidado e higiene personal	t	2026-05-14 06:37:15.241084
5	Respiratorios	Medicamentos para afecciones respiratorias	t	2026-05-14 06:37:15.241084
6	Gastrointestinales	Medicamentos para el sistema digestivo	t	2026-05-14 06:37:15.241084
7	Cardiovasculares	Medicamentos para el corazón y circulación	t	2026-05-14 06:37:15.241084
8	Sistema Nervioso	Medicamentos para el sistema nervioso	t	2026-05-14 06:37:15.241084
9	Dermatológicos	Productos para el cuidado de la piel	t	2026-05-14 06:37:15.241084
\.


--
-- Data for Name: companyinfo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companyinfo (id, name, address, phone, email, logourl, taxid, receiptfooter, rfc, codigopostal, certificadosat, certificadokey, certificadopassword, regimenfiscalcode, seriefactura, folioactual, regimenfiscalid) FROM stdin;
1	Farmacia Mi Salud	Av. Principal 1000, Lima	01-5551234	contacto@farmaciamisalud.com	\N	20123456789	¡Gracias por su preferencia!	EKU9003173C9	45000	\N	\N	\N	601	F	6	1
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, documenttype, documentnumber, fullname, phone, email, address, birthdate, createdat, updatedat, rfc, razonsocial, codigopostal, regimenfiscalid, usocfdiid) FROM stdin;
1			ALEJANDRO GOMEZ MONDRAGON	5656565656	alejandro.gomez.mondragon@gmail.com	El Toreo	1970-09-20	2026-05-15 09:03:38.509242	\N	GOMA700920CE4		54769	2	3
\.


--
-- Data for Name: expense_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expense_categories (id, name, description) FROM stdin;
1	Servicios	Pagos de servicios básicos: luz, agua, internet
2	Alquiler	Pago de alquiler del local
3	Salarios	Salarios del personal
4	Insumos	Compra de insumos y materiales
5	Mantenimiento	Mantenimiento de equipos e instalaciones
6	Publicidad	Gastos de marketing y publicidad
\.


--
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expenses (id, category, description, amount, paymentmethod, reference, userid, createdat) FROM stdin;
1	Alquiler	Renta 	8000.00	\N	\N	1	2026-05-14 09:05:41.211224
\.


--
-- Data for Name: factura_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.factura_items (id, facturaid, saleitemid, productoid, cantidad, claveprodserv, claveunidad, unidad, noidentificacion, descripcion, valorunitario, descuento, importe, ivatasa, ivabase, ivaimporte, iepstasa, iepsbase, iepsimporte, createdat) FROM stdin;
1	3	88	12	5.000000	51101700	H87	Parche	MEX012	Parche Diclofenaco 140mg x5	14.00	0.00	70.00	16.00	70.00	11.20	0.00	0.00	0.00	2026-05-14 12:26:15.978489
2	3	89	119	1.000000	51101700	H87	Caja	MEX119	Cubrebocas KN95 x5	22.00	0.00	22.00	16.00	22.00	3.52	0.00	0.00	0.00	2026-05-14 12:26:15.978495
3	3	90	84	4.000000	51101700	H87	Frasco	MEX084	Nistatina Suspensión 30ml	12.00	0.00	48.00	16.00	48.00	7.68	0.00	0.00	0.00	2026-05-14 12:26:15.978496
4	4	103	6	3.000000	51101700	H87	Ampolla	MEX006	Diclofenaco 75mg x10	7.00	0.00	21.00	16.00	21.00	3.36	0.00	0.00	0.00	2026-05-14 12:31:28.428655
5	4	104	57	1.000000	51101700	H87	Frasco	MEX057	Agua Oxigenada 500ml	5.00	0.00	5.00	16.00	5.00	0.80	0.00	0.00	0.00	2026-05-14 12:31:28.428662
6	4	105	27	3.000000	51101700	H87	Cápsula	MEX027	Dicloxacilina 500mg x20	16.00	0.00	48.00	16.00	48.00	7.68	0.00	0.00	0.00	2026-05-14 12:31:28.428663
7	5	205	63	3.000000	51101700	H87	Inhalador	MEX063	Salbutamol Inhalador 200 dosis	35.00	0.00	105.00	16.00	105.00	16.80	0.00	0.00	0.00	2026-05-15 09:03:55.105048
8	5	206	104	2.000000	51101700	H87	Tubo	MEX104	Clotrimazol Crema 20g	12.00	0.00	24.00	16.00	24.00	3.84	0.00	0.00	0.00	2026-05-15 09:03:55.10638
9	5	207	7	2.000000	51101700	H87	Ampolla	MEX007	Ketorolaco 30mg x6	15.00	0.00	30.00	16.00	30.00	4.80	0.00	0.00	0.00	2026-05-15 09:03:55.106382
10	5	208	76	1.000000	51101700	H87	Tableta	MEX076	Hioscina 10mg x20	8.00	0.00	8.00	16.00	8.00	1.28	0.00	0.00	0.00	2026-05-15 09:03:55.106383
11	6	240	57	4.000000	51101700	H87	Frasco	MEX057	Agua Oxigenada 500ml	5.00	0.00	20.00	16.00	20.00	3.20	0.00	0.00	0.00	2026-05-15 21:54:45.457011
12	6	241	78	2.000000	51101700	H87	Tableta	MEX078	Metoclopramida 10mg x10	9.00	0.00	18.00	16.00	18.00	2.88	0.00	0.00	0.00	2026-05-15 21:54:45.457816
13	7	278	70	3.000000	51101700	H87	Tableta	MEX070	Ambroxol 30mg x20	8.00	0.00	24.00	16.00	24.00	3.84	0.00	0.00	0.00	2026-05-15 22:15:09.439215
14	8	297	54	4.000000	51101700	H87	Tubo	MEX054	Pasta Dental 120ml	9.00	0.00	36.00	16.00	36.00	5.76	0.00	0.00	0.00	2026-05-15 23:15:42.845909
15	8	298	61	1.000000	51101700	H87	Unidad	MEX061	Termómetro Digital	15.00	0.00	15.00	16.00	15.00	2.40	0.00	0.00	0.00	2026-05-15 23:15:42.846715
\.


--
-- Data for Name: factura_relaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.factura_relaciones (id, facturaid, tiporelacion, uuidrelacionado, createdat) FROM stdin;
\.


--
-- Data for Name: facturas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.facturas (id, saleid, uuid, folio, serie, emisorrfc, emisornombre, emisorregimenfiscal, emisorcodigopostal, receptorrfc, receptornombre, receptorusocfdi, receptorcodigopostal, subtotal, descuento, iva, ieps, total, formapago, metodopago, moneda, tipocambio, lugarexpedicion, fechaemision, fechatimbrado, xmltimbrado, xmlcadenaoriginal, satcfdihash, estado, motivocancelacion, createdby, createdat, updatedat) FROM stdin;
3	30	\N	000001	F	EKU9003173C9	Farmacia Mi Salud	601	45000	XAXX010101000	PUBLICO EN GENERAL	G01	\N	140.00	0.00	22.40	0.00	162.40	01	PUE	MXN	1.000000	45000	2026-05-14 12:26:15.978487	\N	\N	\N	\N	Pendiente	\N	1	2026-05-14 12:26:15.978484	\N
4	35	\N	000002	F	EKU9003173C9	Farmacia Mi Salud	601	45000	GOMA700920CE4	PUBLICO EN GENERAL	G01	\N	74.00	0.00	11.84	0.00	85.84	01	PUE	MXN	1.000000	45000	2026-05-14 12:31:28.428653	\N	\N	\N	\N	Pendiente	\N	1	2026-05-14 12:31:28.428648	\N
5	66	\N	000003	F	EKU9003173C9	Farmacia Mi Salud	601	45000	GOMA700920CE4	ALEJANDRO GOMEZ MONDRAGON	D01	54769	167.00	0.00	16.70	0.00	183.70	01	PUE	MXN	1.000000	45000	2026-05-15 09:03:55.104649	\N	\N	\N	\N	Pendiente	\N	1	2026-05-15 09:03:55.103205	\N
6	78	\N	000004	F	EKU9003173C9	Farmacia Mi Salud	601	45000	GOMA700920CE4	ALEJANDRO GOMEZ MONDRAGON	D01	54769	38.00	0.00	3.20	0.00	41.20	01	PUE	MXN	1.000000	45000	2026-05-15 21:54:45.456783	\N	\N	\N	\N	Pendiente	\N	1	2026-05-15 21:54:45.455942	\N
7	88	\N	000005	F	EKU9003173C9	Farmacia Mi Salud	601	45000	GOMA700920CE4	ALEJANDRO GOMEZ MONDRAGON	D01	54769	24.00	0.00	0.00	0.00	24.00	01	PUE	MXN	1.000000	45000	2026-05-15 22:15:09.439212	\N	\N	\N	\N	Pendiente	\N	1	2026-05-15 22:15:09.439208	\N
8	94	\N	000006	F	EKU9003173C9	Farmacia Mi Salud	601	45000	GOMA700920CE4	ALEJANDRO GOMEZ MONDRAGON	D01	54769	51.00	0.00	8.16	0.00	59.16	01	PUE	MXN	1.000000	45000	2026-05-15 23:15:42.84568	\N	\N	\N	\N	Pendiente	\N	1	2026-05-15 23:15:42.844856	\N
\.


--
-- Data for Name: inventorymovements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventorymovements (id, productid, type, quantity, referencetype, referenceid, notes, userid, createdat) FROM stdin;
1	117	OUT	4	Sale	\N	Sale FAC-20260514-0001	1	2026-05-14 08:29:45.081535
2	15	OUT	3	Sale	\N	Sale FAC-20260514-0001	1	2026-05-14 08:29:45.1067
3	2	OUT	1	Sale	\N	Sale FAC-20260514-0001	1	2026-05-14 08:29:45.108655
4	117	OUT	5	Sale	\N	Sale FAC-20260514-0002	1	2026-05-14 08:29:45.719959
5	64	OUT	5	Sale	\N	Sale FAC-20260514-0002	1	2026-05-14 08:29:45.721485
6	85	OUT	1	Sale	\N	Sale FAC-20260514-0002	1	2026-05-14 08:29:45.722749
7	65	OUT	4	Sale	\N	Sale FAC-20260514-0003	1	2026-05-14 08:29:46.064341
8	57	OUT	3	Sale	\N	Sale FAC-20260514-0003	1	2026-05-14 08:29:46.066313
9	12	OUT	5	Sale	\N	Sale FAC-20260514-0003	1	2026-05-14 08:29:46.067829
10	111	OUT	4	Sale	\N	Sale FAC-20260514-0004	1	2026-05-14 08:29:46.397409
11	78	OUT	2	Sale	\N	Sale FAC-20260514-0004	1	2026-05-14 08:29:46.399146
12	81	OUT	2	Sale	\N	Sale FAC-20260514-0004	1	2026-05-14 08:29:46.40042
13	113	OUT	5	Sale	\N	Sale FAC-20260514-0005	1	2026-05-14 08:29:46.728686
14	64	OUT	3	Sale	\N	Sale FAC-20260514-0005	1	2026-05-14 08:29:46.730903
15	80	OUT	5	Sale	\N	Sale FAC-20260514-0005	1	2026-05-14 08:29:46.732861
16	59	OUT	4	Sale	\N	Sale FAC-20260514-0006	1	2026-05-14 08:44:20.298907
17	67	OUT	4	Sale	\N	Sale FAC-20260514-0006	1	2026-05-14 08:44:20.300769
18	26	OUT	3	Sale	\N	Sale FAC-20260514-0006	1	2026-05-14 08:44:20.302363
19	47	OUT	3	Sale	\N	Sale FAC-20260514-0007	1	2026-05-14 08:44:20.626597
20	26	OUT	1	Sale	\N	Sale FAC-20260514-0007	1	2026-05-14 08:44:20.629622
21	56	OUT	4	Sale	\N	Sale FAC-20260514-0007	1	2026-05-14 08:44:20.632492
22	99	OUT	2	Sale	\N	Sale FAC-20260514-0008	1	2026-05-14 08:44:20.971265
23	33	OUT	3	Sale	\N	Sale FAC-20260514-0008	1	2026-05-14 08:44:20.974424
24	98	OUT	2	Sale	\N	Sale FAC-20260514-0008	1	2026-05-14 08:44:20.975766
25	61	OUT	4	Sale	\N	Sale FAC-20260514-0009	1	2026-05-14 08:44:21.311927
26	1	OUT	2	Sale	\N	Sale FAC-20260514-0009	1	2026-05-14 08:44:21.314899
27	98	OUT	1	Sale	\N	Sale FAC-20260514-0009	1	2026-05-14 08:44:21.317887
28	79	OUT	5	Sale	\N	Sale FAC-20260514-0010	1	2026-05-14 08:44:21.652947
29	3	OUT	1	Sale	\N	Sale FAC-20260514-0010	1	2026-05-14 08:44:21.654363
30	99	OUT	5	Sale	\N	Sale FAC-20260514-0010	1	2026-05-14 08:44:21.656709
31	24	OUT	2	Sale	\N	Sale FAC-20260514-0011	1	2026-05-14 08:48:46.766224
32	52	OUT	4	Sale	\N	Sale FAC-20260514-0011	1	2026-05-14 08:48:46.768805
33	8	OUT	3	Sale	\N	Sale FAC-20260514-0011	1	2026-05-14 08:48:46.770087
34	70	OUT	3	Sale	\N	Sale FAC-20260514-0012	1	2026-05-14 08:48:47.097809
35	58	OUT	5	Sale	\N	Sale FAC-20260514-0012	1	2026-05-14 08:48:47.099546
36	30	OUT	3	Sale	\N	Sale FAC-20260514-0012	1	2026-05-14 08:48:47.100869
37	77	OUT	1	Sale	\N	Sale FAC-20260514-0013	1	2026-05-14 08:48:47.426288
38	25	OUT	4	Sale	\N	Sale FAC-20260514-0013	1	2026-05-14 08:48:47.429115
39	32	OUT	2	Sale	\N	Sale FAC-20260514-0013	1	2026-05-14 08:48:47.430823
40	105	OUT	5	Sale	\N	Sale FAC-20260514-0014	1	2026-05-14 08:48:47.764928
41	16	OUT	1	Sale	\N	Sale FAC-20260514-0014	1	2026-05-14 08:48:47.767742
42	83	OUT	5	Sale	\N	Sale FAC-20260514-0014	1	2026-05-14 08:48:47.769324
43	60	OUT	4	Sale	\N	Sale FAC-20260514-0015	1	2026-05-14 08:48:48.100678
44	109	OUT	5	Sale	\N	Sale FAC-20260514-0015	1	2026-05-14 08:48:48.102943
45	81	OUT	5	Sale	\N	Sale FAC-20260514-0015	1	2026-05-14 08:48:48.106936
46	50	OUT	5	Sale	\N	Sale FAC-20260514-0016	1	2026-05-14 09:26:03.773132
47	96	OUT	4	Sale	\N	Sale FAC-20260514-0016	1	2026-05-14 09:26:03.775151
48	119	OUT	5	Sale	\N	Sale FAC-20260514-0016	1	2026-05-14 09:26:03.776268
49	100	OUT	1	Sale	\N	Sale FAC-20260514-0017	1	2026-05-14 09:26:04.123152
50	99	OUT	1	Sale	\N	Sale FAC-20260514-0017	1	2026-05-14 09:26:04.126115
51	36	OUT	5	Sale	\N	Sale FAC-20260514-0017	1	2026-05-14 09:26:04.128322
52	27	OUT	4	Sale	\N	Sale FAC-20260514-0018	1	2026-05-14 09:26:04.46536
53	79	OUT	2	Sale	\N	Sale FAC-20260514-0018	1	2026-05-14 09:26:04.466779
54	42	OUT	3	Sale	\N	Sale FAC-20260514-0018	1	2026-05-14 09:26:04.468094
55	90	OUT	1	Sale	\N	Sale FAC-20260514-0019	1	2026-05-14 09:26:04.798488
56	41	OUT	5	Sale	\N	Sale FAC-20260514-0019	1	2026-05-14 09:26:04.800017
57	7	OUT	4	Sale	\N	Sale FAC-20260514-0019	1	2026-05-14 09:26:04.802328
58	20	OUT	4	Sale	\N	Sale FAC-20260514-0020	1	2026-05-14 09:26:05.146233
59	15	OUT	2	Sale	\N	Sale FAC-20260514-0020	1	2026-05-14 09:26:05.148766
60	55	OUT	1	Sale	\N	Sale FAC-20260514-0020	1	2026-05-14 09:26:05.151574
61	20	OUT	2	Sale	\N	Sale FAC-20260514-0021	1	2026-05-14 10:06:28.279776
62	119	OUT	4	Sale	\N	Sale FAC-20260514-0021	1	2026-05-14 10:06:28.282574
63	117	OUT	1	Sale	\N	Sale FAC-20260514-0021	1	2026-05-14 10:06:28.283856
64	22	OUT	3	Sale	\N	Sale FAC-20260514-0022	1	2026-05-14 10:06:28.629635
65	4	OUT	5	Sale	\N	Sale FAC-20260514-0022	1	2026-05-14 10:06:28.631032
66	42	OUT	4	Sale	\N	Sale FAC-20260514-0022	1	2026-05-14 10:06:28.632173
67	74	OUT	3	Sale	\N	Sale FAC-20260514-0023	1	2026-05-14 10:06:28.957138
68	78	OUT	2	Sale	\N	Sale FAC-20260514-0023	1	2026-05-14 10:06:28.958848
69	19	OUT	4	Sale	\N	Sale FAC-20260514-0023	1	2026-05-14 10:06:28.960387
70	89	OUT	3	Sale	\N	Sale FAC-20260514-0024	1	2026-05-14 10:06:29.292889
71	73	OUT	3	Sale	\N	Sale FAC-20260514-0024	1	2026-05-14 10:06:29.29422
72	57	OUT	4	Sale	\N	Sale FAC-20260514-0024	1	2026-05-14 10:06:29.295342
73	44	OUT	3	Sale	\N	Sale FAC-20260514-0025	1	2026-05-14 10:06:29.62211
74	3	OUT	1	Sale	\N	Sale FAC-20260514-0025	1	2026-05-14 10:06:29.623282
75	119	OUT	3	Sale	\N	Sale FAC-20260514-0025	1	2026-05-14 10:06:29.625179
76	34	OUT	2	Sale	\N	Sale FAC-20260514-0026	1	2026-05-14 10:07:15.442797
77	119	OUT	3	Sale	\N	Sale FAC-20260514-0026	1	2026-05-14 10:07:15.445006
78	55	OUT	4	Sale	\N	Sale FAC-20260514-0026	1	2026-05-14 10:07:15.446399
79	85	OUT	5	Sale	\N	Sale FAC-20260514-0027	1	2026-05-14 10:07:15.778425
80	41	OUT	3	Sale	\N	Sale FAC-20260514-0027	1	2026-05-14 10:07:15.780437
81	62	OUT	4	Sale	\N	Sale FAC-20260514-0027	1	2026-05-14 10:07:15.782348
82	91	OUT	2	Sale	\N	Sale FAC-20260514-0028	1	2026-05-14 10:07:16.102774
83	37	OUT	5	Sale	\N	Sale FAC-20260514-0028	1	2026-05-14 10:07:16.10399
84	43	OUT	2	Sale	\N	Sale FAC-20260514-0028	1	2026-05-14 10:07:16.104953
85	89	OUT	4	Sale	\N	Sale FAC-20260514-0029	1	2026-05-14 10:07:16.431629
86	74	OUT	4	Sale	\N	Sale FAC-20260514-0029	1	2026-05-14 10:07:16.433018
87	84	OUT	1	Sale	\N	Sale FAC-20260514-0029	1	2026-05-14 10:07:16.43505
88	12	OUT	5	Sale	\N	Sale FAC-20260514-0030	1	2026-05-14 10:07:16.760217
89	119	OUT	1	Sale	\N	Sale FAC-20260514-0030	1	2026-05-14 10:07:16.761978
90	84	OUT	4	Sale	\N	Sale FAC-20260514-0030	1	2026-05-14 10:07:16.763462
91	11	OUT	3	Sale	\N	Sale FAC-20260514-0031	1	2026-05-14 12:29:32.30293
92	20	OUT	5	Sale	\N	Sale FAC-20260514-0031	1	2026-05-14 12:29:32.329119
93	53	OUT	4	Sale	\N	Sale FAC-20260514-0031	1	2026-05-14 12:29:32.332127
94	43	OUT	4	Sale	\N	Sale FAC-20260514-0032	1	2026-05-14 12:29:32.851247
95	47	OUT	3	Sale	\N	Sale FAC-20260514-0032	1	2026-05-14 12:29:32.853284
96	101	OUT	4	Sale	\N	Sale FAC-20260514-0032	1	2026-05-14 12:29:32.855148
97	10	OUT	1	Sale	\N	Sale FAC-20260514-0033	1	2026-05-14 12:29:33.196035
98	115	OUT	5	Sale	\N	Sale FAC-20260514-0033	1	2026-05-14 12:29:33.198197
99	116	OUT	4	Sale	\N	Sale FAC-20260514-0033	1	2026-05-14 12:29:33.200623
100	62	OUT	2	Sale	\N	Sale FAC-20260514-0034	1	2026-05-14 12:29:33.53728
101	67	OUT	4	Sale	\N	Sale FAC-20260514-0034	1	2026-05-14 12:29:33.539118
102	88	OUT	4	Sale	\N	Sale FAC-20260514-0034	1	2026-05-14 12:29:33.540552
103	6	OUT	3	Sale	\N	Sale FAC-20260514-0035	1	2026-05-14 12:29:33.871485
104	57	OUT	1	Sale	\N	Sale FAC-20260514-0035	1	2026-05-14 12:29:33.873919
105	27	OUT	3	Sale	\N	Sale FAC-20260514-0035	1	2026-05-14 12:29:33.875445
106	32	OUT	4	Sale	\N	Sale FAC-20260515-0001	1	2026-05-15 08:34:00.760014
107	53	OUT	3	Sale	\N	Sale FAC-20260515-0001	1	2026-05-15 08:34:00.805794
108	50	OUT	1	Sale	\N	Sale FAC-20260515-0001	1	2026-05-15 08:34:00.808812
109	102	OUT	3	Sale	\N	Sale FAC-20260515-0001	1	2026-05-15 08:34:00.810777
110	74	OUT	2	Sale	\N	Sale FAC-20260515-0001	1	2026-05-15 08:34:00.812865
111	9	OUT	2	Sale	\N	Sale FAC-20260515-0002	1	2026-05-15 08:34:01.383633
112	115	OUT	4	Sale	\N	Sale FAC-20260515-0002	1	2026-05-15 08:34:01.38717
113	44	OUT	4	Sale	\N	Sale FAC-20260515-0002	1	2026-05-15 08:34:01.390892
114	57	OUT	4	Sale	\N	Sale FAC-20260515-0002	1	2026-05-15 08:34:01.394288
115	81	OUT	3	Sale	\N	Sale FAC-20260515-0003	1	2026-05-15 08:34:01.636842
116	79	OUT	3	Sale	\N	Sale FAC-20260515-0003	1	2026-05-15 08:34:01.64191
117	27	OUT	3	Sale	\N	Sale FAC-20260515-0003	1	2026-05-15 08:34:01.643532
118	82	OUT	3	Sale	\N	Sale FAC-20260515-0003	1	2026-05-15 08:34:01.645361
119	115	OUT	3	Sale	\N	Sale FAC-20260515-0004	1	2026-05-15 08:34:01.823462
120	28	OUT	5	Sale	\N	Sale FAC-20260515-0005	1	2026-05-15 08:34:02.014134
121	10	OUT	1	Sale	\N	Sale FAC-20260515-0005	1	2026-05-15 08:34:02.018881
122	76	OUT	4	Sale	\N	Sale FAC-20260515-0005	1	2026-05-15 08:34:02.020791
123	42	OUT	4	Sale	\N	Sale FAC-20260515-0006	1	2026-05-15 08:34:02.196535
124	42	IN	4	Cancellation	\N	Cancelled sale FAC-20260515-0006	\N	2026-05-15 08:34:02.466899
125	49	OUT	3	Sale	\N	Sale FAC-20260515-0007	1	2026-05-15 08:37:39.697274
126	42	OUT	1	Sale	\N	Sale FAC-20260515-0007	1	2026-05-15 08:37:39.699108
127	98	OUT	5	Sale	\N	Sale FAC-20260515-0007	1	2026-05-15 08:37:39.700327
128	74	OUT	5	Sale	\N	Sale FAC-20260515-0007	1	2026-05-15 08:37:39.701475
129	55	OUT	4	Sale	\N	Sale FAC-20260515-0007	1	2026-05-15 08:37:39.702595
130	66	OUT	3	Sale	\N	Sale FAC-20260515-0008	1	2026-05-15 08:37:39.88241
131	59	OUT	3	Sale	\N	Sale FAC-20260515-0008	1	2026-05-15 08:37:39.884242
132	84	OUT	3	Sale	\N	Sale FAC-20260515-0009	1	2026-05-15 08:37:40.063149
133	27	OUT	2	Sale	\N	Sale FAC-20260515-0009	1	2026-05-15 08:37:40.064487
134	96	OUT	4	Sale	\N	Sale FAC-20260515-0009	1	2026-05-15 08:37:40.066561
135	21	OUT	1	Sale	\N	Sale FAC-20260515-0009	1	2026-05-15 08:37:40.068395
136	97	OUT	1	Sale	\N	Sale FAC-20260515-0010	1	2026-05-15 08:37:40.249392
137	34	OUT	3	Sale	\N	Sale FAC-20260515-0010	1	2026-05-15 08:37:40.250693
138	91	OUT	2	Sale	\N	Sale FAC-20260515-0011	1	2026-05-15 08:37:40.425333
139	3	OUT	3	Sale	\N	Sale FAC-20260515-0011	1	2026-05-15 08:37:40.427371
140	38	OUT	2	Sale	\N	Sale FAC-20260515-0011	1	2026-05-15 08:37:40.428889
141	60	OUT	4	Sale	\N	Sale FAC-20260515-0011	1	2026-05-15 08:37:40.430296
142	81	OUT	3	Sale	\N	Sale FAC-20260515-0011	1	2026-05-15 08:37:40.431512
143	10	OUT	2	Sale	\N	Sale FAC-20260515-0012	1	2026-05-15 08:37:40.605983
144	113	OUT	3	Sale	\N	Sale FAC-20260515-0012	1	2026-05-15 08:37:40.607387
145	10	IN	2	Cancellation	\N	Cancelled sale FAC-20260515-0012	\N	2026-05-15 08:37:40.805244
146	113	IN	3	Cancellation	\N	Cancelled sale FAC-20260515-0012	\N	2026-05-15 08:37:40.807563
147	36	OUT	2	Sale	\N	Sale FAC-20260515-0013	1	2026-05-15 08:38:07.261609
148	108	OUT	5	Sale	\N	Sale FAC-20260515-0013	1	2026-05-15 08:38:07.263246
149	86	OUT	5	Sale	\N	Sale FAC-20260515-0013	1	2026-05-15 08:38:07.265193
150	10	OUT	3	Sale	\N	Sale FAC-20260515-0014	1	2026-05-15 08:38:07.446411
151	80	OUT	3	Sale	\N	Sale FAC-20260515-0014	1	2026-05-15 08:38:07.447987
152	61	OUT	4	Sale	\N	Sale FAC-20260515-0014	1	2026-05-15 08:38:07.449767
153	20	OUT	1	Sale	\N	Sale FAC-20260515-0014	1	2026-05-15 08:38:07.451137
154	106	OUT	2	Sale	\N	Sale FAC-20260515-0015	1	2026-05-15 08:38:07.625715
155	7	OUT	2	Sale	\N	Sale FAC-20260515-0015	1	2026-05-15 08:38:07.62713
156	107	OUT	5	Sale	\N	Sale FAC-20260515-0015	1	2026-05-15 08:38:07.628297
157	89	OUT	5	Sale	\N	Sale FAC-20260515-0016	1	2026-05-15 08:38:07.805078
158	59	OUT	3	Sale	\N	Sale FAC-20260515-0016	1	2026-05-15 08:38:07.807566
159	44	OUT	5	Sale	\N	Sale FAC-20260515-0016	1	2026-05-15 08:38:07.810108
160	71	OUT	3	Sale	\N	Sale FAC-20260515-0017	1	2026-05-15 08:38:07.990312
161	81	OUT	2	Sale	\N	Sale FAC-20260515-0017	1	2026-05-15 08:38:07.992746
162	56	OUT	5	Sale	\N	Sale FAC-20260515-0017	1	2026-05-15 08:38:07.9955
163	12	OUT	5	Sale	\N	Sale FAC-20260515-0017	1	2026-05-15 08:38:07.998276
164	51	OUT	2	Sale	\N	Sale FAC-20260515-0017	1	2026-05-15 08:38:08.000781
165	52	OUT	1	Sale	\N	Sale FAC-20260515-0018	1	2026-05-15 08:38:08.197341
166	7	OUT	2	Sale	\N	Sale FAC-20260515-0018	1	2026-05-15 08:38:08.1991
167	106	OUT	3	Sale	\N	Sale FAC-20260515-0018	1	2026-05-15 08:38:08.201314
168	52	IN	1	Cancellation	\N	Cancelled sale FAC-20260515-0018	\N	2026-05-15 08:38:08.3985
169	7	IN	2	Cancellation	\N	Cancelled sale FAC-20260515-0018	\N	2026-05-15 08:38:08.399766
170	106	IN	3	Cancellation	\N	Cancelled sale FAC-20260515-0018	\N	2026-05-15 08:38:08.400989
171	45	OUT	3	Sale	\N	Sale FAC-20260515-0019	1	2026-05-15 08:41:37.526482
172	4	OUT	2	Sale	\N	Sale FAC-20260515-0019	1	2026-05-15 08:41:37.527573
173	51	OUT	2	Sale	\N	Sale FAC-20260515-0019	1	2026-05-15 08:41:37.528591
174	61	OUT	2	Sale	\N	Sale FAC-20260515-0020	1	2026-05-15 08:41:37.700698
175	62	OUT	5	Sale	\N	Sale FAC-20260515-0020	1	2026-05-15 08:41:37.701718
176	63	OUT	5	Sale	\N	Sale FAC-20260515-0020	1	2026-05-15 08:41:37.702718
177	113	OUT	3	Sale	\N	Sale FAC-20260515-0021	1	2026-05-15 08:41:37.878048
178	103	OUT	3	Sale	\N	Sale FAC-20260515-0021	1	2026-05-15 08:41:37.880712
179	11	OUT	3	Sale	\N	Sale FAC-20260515-0021	1	2026-05-15 08:41:37.883528
180	31	OUT	5	Sale	\N	Sale FAC-20260515-0021	1	2026-05-15 08:41:37.886414
181	54	OUT	4	Sale	\N	Sale FAC-20260515-0022	1	2026-05-15 08:41:38.082406
182	48	OUT	3	Sale	\N	Sale FAC-20260515-0022	1	2026-05-15 08:41:38.084045
183	37	OUT	5	Sale	\N	Sale FAC-20260515-0023	1	2026-05-15 08:41:38.266128
184	93	OUT	1	Sale	\N	Sale FAC-20260515-0023	1	2026-05-15 08:41:38.268997
185	109	OUT	5	Sale	\N	Sale FAC-20260515-0023	1	2026-05-15 08:41:38.271724
186	54	OUT	5	Sale	\N	Sale FAC-20260515-0024	1	2026-05-15 08:41:38.460601
187	95	OUT	1	Sale	\N	Sale FAC-20260515-0024	1	2026-05-15 08:41:38.463256
188	32	OUT	5	Sale	\N	Sale FAC-20260515-0024	1	2026-05-15 08:41:38.466006
189	54	IN	5	Cancellation	\N	Cancelled sale FAC-20260515-0024	\N	2026-05-15 08:41:38.701568
190	95	IN	1	Cancellation	\N	Cancelled sale FAC-20260515-0024	\N	2026-05-15 08:41:38.703622
191	32	IN	5	Cancellation	\N	Cancelled sale FAC-20260515-0024	\N	2026-05-15 08:41:38.705822
192	17	OUT	4	Sale	\N	Sale FAC-20260515-0025	1	2026-05-15 08:50:45.583748
193	25	OUT	3	Sale	\N	Sale FAC-20260515-0025	1	2026-05-15 08:50:45.667053
194	119	OUT	3	Sale	\N	Sale FAC-20260515-0025	1	2026-05-15 08:50:45.670584
195	98	OUT	3	Sale	\N	Sale FAC-20260515-0025	1	2026-05-15 08:50:45.672883
196	24	OUT	4	Sale	\N	Sale FAC-20260515-0025	1	2026-05-15 08:50:45.675281
197	102	OUT	3	Sale	\N	Sale FAC-20260515-0026	1	2026-05-15 08:50:46.211318
198	42	OUT	4	Sale	\N	Sale FAC-20260515-0026	1	2026-05-15 08:50:46.213378
199	49	OUT	4	Sale	\N	Sale FAC-20260515-0026	1	2026-05-15 08:50:46.214942
200	13	OUT	3	Sale	\N	Sale FAC-20260515-0027	1	2026-05-15 08:50:46.430553
201	36	OUT	4	Sale	\N	Sale FAC-20260515-0028	1	2026-05-15 08:50:46.602898
202	43	OUT	5	Sale	\N	Sale FAC-20260515-0028	1	2026-05-15 08:50:46.604511
203	54	OUT	2	Sale	\N	Sale FAC-20260515-0028	1	2026-05-15 08:50:46.606047
204	67	OUT	4	Sale	\N	Sale FAC-20260515-0028	1	2026-05-15 08:50:46.607436
205	84	OUT	3	Sale	\N	Sale FAC-20260515-0028	1	2026-05-15 08:50:46.611318
206	120	OUT	3	Sale	\N	Sale FAC-20260515-0029	1	2026-05-15 08:50:46.811904
207	86	OUT	5	Sale	\N	Sale FAC-20260515-0029	1	2026-05-15 08:50:46.813421
208	31	OUT	5	Sale	\N	Sale FAC-20260515-0029	1	2026-05-15 08:50:46.814793
209	23	OUT	1	Sale	\N	Sale FAC-20260515-0029	1	2026-05-15 08:50:46.81616
210	66	OUT	5	Sale	\N	Sale FAC-20260515-0030	1	2026-05-15 08:50:46.990981
211	102	OUT	4	Sale	\N	Sale FAC-20260515-0030	1	2026-05-15 08:50:46.992369
212	23	OUT	3	Sale	\N	Sale FAC-20260515-0030	1	2026-05-15 08:50:46.99367
213	106	OUT	4	Sale	\N	Sale FAC-20260515-0030	1	2026-05-15 08:50:46.994979
214	66	IN	5	Cancellation	\N	Cancelled sale FAC-20260515-0030	\N	2026-05-15 08:50:47.316101
215	102	IN	4	Cancellation	\N	Cancelled sale FAC-20260515-0030	\N	2026-05-15 08:50:47.31891
216	23	IN	3	Cancellation	\N	Cancelled sale FAC-20260515-0030	\N	2026-05-15 08:50:47.321246
217	106	IN	4	Cancellation	\N	Cancelled sale FAC-20260515-0030	\N	2026-05-15 08:50:47.323637
218	63	OUT	3	Sale	\N	Sale FAC-20260515-0031	1	2026-05-15 09:03:52.623287
219	104	OUT	2	Sale	\N	Sale FAC-20260515-0031	1	2026-05-15 09:03:52.624685
220	7	OUT	2	Sale	\N	Sale FAC-20260515-0031	1	2026-05-15 09:03:52.62599
221	76	OUT	1	Sale	\N	Sale FAC-20260515-0031	1	2026-05-15 09:03:52.627211
222	36	OUT	4	Sale	\N	Sale FAC-20260515-0032	1	2026-05-15 09:03:52.807997
223	91	OUT	2	Sale	\N	Sale FAC-20260515-0032	1	2026-05-15 09:03:52.810993
224	16	OUT	5	Sale	\N	Sale FAC-20260515-0032	1	2026-05-15 09:03:52.813862
225	79	OUT	1	Sale	\N	Sale FAC-20260515-0033	1	2026-05-15 09:03:53.010632
226	25	OUT	2	Sale	\N	Sale FAC-20260515-0033	1	2026-05-15 09:03:53.011746
227	7	OUT	2	Sale	\N	Sale FAC-20260515-0033	1	2026-05-15 09:03:53.012867
228	98	OUT	2	Sale	\N	Sale FAC-20260515-0033	1	2026-05-15 09:03:53.014025
229	109	OUT	1	Sale	\N	Sale FAC-20260515-0033	1	2026-05-15 09:03:53.015213
230	111	OUT	4	Sale	\N	Sale FAC-20260515-0034	1	2026-05-15 09:03:53.189906
231	3	OUT	2	Sale	\N	Sale FAC-20260515-0035	1	2026-05-15 09:03:53.359435
232	1	OUT	1	Sale	\N	Sale FAC-20260515-0035	1	2026-05-15 09:03:53.36059
233	104	OUT	4	Sale	\N	Sale FAC-20260515-0035	1	2026-05-15 09:03:53.361631
234	11	OUT	4	Sale	\N	Sale FAC-20260515-0035	1	2026-05-15 09:03:53.362794
235	117	OUT	1	Sale	\N	Sale FAC-20260515-0036	1	2026-05-15 09:03:53.535632
236	43	OUT	4	Sale	\N	Sale FAC-20260515-0036	1	2026-05-15 09:03:53.536887
237	117	IN	1	Cancellation	\N	Cancelled sale FAC-20260515-0036	\N	2026-05-15 09:03:53.722013
238	43	IN	4	Cancellation	\N	Cancelled sale FAC-20260515-0036	\N	2026-05-15 09:03:53.723269
239	90	OUT	1	Sale	\N	Sale FAC-20260515-0037	2	2026-05-15 09:05:39.221631
240	107	OUT	1	Sale	\N	Sale FAC-20260515-0037	2	2026-05-15 09:05:39.223772
241	43	OUT	1	Sale	\N	Sale FAC-20260515-0037	2	2026-05-15 09:05:39.225971
242	108	OUT	1	Sale	\N	Sale FAC-20260515-0037	2	2026-05-15 09:05:39.227647
243	90	OUT	1	Sale	\N	Sale FAC-20260515-0038	1	2026-05-15 20:29:26.018253
244	107	OUT	1	Sale	\N	Sale FAC-20260515-0038	1	2026-05-15 20:29:26.065792
245	57	OUT	1	Sale	\N	Sale FAC-20260515-0038	1	2026-05-15 20:29:26.069132
246	101	OUT	1	Sale	\N	Sale FAC-20260515-0039	1	2026-05-15 21:54:22.15522
247	24	OUT	2	Sale	\N	Sale FAC-20260515-0040	1	2026-05-15 21:54:22.791992
248	35	OUT	4	Sale	\N	Sale FAC-20260515-0041	1	2026-05-15 21:54:23.003492
249	32	OUT	2	Sale	\N	Sale FAC-20260515-0041	1	2026-05-15 21:54:23.007916
250	7	OUT	1	Sale	\N	Sale FAC-20260515-0041	1	2026-05-15 21:54:23.011152
251	50	OUT	4	Sale	\N	Sale FAC-20260515-0041	1	2026-05-15 21:54:23.013436
252	98	OUT	4	Sale	\N	Sale FAC-20260515-0041	1	2026-05-15 21:54:23.015875
253	90	OUT	2	Sale	\N	Sale FAC-20260515-0042	1	2026-05-15 21:54:37.001576
254	57	OUT	3	Sale	\N	Sale FAC-20260515-0042	1	2026-05-15 21:54:37.005011
255	57	OUT	4	Sale	\N	Sale FAC-20260515-0043	1	2026-05-15 21:54:42.258348
256	78	OUT	2	Sale	\N	Sale FAC-20260515-0043	1	2026-05-15 21:54:42.259836
257	68	OUT	3	Sale	\N	Sale FAC-20260515-0044	1	2026-05-15 21:54:42.435262
258	65	OUT	2	Sale	\N	Sale FAC-20260515-0044	1	2026-05-15 21:54:42.437499
259	81	OUT	1	Sale	\N	Sale FAC-20260515-0045	1	2026-05-15 21:54:42.613833
260	40	OUT	4	Sale	\N	Sale FAC-20260515-0045	1	2026-05-15 21:54:42.615244
261	48	OUT	5	Sale	\N	Sale FAC-20260515-0046	1	2026-05-15 21:54:42.795944
262	77	OUT	2	Sale	\N	Sale FAC-20260515-0046	1	2026-05-15 21:54:42.798506
263	104	OUT	2	Sale	\N	Sale FAC-20260515-0046	1	2026-05-15 21:54:42.800702
264	111	OUT	1	Sale	\N	Sale FAC-20260515-0046	1	2026-05-15 21:54:42.802915
265	91	OUT	4	Sale	\N	Sale FAC-20260515-0046	1	2026-05-15 21:54:42.804887
266	8	OUT	5	Sale	\N	Sale FAC-20260515-0047	1	2026-05-15 21:54:42.989118
267	112	OUT	1	Sale	\N	Sale FAC-20260515-0047	1	2026-05-15 21:54:42.991307
268	28	OUT	1	Sale	\N	Sale FAC-20260515-0047	1	2026-05-15 21:54:42.99298
269	70	OUT	1	Sale	\N	Sale FAC-20260515-0047	1	2026-05-15 21:54:42.995026
270	99	OUT	3	Sale	\N	Sale FAC-20260515-0048	1	2026-05-15 21:54:43.17701
271	52	OUT	2	Sale	\N	Sale FAC-20260515-0048	1	2026-05-15 21:54:43.178323
272	36	OUT	4	Sale	\N	Sale FAC-20260515-0048	1	2026-05-15 21:54:43.180335
273	56	OUT	4	Sale	\N	Sale FAC-20260515-0048	1	2026-05-15 21:54:43.182282
274	99	IN	3	Cancellation	\N	Cancelled sale FAC-20260515-0048	\N	2026-05-15 21:54:43.449313
275	52	IN	2	Cancellation	\N	Cancelled sale FAC-20260515-0048	\N	2026-05-15 21:54:43.451456
276	36	IN	4	Cancellation	\N	Cancelled sale FAC-20260515-0048	\N	2026-05-15 21:54:43.453161
277	56	IN	4	Cancellation	\N	Cancelled sale FAC-20260515-0048	\N	2026-05-15 21:54:43.455139
278	57	OUT	1	Sale	\N	Sale FAC-20260515-0049	1	2026-05-15 22:05:31.006532
279	116	OUT	1	Sale	\N	Sale FAC-20260515-0049	1	2026-05-15 22:05:31.008592
280	108	OUT	1	Sale	\N	Sale FAC-20260515-0050	1	2026-05-15 22:07:21.859214
281	44	OUT	1	Sale	\N	Sale FAC-20260515-0050	1	2026-05-15 22:07:21.860652
282	43	OUT	1	Sale	\N	Sale FAC-20260515-0050	1	2026-05-15 22:07:21.862258
283	107	OUT	1	Sale	\N	Sale FAC-20260515-0050	1	2026-05-15 22:07:21.863835
284	90	OUT	1	Sale	\N	Sale FAC-20260515-0050	1	2026-05-15 22:07:21.865509
285	17	OUT	2	Sale	\N	Sale FAC-20260515-0050	1	2026-05-15 22:07:21.866603
286	19	OUT	4	Sale	\N	Sale FAC-20260515-0050	1	2026-05-15 22:07:21.867525
287	43	OUT	1	Sale	\N	Sale FAC-20260515-0051	1	2026-05-15 22:07:59.511689
288	33	OUT	1	Sale	\N	Sale FAC-20260515-0051	1	2026-05-15 22:07:59.513696
289	40	OUT	1	Sale	\N	Sale FAC-20260515-0051	1	2026-05-15 22:07:59.518556
290	41	OUT	1	Sale	\N	Sale FAC-20260515-0051	1	2026-05-15 22:07:59.520243
291	35	OUT	1	Sale	\N	Sale FAC-20260515-0051	1	2026-05-15 22:07:59.521912
292	37	OUT	1	Sale	\N	Sale FAC-20260515-0051	1	2026-05-15 22:07:59.523428
293	36	OUT	1	Sale	\N	Sale FAC-20260515-0051	1	2026-05-15 22:07:59.525396
294	31	OUT	1	Sale	\N	Sale FAC-20260515-0051	1	2026-05-15 22:07:59.527176
295	107	OUT	1	Sale	\N	Sale FAC-20260515-0052	1	2026-05-15 22:08:42.40473
296	43	OUT	1	Sale	\N	Sale FAC-20260515-0052	1	2026-05-15 22:08:42.406755
297	70	OUT	3	Sale	\N	Sale FAC-20260515-0053	1	2026-05-15 22:15:07.043257
298	30	OUT	4	Sale	\N	Sale FAC-20260515-0054	1	2026-05-15 22:15:07.224912
299	55	OUT	3	Sale	\N	Sale FAC-20260515-0054	1	2026-05-15 22:15:07.227449
300	119	OUT	3	Sale	\N	Sale FAC-20260515-0055	1	2026-05-15 22:15:07.41033
301	58	OUT	1	Sale	\N	Sale FAC-20260515-0055	1	2026-05-15 22:15:07.411813
302	18	OUT	3	Sale	\N	Sale FAC-20260515-0056	1	2026-05-15 22:15:07.588628
303	85	OUT	4	Sale	\N	Sale FAC-20260515-0056	1	2026-05-15 22:15:07.590048
304	19	OUT	2	Sale	\N	Sale FAC-20260515-0056	1	2026-05-15 22:15:07.591322
305	23	OUT	1	Sale	\N	Sale FAC-20260515-0056	1	2026-05-15 22:15:07.592834
306	6	OUT	1	Sale	\N	Sale FAC-20260515-0057	1	2026-05-15 22:15:07.769152
307	107	OUT	5	Sale	\N	Sale FAC-20260515-0057	1	2026-05-15 22:15:07.770411
308	44	OUT	3	Sale	\N	Sale FAC-20260515-0057	1	2026-05-15 22:15:07.773804
309	118	OUT	2	Sale	\N	Sale FAC-20260515-0057	1	2026-05-15 22:15:07.776726
310	28	OUT	4	Sale	\N	Sale FAC-20260515-0057	1	2026-05-15 22:15:07.778498
311	116	OUT	4	Sale	\N	Sale FAC-20260515-0058	1	2026-05-15 22:15:07.96572
312	71	OUT	3	Sale	\N	Sale FAC-20260515-0058	1	2026-05-15 22:15:07.967361
313	9	OUT	5	Sale	\N	Sale FAC-20260515-0058	1	2026-05-15 22:15:07.968742
314	11	OUT	1	Sale	\N	Sale FAC-20260515-0058	1	2026-05-15 22:15:07.97015
315	82	OUT	3	Sale	\N	Sale FAC-20260515-0058	1	2026-05-15 22:15:07.971648
316	116	IN	4	Cancellation	\N	Cancelled sale FAC-20260515-0058	\N	2026-05-15 22:15:08.182442
317	71	IN	3	Cancellation	\N	Cancelled sale FAC-20260515-0058	\N	2026-05-15 22:15:08.183962
318	9	IN	5	Cancellation	\N	Cancelled sale FAC-20260515-0058	\N	2026-05-15 22:15:08.186124
319	11	IN	1	Cancellation	\N	Cancelled sale FAC-20260515-0058	\N	2026-05-15 22:15:08.187335
320	82	IN	3	Cancellation	\N	Cancelled sale FAC-20260515-0058	\N	2026-05-15 22:15:08.188542
321	54	OUT	4	Sale	\N	Sale FAC-20260515-0059	1	2026-05-15 23:15:38.659425
322	61	OUT	1	Sale	\N	Sale FAC-20260515-0059	1	2026-05-15 23:15:38.71276
323	68	OUT	5	Sale	\N	Sale FAC-20260515-0060	1	2026-05-15 23:15:39.349163
324	56	OUT	4	Sale	\N	Sale FAC-20260515-0060	1	2026-05-15 23:15:39.35421
325	97	OUT	3	Sale	\N	Sale FAC-20260515-0060	1	2026-05-15 23:15:39.356712
326	47	OUT	5	Sale	\N	Sale FAC-20260515-0060	1	2026-05-15 23:15:39.358503
327	52	OUT	1	Sale	\N	Sale FAC-20260515-0061	1	2026-05-15 23:15:39.569601
328	101	OUT	4	Sale	\N	Sale FAC-20260515-0061	1	2026-05-15 23:15:39.571876
329	108	OUT	5	Sale	\N	Sale FAC-20260515-0061	1	2026-05-15 23:15:39.574034
330	88	OUT	5	Sale	\N	Sale FAC-20260515-0062	1	2026-05-15 23:15:39.761815
331	45	OUT	1	Sale	\N	Sale FAC-20260515-0062	1	2026-05-15 23:15:39.763732
332	75	OUT	2	Sale	\N	Sale FAC-20260515-0062	1	2026-05-15 23:15:39.765987
333	39	OUT	3	Sale	\N	Sale FAC-20260515-0063	1	2026-05-15 23:15:39.952153
334	114	OUT	3	Sale	\N	Sale FAC-20260515-0063	1	2026-05-15 23:15:39.954315
335	97	OUT	2	Sale	\N	Sale FAC-20260515-0064	1	2026-05-15 23:15:40.136142
336	55	OUT	2	Sale	\N	Sale FAC-20260515-0064	1	2026-05-15 23:15:40.139011
337	69	OUT	1	Sale	\N	Sale FAC-20260515-0064	1	2026-05-15 23:15:40.141616
338	52	OUT	5	Sale	\N	Sale FAC-20260515-0064	1	2026-05-15 23:15:40.144007
339	82	OUT	2	Sale	\N	Sale FAC-20260515-0064	1	2026-05-15 23:15:40.146542
340	97	IN	2	Cancellation	\N	Cancelled sale FAC-20260515-0064	\N	2026-05-15 23:15:40.491694
341	55	IN	2	Cancellation	\N	Cancelled sale FAC-20260515-0064	\N	2026-05-15 23:15:40.494029
342	69	IN	1	Cancellation	\N	Cancelled sale FAC-20260515-0064	\N	2026-05-15 23:15:40.496373
343	52	IN	5	Cancellation	\N	Cancelled sale FAC-20260515-0064	\N	2026-05-15 23:15:40.49849
344	82	IN	2	Cancellation	\N	Cancelled sale FAC-20260515-0064	\N	2026-05-15 23:15:40.50024
345	1	OUT	2	Sale	\N	Sale FAC-20260515-0065	1	2026-05-15 23:15:48.931113
346	2	OUT	1	Sale	\N	Sale FAC-20260515-0066	1	2026-05-15 23:15:58.15003
\.


--
-- Data for Name: loginlogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.loginlogs (id, userid, ipaddress, action, createdat) FROM stdin;
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patients (id, customerid, medicalhistory, allergies, bloodtype, createdat) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, saleid, amount, paymentmethod, reference, createdat) FROM stdin;
1	1	91.64	Transferencia	\N	2026-05-14 08:29:45.110198
2	2	179.80	Tarjeta	\N	2026-05-14 08:29:45.72284
3	3	154.28	Tarjeta	\N	2026-05-14 08:29:46.067942
4	4	92.80	Efectivo	\N	2026-05-14 08:29:46.400547
5	5	151.96	Efectivo	\N	2026-05-14 08:29:46.733122
6	6	106.72	Tarjeta	\N	2026-05-14 08:44:20.302453
7	7	142.68	Tarjeta	\N	2026-05-14 08:44:20.632774
8	8	245.92	Tarjeta	\N	2026-05-14 08:44:20.975858
9	9	102.08	Transferencia	\N	2026-05-14 08:44:21.318125
10	10	218.08	Efectivo	\N	2026-05-14 08:44:21.656882
11	11	183.28	Efectivo	\N	2026-05-14 08:48:46.770166
12	12	119.48	Tarjeta	\N	2026-05-14 08:48:47.100946
13	13	242.44	Tarjeta	\N	2026-05-14 08:48:47.430938
14	14	139.20	Efectivo	\N	2026-05-14 08:48:47.769468
15	15	179.80	Tarjeta	\N	2026-05-14 08:48:48.107065
16	16	516.20	Efectivo	\N	2026-05-14 09:26:03.776359
17	17	191.40	Tarjeta	\N	2026-05-14 09:26:04.128445
18	18	127.60	Transferencia	\N	2026-05-14 09:26:04.468182
19	19	364.24	Efectivo	\N	2026-05-14 09:26:04.802456
20	20	136.88	Transferencia	\N	2026-05-14 09:26:05.151663
21	21	150.80	Efectivo	\N	2026-05-14 10:06:28.283945
22	22	187.92	Transferencia	\N	2026-05-14 10:06:28.632257
23	23	180.96	Transferencia	\N	2026-05-14 10:06:28.960494
24	24	134.56	Transferencia	\N	2026-05-14 10:06:29.295423
25	25	120.64	Transferencia	\N	2026-05-14 10:06:29.625351
26	26	269.12	Tarjeta	\N	2026-05-14 10:07:15.446579
27	27	469.80	Transferencia	\N	2026-05-14 10:07:15.782443
28	28	344.52	Tarjeta	\N	2026-05-14 10:07:16.105015
29	29	218.08	Efectivo	\N	2026-05-14 10:07:16.435138
30	30	162.40	Efectivo	\N	2026-05-14 10:07:16.763596
31	31	167.04	Tarjeta	\N	2026-05-14 12:29:32.333554
32	32	170.52	Tarjeta	\N	2026-05-14 12:29:32.855322
33	33	84.68	Tarjeta	\N	2026-05-14 12:29:33.200748
34	34	187.92	Tarjeta	\N	2026-05-14 12:29:33.540649
35	35	85.84	Tarjeta	\N	2026-05-14 12:29:33.875569
36	36	328.90	Efectivo	\N	2026-05-15 08:34:00.814118
37	37	114.40	Efectivo	\N	2026-05-15 08:34:01.394624
38	38	132.00	Transferencia	\N	2026-05-15 08:34:01.645598
39	39	23.10	Transferencia	\N	2026-05-15 08:34:01.823669
40	40	127.60	Transferencia	\N	2026-05-15 08:34:02.020939
41	41	35.20	Transferencia	\N	2026-05-15 08:34:02.196711
42	42	336.60	Efectivo	\N	2026-05-15 08:37:39.702773
43	43	52.80	Tarjeta	\N	2026-05-15 08:37:39.884424
44	44	171.60	Transferencia	\N	2026-05-15 08:37:40.068533
45	45	212.30	Tarjeta	\N	2026-05-15 08:37:40.250902
46	46	232.10	Efectivo	\N	2026-05-15 08:37:40.431624
47	47	53.90	Transferencia	\N	2026-05-15 08:37:40.607496
48	48	213.40	Efectivo	\N	2026-05-15 08:38:07.265341
49	49	151.80	Transferencia	\N	2026-05-15 08:38:07.451229
50	50	143.00	Transferencia	\N	2026-05-15 08:38:07.628379
51	51	195.80	Tarjeta	\N	2026-05-15 08:38:07.810277
52	52	188.10	Transferencia	\N	2026-05-15 08:38:08.000952
53	53	99.00	Tarjeta	\N	2026-05-15 08:38:08.201446
54	54	77.00	Transferencia	\N	2026-05-15 08:41:37.528689
55	55	473.00	Efectivo	\N	2026-05-15 08:41:37.702797
56	56	281.60	Transferencia	\N	2026-05-15 08:41:37.886703
57	57	122.10	Efectivo	\N	2026-05-15 08:41:38.084153
58	58	322.30	Transferencia	\N	2026-05-15 08:41:38.271919
59	59	267.30	Tarjeta	\N	2026-05-15 08:41:38.466271
60	60	334.40	Efectivo	\N	2026-05-15 08:50:45.676856
61	61	129.80	Transferencia	\N	2026-05-15 08:50:46.215079
62	62	52.80	Efectivo	\N	2026-05-15 08:50:46.430737
63	63	224.40	Efectivo	\N	2026-05-15 08:50:46.611726
64	64	270.60	Tarjeta	\N	2026-05-15 08:50:46.816291
65	65	189.20	Tarjeta	\N	2026-05-15 08:50:46.995125
66	66	183.70	Transferencia	\N	2026-05-15 09:03:52.627384
67	67	300.30	Tarjeta	\N	2026-05-15 09:03:52.814056
68	68	177.10	Efectivo	\N	2026-05-15 09:03:53.015382
69	69	52.80	Efectivo	\N	2026-05-15 09:03:53.190146
70	70	119.90	Efectivo	\N	2026-05-15 09:03:53.362895
71	71	33.00	Transferencia	\N	2026-05-15 09:03:53.536963
72	72	48.40	Efectivo	\N	2026-05-15 09:05:39.227866
73	73	27.50	Efectivo	\N	2026-05-15 20:29:26.070306
74	74	12.00	Efectivo	\N	2026-05-15 21:54:22.212054
75	75	20.00	Tarjeta	\N	2026-05-15 21:54:22.793864
76	76	610.20	Efectivo	\N	2026-05-15 21:54:23.016042
77	77	25.40	Efectivo	\N	2026-05-15 21:54:37.006451
78	78	41.20	Tarjeta	\N	2026-05-15 21:54:42.259943
79	79	54.00	Transferencia	\N	2026-05-15 21:54:42.437647
80	80	287.00	Tarjeta	\N	2026-05-15 21:54:42.61537
81	81	411.00	Tarjeta	\N	2026-05-15 21:54:42.805059
82	82	60.00	Tarjeta	\N	2026-05-15 21:54:42.995167
83	83	274.36	Tarjeta	\N	2026-05-15 21:54:43.182419
84	84	12.76	Efectivo	\N	2026-05-15 22:05:31.008786
85	85	151.60	Efectivo	\N	2026-05-15 22:07:21.867605
86	86	305.00	Efectivo	\N	2026-05-15 22:07:59.527294
87	87	22.00	Efectivo	\N	2026-05-15 22:08:42.406906
88	88	24.00	Tarjeta	\N	2026-05-15 22:15:07.043335
89	89	120.72	Tarjeta	\N	2026-05-15 22:15:07.227586
90	90	82.36	Transferencia	\N	2026-05-15 22:15:07.411936
91	91	176.00	Transferencia	\N	2026-05-15 22:15:07.592951
92	92	187.08	Tarjeta	\N	2026-05-15 22:15:07.778581
93	93	113.84	Transferencia	\N	2026-05-15 22:15:07.971735
94	94	59.16	Transferencia	\N	2026-05-15 23:15:38.714768
95	95	320.76	Transferencia	\N	2026-05-15 23:15:39.358765
96	96	172.80	Transferencia	\N	2026-05-15 23:15:39.574248
97	97	71.28	Transferencia	\N	2026-05-15 23:15:39.766109
98	98	101.40	Efectivo	\N	2026-05-15 23:15:39.954529
99	99	349.48	Efectivo	\N	2026-05-15 23:15:40.146681
100	100	10.00	Efectivo	\N	2026-05-15 23:15:48.931437
101	101	7.00	Transferencia	\N	2026-05-15 23:15:58.150235
\.


--
-- Data for Name: prescription_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prescription_items (id, prescriptionid, productid, dosage, frequency, duration, notes) FROM stdin;
\.


--
-- Data for Name: prescriptionitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prescriptionitems (id, prescriptionid, productid, dosage, frequency, duration, notes) FROM stdin;
\.


--
-- Data for Name: prescriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prescriptions (id, patientid, doctorname, doctorlicense, diagnosis, notes, issueddate, expirydate, createdat) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, code, barcode, name, description, categoryid, supplierid, purchaseprice, saleprice, stock, minstock, unit, isactive, requiresprescription, createdat, updatedat, wholesale_price, expiry_date, requires_tax) FROM stdin;
104	MEX104	7500000001043	Clotrimazol Crema 20g	Antifúngico tópico para hongos en la piel	9	1	6.00	12.00	62	12	Tubo	t	f	2026-05-14 08:27:56.975202	\N	8.40	2027-05-14 00:00:00	f
111	MEX111	7500000001111	Ungüento Triple Antibiótico 30g	Ungüento neomicina/bacitracina/polimixina	9	1	6.00	12.00	61	12	Tubo	t	f	2026-05-14 08:27:57.470027	\N	8.40	2027-05-14 00:00:00	f
18	MEX018	7500000000183	Azitromicina 500mg x3	Antibiótico macrólido para infecciones respiratorias	2	1	12.00	22.00	97	15	Tableta	t	t	2026-05-14 08:27:51.11506	\N	15.40	2027-05-14 00:00:00	f
101	MEX101	7500000001012	Alprazolam 0.5mg x30	Ansiolítico para trastorno de ansiedad generalizada	8	1	6.00	12.00	36	10	Tableta	t	t	2026-05-14 08:27:56.764029	\N	8.40	2027-05-14 00:00:00	f
5	MEX005	7500000000053	Naproxeno Sódico 550mg x10	Antiinflamatorio para dolor muscular y articular	1	1	6.00	12.00	90	15	Tableta	t	f	2026-05-14 08:27:50.284254	\N	8.40	2027-05-14 00:00:00	f
14	MEX014	7500000000145	Tramadol 50mg x10	Analgésico opioide para dolor moderado a severo	1	1	12.00	22.00	50	10	Cápsula	t	t	2026-05-14 08:27:50.858025	\N	15.40	2027-05-14 00:00:00	f
50	MEX050	7500000000503	Protector Solar FPS 50 200ml	Protector solar de amplio espectro resistente al agua	4	1	35.00	55.00	50	15	Frasco	t	f	2026-05-14 08:27:53.213867	\N	38.50	2027-05-14 00:00:00	t
55	MEX055	7500000000558	Enjuague Bucal 500ml	Enjuague bucal antiséptico sin alcohol	4	1	8.00	14.00	78	15	Frasco	t	f	2026-05-14 08:27:53.561004	\N	9.80	2027-05-14 00:00:00	t
54	MEX054	7500000000541	Pasta Dental 120ml	Pasta dental con flúor para protección anticaries	4	1	5.00	9.00	150	25	Tubo	t	f	2026-05-14 08:27:53.489291	\N	6.30	2027-05-14 00:00:00	t
69	MEX069	7500000000695	Budesonida Inhalador 200 dosis	Corticoide inhalado para asma de mantenimiento	5	1	45.00	75.00	30	8	Inhalador	t	t	2026-05-14 08:27:54.527793	\N	52.50	2027-05-14 00:00:00	f
48	MEX048	7500000000480	Guantes Latex x100	Guantes de examen descartables talla M	4	1	15.00	25.00	152	25	Caja	t	f	2026-05-14 08:27:53.066494	\N	17.50	2027-05-14 00:00:00	t
61	MEX061	7500000000619	Termómetro Digital	Termómetro digital de punta flexible	4	1	8.00	15.00	49	15	Unidad	t	f	2026-05-14 08:27:53.982322	\N	10.50	2027-05-14 00:00:00	t
47	MEX047	7500000000473	Mascarilla KN95 x10	Mascarilla de protección avanzada	4	1	15.00	25.00	189	40	Caja	t	f	2026-05-14 08:27:52.993395	\N	17.50	2027-05-14 00:00:00	t
82	MEX082	7500000000824	Senna 12mg x20	Laxante natural para estreñimiento ocasional	6	1	3.00	6.00	87	15	Tableta	t	f	2026-05-14 08:27:55.423088	\N	4.20	2027-05-14 00:00:00	f
57	MEX057	7500000000572	Agua Oxigenada 500ml	Peróxido de hidrógeno para limpieza de heridas	4	1	3.00	5.00	139	25	Frasco	t	f	2026-05-14 08:27:53.704534	\N	3.50	2027-05-14 00:00:00	t
56	MEX056	7500000000565	Yodo Povidona 10% 120ml	Antiséptico tópico para desinfección de heridas	4	1	5.00	9.00	107	18	Frasco	t	f	2026-05-14 08:27:53.638028	\N	6.30	2027-05-14 00:00:00	t
58	MEX058	7500000000589	Gasas Esterilizadas x10	Paquete de gasas estériles para curación	4	1	2.50	5.00	244	40	Paquete	t	f	2026-05-14 08:27:53.772339	\N	3.50	2027-05-14 00:00:00	t
44	MEX044	7500000000442	Alcohol Gel 70% 250ml	Desinfectante de manos antibacterial	4	1	5.00	10.00	334	50	Frasco	t	f	2026-05-14 08:27:52.794817	\N	7.00	2027-05-14 00:00:00	t
68	MEX068	7500000000688	Prednisona 20mg x8	Corticoide oral para inflamación severa	5	1	5.00	10.00	72	12	Tableta	t	t	2026-05-14 08:27:54.459581	\N	7.00	2027-05-14 00:00:00	f
45	MEX045	7500000000459	Alcohol Medicinal 500ml	Alcohol antiséptico para limpieza de heridas	4	1	4.00	8.00	246	30	Frasco	t	f	2026-05-14 08:27:52.856745	\N	5.60	2027-05-14 00:00:00	t
75	MEX075	7500000000756	Ranitidina 150mg x20	Antihistamínico H2 para úlceras y reflujo	6	1	3.00	6.00	138	20	Tableta	t	f	2026-05-14 08:27:54.930539	\N	4.20	2027-05-14 00:00:00	f
46	MEX046	7500000000466	Mascarilla Quirúrgica x50	Mascarilla facial desechable de 3 capas	4	1	6.00	12.00	500	80	Caja	t	f	2026-05-14 08:27:52.922476	\N	8.40	2027-05-14 00:00:00	t
52	MEX052	7500000000527	Shampoo Anticaspa 400ml	Shampoo medicado para control de caspa	4	1	18.00	30.00	75	15	Frasco	t	f	2026-05-14 08:27:53.349822	\N	21.00	2027-05-14 00:00:00	t
60	MEX060	7500000000602	Esparadrapo 5cm x 5m	Cinta adhesiva médica para fijación de apósitos	4	1	2.50	5.00	152	20	Rollo	t	f	2026-05-14 08:27:53.911255	\N	3.50	2027-05-14 00:00:00	t
59	MEX059	7500000000596	Venda Elástica 10cm x 5m	Venda de compresión para soporte muscular	4	1	3.00	6.00	170	25	Unidad	t	f	2026-05-14 08:27:53.840386	\N	4.20	2027-05-14 00:00:00	t
53	MEX053	7500000000534	Cepillo Dental Suave	Cepillo dental de cerdas suaves para adultos	4	1	3.00	6.00	193	30	Unidad	t	f	2026-05-14 08:27:53.417064	\N	4.20	2027-05-14 00:00:00	t
72	MEX072	7500000000725	Oxigenador Nasal Spray 20ml	Spray descongestionante nasal de acción rápida	5	1	7.00	12.00	70	12	Frasco	t	f	2026-05-14 08:27:54.723869	\N	8.40	2027-05-14 00:00:00	f
51	MEX051	7500000000510	Toalla Húmeda x100	Toallitas húmedas para bebé y adultos	4	1	7.00	12.00	236	30	Paquete	t	f	2026-05-14 08:27:53.282411	\N	8.40	2027-05-14 00:00:00	t
119	MEX119	7500000001197	Cubrebocas KN95 x5	Cubrebocas de alta eficiencia certificados	4	1	12.00	22.00	128	30	Caja	t	f	2026-05-14 08:27:58.025934	\N	15.40	2027-05-14 00:00:00	t
118	MEX118	7500000001180	Baja Lenguas x100	Bajalenguas de madera para examen médico	4	1	2.00	4.00	298	50	Paquete	t	f	2026-05-14 08:27:57.957952	\N	2.80	2027-05-14 00:00:00	t
116	MEX116	7500000001166	Agujas Hipodérmicas x20	Agujas desechables estériles calibre 21G	4	1	3.50	6.00	145	25	Paquete	t	f	2026-05-14 08:27:57.821981	\N	4.20	2027-05-14 00:00:00	t
114	MEX114	7500000001142	Jeringa 5ml x10	Jeringas desechables estériles de 5 ml	4	1	3.00	5.00	197	30	Paquete	t	f	2026-05-14 08:27:57.684085	\N	3.50	2027-05-14 00:00:00	t
87	MEX087	7500000000879	Amlodipino 5mg x30	Antihipertensivo bloqueador de canales de calcio	7	1	7.00	14.00	100	15	Tableta	t	t	2026-05-14 08:27:55.771965	\N	9.80	2027-05-14 00:00:00	f
115	MEX115	7500000001159	Jeringa 10ml x10	Jeringas desechables estériles de 10 ml	4	1	4.00	7.00	168	25	Paquete	t	f	2026-05-14 08:27:57.755857	\N	4.90	2027-05-14 00:00:00	t
92	MEX092	7500000000923	Furosemida 40mg x20	Diurético para hipertensión y edemas	7	1	3.00	6.00	80	12	Tableta	t	t	2026-05-14 08:27:56.127761	\N	4.20	2027-05-14 00:00:00	f
94	MEX094	7500000000947	Clopidogrel 75mg x28	Antiagregante plaquetario para prevención de infartos	7	1	14.00	25.00	55	10	Tableta	t	t	2026-05-14 08:27:56.265953	\N	17.50	2027-05-14 00:00:00	f
6	MEX006	7500000000060	Diclofenaco 75mg x10	Antiinflamatorio para dolores reumáticos	1	1	3.50	7.00	96	15	Ampolla	t	f	2026-05-14 08:27:50.351973	\N	4.90	2027-05-14 00:00:00	f
7	MEX007	7500000000077	Ketorolaco 30mg x6	Analgésico potente para dolor agudo	1	1	8.00	15.00	49	10	Ampolla	t	f	2026-05-14 08:27:50.416955	\N	10.50	2027-05-14 00:00:00	f
117	MEX117	7500000001173	Apósito Transparente 10x10cm	Apósito adhesivo estéril para heridas	4	1	3.00	6.00	190	30	Unidad	t	f	2026-05-14 08:27:57.889249	\N	4.20	2027-05-14 00:00:00	t
32	MEX032	7500000000329	Vitamina D3 400UI x60	Suplemento de vitamina D para huesos	3	1	22.00	38.00	92	15	Cápsula	t	f	2026-05-14 08:27:52.034986	\N	26.60	2027-05-14 00:00:00	f
70	MEX070	7500000000701	Ambroxol 30mg x20	Mucolítico y expectorante para congestión	5	1	4.00	8.00	113	18	Tableta	t	f	2026-05-14 08:27:54.590836	\N	5.60	2027-05-14 00:00:00	f
33	MEX033	7500000000336	Calcio + Vitamina D3 x30	Suplemento de calcio para osteoporosis	3	1	25.00	42.00	76	12	Tableta	t	f	2026-05-14 08:27:52.096315	\N	29.40	2027-05-14 00:00:00	f
65	MEX065	7500000000657	Loratadina 10mg x10	Antihistamínico para alergias estacionales	5	1	6.00	12.00	154	20	Tableta	t	f	2026-05-14 08:27:54.262035	\N	8.40	2027-05-14 00:00:00	f
30	MEX030	7500000000305	Vitamina C 500mg x60	Suplemento de vitamina C dosis media	3	1	10.00	18.00	113	20	Tableta	t	f	2026-05-14 08:27:51.90885	\N	12.60	2027-05-14 00:00:00	f
29	MEX029	7500000000299	Vitamina C 1000mg x30	Suplemento de vitamina C para defensas	3	1	15.00	28.00	180	25	Tableta efervescente	t	f	2026-05-14 08:27:51.844019	\N	19.60	2027-05-14 00:00:00	f
26	MEX026	7500000000268	Trimetoprima/Sulfa 800/160mg x20	Antibiótico para infecciones urinarias y respiratorias	2	1	6.00	12.00	76	12	Tableta	t	t	2026-05-14 08:27:51.639006	\N	8.40	2027-05-14 00:00:00	f
13	MEX013	7500000000138	Ketoprofeno Gel 60g	Gel antiinflamatorio para dolores musculares	1	1	9.00	16.00	72	12	Tubo	t	f	2026-05-14 08:27:50.793812	\N	11.20	2027-05-14 00:00:00	f
10	MEX010	7500000000107	Meloxicam 15mg x10	Antiinflamatorio para artritis y osteoartritis	1	1	7.00	14.00	65	10	Tableta	t	f	2026-05-14 08:27:50.607101	\N	9.80	2027-05-14 00:00:00	f
12	MEX012	7500000000121	Parche Diclofenaco 140mg x5	Parche antiinflamatorio para dolor localizado	1	1	8.00	14.00	75	15	Parche	t	f	2026-05-14 08:27:50.730559	\N	9.80	2027-05-14 00:00:00	f
21	MEX021	7500000000213	Ceftriaxona 1g inyectable	Antibiótico cefalosporina de tercera generación	2	1	15.00	28.00	49	10	Ampolla	t	t	2026-05-14 08:27:51.30702	\N	19.60	2027-05-14 00:00:00	f
22	MEX022	7500000000220	Clindamicina 300mg x20	Antibiótico para infecciones anaerobias y dentales	2	1	14.00	25.00	67	12	Cápsula	t	t	2026-05-14 08:27:51.373651	\N	17.50	2027-05-14 00:00:00	f
4	MEX004	7500000000046	Ibuprofeno 600mg x20	Antiinflamatorio para dolor moderado a severo	1	1	5.50	11.00	113	15	Tableta	t	f	2026-05-14 08:27:50.213268	\N	7.70	2027-05-14 00:00:00	f
74	MEX074	7500000000749	Esomeprazol 40mg x14	Protector gástrico de acción prolongada	6	1	12.00	22.00	76	15	Tableta	t	f	2026-05-14 08:27:54.861373	\N	15.40	2027-05-14 00:00:00	f
20	MEX020	7500000000206	Ciprofloxacino 500mg x14	Antibiótico fluoroquinolona para infecciones urinarias	2	1	10.00	18.00	68	12	Tableta	t	t	2026-05-14 08:27:51.245758	\N	12.60	2027-05-14 00:00:00	f
17	MEX017	7500000000176	Amoxicilina 250mg/5ml 60ml	Antibiótico suspensión infantil	2	1	6.00	12.00	74	15	Frasco	t	t	2026-05-14 08:27:51.050531	\N	8.40	2027-05-14 00:00:00	f
113	MEX113	7500000001135	Parche para Callicidas x6	Parche medicado para eliminar callos y durezas	9	1	3.50	7.00	72	15	Parche	t	f	2026-05-14 08:27:57.614812	\N	4.90	2027-05-14 00:00:00	f
25	MEX025	7500000000251	Levofloxacino 500mg x7	Antibiótico para infecciones respiratorias y urinarias	2	1	18.00	32.00	31	8	Tableta	t	t	2026-05-14 08:27:51.57684	\N	22.40	2027-05-14 00:00:00	f
81	MEX081	7500000000817	Simeticona 40mg x20	Antiflatulento para gases y distensión abdominal	6	1	3.50	7.00	104	18	Tableta	t	f	2026-05-14 08:27:55.35195	\N	4.90	2027-05-14 00:00:00	f
8	MEX008	7500000000084	Metamizol 500mg x10	Analgésico y antipirético de acción rápida	1	1	3.00	6.00	112	20	Tableta	t	f	2026-05-14 08:27:50.479748	\N	4.20	2027-05-14 00:00:00	f
9	MEX009	7500000000091	Metamizol Gotero 20ml	Analgésico en gotas para niños y adultos	1	1	4.00	8.00	78	15	Frasco	t	f	2026-05-14 08:27:50.54267	\N	5.60	2027-05-14 00:00:00	f
35	MEX035	7500000000350	Multivitamínico x30	Multivitamínico completo para adultos	3	1	28.00	48.00	135	20	Tableta	t	f	2026-05-14 08:27:52.222812	\N	33.60	2027-05-14 00:00:00	f
37	MEX037	7500000000374	Magnesio 400mg x60	Suplemento de magnesio para músculos y nervios	3	1	20.00	35.00	69	12	Tableta	t	f	2026-05-14 08:27:52.348044	\N	24.50	2027-05-14 00:00:00	f
40	MEX040	7500000000404	Coenzima Q10 100mg x30	Suplemento para salud cardiovascular y energía	3	1	45.00	70.00	35	8	Cápsula	t	f	2026-05-14 08:27:52.53607	\N	49.00	2027-05-14 00:00:00	f
41	MEX041	7500000000411	Colágeno Hidrolizado 500mg x60	Suplemento para articulaciones y piel	3	1	30.00	50.00	76	15	Sobre	t	f	2026-05-14 08:27:52.598194	\N	35.00	2027-05-14 00:00:00	f
19	MEX019	7500000000190	Azitromicina 200mg/5ml 30ml	Antibiótico suspensión infantil	2	1	10.00	18.00	50	10	Frasco	t	t	2026-05-14 08:27:51.181392	\N	12.60	2027-05-14 00:00:00	f
23	MEX023	7500000000237	Nitrofurantoína 100mg x30	Antibiótico para infecciones urinarias	2	1	7.00	14.00	58	10	Tableta	t	t	2026-05-14 08:27:51.439733	\N	9.80	2027-05-14 00:00:00	f
39	MEX039	7500000000398	Vitamina E 400UI x30	Suplemento antioxidante para piel y sistema inmune	3	1	16.00	28.00	67	12	Cápsula	t	f	2026-05-14 08:27:52.473783	\N	19.60	2027-05-14 00:00:00	f
1	MEX001	7500000000015	Paracetamol 500mg x10	Analgésico y antipirético para fiebre y dolor leve	1	1	2.50	5.00	195	30	Tableta	t	f	2026-05-14 08:27:49.654907	\N	3.50	2027-05-14 00:00:00	f
16	MEX016	7500000000169	Amoxicilina 500mg x21	Antibiótico betalactámico para infecciones bacterianas	2	1	8.00	15.00	134	20	Cápsula	t	t	2026-05-14 08:27:50.983652	\N	10.50	2027-05-14 00:00:00	f
34	MEX034	7500000000343	Omega 3 1000mg x60	Ácidos grasos esenciales para corazón y cerebro	3	1	35.00	55.00	85	15	Cápsula	t	f	2026-05-14 08:27:52.158165	\N	38.50	2027-05-14 00:00:00	f
27	MEX027	7500000000275	Dicloxacilina 500mg x20	Antibiótico para infecciones estafilocócicas	2	1	9.00	16.00	43	10	Cápsula	t	t	2026-05-14 08:27:51.708712	\N	11.20	2027-05-14 00:00:00	f
38	MEX038	7500000000381	Zinc 25mg x30	Suplemento de zinc para sistema inmunológico	3	1	10.00	18.00	118	15	Tableta	t	f	2026-05-14 08:27:52.409125	\N	12.60	2027-05-14 00:00:00	f
3	MEX003	7500000000039	Ibuprofeno 400mg x20	Antiinflamatorio no esteroideo para dolor e inflamación	1	1	4.00	8.00	173	20	Tableta	t	f	2026-05-14 08:27:50.142844	\N	5.60	2027-05-14 00:00:00	f
63	MEX063	7500000000633	Salbutamol Inhalador 200 dosis	Broncodilatador para asma y EPOC	5	1	18.00	35.00	52	12	Inhalador	t	t	2026-05-14 08:27:54.118667	\N	24.50	2027-05-14 00:00:00	f
83	MEX083	7500000000831	Carbón Activado 250mg x20	Antidiarreico y absorbente gastrointestinal	6	1	4.00	8.00	65	12	Tableta	t	f	2026-05-14 08:27:55.493021	\N	5.60	2027-05-14 00:00:00	f
80	MEX080	7500000000800	Electrolitos Orales x10	Sobres para rehidratación oral	6	1	3.00	6.00	192	30	Sobre	t	f	2026-05-14 08:27:55.279986	\N	4.20	2027-05-14 00:00:00	f
79	MEX079	7500000000794	Bismuto Subsalicilato 262mg x30	Antidiarreico y protector gástrico	6	1	6.00	11.00	74	15	Tableta	t	f	2026-05-14 08:27:55.212388	\N	7.70	2027-05-14 00:00:00	f
73	MEX073	7500000000732	Omeprazol 20mg x14	Inhibidor de bomba de protones para acidez estomacal	6	1	5.00	10.00	197	25	Cápsula	t	f	2026-05-14 08:27:54.792884	\N	7.00	2027-05-14 00:00:00	f
66	MEX066	7500000000664	Cetirizina 10mg x10	Antihistamínico para rinitis alérgica	5	1	5.00	10.00	137	18	Tableta	t	f	2026-05-14 08:27:54.332045	\N	7.00	2027-05-14 00:00:00	f
76	MEX076	7500000000763	Hioscina 10mg x20	Antiespasmódico para cólicos abdominales	6	1	4.00	8.00	95	15	Tableta	t	f	2026-05-14 08:27:55.000949	\N	5.60	2027-05-14 00:00:00	f
42	MEX042	7500000000428	Sulfato Ferroso 200mg x30	Suplemento de hierro para prevenir y tratar anemia	3	1	4.00	8.00	138	20	Tableta	t	f	2026-05-14 08:27:52.663422	\N	5.60	2027-05-14 00:00:00	f
67	MEX067	7500000000671	Dexametasona 4mg x8	Corticoide antiinflamatorio e inmunosupresor	5	1	4.00	8.00	88	15	Tableta	t	t	2026-05-14 08:27:54.395739	\N	5.60	2027-05-14 00:00:00	f
110	MEX110	7500000001104	Tretinoína Crema 0.05% 20g	Retinoide tópico para acné y rejuvenecimiento	9	1	14.00	25.00	40	8	Tubo	t	f	2026-05-14 08:27:57.393822	\N	17.50	2027-05-14 00:00:00	f
64	MEX064	7500000000640	Salbutamol Solución Nebulizar 20ml	Solución para nebulización en crisis asmáticas	5	1	12.00	22.00	37	10	Frasco	t	t	2026-05-14 08:27:54.189899	\N	15.40	2027-05-14 00:00:00	f
93	MEX093	7500000000930	Carvedilol 25mg x30	Beta-bloqueador para hipertensión e insuficiencia cardiaca	7	1	10.00	18.00	59	10	Tableta	t	t	2026-05-14 08:27:56.195003	\N	12.60	2027-05-14 00:00:00	f
105	MEX105	7500000001050	Miconazol Crema 30g	Antifúngico para candidiasis cutánea	9	1	7.00	13.00	55	10	Tubo	t	f	2026-05-14 08:27:57.044332	\N	9.10	2027-05-14 00:00:00	f
86	MEX086	7500000000862	Enalapril 10mg x20	Antihipertensivo IECA para hipertensión	7	1	6.00	12.00	100	15	Tableta	t	t	2026-05-14 08:27:55.705242	\N	8.40	2027-05-14 00:00:00	f
100	MEX100	7500000001005	Pregabalina 75mg x14	Anticonvulsivante para fibromialgia y neuropatía	8	1	18.00	30.00	39	8	Cápsula	t	t	2026-05-14 08:27:56.696785	\N	21.00	2027-05-14 00:00:00	f
15	MEX015	7500000000152	Lidocaína Spray 10%	Anestésico tópico en aerosol para procedimientos menores	1	1	9.00	16.00	40	10	Frasco	t	f	2026-05-14 08:27:50.921777	\N	11.20	2027-05-14 00:00:00	f
24	MEX024	7500000000244	Metronidazol 500mg x14	Antibiótico para infecciones parasitarias y bacterianas	2	1	5.00	10.00	102	15	Tableta	t	t	2026-05-14 08:27:51.5069	\N	7.00	2027-05-14 00:00:00	f
98	MEX098	7500000000985	Fluoxetina 20mg x30	Antidepresivo ISRS para depresión mayor	8	1	10.00	18.00	53	12	Cápsula	t	t	2026-05-14 08:27:56.554124	\N	12.60	2027-05-14 00:00:00	f
31	MEX031	7500000000312	Complejo B x30	Suplemento de vitaminas del complejo B	3	1	18.00	32.00	119	20	Tableta	t	f	2026-05-14 08:27:51.974349	\N	22.40	2027-05-14 00:00:00	f
78	MEX078	7500000000787	Metoclopramida 10mg x10	Antiemético para náuseas y vómitos	6	1	5.00	9.00	84	15	Tableta	t	f	2026-05-14 08:27:55.13883	\N	6.30	2027-05-14 00:00:00	f
77	MEX077	7500000000770	Loperamida 2mg x6	Antidiarreico de acción rápida	6	1	3.00	5.00	157	20	Cápsula	t	f	2026-05-14 08:27:55.069955	\N	3.50	2027-05-14 00:00:00	f
97	MEX097	7500000000978	Sertralina 50mg x30	Antidepresivo ISRS para depresión y ansiedad	8	1	15.00	28.00	76	12	Tableta	t	t	2026-05-14 08:27:56.485281	\N	19.60	2027-05-14 00:00:00	f
112	MEX112	7500000001128	Calamina Loción 120ml	Loción calmante para picaduras y alergias cutáneas	9	1	4.00	8.00	99	15	Frasco	t	f	2026-05-14 08:27:57.542108	\N	5.60	2027-05-14 00:00:00	f
43	MEX043	7500000000435	Ácido Fólico 5mg x30	Suplemento de ácido fólico para embarazadas	3	1	3.00	6.00	115	20	Tableta	t	f	2026-05-14 08:27:52.732891	\N	4.20	2027-05-14 00:00:00	f
90	MEX090	7500000000909	AAS 100mg x30	Aspirina infantil para prevención cardiovascular	7	1	2.00	4.00	234	30	Tableta	t	f	2026-05-14 08:27:55.980769	\N	2.80	2027-05-14 00:00:00	f
28	MEX028	7500000000282	Cefalexina 500mg x20	Antibiótico cefalosporina oral para infecciones diversas	2	1	7.00	14.00	65	12	Cápsula	t	t	2026-05-14 08:27:51.781275	\N	9.80	2027-05-14 00:00:00	f
99	MEX099	7500000000992	Gabapentina 300mg x30	Anticonvulsivante para epilepsia y dolor neuropático	8	1	14.00	25.00	52	10	Cápsula	t	t	2026-05-14 08:27:56.626445	\N	17.50	2027-05-14 00:00:00	f
36	MEX036	7500000000367	Hierro 65mg x30	Suplemento de hierro para anemia	3	1	12.00	22.00	94	15	Cápsula	t	f	2026-05-14 08:27:52.287301	\N	15.40	2027-05-14 00:00:00	f
2	MEX002	7500000000022	Paracetamol 750mg x10	Analgésico y antipirético de dosis alta	1	1	3.50	7.00	148	25	Tableta	t	f	2026-05-14 08:27:50.072073	\N	4.90	2027-05-14 00:00:00	f
11	MEX011	7500000000114	Piroxicam 20mg x10	Antiinflamatorio para dolores reumáticos agudos	1	1	5.00	10.00	55	10	Cápsula	t	f	2026-05-14 08:27:50.667629	\N	7.00	2027-05-14 00:00:00	f
71	MEX071	7500000000718	Fenilefrina 10mg x20	Descongestionante nasal para resfriados	5	1	3.00	6.00	87	15	Tableta	t	f	2026-05-14 08:27:54.657602	\N	4.20	2027-05-14 00:00:00	f
103	MEX103	7500000001036	Betametasona Crema 15g	Corticoide tópico para dermatitis y alergias cutáneas	9	1	8.00	15.00	77	15	Tubo	t	f	2026-05-14 08:27:56.901494	\N	10.50	2027-05-14 00:00:00	f
102	MEX102	7500000001029	Amitriptilina 25mg x30	Antidepresivo tricíclico para depresión y dolor crónico	8	1	5.00	10.00	49	10	Tableta	t	t	2026-05-14 08:27:56.834442	\N	7.00	2027-05-14 00:00:00	f
84	MEX084	7500000000848	Nistatina Suspensión 30ml	Antifúngico oral para candidiasis bucal	6	1	6.00	12.00	39	10	Frasco	t	f	2026-05-14 08:27:55.563461	\N	8.40	2027-05-14 00:00:00	f
120	MEX120	7500000001203	Bicarbonato de Sodio 100g	Antiácido y auxiliar para digestión	6	1	2.00	4.00	97	20	Sobre	t	f	2026-05-14 08:27:58.093969	\N	2.80	2027-05-14 00:00:00	f
96	MEX096	7500000000961	Clonazepam 2mg x30	Ansiolítico y anticonvulsivante de acción prolongada	8	1	8.00	15.00	42	10	Tableta	t	t	2026-05-14 08:27:56.415827	\N	10.50	2027-05-14 00:00:00	f
106	MEX106	7500000001067	Hidrocortisona Crema 1% 15g	Corticoide suave para inflamación cutánea	9	1	5.00	10.00	88	15	Tubo	t	f	2026-05-14 08:27:57.113866	\N	7.00	2027-05-14 00:00:00	f
89	MEX089	7500000000893	Atorvastatina 20mg x30	Estatinas para reducir colesterol LDL	7	1	12.00	22.00	78	15	Tableta	t	t	2026-05-14 08:27:55.909435	\N	15.40	2027-05-14 00:00:00	f
95	MEX095	7500000000954	Diazepam 5mg x10	Ansiolítico benzodiacepina para ansiedad	8	1	4.00	8.00	60	10	Tableta	t	t	2026-05-14 08:27:56.338186	\N	5.60	2027-05-14 00:00:00	f
109	MEX109	7500000001098	Terbinafina Crema 15g	Antifúngico tópico para pie de atleta y tiñas	9	1	11.00	20.00	44	10	Tubo	t	f	2026-05-14 08:27:57.323622	\N	14.00	2027-05-14 00:00:00	f
62	MEX062	7500000000626	Oxímetro de Pulso	Oxímetro digital para medir saturación de oxígeno	4	1	25.00	45.00	29	10	Unidad	t	f	2026-05-14 08:27:54.049385	\N	31.50	2027-05-14 00:00:00	t
49	MEX049	7500000000497	Jabón Líquido Antibacterial 400ml	Jabón para manos con acción antibacterial	4	1	8.00	14.00	173	25	Frasco	t	f	2026-05-14 08:27:53.141859	\N	9.80	2027-05-14 00:00:00	t
91	MEX091	7500000000916	Insulina NPH 100UI/ml 10ml	Insulina de acción intermedia para diabetes	7	1	35.00	55.00	30	10	Frasco	t	t	2026-05-14 08:27:56.051111	\N	38.50	2027-05-14 00:00:00	f
85	MEX085	7500000000855	Losartán 50mg x30	Antihipertensivo para presión arterial alta	7	1	8.00	15.00	110	18	Tableta	t	t	2026-05-14 08:27:55.633471	\N	10.50	2027-05-14 00:00:00	f
107	MEX107	7500000001074	Aciclovir Crema 10g	Antiviral tópico para herpes labial y genital	9	1	9.00	16.00	46	10	Tubo	t	f	2026-05-14 08:27:57.184788	\N	11.20	2027-05-14 00:00:00	f
108	MEX108	7500000001081	Ácido Fusídico Crema 15g	Antibiótico tópico para infecciones cutáneas	9	1	10.00	18.00	38	10	Tubo	t	f	2026-05-14 08:27:57.253574	\N	12.60	2027-05-14 00:00:00	f
88	MEX088	7500000000886	Metformina 850mg x30	Antidiabético oral para diabetes tipo 2	7	1	5.00	10.00	151	20	Tableta	t	t	2026-05-14 08:27:55.838102	\N	7.00	2027-05-14 00:00:00	f
\.


--
-- Data for Name: return_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.return_items (id, returnid, productid, quantity, unitprice, subtotal) FROM stdin;
\.


--
-- Data for Name: returnitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.returnitems (id, returnid, productid, quantity, unitprice, subtotal) FROM stdin;
\.


--
-- Data for Name: returns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.returns (id, saleid, userid, reason, total, createdat) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, description, createdat) FROM stdin;
1	Admin	Administrador del sistema con acceso total	2026-05-14 06:37:15.227028
2	Cajero	Usuario de caja con acceso a ventas	2026-05-14 06:37:15.227028
3	Farmacéutico	Farmacéutico con acceso a recetas y pacientes	2026-05-14 06:37:15.227028
4	Almacenero	Encargado de inventario y stock	2026-05-14 06:37:15.227028
\.


--
-- Data for Name: saleitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.saleitems (id, saleid, productid, quantity, unitprice, discount, subtotal) FROM stdin;
1	1	117	4	6.00	0.00	24.00
2	1	15	3	16.00	0.00	48.00
3	1	2	1	7.00	0.00	7.00
4	2	117	5	6.00	0.00	30.00
5	2	64	5	22.00	0.00	110.00
6	2	85	1	15.00	0.00	15.00
7	3	65	4	12.00	0.00	48.00
8	3	57	3	5.00	0.00	15.00
9	3	12	5	14.00	0.00	70.00
10	4	111	4	12.00	0.00	48.00
11	4	78	2	9.00	0.00	18.00
12	4	81	2	7.00	0.00	14.00
13	5	113	5	7.00	0.00	35.00
14	5	64	3	22.00	0.00	66.00
15	5	80	5	6.00	0.00	30.00
16	6	59	4	6.00	0.00	24.00
17	6	67	4	8.00	0.00	32.00
18	6	26	3	12.00	0.00	36.00
19	7	47	3	25.00	0.00	75.00
20	7	26	1	12.00	0.00	12.00
21	7	56	4	9.00	0.00	36.00
22	8	99	2	25.00	0.00	50.00
23	8	33	3	42.00	0.00	126.00
24	8	98	2	18.00	0.00	36.00
25	9	61	4	15.00	0.00	60.00
26	9	1	2	5.00	0.00	10.00
27	9	98	1	18.00	0.00	18.00
28	10	79	5	11.00	0.00	55.00
29	10	3	1	8.00	0.00	8.00
30	10	99	5	25.00	0.00	125.00
31	11	24	2	10.00	0.00	20.00
32	11	52	4	30.00	0.00	120.00
33	11	8	3	6.00	0.00	18.00
34	12	70	3	8.00	0.00	24.00
35	12	58	5	5.00	0.00	25.00
36	12	30	3	18.00	0.00	54.00
37	13	77	1	5.00	0.00	5.00
38	13	25	4	32.00	0.00	128.00
39	13	32	2	38.00	0.00	76.00
40	14	105	5	13.00	0.00	65.00
41	14	16	1	15.00	0.00	15.00
42	14	83	5	8.00	0.00	40.00
43	15	60	4	5.00	0.00	20.00
44	15	109	5	20.00	0.00	100.00
45	15	81	5	7.00	0.00	35.00
46	16	50	5	55.00	0.00	275.00
47	16	96	4	15.00	0.00	60.00
48	16	119	5	22.00	0.00	110.00
49	17	100	1	30.00	0.00	30.00
50	17	99	1	25.00	0.00	25.00
51	17	36	5	22.00	0.00	110.00
52	18	27	4	16.00	0.00	64.00
53	18	79	2	11.00	0.00	22.00
54	18	42	3	8.00	0.00	24.00
55	19	90	1	4.00	0.00	4.00
56	19	41	5	50.00	0.00	250.00
57	19	7	4	15.00	0.00	60.00
58	20	20	4	18.00	0.00	72.00
59	20	15	2	16.00	0.00	32.00
60	20	55	1	14.00	0.00	14.00
61	21	20	2	18.00	0.00	36.00
62	21	119	4	22.00	0.00	88.00
63	21	117	1	6.00	0.00	6.00
64	22	22	3	25.00	0.00	75.00
65	22	4	5	11.00	0.00	55.00
66	22	42	4	8.00	0.00	32.00
67	23	74	3	22.00	0.00	66.00
68	23	78	2	9.00	0.00	18.00
69	23	19	4	18.00	0.00	72.00
70	24	89	3	22.00	0.00	66.00
71	24	73	3	10.00	0.00	30.00
72	24	57	4	5.00	0.00	20.00
73	25	44	3	10.00	0.00	30.00
74	25	3	1	8.00	0.00	8.00
75	25	119	3	22.00	0.00	66.00
76	26	34	2	55.00	0.00	110.00
77	26	119	3	22.00	0.00	66.00
78	26	55	4	14.00	0.00	56.00
79	27	85	5	15.00	0.00	75.00
80	27	41	3	50.00	0.00	150.00
81	27	62	4	45.00	0.00	180.00
82	28	91	2	55.00	0.00	110.00
83	28	37	5	35.00	0.00	175.00
84	28	43	2	6.00	0.00	12.00
85	29	89	4	22.00	0.00	88.00
86	29	74	4	22.00	0.00	88.00
87	29	84	1	12.00	0.00	12.00
88	30	12	5	14.00	0.00	70.00
89	30	119	1	22.00	0.00	22.00
90	30	84	4	12.00	0.00	48.00
91	31	11	3	10.00	0.00	30.00
92	31	20	5	18.00	0.00	90.00
93	31	53	4	6.00	0.00	24.00
94	32	43	4	6.00	0.00	24.00
95	32	47	3	25.00	0.00	75.00
96	32	101	4	12.00	0.00	48.00
97	33	10	1	14.00	0.00	14.00
98	33	115	5	7.00	0.00	35.00
99	33	116	4	6.00	0.00	24.00
100	34	62	2	45.00	0.00	90.00
101	34	67	4	8.00	0.00	32.00
102	34	88	4	10.00	0.00	40.00
103	35	6	3	7.00	0.00	21.00
104	35	57	1	5.00	0.00	5.00
105	35	27	3	16.00	0.00	48.00
106	36	32	4	38.00	0.00	152.00
107	36	53	3	6.00	0.00	18.00
108	36	50	1	55.00	0.00	55.00
109	36	102	3	10.00	0.00	30.00
110	36	74	2	22.00	0.00	44.00
111	37	9	2	8.00	0.00	16.00
112	37	115	4	7.00	0.00	28.00
113	37	44	4	10.00	0.00	40.00
114	37	57	4	5.00	0.00	20.00
115	38	81	3	7.00	0.00	21.00
116	38	79	3	11.00	0.00	33.00
117	38	27	3	16.00	0.00	48.00
118	38	82	3	6.00	0.00	18.00
119	39	115	3	7.00	0.00	21.00
120	40	28	5	14.00	0.00	70.00
121	40	10	1	14.00	0.00	14.00
122	40	76	4	8.00	0.00	32.00
123	41	42	4	8.00	0.00	32.00
124	42	49	3	14.00	0.00	42.00
125	42	42	1	8.00	0.00	8.00
126	42	98	5	18.00	0.00	90.00
127	42	74	5	22.00	0.00	110.00
128	42	55	4	14.00	0.00	56.00
129	43	66	3	10.00	0.00	30.00
130	43	59	3	6.00	0.00	18.00
131	44	84	3	12.00	0.00	36.00
132	44	27	2	16.00	0.00	32.00
133	44	96	4	15.00	0.00	60.00
134	44	21	1	28.00	0.00	28.00
135	45	97	1	28.00	0.00	28.00
136	45	34	3	55.00	0.00	165.00
137	46	91	2	55.00	0.00	110.00
138	46	3	3	8.00	0.00	24.00
139	46	38	2	18.00	0.00	36.00
140	46	60	4	5.00	0.00	20.00
141	46	81	3	7.00	0.00	21.00
142	47	10	2	14.00	0.00	28.00
143	47	113	3	7.00	0.00	21.00
144	48	36	2	22.00	0.00	44.00
145	48	108	5	18.00	0.00	90.00
146	48	86	5	12.00	0.00	60.00
147	49	10	3	14.00	0.00	42.00
148	49	80	3	6.00	0.00	18.00
149	49	61	4	15.00	0.00	60.00
150	49	20	1	18.00	0.00	18.00
151	50	106	2	10.00	0.00	20.00
152	50	7	2	15.00	0.00	30.00
153	50	107	5	16.00	0.00	80.00
154	51	89	5	22.00	0.00	110.00
155	51	59	3	6.00	0.00	18.00
156	51	44	5	10.00	0.00	50.00
157	52	71	3	6.00	0.00	18.00
158	52	81	2	7.00	0.00	14.00
159	52	56	5	9.00	0.00	45.00
160	52	12	5	14.00	0.00	70.00
161	52	51	2	12.00	0.00	24.00
162	53	52	1	30.00	0.00	30.00
163	53	7	2	15.00	0.00	30.00
164	53	106	3	10.00	0.00	30.00
165	54	45	3	8.00	0.00	24.00
166	54	4	2	11.00	0.00	22.00
167	54	51	2	12.00	0.00	24.00
168	55	61	2	15.00	0.00	30.00
169	55	62	5	45.00	0.00	225.00
170	55	63	5	35.00	0.00	175.00
171	56	113	3	7.00	0.00	21.00
172	56	103	3	15.00	0.00	45.00
173	56	11	3	10.00	0.00	30.00
174	56	31	5	32.00	0.00	160.00
175	57	54	4	9.00	0.00	36.00
176	57	48	3	25.00	0.00	75.00
177	58	37	5	35.00	0.00	175.00
178	58	93	1	18.00	0.00	18.00
179	58	109	5	20.00	0.00	100.00
180	59	54	5	9.00	0.00	45.00
181	59	95	1	8.00	0.00	8.00
182	59	32	5	38.00	0.00	190.00
183	60	17	4	12.00	0.00	48.00
184	60	25	3	32.00	0.00	96.00
185	60	119	3	22.00	0.00	66.00
186	60	98	3	18.00	0.00	54.00
187	60	24	4	10.00	0.00	40.00
188	61	102	3	10.00	0.00	30.00
189	61	42	4	8.00	0.00	32.00
190	61	49	4	14.00	0.00	56.00
191	62	13	3	16.00	0.00	48.00
192	63	36	4	22.00	0.00	88.00
193	63	43	5	6.00	0.00	30.00
194	63	54	2	9.00	0.00	18.00
195	63	67	4	8.00	0.00	32.00
196	63	84	3	12.00	0.00	36.00
197	64	120	3	4.00	0.00	12.00
198	64	86	5	12.00	0.00	60.00
199	64	31	5	32.00	0.00	160.00
200	64	23	1	14.00	0.00	14.00
201	65	66	5	10.00	0.00	50.00
202	65	102	4	10.00	0.00	40.00
203	65	23	3	14.00	0.00	42.00
204	65	106	4	10.00	0.00	40.00
205	66	63	3	35.00	0.00	105.00
206	66	104	2	12.00	0.00	24.00
207	66	7	2	15.00	0.00	30.00
208	66	76	1	8.00	0.00	8.00
209	67	36	4	22.00	0.00	88.00
210	67	91	2	55.00	0.00	110.00
211	67	16	5	15.00	0.00	75.00
212	68	79	1	11.00	0.00	11.00
213	68	25	2	32.00	0.00	64.00
214	68	7	2	15.00	0.00	30.00
215	68	98	2	18.00	0.00	36.00
216	68	109	1	20.00	0.00	20.00
217	69	111	4	12.00	0.00	48.00
218	70	3	2	8.00	0.00	16.00
219	70	1	1	5.00	0.00	5.00
220	70	104	4	12.00	0.00	48.00
221	70	11	4	10.00	0.00	40.00
222	71	117	1	6.00	0.00	6.00
223	71	43	4	6.00	0.00	24.00
224	72	90	1	4.00	0.00	4.00
225	72	107	1	16.00	0.00	16.00
226	72	43	1	6.00	0.00	6.00
227	72	108	1	18.00	0.00	18.00
228	73	90	1	4.00	0.00	4.00
229	73	107	1	16.00	0.00	16.00
230	73	57	1	5.00	0.00	5.00
231	74	101	1	12.00	0.00	12.00
232	75	24	2	10.00	0.00	20.00
233	76	35	4	48.00	0.00	192.00
234	76	32	2	38.00	0.00	76.00
235	76	7	1	15.00	0.00	15.00
236	76	50	4	55.00	0.00	220.00
237	76	98	4	18.00	0.00	72.00
238	77	90	2	4.00	0.00	8.00
239	77	57	3	5.00	0.00	15.00
240	78	57	4	5.00	0.00	20.00
241	78	78	2	9.00	0.00	18.00
242	79	68	3	10.00	0.00	30.00
243	79	65	2	12.00	0.00	24.00
244	80	81	1	7.00	0.00	7.00
245	80	40	4	70.00	0.00	280.00
246	81	48	5	25.00	0.00	125.00
247	81	77	2	5.00	0.00	10.00
248	81	104	2	12.00	0.00	24.00
249	81	111	1	12.00	0.00	12.00
250	81	91	4	55.00	0.00	220.00
251	82	8	5	6.00	0.00	30.00
252	82	112	1	8.00	0.00	8.00
253	82	28	1	14.00	0.00	14.00
254	82	70	1	8.00	0.00	8.00
255	83	99	3	25.00	0.00	75.00
256	83	52	2	30.00	0.00	60.00
257	83	36	4	22.00	0.00	88.00
258	83	56	4	9.00	0.00	36.00
259	84	57	1	5.00	0.00	5.00
260	84	116	1	6.00	0.00	6.00
261	85	108	1	18.00	0.00	18.00
262	85	44	1	10.00	0.00	10.00
263	85	43	1	6.00	0.00	6.00
264	85	107	1	16.00	0.00	16.00
265	85	90	1	4.00	0.00	4.00
266	85	17	2	12.00	0.00	24.00
267	85	19	4	18.00	0.00	72.00
268	86	43	1	6.00	0.00	6.00
269	86	33	1	42.00	0.00	42.00
270	86	40	1	70.00	0.00	70.00
271	86	41	1	50.00	0.00	50.00
272	86	35	1	48.00	0.00	48.00
273	86	37	1	35.00	0.00	35.00
274	86	36	1	22.00	0.00	22.00
275	86	31	1	32.00	0.00	32.00
276	87	107	1	16.00	0.00	16.00
277	87	43	1	6.00	0.00	6.00
278	88	70	3	8.00	0.00	24.00
279	89	30	4	18.00	0.00	72.00
280	89	55	3	14.00	0.00	42.00
281	90	119	3	22.00	0.00	66.00
282	90	58	1	5.00	0.00	5.00
283	91	18	3	22.00	0.00	66.00
284	91	85	4	15.00	0.00	60.00
285	91	19	2	18.00	0.00	36.00
286	91	23	1	14.00	0.00	14.00
287	92	6	1	7.00	0.00	7.00
288	92	107	5	16.00	0.00	80.00
289	92	44	3	10.00	0.00	30.00
290	92	118	2	4.00	0.00	8.00
291	92	28	4	14.00	0.00	56.00
292	93	116	4	6.00	0.00	24.00
293	93	71	3	6.00	0.00	18.00
294	93	9	5	8.00	0.00	40.00
295	93	11	1	10.00	0.00	10.00
296	93	82	3	6.00	0.00	18.00
297	94	54	4	9.00	0.00	36.00
298	94	61	1	15.00	0.00	15.00
299	95	68	5	10.00	0.00	50.00
300	95	56	4	9.00	0.00	36.00
301	95	97	3	28.00	0.00	84.00
302	95	47	5	25.00	0.00	125.00
303	96	52	1	30.00	0.00	30.00
304	96	101	4	12.00	0.00	48.00
305	96	108	5	18.00	0.00	90.00
306	97	88	5	10.00	0.00	50.00
307	97	45	1	8.00	0.00	8.00
308	97	75	2	6.00	0.00	12.00
309	98	39	3	28.00	0.00	84.00
310	98	114	3	5.00	0.00	15.00
311	99	97	2	28.00	0.00	56.00
312	99	55	2	14.00	0.00	28.00
313	99	69	1	75.00	0.00	75.00
314	99	52	5	30.00	0.00	150.00
315	99	82	2	6.00	0.00	12.00
316	100	1	2	5.00	0.00	10.00
317	101	2	1	7.00	0.00	7.00
\.


--
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales (id, receiptnumber, userid, customerid, subtotal, tax, discount, total, paymentmethod, paymentstatus, notes, cashregistersessionid, createdat, amountreceived, change) FROM stdin;
1	FAC-20260514-0001	1	\N	79.00	12.64	0.00	91.64	Transferencia	Completed	Venta automática de prueba #1	\N	2026-05-14 08:29:45.109945	0.00	0.00
2	FAC-20260514-0002	1	\N	155.00	24.80	0.00	179.80	Tarjeta	Completed	Venta automática de prueba #2	\N	2026-05-14 08:29:45.722831	0.00	0.00
3	FAC-20260514-0003	1	\N	133.00	21.28	0.00	154.28	Tarjeta	Completed	Venta automática de prueba #3	\N	2026-05-14 08:29:46.067941	0.00	0.00
4	FAC-20260514-0004	1	\N	80.00	12.80	0.00	92.80	Efectivo	Completed	Venta automática de prueba #4	\N	2026-05-14 08:29:46.400546	0.00	0.00
5	FAC-20260514-0005	1	\N	131.00	20.96	0.00	151.96	Efectivo	Completed	Venta automática de prueba #5	\N	2026-05-14 08:29:46.733121	0.00	0.00
6	FAC-20260514-0006	1	\N	92.00	14.72	0.00	106.72	Tarjeta	Completed	Venta automática de prueba #1	\N	2026-05-14 08:44:20.302453	0.00	0.00
7	FAC-20260514-0007	1	\N	123.00	19.68	0.00	142.68	Tarjeta	Completed	Venta automática de prueba #2	\N	2026-05-14 08:44:20.632772	0.00	0.00
8	FAC-20260514-0008	1	\N	212.00	33.92	0.00	245.92	Tarjeta	Completed	Venta automática de prueba #3	\N	2026-05-14 08:44:20.975858	0.00	0.00
9	FAC-20260514-0009	1	\N	88.00	14.08	0.00	102.08	Transferencia	Completed	Venta automática de prueba #4	\N	2026-05-14 08:44:21.318123	0.00	0.00
10	FAC-20260514-0010	1	\N	188.00	30.08	0.00	218.08	Efectivo	Completed	Venta automática de prueba #5	\N	2026-05-14 08:44:21.656881	0.00	0.00
11	FAC-20260514-0011	1	\N	158.00	25.28	0.00	183.28	Efectivo	Completed	Venta automática de prueba #1	\N	2026-05-14 08:48:46.770165	0.00	0.00
12	FAC-20260514-0012	1	\N	103.00	16.48	0.00	119.48	Tarjeta	Completed	Venta automática de prueba #2	\N	2026-05-14 08:48:47.100946	0.00	0.00
13	FAC-20260514-0013	1	\N	209.00	33.44	0.00	242.44	Tarjeta	Completed	Venta automática de prueba #3	\N	2026-05-14 08:48:47.430937	0.00	0.00
14	FAC-20260514-0014	1	\N	120.00	19.20	0.00	139.20	Efectivo	Completed	Venta automática de prueba #4	\N	2026-05-14 08:48:47.769466	0.00	0.00
15	FAC-20260514-0015	1	\N	155.00	24.80	0.00	179.80	Tarjeta	Completed	Venta automática de prueba #5	\N	2026-05-14 08:48:48.107064	0.00	0.00
16	FAC-20260514-0016	1	\N	445.00	71.20	0.00	516.20	Efectivo	Completed	Venta automática de prueba #1	\N	2026-05-14 09:26:03.776358	0.00	0.00
17	FAC-20260514-0017	1	\N	165.00	26.40	0.00	191.40	Tarjeta	Completed	Venta automática de prueba #2	\N	2026-05-14 09:26:04.128444	0.00	0.00
18	FAC-20260514-0018	1	\N	110.00	17.60	0.00	127.60	Transferencia	Completed	Venta automática de prueba #3	\N	2026-05-14 09:26:04.468181	0.00	0.00
19	FAC-20260514-0019	1	\N	314.00	50.24	0.00	364.24	Efectivo	Completed	Venta automática de prueba #4	\N	2026-05-14 09:26:04.802455	0.00	0.00
20	FAC-20260514-0020	1	\N	118.00	18.88	0.00	136.88	Transferencia	Completed	Venta automática de prueba #5	\N	2026-05-14 09:26:05.151662	0.00	0.00
21	FAC-20260514-0021	1	\N	130.00	20.80	0.00	150.80	Efectivo	Completed	Venta automática de prueba #1	\N	2026-05-14 10:06:28.283944	0.00	0.00
22	FAC-20260514-0022	1	\N	162.00	25.92	0.00	187.92	Transferencia	Completed	Venta automática de prueba #2	\N	2026-05-14 10:06:28.632255	0.00	0.00
23	FAC-20260514-0023	1	\N	156.00	24.96	0.00	180.96	Transferencia	Completed	Venta automática de prueba #3	\N	2026-05-14 10:06:28.960493	0.00	0.00
24	FAC-20260514-0024	1	\N	116.00	18.56	0.00	134.56	Transferencia	Completed	Venta automática de prueba #4	\N	2026-05-14 10:06:29.295419	0.00	0.00
25	FAC-20260514-0025	1	\N	104.00	16.64	0.00	120.64	Transferencia	Completed	Venta automática de prueba #5	\N	2026-05-14 10:06:29.625349	0.00	0.00
26	FAC-20260514-0026	1	\N	232.00	37.12	0.00	269.12	Tarjeta	Completed	Venta automática de prueba #1	\N	2026-05-14 10:07:15.446578	0.00	0.00
27	FAC-20260514-0027	1	\N	405.00	64.80	0.00	469.80	Transferencia	Completed	Venta automática de prueba #2	\N	2026-05-14 10:07:15.782442	0.00	0.00
28	FAC-20260514-0028	1	\N	297.00	47.52	0.00	344.52	Tarjeta	Completed	Venta automática de prueba #3	\N	2026-05-14 10:07:16.105014	0.00	0.00
29	FAC-20260514-0029	1	\N	188.00	30.08	0.00	218.08	Efectivo	Completed	Venta automática de prueba #4	\N	2026-05-14 10:07:16.435136	0.00	0.00
30	FAC-20260514-0030	1	\N	140.00	22.40	0.00	162.40	Efectivo	Completed	Venta automática de prueba #5	\N	2026-05-14 10:07:16.763595	0.00	0.00
31	FAC-20260514-0031	1	\N	144.00	23.04	0.00	167.04	Tarjeta	Completed	Venta automática de prueba #1	\N	2026-05-14 12:29:32.333152	0.00	0.00
32	FAC-20260514-0032	1	\N	147.00	23.52	0.00	170.52	Tarjeta	Completed	Venta automática de prueba #2	\N	2026-05-14 12:29:32.855322	0.00	0.00
33	FAC-20260514-0033	1	\N	73.00	11.68	0.00	84.68	Tarjeta	Completed	Venta automática de prueba #3	\N	2026-05-14 12:29:33.200748	0.00	0.00
34	FAC-20260514-0034	1	\N	162.00	25.92	0.00	187.92	Tarjeta	Completed	Venta automática de prueba #4	\N	2026-05-14 12:29:33.540649	0.00	0.00
35	FAC-20260514-0035	1	\N	74.00	11.84	0.00	85.84	Tarjeta	Completed	Venta automática de prueba #5	\N	2026-05-14 12:29:33.875568	0.00	0.00
36	FAC-20260515-0001	1	\N	299.00	29.90	0.00	328.90	Efectivo	Completed	Simulación #1 (full)	\N	2026-05-15 08:34:00.813879	0.00	0.00
37	FAC-20260515-0002	1	\N	104.00	10.40	0.00	114.40	Efectivo	Completed	Simulación #2 (full)	\N	2026-05-15 08:34:01.394623	0.00	0.00
38	FAC-20260515-0003	1	\N	120.00	12.00	0.00	132.00	Transferencia	Completed	Simulación #3 (full)	\N	2026-05-15 08:34:01.645597	0.00	0.00
39	FAC-20260515-0004	1	\N	21.00	2.10	0.00	23.10	Transferencia	Completed	Simulación #4 (full)	\N	2026-05-15 08:34:01.823668	0.00	0.00
40	FAC-20260515-0005	1	\N	116.00	11.60	0.00	127.60	Transferencia	Completed	Simulación #5 (full)	\N	2026-05-15 08:34:02.020938	0.00	0.00
41	FAC-20260515-0006	1	\N	32.00	3.20	0.00	35.20	Transferencia	Cancelled	Simulación #6 (full)	\N	2026-05-15 08:34:02.19671	0.00	0.00
42	FAC-20260515-0007	1	\N	306.00	30.60	0.00	336.60	Efectivo	Completed	Simulación #1 (full)	\N	2026-05-15 08:37:39.702773	0.00	0.00
43	FAC-20260515-0008	1	\N	48.00	4.80	0.00	52.80	Tarjeta	Completed	Simulación #2 (full)	\N	2026-05-15 08:37:39.884423	0.00	0.00
44	FAC-20260515-0009	1	\N	156.00	15.60	0.00	171.60	Transferencia	Completed	Simulación #3 (full)	\N	2026-05-15 08:37:40.068532	0.00	0.00
45	FAC-20260515-0010	1	\N	193.00	19.30	0.00	212.30	Tarjeta	Completed	Simulación #4 (full)	\N	2026-05-15 08:37:40.250901	0.00	0.00
46	FAC-20260515-0011	1	\N	211.00	21.10	0.00	232.10	Efectivo	Completed	Simulación #5 (full)	\N	2026-05-15 08:37:40.431623	0.00	0.00
47	FAC-20260515-0012	1	\N	49.00	4.90	0.00	53.90	Transferencia	Cancelled	Simulación #6 (full)	\N	2026-05-15 08:37:40.607496	0.00	0.00
48	FAC-20260515-0013	1	\N	194.00	19.40	0.00	213.40	Efectivo	Completed	Simulación #1 (full)	\N	2026-05-15 08:38:07.26534	0.00	0.00
49	FAC-20260515-0014	1	\N	138.00	13.80	0.00	151.80	Transferencia	Completed	Simulación #2 (full)	\N	2026-05-15 08:38:07.451228	0.00	0.00
50	FAC-20260515-0015	1	\N	130.00	13.00	0.00	143.00	Transferencia	Completed	Simulación #3 (full)	\N	2026-05-15 08:38:07.628378	0.00	0.00
51	FAC-20260515-0016	1	\N	178.00	17.80	0.00	195.80	Tarjeta	Completed	Simulación #4 (full)	\N	2026-05-15 08:38:07.810275	0.00	0.00
52	FAC-20260515-0017	1	\N	171.00	17.10	0.00	188.10	Transferencia	Completed	Simulación #5 (full)	\N	2026-05-15 08:38:08.00095	0.00	0.00
53	FAC-20260515-0018	1	\N	90.00	9.00	0.00	99.00	Tarjeta	Cancelled	Simulación #6 (full)	\N	2026-05-15 08:38:08.201445	0.00	0.00
54	FAC-20260515-0019	1	\N	70.00	7.00	0.00	77.00	Transferencia	Completed	Simulación #1 (full)	\N	2026-05-15 08:41:37.528688	0.00	0.00
55	FAC-20260515-0020	1	\N	430.00	43.00	0.00	473.00	Efectivo	Completed	Simulación #2 (full)	\N	2026-05-15 08:41:37.702796	0.00	0.00
56	FAC-20260515-0021	1	\N	256.00	25.60	0.00	281.60	Transferencia	Completed	Simulación #3 (full)	\N	2026-05-15 08:41:37.8867	0.00	0.00
57	FAC-20260515-0022	1	\N	111.00	11.10	0.00	122.10	Efectivo	Completed	Simulación #4 (full)	\N	2026-05-15 08:41:38.084152	0.00	0.00
58	FAC-20260515-0023	1	\N	293.00	29.30	0.00	322.30	Transferencia	Completed	Simulación #5 (full)	\N	2026-05-15 08:41:38.271916	0.00	0.00
59	FAC-20260515-0024	1	\N	243.00	24.30	0.00	267.30	Tarjeta	Cancelled	Simulación #6 (full)	\N	2026-05-15 08:41:38.466268	0.00	0.00
60	FAC-20260515-0025	1	\N	304.00	30.40	0.00	334.40	Efectivo	Completed	Simulación #1 (full)	\N	2026-05-15 08:50:45.67642	0.00	0.00
61	FAC-20260515-0026	1	\N	118.00	11.80	0.00	129.80	Transferencia	Completed	Simulación #2 (full)	\N	2026-05-15 08:50:46.215079	0.00	0.00
62	FAC-20260515-0027	1	\N	48.00	4.80	0.00	52.80	Efectivo	Completed	Simulación #3 (full)	\N	2026-05-15 08:50:46.430736	0.00	0.00
63	FAC-20260515-0028	1	\N	204.00	20.40	0.00	224.40	Efectivo	Completed	Simulación #4 (full)	\N	2026-05-15 08:50:46.611724	0.00	0.00
64	FAC-20260515-0029	1	\N	246.00	24.60	0.00	270.60	Tarjeta	Completed	Simulación #5 (full)	\N	2026-05-15 08:50:46.81629	0.00	0.00
65	FAC-20260515-0030	1	\N	172.00	17.20	0.00	189.20	Tarjeta	Cancelled	Simulación #6 (full)	\N	2026-05-15 08:50:46.995124	0.00	0.00
66	FAC-20260515-0031	1	1	167.00	16.70	0.00	183.70	Transferencia	Completed	Simulación #1 (full)	\N	2026-05-15 09:03:52.627383	0.00	0.00
67	FAC-20260515-0032	1	1	273.00	27.30	0.00	300.30	Tarjeta	Completed	Simulación #2 (full)	\N	2026-05-15 09:03:52.814054	0.00	0.00
68	FAC-20260515-0033	1	\N	161.00	16.10	0.00	177.10	Efectivo	Completed	Simulación #3 (full)	\N	2026-05-15 09:03:53.015381	0.00	0.00
69	FAC-20260515-0034	1	1	48.00	4.80	0.00	52.80	Efectivo	Completed	Simulación #4 (full)	\N	2026-05-15 09:03:53.190145	0.00	0.00
70	FAC-20260515-0035	1	1	109.00	10.90	0.00	119.90	Efectivo	Completed	Simulación #5 (full)	\N	2026-05-15 09:03:53.362892	0.00	0.00
71	FAC-20260515-0036	1	\N	30.00	3.00	0.00	33.00	Transferencia	Cancelled	Simulación #6 (full)	\N	2026-05-15 09:03:53.536962	0.00	0.00
72	FAC-20260515-0037	2	\N	44.00	4.40	0.00	48.40	Efectivo	Completed	\N	\N	2026-05-15 09:05:39.227864	0.00	0.00
73	FAC-20260515-0038	1	\N	25.00	2.50	0.00	27.50	Efectivo	Completed	\N	\N	2026-05-15 20:29:26.06998	0.00	0.00
74	FAC-20260515-0039	1	1	12.00	0.00	0.00	12.00	Efectivo	Completed	Simulación #1 (quick)	\N	2026-05-15 21:54:22.211801	0.00	0.00
75	FAC-20260515-0040	1	1	20.00	0.00	0.00	20.00	Tarjeta	Completed	Simulación #2 (quick)	\N	2026-05-15 21:54:22.793864	0.00	0.00
76	FAC-20260515-0041	1	1	575.00	35.20	0.00	610.20	Efectivo	Completed	Simulación #3 (quick)	\N	2026-05-15 21:54:23.016042	0.00	0.00
77	FAC-20260515-0042	1	\N	23.00	2.40	0.00	25.40	Efectivo	Completed	\N	\N	2026-05-15 21:54:37.00645	0.00	0.00
78	FAC-20260515-0043	1	\N	38.00	3.20	0.00	41.20	Tarjeta	Completed	Simulación #1 (full)	\N	2026-05-15 21:54:42.259942	0.00	0.00
79	FAC-20260515-0044	1	1	54.00	0.00	0.00	54.00	Transferencia	Completed	Simulación #2 (full)	\N	2026-05-15 21:54:42.437646	0.00	0.00
80	FAC-20260515-0045	1	1	287.00	0.00	0.00	287.00	Tarjeta	Completed	Simulación #3 (full)	\N	2026-05-15 21:54:42.615369	0.00	0.00
81	FAC-20260515-0046	1	\N	391.00	20.00	0.00	411.00	Tarjeta	Completed	Simulación #4 (full)	\N	2026-05-15 21:54:42.805058	0.00	0.00
82	FAC-20260515-0047	1	1	60.00	0.00	0.00	60.00	Tarjeta	Completed	Simulación #5 (full)	\N	2026-05-15 21:54:42.995166	0.00	0.00
83	FAC-20260515-0048	1	1	259.00	15.36	0.00	274.36	Tarjeta	Cancelled	Simulación #6 (full)	\N	2026-05-15 21:54:43.182418	0.00	0.00
84	FAC-20260515-0049	1	\N	11.00	1.76	0.00	12.76	Efectivo	Completed	\N	\N	2026-05-15 22:05:31.008784	0.00	0.00
85	FAC-20260515-0050	1	1	150.00	1.60	0.00	151.60	Efectivo	Completed	\N	\N	2026-05-15 22:07:21.867604	0.00	0.00
86	FAC-20260515-0051	1	\N	305.00	0.00	0.00	305.00	Efectivo	Completed	\N	\N	2026-05-15 22:07:59.527289	0.00	0.00
87	FAC-20260515-0052	1	\N	22.00	0.00	0.00	22.00	Efectivo	Completed	\N	\N	2026-05-15 22:08:42.406905	0.00	0.00
88	FAC-20260515-0053	1	1	24.00	0.00	0.00	24.00	Tarjeta	Completed	Simulación #1 (full)	\N	2026-05-15 22:15:07.043334	0.00	0.00
89	FAC-20260515-0054	1	1	114.00	6.72	0.00	120.72	Tarjeta	Completed	Simulación #2 (full)	\N	2026-05-15 22:15:07.227585	0.00	0.00
90	FAC-20260515-0055	1	\N	71.00	11.36	0.00	82.36	Transferencia	Completed	Simulación #3 (full)	\N	2026-05-15 22:15:07.411935	0.00	0.00
91	FAC-20260515-0056	1	1	176.00	0.00	0.00	176.00	Transferencia	Completed	Simulación #4 (full)	\N	2026-05-15 22:15:07.59295	0.00	0.00
92	FAC-20260515-0057	1	1	181.00	6.08	0.00	187.08	Tarjeta	Completed	Simulación #5 (full)	\N	2026-05-15 22:15:07.77858	0.00	0.00
93	FAC-20260515-0058	1	\N	110.00	3.84	0.00	113.84	Transferencia	Cancelled	Simulación #6 (full)	\N	2026-05-15 22:15:07.971734	0.00	0.00
94	FAC-20260515-0059	1	1	51.00	8.16	0.00	59.16	Transferencia	Completed	Simulación #1 (full)	\N	2026-05-15 23:15:38.71451	0.00	0.00
95	FAC-20260515-0060	1	1	295.00	25.76	0.00	320.76	Transferencia	Completed	Simulación #2 (full)	\N	2026-05-15 23:15:39.358756	0.00	0.00
96	FAC-20260515-0061	1	1	168.00	4.80	0.00	172.80	Transferencia	Completed	Simulación #3 (full)	\N	2026-05-15 23:15:39.574247	0.00	0.00
97	FAC-20260515-0062	1	1	70.00	1.28	0.00	71.28	Transferencia	Completed	Simulación #4 (full)	\N	2026-05-15 23:15:39.766109	0.00	0.00
98	FAC-20260515-0063	1	1	99.00	2.40	0.00	101.40	Efectivo	Completed	Simulación #5 (full)	\N	2026-05-15 23:15:39.954481	0.00	0.00
99	FAC-20260515-0064	1	1	321.00	28.48	0.00	349.48	Efectivo	Cancelled	Simulación #6 (full)	\N	2026-05-15 23:15:40.14668	0.00	0.00
100	FAC-20260515-0065	1	\N	10.00	0.00	0.00	10.00	Efectivo	Completed	\N	\N	2026-05-15 23:15:48.931437	100.00	20.00
101	FAC-20260515-0066	1	\N	7.00	0.00	0.00	7.00	Transferencia	Completed	\N	\N	2026-05-15 23:15:58.150234	0.00	0.00
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (id, name, contactname, phone, email, address, createdat) FROM stdin;
1	Distribuidora Farma CDMX	Carlos López	5551110000	carlos@farmadist.mx	Av. Reforma 123, CDMX	2026-05-14 06:37:15.245217
2	Medicorp México	Ana García	5552221111	ana@medicorp.mx	Insurgentes Sur 456, CDMX	2026-05-14 06:37:15.245217
3	Salud Total MX	Pedro Sánchez	5553332222	pedro@saludtotal.mx	Av. Universidad 789, CDMX	2026-05-14 06:37:15.245217
4	Farmacéuticos del Bajío	María Torres	5554443333	maria@bajiofarm.mx	Blvd. Adolfo López Mateos 321, Guanajuato	2026-05-14 06:37:15.245217
5	Proveedora Médica MX	José Martínez	5555554444	jose@provmedica.mx	Av. Chapultepec 654, CDMX	2026-05-14 06:37:15.245217
\.


--
-- Data for Name: systemsettings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.systemsettings (id, key, value, description) FROM stdin;
1	company_name	Farmacia Mi Salud	Nombre de la empresa
3	currency	PEN	Moneda del sistema
4	receipt_footer	¡Gracias por su preferencia!	Texto del pie de recibo/boleta
5	low_stock_threshold	5	Cantidad mínima para alerta de stock bajo
2	tax_rate	16	Porcentaje de impuesto por defecto
\.


--
-- Data for Name: taxrates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.taxrates (id, name, rate, isactive, createdat) FROM stdin;
1	ISR	10.00	t	2026-05-14 06:37:15.255903
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, passwordhash, email, fullname, roleid, isactive, lastlogin, createdat, updatedat) FROM stdin;
1	admin	$2b$10$8Ob1aHw.9VHx0OfXK7nP5ebL0NMIBRPu/7dhlYFtnYf1X4UhqUdBS	admin@farmacia.com	Administrador Principal	1	t	2026-05-17 04:52:53.156224	2026-05-14 06:37:15.232399	\N
2	cajero	$2b$10$UILL0MQ0o1GzVfei2yNg3.VIC5NXDMb9LXiYsV6EOjcQAKWJuZzPG	cajero@farmacia.com	Cajero Principal	2	t	2026-05-15 09:05:20.201669	2026-05-14 06:37:15.237226	\N
\.


--
-- Name: alerts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alerts_id_seq', 1, false);


--
-- Name: appointments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointments_id_seq', 1, false);


--
-- Name: cashregisters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cashregisters_id_seq', 1, false);


--
-- Name: cashregistersessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cashregistersessions_id_seq', 2, true);


--
-- Name: cat_clave_prod_serv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cat_clave_prod_serv_id_seq', 23, true);


--
-- Name: cat_clave_unidad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cat_clave_unidad_id_seq', 11, true);


--
-- Name: cat_forma_pago_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cat_forma_pago_id_seq', 22, true);


--
-- Name: cat_metodo_pago_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cat_metodo_pago_id_seq', 2, true);


--
-- Name: cat_regimen_fiscal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cat_regimen_fiscal_id_seq', 18, true);


--
-- Name: cat_uso_cfdi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cat_uso_cfdi_id_seq', 21, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 9, true);


--
-- Name: companyinfo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companyinfo_id_seq', 1, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 1, true);


--
-- Name: expense_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.expense_categories_id_seq', 6, true);


--
-- Name: expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.expenses_id_seq', 1, true);


--
-- Name: factura_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.factura_items_id_seq', 15, true);


--
-- Name: factura_relaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.factura_relaciones_id_seq', 1, false);


--
-- Name: facturas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.facturas_id_seq', 8, true);


--
-- Name: inventorymovements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventorymovements_id_seq', 346, true);


--
-- Name: loginlogs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.loginlogs_id_seq', 1, false);


--
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patients_id_seq', 1, false);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_id_seq', 101, true);


--
-- Name: prescription_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prescription_items_id_seq', 1, false);


--
-- Name: prescriptionitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prescriptionitems_id_seq', 1, false);


--
-- Name: prescriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prescriptions_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 121, true);


--
-- Name: return_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.return_items_id_seq', 1, false);


--
-- Name: returnitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.returnitems_id_seq', 1, false);


--
-- Name: returns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.returns_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 4, true);


--
-- Name: saleitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.saleitems_id_seq', 317, true);


--
-- Name: sales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sales_id_seq', 101, true);


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 5, true);


--
-- Name: systemsettings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.systemsettings_id_seq', 5, true);


--
-- Name: taxrates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taxrates_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: alerts alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (id);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: cashregisters cashregisters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cashregisters
    ADD CONSTRAINT cashregisters_pkey PRIMARY KEY (id);


--
-- Name: cashregistersessions cashregistersessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cashregistersessions
    ADD CONSTRAINT cashregistersessions_pkey PRIMARY KEY (id);


--
-- Name: cat_clave_prod_serv cat_clave_prod_serv_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_clave_prod_serv
    ADD CONSTRAINT cat_clave_prod_serv_codigo_key UNIQUE (codigo);


--
-- Name: cat_clave_prod_serv cat_clave_prod_serv_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_clave_prod_serv
    ADD CONSTRAINT cat_clave_prod_serv_pkey PRIMARY KEY (id);


--
-- Name: cat_clave_unidad cat_clave_unidad_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_clave_unidad
    ADD CONSTRAINT cat_clave_unidad_codigo_key UNIQUE (codigo);


--
-- Name: cat_clave_unidad cat_clave_unidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_clave_unidad
    ADD CONSTRAINT cat_clave_unidad_pkey PRIMARY KEY (id);


--
-- Name: cat_forma_pago cat_forma_pago_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_forma_pago
    ADD CONSTRAINT cat_forma_pago_codigo_key UNIQUE (codigo);


--
-- Name: cat_forma_pago cat_forma_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_forma_pago
    ADD CONSTRAINT cat_forma_pago_pkey PRIMARY KEY (id);


--
-- Name: cat_metodo_pago cat_metodo_pago_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_metodo_pago
    ADD CONSTRAINT cat_metodo_pago_codigo_key UNIQUE (codigo);


--
-- Name: cat_metodo_pago cat_metodo_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_metodo_pago
    ADD CONSTRAINT cat_metodo_pago_pkey PRIMARY KEY (id);


--
-- Name: cat_regimen_fiscal cat_regimen_fiscal_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_regimen_fiscal
    ADD CONSTRAINT cat_regimen_fiscal_codigo_key UNIQUE (codigo);


--
-- Name: cat_regimen_fiscal cat_regimen_fiscal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_regimen_fiscal
    ADD CONSTRAINT cat_regimen_fiscal_pkey PRIMARY KEY (id);


--
-- Name: cat_uso_cfdi cat_uso_cfdi_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_uso_cfdi
    ADD CONSTRAINT cat_uso_cfdi_codigo_key UNIQUE (codigo);


--
-- Name: cat_uso_cfdi cat_uso_cfdi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_uso_cfdi
    ADD CONSTRAINT cat_uso_cfdi_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: companyinfo companyinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companyinfo
    ADD CONSTRAINT companyinfo_pkey PRIMARY KEY (id);


--
-- Name: customers customers_documentnumber_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_documentnumber_key UNIQUE (documentnumber);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: expense_categories expense_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expense_categories
    ADD CONSTRAINT expense_categories_pkey PRIMARY KEY (id);


--
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- Name: factura_items factura_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_items
    ADD CONSTRAINT factura_items_pkey PRIMARY KEY (id);


--
-- Name: factura_relaciones factura_relaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_relaciones
    ADD CONSTRAINT factura_relaciones_pkey PRIMARY KEY (id);


--
-- Name: facturas facturas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_pkey PRIMARY KEY (id);


--
-- Name: inventorymovements inventorymovements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventorymovements
    ADD CONSTRAINT inventorymovements_pkey PRIMARY KEY (id);


--
-- Name: loginlogs loginlogs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loginlogs
    ADD CONSTRAINT loginlogs_pkey PRIMARY KEY (id);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: prescription_items prescription_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription_items
    ADD CONSTRAINT prescription_items_pkey PRIMARY KEY (id);


--
-- Name: prescriptionitems prescriptionitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptionitems
    ADD CONSTRAINT prescriptionitems_pkey PRIMARY KEY (id);


--
-- Name: prescriptions prescriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_pkey PRIMARY KEY (id);


--
-- Name: products products_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_code_key UNIQUE (code);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: return_items return_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_items
    ADD CONSTRAINT return_items_pkey PRIMARY KEY (id);


--
-- Name: returnitems returnitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returnitems
    ADD CONSTRAINT returnitems_pkey PRIMARY KEY (id);


--
-- Name: returns returns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returns
    ADD CONSTRAINT returns_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: saleitems saleitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saleitems
    ADD CONSTRAINT saleitems_pkey PRIMARY KEY (id);


--
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- Name: sales sales_receiptnumber_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_receiptnumber_key UNIQUE (receiptnumber);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: systemsettings systemsettings_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.systemsettings
    ADD CONSTRAINT systemsettings_key_key UNIQUE (key);


--
-- Name: systemsettings systemsettings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.systemsettings
    ADD CONSTRAINT systemsettings_pkey PRIMARY KEY (id);


--
-- Name: taxrates taxrates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxrates
    ADD CONSTRAINT taxrates_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_factura_items_facturaid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_factura_items_facturaid ON public.factura_items USING btree (facturaid);


--
-- Name: idx_factura_relaciones_facturaid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_factura_relaciones_facturaid ON public.factura_relaciones USING btree (facturaid);


--
-- Name: idx_facturas_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_facturas_estado ON public.facturas USING btree (estado);


--
-- Name: idx_facturas_fecha_emision; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_facturas_fecha_emision ON public.facturas USING btree (fechaemision);


--
-- Name: idx_facturas_rfc_receptor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_facturas_rfc_receptor ON public.facturas USING btree (receptorrfc);


--
-- Name: idx_facturas_saleid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_facturas_saleid ON public.facturas USING btree (saleid);


--
-- Name: idx_facturas_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_facturas_uuid ON public.facturas USING btree (uuid);


--
-- Name: alerts alerts_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- Name: appointments appointments_patientid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_patientid_fkey FOREIGN KEY (patientid) REFERENCES public.patients(id);


--
-- Name: appointments appointments_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- Name: cashregistersessions cashregistersessions_cashregisterid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cashregistersessions
    ADD CONSTRAINT cashregistersessions_cashregisterid_fkey FOREIGN KEY (cashregisterid) REFERENCES public.cashregisters(id);


--
-- Name: cashregistersessions cashregistersessions_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cashregistersessions
    ADD CONSTRAINT cashregistersessions_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- Name: companyinfo companyinfo_regimenfiscalid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companyinfo
    ADD CONSTRAINT companyinfo_regimenfiscalid_fkey FOREIGN KEY (regimenfiscalid) REFERENCES public.cat_regimen_fiscal(id);


--
-- Name: customers customers_regimenfiscalid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_regimenfiscalid_fkey FOREIGN KEY (regimenfiscalid) REFERENCES public.cat_regimen_fiscal(id);


--
-- Name: customers customers_usocfdiid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_usocfdiid_fkey FOREIGN KEY (usocfdiid) REFERENCES public.cat_uso_cfdi(id);


--
-- Name: expenses expenses_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- Name: factura_items factura_items_facturaid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_items
    ADD CONSTRAINT factura_items_facturaid_fkey FOREIGN KEY (facturaid) REFERENCES public.facturas(id) ON DELETE CASCADE;


--
-- Name: factura_items factura_items_productoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_items
    ADD CONSTRAINT factura_items_productoid_fkey FOREIGN KEY (productoid) REFERENCES public.products(id);


--
-- Name: factura_items factura_items_saleitemid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_items
    ADD CONSTRAINT factura_items_saleitemid_fkey FOREIGN KEY (saleitemid) REFERENCES public.saleitems(id);


--
-- Name: factura_relaciones factura_relaciones_facturaid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_relaciones
    ADD CONSTRAINT factura_relaciones_facturaid_fkey FOREIGN KEY (facturaid) REFERENCES public.facturas(id) ON DELETE CASCADE;


--
-- Name: facturas facturas_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


--
-- Name: facturas facturas_saleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_saleid_fkey FOREIGN KEY (saleid) REFERENCES public.sales(id);


--
-- Name: inventorymovements inventorymovements_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventorymovements
    ADD CONSTRAINT inventorymovements_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(id);


--
-- Name: inventorymovements inventorymovements_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventorymovements
    ADD CONSTRAINT inventorymovements_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- Name: loginlogs loginlogs_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loginlogs
    ADD CONSTRAINT loginlogs_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- Name: patients patients_customerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_customerid_fkey FOREIGN KEY (customerid) REFERENCES public.customers(id);


--
-- Name: payments payments_saleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_saleid_fkey FOREIGN KEY (saleid) REFERENCES public.sales(id) ON DELETE CASCADE;


--
-- Name: prescription_items prescription_items_prescriptionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription_items
    ADD CONSTRAINT prescription_items_prescriptionid_fkey FOREIGN KEY (prescriptionid) REFERENCES public.prescriptions(id) ON DELETE CASCADE;


--
-- Name: prescription_items prescription_items_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription_items
    ADD CONSTRAINT prescription_items_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(id);


--
-- Name: prescriptionitems prescriptionitems_prescriptionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptionitems
    ADD CONSTRAINT prescriptionitems_prescriptionid_fkey FOREIGN KEY (prescriptionid) REFERENCES public.prescriptions(id) ON DELETE CASCADE;


--
-- Name: prescriptionitems prescriptionitems_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptionitems
    ADD CONSTRAINT prescriptionitems_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(id);


--
-- Name: prescriptions prescriptions_patientid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_patientid_fkey FOREIGN KEY (patientid) REFERENCES public.patients(id);


--
-- Name: products products_categoryid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_categoryid_fkey FOREIGN KEY (categoryid) REFERENCES public.categories(id);


--
-- Name: products products_supplierid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_supplierid_fkey FOREIGN KEY (supplierid) REFERENCES public.suppliers(id);


--
-- Name: return_items return_items_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_items
    ADD CONSTRAINT return_items_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(id);


--
-- Name: return_items return_items_returnid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_items
    ADD CONSTRAINT return_items_returnid_fkey FOREIGN KEY (returnid) REFERENCES public.returns(id) ON DELETE CASCADE;


--
-- Name: returnitems returnitems_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returnitems
    ADD CONSTRAINT returnitems_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(id);


--
-- Name: returnitems returnitems_returnid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returnitems
    ADD CONSTRAINT returnitems_returnid_fkey FOREIGN KEY (returnid) REFERENCES public.returns(id) ON DELETE CASCADE;


--
-- Name: returns returns_saleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returns
    ADD CONSTRAINT returns_saleid_fkey FOREIGN KEY (saleid) REFERENCES public.sales(id);


--
-- Name: returns returns_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returns
    ADD CONSTRAINT returns_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- Name: saleitems saleitems_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saleitems
    ADD CONSTRAINT saleitems_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(id);


--
-- Name: saleitems saleitems_saleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saleitems
    ADD CONSTRAINT saleitems_saleid_fkey FOREIGN KEY (saleid) REFERENCES public.sales(id) ON DELETE CASCADE;


--
-- Name: sales sales_cashregistersessionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_cashregistersessionid_fkey FOREIGN KEY (cashregistersessionid) REFERENCES public.cashregistersessions(id);


--
-- Name: sales sales_customerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_customerid_fkey FOREIGN KEY (customerid) REFERENCES public.customers(id);


--
-- Name: sales sales_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- Name: users users_roleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_roleid_fkey FOREIGN KEY (roleid) REFERENCES public.roles(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 2td9imDRcuE9w8HGCs985yFcqTIjoU52tlubCS6rFHHwObqqxdjAdydoj0YpdjR

