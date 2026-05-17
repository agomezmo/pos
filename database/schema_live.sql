--
-- PostgreSQL database dump
--

\restrict lolSmIOK386IadOCGmeDkaPr2eWjAgNfgsaqd7BcwAQO1maaj2fiLmGKT2i8iUf

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

\unrestrict lolSmIOK386IadOCGmeDkaPr2eWjAgNfgsaqd7BcwAQO1maaj2fiLmGKT2i8iUf

