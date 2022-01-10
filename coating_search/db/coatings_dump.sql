--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-1.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-1.pgdg20.04+1)

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

--
-- Name: env; Type: TYPE; Schema: public; Owner: gb_user
--

CREATE TYPE public.env AS (
	air boolean,
	immersion boolean,
	immersion_water boolean,
	immersion_soil boolean,
	immersion_chem boolean
);


ALTER TYPE public.env OWNER TO gb_user;

--
-- Name: main_functions; Type: TYPE; Schema: public; Owner: gb_user
--

CREATE TYPE public.main_functions AS (
	primer boolean,
	intermediate boolean,
	finish boolean,
	internal boolean
);


ALTER TYPE public.main_functions OWNER TO gb_user;

--
-- Name: substrate; Type: TYPE; Schema: public; Owner: gb_user
--

CREATE TYPE public.substrate AS (
	steel boolean,
	concrete boolean,
	hdg boolean,
	nf_metal boolean
);


ALTER TYPE public.substrate OWNER TO gb_user;

--
-- Name: check_coat_types(); Type: FUNCTION; Schema: public; Owner: gb_user
--

CREATE FUNCTION public.check_coat_types() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE same BOOLEAN;
BEGIN
IF ((SELECT catalogs.id FROM products
JOIN catalogs ON products.catalog_id = catalogs.id
WHERE products.id = NEW.primer_id) = (SELECT catalogs.id FROM products
JOIN catalogs ON products.catalog_id = catalogs.id
WHERE products.id = NEW.intermediate_id) AND (SELECT catalogs.id FROM products
JOIN catalogs ON products.catalog_id = catalogs.id
WHERE products.id = NEW.primer_id) = (SELECT catalogs.id FROM products
JOIN catalogs ON products.catalog_id = catalogs.id
WHERE products.id = NEW.finish_id))
THEN
  RETURN NEW;
  END IF; 
  RAISE NOTICE 'coating catalogs are not the same';
END
$$;


ALTER FUNCTION public.check_coat_types() OWNER TO gb_user;

--
-- Name: most_used_finish_in(character varying); Type: FUNCTION; Schema: public; Owner: gb_user
--

CREATE FUNCTION public.most_used_finish_in(catalog_name character varying) RETURNS character varying
    LANGUAGE sql
    AS $$
  WITH most_used AS(
	SELECT DISTINCT 
	  	products.name AS product_name,
		COUNT (coating_systems.finish_id) OVER (PARTITION BY products.name) AS count_product 
	FROM used_systems
	JOIN coating_systems ON coating_systems.id = used_systems.used_system_id
	JOIN products ON products.id = coating_systems.finish_id
	JOIN catalogs ON catalogs.id = products.catalog_id
	WHERE catalogs.name = catalog_name
	ORDER BY count_product DESC
)
SELECT  product_name
FROM most_used
LIMIT 1; 
$$;


ALTER FUNCTION public.most_used_finish_in(catalog_name character varying) OWNER TO gb_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: additives; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.additives (
    id smallint NOT NULL,
    name character varying
);


ALTER TABLE public.additives OWNER TO gb_user;

--
-- Name: additives_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.additives_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.additives_id_seq OWNER TO gb_user;

--
-- Name: additives_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.additives_id_seq OWNED BY public.additives.id;


--
-- Name: approved_tests; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.approved_tests (
    id integer NOT NULL,
    lab_id integer NOT NULL,
    system_id integer NOT NULL,
    standard_id integer NOT NULL,
    comments text,
    url character varying(250) NOT NULL,
    issued_at date NOT NULL,
    expires_at date,
    CONSTRAINT approved_tests_check CHECK ((expires_at >= issued_at))
);


ALTER TABLE public.approved_tests OWNER TO gb_user;

--
-- Name: approved_tests_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.approved_tests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.approved_tests_id_seq OWNER TO gb_user;

--
-- Name: approved_tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.approved_tests_id_seq OWNED BY public.approved_tests.id;


--
-- Name: binders; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.binders (
    id smallint NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.binders OWNER TO gb_user;

--
-- Name: binders_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.binders_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.binders_id_seq OWNER TO gb_user;

--
-- Name: binders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.binders_id_seq OWNED BY public.binders.id;


--
-- Name: brands; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.brands (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.brands OWNER TO gb_user;

--
-- Name: brands_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.brands_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.brands_id_seq OWNER TO gb_user;

--
-- Name: brands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.brands_id_seq OWNED BY public.brands.id;


--
-- Name: catalogs; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.catalogs (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.catalogs OWNER TO gb_user;

--
-- Name: catalogs_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.catalogs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogs_id_seq OWNER TO gb_user;

--
-- Name: catalogs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.catalogs_id_seq OWNED BY public.catalogs.id;


--
-- Name: coating_systems; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.coating_systems (
    id integer NOT NULL,
    primer_id integer NOT NULL,
    primer_dft smallint NOT NULL,
    intermediate_id integer NOT NULL,
    intermediate_dft smallint NOT NULL,
    finish_id integer NOT NULL,
    finish_dft smallint NOT NULL
);


ALTER TABLE public.coating_systems OWNER TO gb_user;

--
-- Name: coating_systems_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.coating_systems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coating_systems_id_seq OWNER TO gb_user;

--
-- Name: coating_systems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.coating_systems_id_seq OWNED BY public.coating_systems.id;


--
-- Name: contractors; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.contractors (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.contractors OWNER TO gb_user;

--
-- Name: contractors_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.contractors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contractors_id_seq OWNER TO gb_user;

--
-- Name: contractors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.contractors_id_seq OWNED BY public.contractors.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.customers OWNER TO gb_user;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO gb_user;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: environments; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.environments (
    id smallint NOT NULL,
    name character varying(25) NOT NULL
);


ALTER TABLE public.environments OWNER TO gb_user;

--
-- Name: environments_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.environments_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.environments_id_seq OWNER TO gb_user;

--
-- Name: environments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.environments_id_seq OWNED BY public.environments.id;


--
-- Name: labs; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.labs (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.labs OWNER TO gb_user;

--
-- Name: labs_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.labs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.labs_id_seq OWNER TO gb_user;

--
-- Name: labs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.labs_id_seq OWNED BY public.labs.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    customer_id integer NOT NULL,
    contractor_id integer NOT NULL,
    comments text,
    started_at date,
    finished_at date,
    CONSTRAINT projects_check CHECK ((finished_at >= started_at))
);


ALTER TABLE public.projects OWNER TO gb_user;

--
-- Name: reports; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.reports (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    project_id integer NOT NULL,
    url character varying(250) NOT NULL,
    tsr_id smallint NOT NULL,
    started_at date,
    finished_at date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    CONSTRAINT reports_check CHECK ((finished_at >= started_at)),
    CONSTRAINT reports_check1 CHECK ((updated_at >= created_at))
);


ALTER TABLE public.reports OWNER TO gb_user;

--
-- Name: tsr; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.tsr (
    id smallint NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(120) NOT NULL
);


ALTER TABLE public.tsr OWNER TO gb_user;

--
-- Name: last_reports_projects; Type: VIEW; Schema: public; Owner: gb_user
--

CREATE VIEW public.last_reports_projects AS
 WITH last_reports AS (
         SELECT projects.id AS project_id,
            projects.name AS project_name,
            reports.id AS report_id,
            reports.updated_at,
            (((tsr.first_name)::text || ' '::text) || (tsr.last_name)::text) AS tsr_name,
            max(reports.updated_at) OVER (PARTITION BY projects.id) AS last_date
           FROM ((public.projects
             LEFT JOIN public.reports ON ((reports.project_id = projects.id)))
             LEFT JOIN public.tsr ON ((tsr.id = reports.tsr_id)))
          ORDER BY projects.id
        )
 SELECT last_reports.project_id,
    last_reports.project_name,
    last_reports.report_id,
    last_reports.last_date,
    last_reports.tsr_name
   FROM last_reports
  WHERE ((last_reports.last_date = last_reports.updated_at) OR (last_reports.last_date IS NULL));


ALTER TABLE public.last_reports_projects OWNER TO gb_user;

--
-- Name: main_technical_data; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.main_technical_data (
    product_id integer NOT NULL,
    volume_solid smallint NOT NULL,
    standard_dft smallint,
    dry_to_touch real,
    treatment_tolerance boolean DEFAULT false,
    min_temp smallint,
    max_service_temp smallint,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone,
    dry_to_handle real,
    min_interval real,
    max_interval real DEFAULT 0,
    CONSTRAINT main_technical_data_check CHECK ((updated_at >= created_at)),
    CONSTRAINT main_technical_data_volume_solid_check CHECK ((volume_solid <= 100))
);


ALTER TABLE public.main_technical_data OWNER TO gb_user;

--
-- Name: pds; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.pds (
    product_id integer NOT NULL,
    url character varying(250) NOT NULL
);


ALTER TABLE public.pds OWNER TO gb_user;

--
-- Name: prod_func_in_systems; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.prod_func_in_systems (
    product_id integer NOT NULL,
    function_id smallint NOT NULL
);


ALTER TABLE public.prod_func_in_systems OWNER TO gb_user;

--
-- Name: product_additives; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.product_additives (
    product_id integer,
    additive_id smallint
);


ALTER TABLE public.product_additives OWNER TO gb_user;

--
-- Name: product_binders; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.product_binders (
    product_id integer,
    binder_id smallint
);


ALTER TABLE public.product_binders OWNER TO gb_user;

--
-- Name: product_environments; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.product_environments (
    product_id integer,
    environment_id smallint
);


ALTER TABLE public.product_environments OWNER TO gb_user;

--
-- Name: product_functions; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.product_functions (
    id smallint NOT NULL,
    name character varying(50)
);


ALTER TABLE public.product_functions OWNER TO gb_user;

--
-- Name: product_functions_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.product_functions_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_functions_id_seq OWNER TO gb_user;

--
-- Name: product_functions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.product_functions_id_seq OWNED BY public.product_functions.id;


--
-- Name: product_resistances; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.product_resistances (
    product_id integer,
    resistance_id smallint
);


ALTER TABLE public.product_resistances OWNER TO gb_user;

--
-- Name: product_substrates; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.product_substrates (
    product_id integer,
    substrate_id smallint
);


ALTER TABLE public.product_substrates OWNER TO gb_user;

--
-- Name: products; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    brand_name_id smallint NOT NULL,
    catalog_id smallint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    description text
);


ALTER TABLE public.products OWNER TO gb_user;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO gb_user;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO gb_user;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reports_id_seq OWNER TO gb_user;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- Name: resistances; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.resistances (
    id smallint NOT NULL,
    name character varying
);


ALTER TABLE public.resistances OWNER TO gb_user;

--
-- Name: resistances_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.resistances_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resistances_id_seq OWNER TO gb_user;

--
-- Name: resistances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.resistances_id_seq OWNED BY public.resistances.id;


--
-- Name: standards; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.standards (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.standards OWNER TO gb_user;

--
-- Name: standards_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.standards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.standards_id_seq OWNER TO gb_user;

--
-- Name: standards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.standards_id_seq OWNED BY public.standards.id;


--
-- Name: substrates; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.substrates (
    id smallint NOT NULL,
    name character varying(25)
);


ALTER TABLE public.substrates OWNER TO gb_user;

--
-- Name: substrates_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.substrates_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.substrates_id_seq OWNER TO gb_user;

--
-- Name: substrates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.substrates_id_seq OWNED BY public.substrates.id;


--
-- Name: used_systems; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.used_systems (
    project_id integer NOT NULL,
    used_system_id integer NOT NULL
);


ALTER TABLE public.used_systems OWNER TO gb_user;

--
-- Name: tests_to_update; Type: VIEW; Schema: public; Owner: gb_user
--

CREATE VIEW public.tests_to_update AS
 SELECT projects.id AS project_id,
    used_systems.used_system_id AS system_id,
    approved_tests.expires_at
   FROM ((public.projects
     JOIN public.used_systems ON ((used_systems.project_id = projects.id)))
     JOIN public.approved_tests ON ((approved_tests.system_id = used_systems.used_system_id)))
  WHERE ((date_part('year'::text, projects.finished_at) >= date_part('year'::text, CURRENT_DATE)) AND ((date_part('year'::text, approved_tests.expires_at) >= date_part('year'::text, CURRENT_DATE)) AND (approved_tests.expires_at >= CURRENT_DATE)));


ALTER TABLE public.tests_to_update OWNER TO gb_user;

--
-- Name: tsr_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.tsr_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tsr_id_seq OWNER TO gb_user;

--
-- Name: tsr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.tsr_id_seq OWNED BY public.tsr.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    nickname character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone,
    pass_hash character varying(128) NOT NULL,
    hash character varying(128) DEFAULT NULL::character varying,
    email character varying(128) DEFAULT NULL::character varying,
    CONSTRAINT users_check CHECK ((updated_at >= created_at))
);


ALTER TABLE public.users OWNER TO gb_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO gb_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: additives id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.additives ALTER COLUMN id SET DEFAULT nextval('public.additives_id_seq'::regclass);


--
-- Name: approved_tests id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.approved_tests ALTER COLUMN id SET DEFAULT nextval('public.approved_tests_id_seq'::regclass);


--
-- Name: binders id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.binders ALTER COLUMN id SET DEFAULT nextval('public.binders_id_seq'::regclass);


--
-- Name: brands id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.brands ALTER COLUMN id SET DEFAULT nextval('public.brands_id_seq'::regclass);


--
-- Name: catalogs id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.catalogs ALTER COLUMN id SET DEFAULT nextval('public.catalogs_id_seq'::regclass);


--
-- Name: coating_systems id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.coating_systems ALTER COLUMN id SET DEFAULT nextval('public.coating_systems_id_seq'::regclass);


--
-- Name: contractors id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.contractors ALTER COLUMN id SET DEFAULT nextval('public.contractors_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: environments id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.environments ALTER COLUMN id SET DEFAULT nextval('public.environments_id_seq'::regclass);


--
-- Name: labs id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.labs ALTER COLUMN id SET DEFAULT nextval('public.labs_id_seq'::regclass);


--
-- Name: product_functions id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_functions ALTER COLUMN id SET DEFAULT nextval('public.product_functions_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- Name: resistances id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.resistances ALTER COLUMN id SET DEFAULT nextval('public.resistances_id_seq'::regclass);


--
-- Name: standards id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.standards ALTER COLUMN id SET DEFAULT nextval('public.standards_id_seq'::regclass);


--
-- Name: substrates id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.substrates ALTER COLUMN id SET DEFAULT nextval('public.substrates_id_seq'::regclass);


--
-- Name: tsr id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.tsr ALTER COLUMN id SET DEFAULT nextval('public.tsr_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: additives; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.additives (id, name) FROM stdin;
1	GF (стеклянные чешуйки)
2	MIO (слюдистый оксид железа)
3	алюминий
4	кварцевый порошок
5	фосфат цинка
6	цинк
\.


--
-- Data for Name: approved_tests; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.approved_tests (id, lab_id, system_id, standard_id, comments, url, issued_at, expires_at) FROM stdin;
\.


--
-- Data for Name: binders; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.binders (id, name) FROM stdin;
1	эпоксид
2	чистый эпоксид
3	эпоксид с феналкаминовым отверждением
4	эпоксид с амидным отверждением
5	фенол эпоксид
6	полиуретан
7	акрил
8	акрил-полиуретан
9	этилсиликат
10	силоксан
11	неорганическое керамической
12	алкид
13	каменноугольный эпоксид
14	силикон
15	противообрастающее
16	новолак
17	добавка
18	винилэфир
19	хлоркаучук
20	водная основа
21	винил
22	битум
23	фторуглеродное
24	полиэфир
25	фенольная смола
\.


--
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.brands (id, name) FROM stdin;
1	PPG
2	Hempel
3	Jotun
4	International
\.


--
-- Data for Name: catalogs; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.catalogs (id, name) FROM stdin;
3	industrial
4	architect
5	coil
1	защитные покрытия (protective)
2	морские покрытия (marine)
\.


--
-- Data for Name: coating_systems; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.coating_systems (id, primer_id, primer_dft, intermediate_id, intermediate_dft, finish_id, finish_dft) FROM stdin;
\.


--
-- Data for Name: contractors; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.contractors (id, name) FROM stdin;
1	Bergstrom-Blick
2	Raynor-Trantow
3	Hackett LLC
4	Bauch, Pfeffer and Beer
5	Littel and Sons
6	Lakin-Pfannerstill
7	Mann PLC
8	Hammes-Schowalter
9	Beahan, Lehner and Balistreri
10	Weissnat LLC
11	Schultz, Jakubowski and Lang
12	Rodriguez LLC
13	Weimann PLC
14	Osinski and Sons
15	Kirlin, Pfeffer and Sauer
16	Kirlin, Greenfelder and Powlowski
17	Gorczany-Casper
18	Connelly-Mertz
19	Bradtke, Baumbach and Wisoky
20	Bailey-Corkery
21	Medhurst-Hirthe
22	Swaniawski, Weimann and Corkery
23	Koss-Wintheiser
24	Schmeler, Stroman and Padberg
25	Osinski, Hackett and Stark
26	Hammes Ltd
27	Kreiger Group
28	Schiller and Sons
29	Langworth and Sons
30	McGlynn and Sons
31	Kris-Bins
32	Champlin-Leuschke
33	Legros, Roob and Ledner
34	Smith, Hettinger and Schaden
35	OReilly, Upton and Durgan
36	Johnson Ltd
37	Greenholt Inc
38	Steuber-Pfeffer
39	Ullrich Inc
40	Turcotte, Shanahan and Hara
41	Kozey Group
42	Pollich, Green and Watsica
43	Paucek, Bogisich and Morissette
44	Mohr, Yundt and Sauer
45	Adams Inc
46	Legros LLC
47	Zieme, Bayer and Champlin
48	Considine and Sons
49	Senger LLC
50	McCullough-Schumm
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.customers (id, name) FROM stdin;
1	Kertzmann, Stiedemann and Vandervort
2	Brown, Vandervort and Larkin
3	Towne, Torp and Pagac
4	Schumm Inc
5	Sipes Group
6	Kessler-Bradtke
7	Dach-Breitenberg
8	Howe, Koelpin and Dibbert
9	Marquardt Ltd
10	Cassin, Muller and Aufderhar
11	Renner-Nikolaus
12	Koelpin PLC
13	Gibson-Stokes
14	Jakubowski-Mann
15	Swaniawski, Boyle and Von
16	Reichel Group
17	Kiehn-Rath
18	Friesen-Quitzon
19	Batz-Gerlach
20	West, Leuschke and Little
21	Waters Group
22	Metz LLC
23	Friesen, Dietrich and Haag
24	Haley, Von and Jacobs
25	Beahan Ltd
26	Goodwin-Barton
27	Hodkiewicz-Pagac
28	Parisian Group
29	Feeney, Nitzsche and Bosco
30	Bauch, Homenick and Quigley
31	Mraz-Thiel
32	Cremin, Keebler and Wuckert
33	Ferry-Price
34	Nitzsche-Jerde
35	Eichmann, Gislason and Cronin
36	Russel, Kohler and Okuneva
37	Lubowitz Group
38	Satterfield-Vandervort
39	Cole and Sons
40	Gleason-Lakin
41	Waters-Blanda
42	Heidenreich, Walker and Ruecker
43	Bosco, Kassulke and Runolfsdottir
44	Ferry Inc
45	Wuckert, Hessel and Veum
46	Keeling-Hammes
47	Kirlin Ltd
48	DuBuque-Collins
49	Leuschke-Satterfield
50	Bradtke, Bins and Bartoletti
51	Hauck, Roob and Beahan
52	Mueller, Lubowitz and Cummerata
53	Rath, Hahn and Rath
54	Krajcik, Grimes and Fay
55	Sawayn, Baumbach and Schultz
56	Okuneva LLC
57	Braun-Hansen
58	Lockman, Klocko and Daniel
59	Bailey, Kemmer and Ruecker
60	Larkin-Auer
61	Torp LLC
62	Davis, Blanda and Quigley
63	Sanford, Hudson and Dooley
64	Mertz, Reichert and Dicki
65	Beier Ltd
66	Padberg, Cole and Kuhic
67	McDermott-Moen
68	Ferry-Parker
69	Koch, Hilpert and Lang
70	Armstrong and Sons
71	Effertz-Klein
72	Beier, Volkman and Considine
73	Fisher, Kulas and Hara
74	Herman-Weber
75	Hintz LLC
76	Hilpert-Doyle
77	Jaskolski-Bogan
78	Jast, Morissette and Corwin
79	Spencer, Wunsch and Kassulke
80	Schowalter, Conner and Cormier
81	Hand, Labadie and Corwin
82	Torphy-Kuhn
83	Johnston and Sons
84	Schinner LLC
85	Shields-Hilll
86	Gutmann and Sons
87	Towne, Bosco and Kuhlman
88	Balistreri Inc
89	Pouros-Ruecker
90	Rice, Wisozk and Reichel
91	Goldner, Mohr and Prohaska
92	Beer, Feeney and Moore
93	Johns-Towne
94	Kub-Mitchell
95	Hermann PLC
96	Hickle PLC
97	Carroll, Kemmer and Williamson
98	Medhurst-Smith
99	Runte-Goldner
100	Greenfelder Ltd
\.


--
-- Data for Name: environments; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.environments (id, name) FROM stdin;
1	атмосфера
2	погружение в воду
3	погружение в почву
\.


--
-- Data for Name: labs; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.labs (id, name) FROM stdin;
1	Hartmann-Lesch
2	Tromp-Jacobi
3	Abernathy Ltd
4	Sanford-Botsford
5	Zieme, Deckow and Baumbach
6	Satterfield, Krajcik and Boyle
7	Kreiger, Pouros and Schulist
8	Legros Ltd
9	Gutmann LLC
10	Wiza Ltd
11	Reichel, Walker and Lynch
12	Mills Inc
13	Witting-Maggio
14	Kilback Ltd
15	Stoltenberg, Kerluke and McKenzie
\.


--
-- Data for Name: main_technical_data; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.main_technical_data (product_id, volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval) FROM stdin;
1	55	100	3	f	5	120	2022-01-05 10:30:20.491775	2022-01-05 10:30:20.491775	4	4	0
2	80	100	4	t	-7	120	2022-01-05 11:03:37.122336	2022-01-05 11:03:37.122336	8	3	30
3	87	300	5	t	-18	120	2022-01-05 11:23:11.817216	2022-01-05 11:23:11.817216	10	5	90
13	94	99	1	f	-10	47	1985-09-16 00:00:00	2021-12-23 13:46:39.588938	\N	\N	0
4	68	200	2	t	3	121	2022-01-05 11:48:38.524008	2022-01-05 11:48:38.524008	16	12	30
5	100	1000	2	f	5	60	2022-01-05 11:57:15.435252	2022-01-05 11:57:15.435252	5	4	16
19	59	146	1	f	-2	49	2007-01-07 00:00:00	2021-12-23 13:46:39.588938	\N	\N	0
25	94	217	2	f	6	57	2000-02-05 00:00:00	2021-12-23 13:46:39.588938	\N	\N	0
6	60	75	3	f	0	120	2022-01-05 12:16:46.326953	2022-01-05 12:16:46.326953	8	8	0
7	58	50	1	f	0	120	2022-01-05 12:25:21.158637	2022-01-05 12:25:21.158637	4	4	0
28	42	213	1	f	2	43	2007-08-16 00:00:00	2021-12-23 13:46:39.588938	\N	\N	0
32	68	153	0	f	-6	52	2002-12-17 00:00:00	2021-12-23 13:46:39.588938	\N	\N	0
34	58	64	0	f	7	43	2013-04-08 00:00:00	2021-12-23 13:46:39.588938	\N	\N	0
8	51	50	2	t	5	120	2022-01-05 12:32:34.823949	2022-01-05 12:32:34.823949	4	4	0
37	58	86	1	f	-6	49	2013-03-02 00:00:00	2021-12-23 13:46:39.588938	\N	\N	0
10	73	150	0.75	f	-5	120	2022-01-05 13:07:04.43242	2022-01-05 13:07:04.43242	3	8	4
45	78	100	0	f	-7	52	2007-10-06 00:00:00	2021-12-23 13:46:39.588938	\N	\N	0
54	63	84	0	f	1	50	2006-06-27 00:00:00	2021-12-23 13:46:39.588938	\N	\N	0
83	58	189	2	f	-5	40	2009-12-29 00:00:00	2021-12-23 13:46:39.588938	\N	\N	0
87	46	223	0	f	-5	53	2004-02-10 00:00:00	2021-12-23 13:46:39.588938	\N	\N	0
94	77	74	2	f	-1	50	2018-10-26 00:00:00	2021-12-23 13:46:39.588938	\N	\N	0
9	85	125	6	t	10	120	2022-01-05 12:57:24.436618	2022-01-05 12:57:24.436618	24	16	90
20	52	199	2	f	10	57	2015-03-21 00:00:00	2021-12-23 13:44:06.135328	\N	\N	0
29	83	62	0	f	8	49	1975-10-27 00:00:00	2021-12-23 13:44:06.135328	\N	\N	0
38	69	137	3	f	0	53	1983-07-20 00:00:00	2021-12-23 13:44:06.135328	\N	\N	0
39	99	161	1	f	-1	55	1977-03-08 00:00:00	2021-12-23 13:44:06.135328	\N	\N	0
49	53	207	3	f	5	43	2003-09-10 00:00:00	2021-12-23 13:44:06.135328	\N	\N	0
55	52	73	1	f	9	49	2014-01-03 00:00:00	2021-12-23 13:44:06.135328	\N	\N	0
58	37	200	3	f	7	53	1977-02-28 00:00:00	2021-12-23 13:44:06.135328	\N	\N	0
65	77	140	0	f	0	40	1981-12-13 00:00:00	2021-12-23 13:44:06.135328	\N	\N	0
71	52	162	3	f	0	53	1983-07-09 00:00:00	2021-12-23 13:44:06.135328	\N	\N	0
78	47	199	3	f	-1	41	1976-11-29 00:00:00	2021-12-23 13:44:06.135328	\N	\N	0
89	40	96	0	f	5	59	1976-09-12 00:00:00	2021-12-23 13:44:06.135328	\N	\N	0
99	81	143	2	f	-8	53	1970-10-13 00:00:00	2021-12-23 13:44:06.135328	\N	\N	0
\.


--
-- Data for Name: pds; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.pds (product_id, url) FROM stdin;
3	https://docs.td.ppgpmc.com/download/646/2541/amercoat-240--sigmacover-240
4	https://docs.td.ppgpmc.com/download/896/64213/amercoat-385
5	https://docs.td.ppgpmc.com/download/21735/53409/amercoat-391-pc
6	https://docs.td.ppgpmc.com/download/762/65526/amercoat-450-e
7	https://docs.td.ppgpmc.com/download/827/53453/amercoat-450-s
8	https://docs.td.ppgpmc.com/download/21760/64155/amercoat-71-tc
9	https://docs.td.ppgpmc.com/download/21763/64688/amerlock-400-al
10	https://docs.td.ppgpmc.com/download/802/2381/amershield
\.


--
-- Data for Name: prod_func_in_systems; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.prod_func_in_systems (product_id, function_id) FROM stdin;
1	1
1	2
2	1
2	2
3	1
3	2
4	1
4	2
5	1
5	2
6	3
7	3
8	1
8	2
9	1
9	3
10	1
10	3
\.


--
-- Data for Name: product_additives; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.product_additives (product_id, additive_id) FROM stdin;
1	2
1	5
2	2
2	5
3	2
3	5
4	2
4	5
9	3
\.


--
-- Data for Name: product_binders; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.product_binders (product_id, binder_id) FROM stdin;
1	4
2	3
3	3
4	4
5	1
6	8
7	8
8	4
9	1
10	8
\.


--
-- Data for Name: product_environments; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.product_environments (product_id, environment_id) FROM stdin;
1	1
2	1
2	2
4	1
4	2
5	2
5	3
6	1
7	1
8	1
8	2
9	1
9	2
10	1
\.


--
-- Data for Name: product_functions; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.product_functions (id, name) FROM stdin;
1	грунт
2	промежуток
3	финиш
4	внутреннее покрвытие
\.


--
-- Data for Name: product_resistances; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.product_resistances (product_id, resistance_id) FROM stdin;
2	1
2	3
2	16
2	13
3	8
3	10
3	12
3	16
3	1
3	2
3	17
4	4
5	6
5	8
5	10
5	12
5	16
5	13
5	9
5	1
5	4
6	1
7	1
8	3
9	3
9	4
10	1
10	4
\.


--
-- Data for Name: product_substrates; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.product_substrates (product_id, substrate_id) FROM stdin;
1	1
2	1
3	1
3	4
2	4
4	1
4	4
4	2
4	3
5	1
5	2
6	1
7	1
8	1
8	3
8	5
9	1
10	1
10	2
10	5
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.products (id, name, brand_name_id, catalog_id, created_at, description) FROM stdin;
2	AMERCOAT 236	1	1	2022-01-05 11:02:07.300159	\N
3	AMERCOAT 240	1	1	2022-01-05 11:21:08.179721	\N
4	AMERCOAT 385	1	1	2022-01-05 11:43:55.834196	\N
5	AMERCOAT 391 PC	1	1	2022-01-05 11:54:25.299341	\N
13	dignissimos	1	3	1972-09-05 17:07:23	\N
6	AMERCOAT 450 E	1	1	2022-01-05 12:14:12.927906	\N
7	AMERCOAT 450 S	1	1	2022-01-05 12:23:24.374996	\N
8	AMERCOAT 71 TC	1	1	2022-01-05 12:31:03.454618	\N
9	AMERLOCK 400 AL	1	1	2022-01-05 12:55:42.957404	\N
10	AMERSHIELD	1	1	2022-01-05 13:04:32.820812	\N
29	ab	4	5	1984-01-24 14:11:39	\N
34	asperiores	4	2	1982-02-02 08:06:18	\N
54	necessitatibus	2	5	2010-09-09 03:39:33	\N
55	laboriosam	3	2	2011-02-17 00:43:32	\N
58	inventore	2	5	2006-05-20 17:04:41	\N
71	libero	2	4	1981-03-06 13:45:46	\N
78	ullam	2	1	2012-09-18 03:15:29	\N
83	enim	2	4	2021-10-08 23:37:28	\N
94	voluptatum	4	2	2012-10-05 19:35:12	\N
19	dolore	4	1	2016-08-05 06:36:48	\N
20	non	1	1	2010-01-14 00:00:07	\N
25	ut	2	1	1993-02-06 03:42:48	\N
28	animi	4	1	2008-10-04 10:47:29	\N
32	est	3	1	1976-01-12 09:20:57	\N
37	accusamus	4	1	1991-08-14 05:51:56	\N
38	aperiam	2	1	2020-05-29 07:34:00	\N
39	maxime	1	1	1987-11-30 19:11:40	\N
45	quisquam	2	1	1983-04-14 03:10:26	\N
49	eius	4	1	1997-08-19 03:57:30	\N
65	nesciunt	2	1	2001-03-30 12:48:45	\N
87	illum	4	1	2019-12-18 14:22:52	\N
89	doloremque	2	1	1997-11-24 21:06:11	\N
99	ducimus	4	1	1972-02-12 00:01:23	\N
1	AMERCOAT 182 ZP HP	1	1	1998-11-06 01:35:14	\N
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.projects (id, name, customer_id, contractor_id, comments, started_at, finished_at) FROM stdin;
1	aliquam	3	20	Occaecati hic itaque et sapiente. Ut ducimus corporis omnis esse vel sunt. Voluptatem asperiores porro laborum voluptatibus aut consequatur qui.	1978-06-05	1979-06-01
2	consectetur	4	4	Omnis veniam ut odio ut. Autem cum corporis tempora ex ea est qui. Iste et perspiciatis ab voluptas.	2015-07-13	2017-05-19
4	ea	10	11	Nisi labore ipsa aspernatur consequatur. Aliquid aliquam non ipsum id aut. Dolores sit consequuntur dolore provident illo rerum et dolor. Vel quia occaecati laboriosam est ut repudiandae.	1988-01-24	2006-04-07
5	earum	13	12	Voluptatem non et nemo eos. Et et sit accusantium cupiditate accusantium eum illo. Sit sequi assumenda quibusdam omnis inventore. Quasi rem eius qui doloremque et nostrum autem doloribus.	1976-10-25	1993-05-25
6	minima	2	8	Odio debitis rem tempora eaque. Vel dolorum nulla eligendi recusandae quisquam et. Tempora voluptatem qui deleniti. Delectus rerum dolores molestiae consequuntur.	1994-02-21	2013-12-13
11	nulla	11	12	Quo et occaecati et et quia rerum. Neque pariatur molestiae quo impedit consequuntur sit et qui. Magni adipisci atque assumenda vitae culpa.	1972-12-19	2001-05-19
12	provident	6	12	Repellendus et aut magni. Dolor repellendus consequatur culpa iusto beatae. Dolor et qui ut a veniam esse. Est similique dolores ea impedit et.	1994-08-12	2004-02-21
13	corporis	25	2	Ab et in voluptate neque. Molestias necessitatibus adipisci qui in repudiandae voluptatem assumenda.	1980-09-13	2009-11-20
16	quia	9	13	Rerum et quod ullam dolor autem. Laboriosam quod odit ut vero. Commodi officiis magni minima.	1972-03-17	1996-02-24
17	voluptate	10	2	Voluptatem ab sit inventore quidem corporis. Voluptatem repellat ullam recusandae sit. Est non voluptatem reprehenderit unde tempore debitis esse.	1971-08-07	2000-01-25
20	rerum	20	19	Labore qui id vero neque. Ut est et consequuntur optio ratione est cupiditate suscipit. Est qui nemo autem consequatur.	1993-10-03	1996-04-01
21	voluptatem	3	13	Suscipit animi consectetur aut. Quidem voluptatibus quis dolore vel ad. Earum et culpa voluptatibus ratione. Consequatur recusandae sed soluta earum sit dolore.	1992-03-03	2008-09-02
7	corrupti	24	17	Voluptas maxime ex dolor asperiores atque. Neque dolor sed eos similique commodi suscipit quo. Totam qui aliquid perspiciatis explicabo eligendi. Et eveniet dolor sequi officia asperiores magni eum.	1998-11-20	2021-12-23
72	aut	13	16	Molestiae beatae quia rerum ab maxime nihil dolorem. Nam suscipit ut quaerat numquam qui labore ipsa corrupti. Non quis iusto rem quia voluptatum accusamus porro.	2014-06-26	2014-09-14
73	alias	2	10	Aut dicta aut minima est qui necessitatibus harum in. Mollitia id rem voluptate. Laborum magnam omnis vitae illo et officia est.	1970-06-30	1974-11-13
74	voluptatem	17	15	Et temporibus tempora dignissimos. Libero repellat ad maiores totam rerum quasi rerum. Distinctio aspernatur non explicabo quo doloribus. Quam officia ex officiis hic expedita.	1977-04-21	1978-08-19
76	vel	25	12	A error id ut dolores sit. Voluptatem harum et natus et et quis.	1993-06-24	1997-01-17
78	illo	2	14	Eos voluptatem beatae corrupti rem quae. Nesciunt quaerat aut consequuntur est quis qui pariatur. Et eum repudiandae expedita nostrum. Dolores dolores iure maiores necessitatibus ipsa aut.	1973-02-22	1992-01-23
79	nemo	20	13	Pariatur non et eos facilis. Deleniti facilis architecto quod et repellat.	2000-01-21	2020-05-09
80	culpa	17	20	Sequi animi qui natus ratione ut impedit. Qui sed rerum eum ut vel consequatur. Reiciendis ratione repellat consequatur quam ut expedita.	2001-09-18	2021-04-27
87	quae	14	10	Consequatur eum odit magnam quia sit tempore enim. Tenetur ea reiciendis fuga nisi.	1985-03-26	2020-01-03
89	eum	10	20	Laborum nobis unde numquam officiis. Voluptatum quisquam iure qui dolore sed. Quibusdam doloribus molestiae ratione rerum enim.	1989-12-14	2017-06-29
90	dolor	7	1	Quia ut reiciendis vel et provident mollitia. Eligendi aut est sint quia qui itaque. Nisi nihil consequatur et totam ad.	1997-09-19	2001-11-19
94	voluptatem	2	1	Dolor et maiores non rem illum. Nemo architecto placeat et voluptatem nostrum hic et. Sint ipsa ex omnis accusantium.	1975-02-25	1977-04-01
8	est	6	4	Molestiae sit eaque voluptatem magni ut facilis. Eaque quia molestiae quam alias in. Dolorum eveniet alias ducimus quis. Quia voluptatem enim et nihil incidunt ipsa voluptatem.	1991-11-18	2021-12-23
9	qui	20	4	Sint excepturi porro officiis debitis rerum. Quod optio illo eos sint. Nesciunt et esse dolores aliquid voluptatem aut nulla. Et ea qui explicabo dolorum voluptates.	2001-04-02	2021-12-23
19	eum	15	5	Tempora ea voluptatum omnis. Praesentium et maiores officiis omnis. Sed est iste non explicabo quasi iste saepe.	2001-02-15	2021-12-23
22	error	9	10	Minima eum aut ducimus expedita deleniti id voluptatum. Ut quidem a eum quasi amet ab. Non quia ea consequuntur laudantium ratione libero.	1976-07-25	2021-12-23
32	ea	16	6	Omnis optio aut aperiam laboriosam voluptatem eos. Et quas inventore corporis.	2020-01-02	2021-12-23
34	molestiae	15	11	Sed a sed et ducimus. Fugiat quia totam numquam. Sed impedit est velit in consequatur itaque. Qui reiciendis et quia facere accusantium ut quia.	2004-09-13	2021-12-23
61	corrupti	7	11	Et non quia sed est beatae. Provident et adipisci quis. Doloribus beatae qui est asperiores. Vel dignissimos et corporis sit vel.	2005-09-29	2021-12-23
36	aut	7	2	Dicta autem non impedit voluptates voluptas sed. Vero corporis mollitia beatae adipisci excepturi.	2010-12-22	2021-12-23
39	doloremque	6	16	Enim et illum numquam consectetur vero pariatur fugiat. Omnis itaque aliquam quia culpa fugiat. Repudiandae mollitia eos perspiciatis tempora quibusdam ut.	2013-04-29	2021-12-23
41	quo	4	14	Optio est sit eum non velit pariatur delectus. Error error provident velit eaque illum est pariatur itaque. Dicta nulla vel aspernatur quas.	2001-12-02	2021-12-23
42	et	25	6	Possimus est dolores odit debitis soluta et nulla quam. Neque voluptas est molestiae iure nam. Omnis placeat et cumque illum deserunt.	2015-11-25	2021-12-23
43	optio	23	5	Eos in perspiciatis sed sint. Ea ut dolorem dolores quae reprehenderit qui provident. Et similique vel qui blanditiis laudantium et corporis.	2001-03-14	2021-12-23
44	voluptatem	20	14	Recusandae consequuntur qui voluptas similique. Aut placeat corrupti iusto est sint minus. Laudantium temporibus voluptatem mollitia ipsum eius. Nostrum fugit numquam autem aut.	2001-06-09	2021-12-23
62	dolor	6	17	Aliquam itaque tempora sunt. Consequatur qui qui minima consectetur facere omnis rerum. Consequatur recusandae sunt occaecati laudantium.	1991-11-30	2021-12-23
63	facilis	12	5	Quisquam rem assumenda dolores voluptatem qui dolores. Quos quo sunt nisi voluptatem eum nam omnis. Molestiae animi repellat occaecati hic sunt.	2018-11-12	2021-12-23
64	optio	20	11	Nam distinctio sed explicabo. Ut nostrum dicta quia doloribus ut doloribus distinctio impedit.	1998-08-16	2021-12-23
18	et	14	17	Laudantium in recusandae recusandae quia voluptatem totam voluptas. Quam id aut nulla.	1974-11-14	2021-12-23
65	totam	19	18	Exercitationem sunt sed earum rerum asperiores doloribus. Rerum quia et labore quam saepe. Laboriosam quasi corporis omnis. Voluptatem dolores quia debitis est quia dicta consequatur.	2001-02-28	2021-12-23
81	quia	15	6	Ea nisi quos voluptas labore dolor praesentium. Eveniet quaerat totam distinctio excepturi et eos ab vel. Ut laborum debitis minus.	1977-07-28	2021-12-23
88	commodi	16	3	Soluta repudiandae necessitatibus velit repellendus eos deserunt. Ducimus sit sit magni quos blanditiis. Non rerum sed est laboriosam qui.	2001-09-02	2021-12-23
91	nisi	6	11	Voluptas vel sunt aperiam. Maiores molestiae iste voluptatem placeat reprehenderit. Ab illo natus aut facilis.	1997-03-03	2021-12-23
93	est	3	3	Dolores molestiae deleniti et ipsum. Enim sed nesciunt fugiat. Et omnis rem incidunt consequatur. Fuga odit aut et quo.	2011-12-05	2021-12-23
23	est	4	3	Natus aut voluptatem minima vero rerum qui at. Laboriosam provident libero blanditiis tenetur et. Quod tenetur veniam eius unde delectus et est. Earum dolorum alias mollitia facere doloribus id.	1999-01-31	2011-08-09
25	et	20	3	Quos reiciendis sunt sequi iure impedit. Asperiores culpa molestiae molestias ut voluptatibus a. Voluptatem molestiae est quo. Voluptates aspernatur assumenda ut animi optio esse.	1975-12-12	2003-10-24
28	nobis	3	8	Officia nam sunt aliquam dolor id. Sit nesciunt rerum sit et ut pariatur.	1984-02-03	1998-07-01
33	veritatis	16	5	In aut eos est cum voluptate. Quibusdam quasi expedita ut sapiente qui et beatae autem. Modi repellat debitis sed sit ab velit.	1975-10-21	1998-11-22
49	voluptate	21	1	Doloremque voluptas molestiae et incidunt modi deleniti. Voluptatem sint et rerum. Explicabo doloremque corrupti natus velit non odit dolore.	1986-02-26	2012-03-04
52	non	16	13	Voluptatum velit beatae dolores est. Et aut dolorem fugit repellendus perferendis commodi quis. Et quo voluptas quaerat vero consequatur animi dignissimos.	1975-06-11	2002-06-14
54	at	16	2	Cum facilis quia et saepe sapiente. Ipsa tenetur quam voluptatem alias veritatis ad harum. Dolorem illum consequatur dolorem dolore quas aspernatur rerum. Velit aliquid sunt voluptatem ut eum.	1994-06-13	2008-05-30
55	amet	14	2	Dicta officiis perferendis ex aut distinctio. Aut facilis qui nobis provident. Repellendus commodi quo incidunt provident ea architecto fugit. Accusamus ex consequuntur aut id.	1972-07-15	2016-11-10
57	porro	25	9	Est nisi ratione atque ipsum esse dolores reprehenderit dolores. Voluptatem optio esse qui in. Ipsa est dolores similique veniam quisquam nam ut.	2014-04-07	2020-10-25
71	quos	14	2	Et velit voluptatem iusto quod dolor ad. Voluptas mollitia omnis est debitis quod et.	1983-01-31	2017-03-04
92	quis	17	5	Sapiente dolores voluptatum iure beatae corporis mollitia voluptatem. Expedita quos vitae nam inventore eum architecto aliquam. Voluptatem molestias explicabo ut ab explicabo quos.	1994-05-27	2021-12-23
35	inventore	17	18	Quibusdam est minus et. Dolorem iste aliquid qui consectetur voluptas aut. Repellendus aliquid porro sunt non tempore modi voluptatem.	1977-10-02	2010-08-11
37	est	23	2	Rem nobis ipsum et ducimus. Accusamus voluptate debitis officia nostrum possimus velit. Blanditiis delectus soluta rerum atque. Nobis ex odio ut.	1970-05-06	1971-07-04
40	non	14	9	Ea fugit beatae a cupiditate quasi. Voluptas vel dicta ipsam in in velit. Maiores illo quasi voluptatibus est.	2000-02-19	2012-06-03
45	occaecati	7	12	Facilis labore reprehenderit ut vel distinctio saepe. Ab deserunt cupiditate et repellat. Veniam aut tempora aspernatur voluptas. Iste sed excepturi rem voluptas. Et vero culpa esse.	1992-10-10	1993-02-02
46	necessitatibus	20	19	Magnam rerum quia tenetur rerum quis rerum. Eveniet quis dolorum asperiores quidem dolorem. Et quis voluptatem dolor voluptatibus expedita exercitationem odit non.	1996-05-24	2000-04-22
47	necessitatibus	9	19	Quis enim repellat porro eos et modi molestiae. Qui enim excepturi pariatur sunt perferendis. Amet quia nobis ex ut.	1986-05-25	2006-12-06
48	accusamus	8	7	Quia est laudantium corrupti accusamus. Iusto sunt velit beatae tenetur. Ex libero vel voluptas.	1985-11-12	2004-04-09
60	est	9	20	Facere sit expedita voluptates omnis. A sit blanditiis sint a ut a. Impedit et a id voluptatem nihil. Ut ab totam vel.	1982-02-04	2020-12-26
66	explicabo	7	2	Nostrum odit aliquid vitae incidunt molestias et. Quisquam minus necessitatibus consequuntur placeat. Aut veniam sapiente alias beatae vel et dolor.	2003-02-14	2017-10-17
67	praesentium	17	5	Aut earum veniam ut eaque doloribus laudantium. Distinctio esse est beatae et cupiditate rerum fugiat. Doloribus veritatis facilis numquam autem corporis.	1996-03-04	1997-01-17
68	ut	6	12	Odit nulla velit et aut quia illo ratione. Distinctio aperiam aut dolorum sint suscipit. Aut reiciendis dolor nihil voluptatem soluta.	1970-06-14	1991-05-11
38	quia	4	1	Magnam sed et voluptatibus dolor est. Similique hic aut aperiam quia.	2001-03-27	2021-12-23
69	et	1	18	Deserunt quos cum provident sunt. Praesentium voluptate dolorem provident ea rerum repellat aut. Similique qui aperiam voluptas neque labore. In autem rerum provident provident consequatur et.	1986-10-30	2021-12-12
82	delectus	12	15	Facilis eum id possimus ratione harum saepe quisquam porro. Hic non fugiat omnis est voluptate quam. Nihil deserunt in quia soluta vero soluta quia. Nisi labore qui aut aperiam ratione ducimus enim.	1999-12-29	2002-11-27
83	est	11	10	Sit dignissimos culpa nobis molestias quae. Rerum natus a nihil quia amet harum sed.	2002-01-13	2018-11-05
85	iste	13	5	Ut cum exercitationem quos nobis odit beatae. Eos aut dolorem aut fuga consequuntur ipsam labore. Cumque enim accusantium mollitia laborum sint quia harum.	1999-01-09	2016-12-01
96	qui	9	9	Fugit dolor natus quo ipsum facilis. Debitis qui voluptas rerum aut. Et cupiditate qui vitae omnis veritatis.\\nConsequuntur adipisci nobis quam. Et error illo reprehenderit.	1994-02-28	1999-12-14
97	ut	12	19	Quis odio odio magnam pariatur. Ipsam in voluptatibus id. Neque corporis voluptas rerum aspernatur sit beatae neque. Tempore tenetur sint beatae illum. Est est iusto assumenda non fugiat.	2012-03-26	2017-07-25
99	excepturi	12	1	Cumque temporibus laudantium nulla. Sed quaerat omnis ipsam. Sit veritatis in pariatur iste iusto sed. Omnis aut hic perspiciatis dolorem nesciunt.	1980-05-07	2017-08-26
3	quidem	4	2	Quia nemo et officia aut. Sed quasi mollitia totam ullam quis. Non rem voluptatibus nostrum architecto. Nam ut nihil error magnam harum.	2000-12-06	2021-12-23
10	sint	13	18	Sint eum voluptates quae consequatur facere commodi. Ad maiores optio maiores doloremque non incidunt. Sed quia aliquid amet accusamus laborum itaque. Nobis sapiente dicta explicabo nulla illo odit.	1995-03-12	2021-12-23
14	id	14	17	Quis ut corporis in provident magni. Praesentium sequi quis aut nostrum. Impedit et numquam sint vitae similique rem possimus. Debitis doloribus vero sed modi minus quisquam.	2003-06-10	2021-12-23
15	dolor	8	9	Ut rerum inventore expedita aliquam nulla. Ab tempore ut impedit magni. Ut molestiae magni expedita doloribus eos ut sed impedit.	1984-05-14	2021-12-23
24	delectus	10	15	Quo quis sequi rerum voluptatem. Perspiciatis sit nulla sit ut similique error. Eaque expedita odit assumenda quasi.	2018-12-07	2021-12-23
26	distinctio	24	16	At rerum consequatur aspernatur et rerum ad et. Quaerat laudantium dolores alias vel. Non cumque quibusdam et voluptatibus rerum nihil.	1999-08-15	2021-12-23
27	consequuntur	10	18	Esse dolores quia soluta praesentium sed officia. Aliquid illo quis dolores est illum. Quia id consequatur sunt est enim. Et non et aut sit eligendi.	2002-05-01	2021-12-23
29	repellat	14	2	Mollitia suscipit odit tenetur dolorum inventore unde sit molestiae. Eius voluptas cumque soluta quia aut iste eius suscipit. Dolores hic est expedita sint distinctio.	2020-11-22	2021-12-23
30	omnis	22	8	Impedit consequatur quia quo. Dicta non nihil sint occaecati occaecati illum eaque eligendi. Est sed dolorem quae accusantium et rem. Non nulla hic ipsum qui blanditiis id.	2019-07-24	2021-12-23
31	atque	2	18	Cupiditate sequi totam facilis incidunt quia. Quasi aut repudiandae est voluptatum esse dolorem voluptates. Rem et necessitatibus nobis iste iure nemo.	2017-05-03	2021-12-23
50	dolores	3	11	Sit in quia itaque et harum sed eos. Aspernatur est inventore sit. Voluptatem reprehenderit libero sunt illo ab ea qui. Ea atque et omnis amet.	1989-05-04	2021-12-23
51	consequatur	7	7	Occaecati eos sunt iure et repellendus qui. Omnis eius eligendi beatae quo molestiae. Sunt sit velit quibusdam facere voluptatem nesciunt est.	2002-03-14	2021-12-23
53	laborum	16	19	Sunt dignissimos impedit dolorum provident aspernatur rerum quas. Quidem harum expedita excepturi rerum culpa quo. Molestias soluta ipsa consequatur eius. Illum dolore qui voluptas explicabo autem.	2007-01-20	2021-12-23
56	dignissimos	17	13	Quo quo odit beatae. Autem aut tempore quibusdam eos maxime ut. Eveniet expedita aut maxime officia enim alias. Dolorem et reprehenderit facere nihil.	2019-02-03	2021-12-23
58	suscipit	13	20	Eos sunt aut molestiae ut velit est. Nihil voluptatem ut labore accusantium at est. Qui aut et non molestias qui sapiente quia.	2002-07-04	2021-12-23
59	aliquid	7	9	Cum dolorem dignissimos quibusdam amet explicabo repellat. Ut distinctio atque ipsum cumque facilis ipsam. Vel vero totam et qui.	1984-11-06	2021-12-23
70	perferendis	25	6	Et omnis odit ex sint est qui est ullam. Et praesentium ducimus laudantium vitae eius deleniti saepe quia. Aut omnis accusamus ut qui quaerat. Non commodi fugit sint quia ut.	1998-07-14	2021-12-23
75	doloremque	16	2	Quia nisi saepe ipsa eos. Et vel sed aut quia reiciendis facilis. Magnam voluptatem autem et eligendi.	1994-12-24	2021-12-23
77	doloribus	8	2	Adipisci distinctio consequuntur dolores nulla. Quia architecto est totam id dolor. Ut placeat illo nesciunt suscipit dolores ut aperiam. Deleniti voluptatem consequatur iure quibusdam.	1975-04-27	2021-12-23
84	quas	19	14	Magnam dolorum nisi fuga in voluptatem animi. Quos fugiat sint at consequuntur. Eum non voluptatum at suscipit.\\nAspernatur sed incidunt similique esse eaque. Rerum laudantium esse animi iste.	2003-05-02	2021-12-23
86	nulla	7	13	Labore et quisquam animi necessitatibus hic voluptatum. Qui sunt ea ut atque et exercitationem vel. Placeat ducimus consequatur in fuga. Eos aut et iure ea illum sed alias nulla.	2009-01-30	2021-12-23
95	dolor	20	20	Voluptatem adipisci ex quibusdam cupiditate tenetur. Perferendis dolores doloremque placeat quos quis optio tempore. Qui sunt veritatis delectus ullam aut dignissimos dolorum deleniti.	1987-10-28	2021-12-23
98	veritatis	13	13	Et optio modi velit qui sed ea. Voluptatem qui iure reiciendis. Aut quos voluptas quaerat rerum.	1993-03-11	2021-12-23
100	enim	4	4	Beatae a fuga iste ut quas. Mollitia eum totam et. Veniam recusandae voluptas sint nulla.	2007-07-26	2021-12-23
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.reports (id, name, project_id, url, tsr_id, started_at, finished_at, created_at, updated_at) FROM stdin;
18	Iure sunt quod quos qui sed est deleniti.	52	http://www.hodkiewicz.com/	21	1990-06-06	2007-03-14	1990-06-13 00:00:00	2017-05-07 11:36:41
27	Ea in placeat amet libero reprehenderit corrupti s	31	http://doyle.net/	25	1996-10-09	2006-01-06	1996-10-16 00:00:00	2007-09-07 13:59:10
53	Sit id et qui autem architecto et.	47	http://rodriguez.com/	26	2016-06-13	2016-12-13	2016-06-20 00:00:00	2016-12-20 00:00:00
30	Et nam et doloremque temporibus corporis soluta.	56	http://koss.net/	12	2006-08-10	2007-02-10	2006-08-17 00:00:00	2015-10-22 22:24:45
35	Deserunt voluptatem vitae accusamus nisi.	59	http://hagenesfunk.biz/	23	1984-07-18	1985-01-18	1984-07-25 00:00:00	2020-06-10 08:30:26
41	Voluptatem sequi at magni.	35	http://mosciski.com/	16	2018-11-11	2019-05-11	2018-11-18 00:00:00	2020-04-04 16:38:45
42	Possimus aliquid nam blanditiis aut reiciendis.	36	http://www.padberg.info/	23	1999-02-02	1999-08-02	1999-02-09 00:00:00	2000-10-15 06:48:33
50	Placeat eum ea optio velit eligendi asperiores.	42	http://www.bartonschneider.biz/	12	1980-09-28	1981-03-28	1980-10-05 00:00:00	1996-04-17 13:15:58
56	Est id expedita quaerat.	54	http://sawaynjones.com/	10	1990-03-08	1990-09-08	1990-03-15 00:00:00	2014-08-10 09:58:23
60	Magni natus odio impedit.	33	http://pagac.org/	10	2013-09-16	2014-03-16	2013-09-23 00:00:00	2020-02-08 03:01:22
61	Hic placeat qui illum aut sint magni.	42	http://www.schmeler.org/	28	1988-03-14	1988-09-14	1988-03-21 00:00:00	1994-04-14 20:12:48
5	Ad hic similique natus officiis sint commodi incid	55	http://www.schroederhauck.com/	11	2010-11-15	2011-05-15	2010-11-22 00:00:00	2016-10-20 22:54:17
67	Et quis dignissimos distinctio.	44	http://www.friesen.com/	27	2010-06-04	2010-12-04	2010-06-11 00:00:00	2011-01-13 22:23:30
16	Quos possimus maiores saepe sunt deleniti.	37	http://frami.info/	28	2021-06-11	2021-12-11	2021-06-18 00:00:00	2021-07-02 05:14:50
17	Consequatur sed nobis debitis saepe et impedit.	42	http://www.blandachamplin.com/	29	1991-08-16	1992-02-16	1991-08-23 00:00:00	2015-11-09 10:10:11
57	Doloribus nihil rem at culpa velit quo.	32	http://www.pfannerstillzboncak.com/	18	2006-07-09	2007-01-09	2006-07-16 00:00:00	2007-01-16 00:00:00
64	Suscipit ea temporibus unde omnis exercitationem e	45	http://corkery.com/	22	2019-11-23	2020-05-23	2019-11-30 00:00:00	2020-05-30 00:00:00
1	Temporibus aut optio in tempora et earum.	50	http://www.lebsackboehm.com/	24	2019-03-17	2019-09-17	2019-03-24 00:00:00	2019-09-24 00:00:00
12	Et aperiam odit vel blanditiis non est culpa volup	40	http://www.becker.biz/	28	2011-12-28	2012-06-28	2012-01-04 00:00:00	2012-07-04 00:00:00
13	Velit tenetur libero excepturi similique veniam vo	56	http://ankunding.com/	24	1988-12-04	2012-10-07	1988-12-11 00:00:00	1989-06-11 00:00:00
74	Non impedit voluptatem aut nihil dolores magnam fu	44	http://www.quitzonwilkinson.com/	12	2009-10-29	2019-10-14	2009-11-05 00:00:00	2010-05-05 00:00:00
58	Porro est corrupti tempore qui voluptatem voluptat	32	http://www.williamson.org/	21	1991-11-26	2000-08-19	1991-12-03 00:00:00	2014-12-08 06:21:37
62	Possimus magni aut et possimus.	34	http://metz.biz/	30	1993-03-30	1999-09-28	1993-04-06 00:00:00	2013-09-25 00:52:04
63	Adipisci quo natus eius adipisci velit.	36	http://hermiston.com/	18	1984-05-04	1993-09-03	1984-05-11 00:00:00	1993-09-20 15:29:35
6	Optio veniam nihil maiores non.	58	http://zemlakkohler.info/	26	1978-12-06	2018-12-07	1978-12-13 00:00:00	2012-07-27 03:00:23
11	Eos labore facilis rerum ullam et.	31	http://mcglynn.net/	20	1995-09-09	2010-04-07	1995-09-16 00:00:00	2017-08-04 16:08:28
70	Repellat ullam ut veniam.	44	http://www.funk.biz/	26	1992-01-30	2014-10-22	1992-02-06 00:00:00	2000-12-17 09:02:56
73	Voluptatum asperiores ut libero deleniti repudiand	42	http://www.lemke.com/	10	1984-01-10	2011-10-29	1984-01-17 00:00:00	2021-08-01 21:00:00
15	Non voluptas temporibus a iste adipisci.	61	http://www.bartoletti.com/	20	1972-04-02	1983-12-24	1972-04-09 00:00:00	2018-07-15 11:48:00
76	Laborum autem neque quasi ut ut molestias aut.	46	http://www.murphynolan.com/	22	1984-09-21	2016-07-06	1984-09-28 00:00:00	1989-12-21 05:14:36
21	Modi laboriosam eveniet sit nulla quam deserunt co	60	http://herman.com/	24	1998-03-31	2002-08-07	1998-04-07 00:00:00	2021-06-21 04:05:29
24	Voluptas placeat et rerum ut magnam provident fuga	55	http://lindlittel.com/	26	1993-03-07	2018-10-20	1993-03-14 00:00:00	1993-09-14 00:00:00
81	Officiis fugit eveniet explicabo magni maiores quo	51	http://okuneva.com/	29	1994-12-11	1995-06-11	1994-12-18 00:00:00	1995-06-18 00:00:00
25	Rerum qui quia cupiditate architecto.	34	http://donnelly.com/	30	2018-05-20	2018-11-20	2018-05-27 00:00:00	2018-11-27 00:00:00
87	Rerum commodi sed enim autem aspernatur et.	39	http://murazik.com/	15	2015-04-19	2015-10-19	2015-04-26 00:00:00	2015-10-26 00:00:00
88	Et beatae vitae officia aperiam.	54	http://www.hilllpfeffer.org/	18	2019-11-12	2020-05-12	2019-11-19 00:00:00	2020-05-19 00:00:00
91	Id labore qui quia placeat dolores ut sunt.	70	http://www.reichert.info/	22	2003-02-17	2003-08-17	2003-02-24 00:00:00	2003-08-24 00:00:00
39	Exercitationem voluptatem similique commodi offici	37	http://cruickshankbaumbach.net/	11	2006-05-12	2006-11-12	2006-05-19 00:00:00	2006-11-19 00:00:00
84	Voluptas soluta autem recusandae enim sit officiis	54	http://spinka.com/	18	2019-01-31	2019-07-31	2019-02-07 00:00:00	2019-08-07 00:00:00
86	Provident sunt et quasi culpa perspiciatis quos sa	51	http://www.gerhold.com/	13	1998-09-19	1999-03-19	1998-09-26 00:00:00	1999-03-26 00:00:00
54	Autem et sit dignissimos unde.	62	http://www.harvey.com/	21	2012-02-24	2012-08-24	2012-03-02 00:00:00	2012-09-02 00:00:00
65	Voluptate enim ad dolores.	30	http://www.blanda.com/	13	1993-04-20	2018-02-16	1993-04-27 00:00:00	1993-10-27 00:00:00
80	Dolorem illum sit enim esse qui aut.	40	http://www.feest.com/	17	1975-12-19	1994-11-30	1975-12-26 00:00:00	1981-09-06 06:41:57
85	Debitis dolorem consequuntur provident debitis ill	37	http://gusikowski.com/	26	2010-04-13	2011-12-20	2010-04-20 00:00:00	2013-01-26 08:15:07
28	Et ea debitis consequatur repellat harum natus por	50	http://murray.com/	16	1985-03-28	2014-04-04	1985-04-04 00:00:00	2001-06-15 03:10:45
29	Nam ipsam dolorem praesentium blanditiis corrupti 	47	http://pacochareilly.com/	14	2001-05-23	2006-07-06	2001-05-30 00:00:00	2019-10-14 07:23:06
90	A facilis eius beatae eum officiis eos sint.	41	http://runolfsson.org/	27	1977-09-15	2010-10-19	1977-09-22 00:00:00	2003-01-13 05:08:45
92	Officiis vero est nihil aut sed.	46	http://nienowspinka.com/	24	1973-03-02	1977-11-13	1973-03-09 00:00:00	2001-09-27 04:34:57
31	Dolorem error occaecati odio doloremque.	41	http://www.erdman.com/	14	1993-04-03	2016-05-03	1993-04-10 00:00:00	2012-07-05 15:30:05
32	Iste fuga magnam dignissimos voluptas et.	59	http://schmitt.org/	12	1987-07-13	2008-04-11	1987-07-20 00:00:00	2014-07-14 21:36:18
95	Sunt dicta aut iste aut veritatis est sunt.	40	http://www.dickinson.com/	12	1985-12-19	1986-07-01	1985-12-26 00:00:00	2017-01-31 19:35:27
37	Modi et aut quasi enim quaerat.	59	http://www.hudson.org/	23	1997-06-09	2000-12-24	1997-06-16 00:00:00	2008-12-10 05:51:06
97	At omnis qui cum aut aut officia.	31	http://erdman.info/	28	1997-08-18	2001-01-15	1997-08-25 00:00:00	2015-02-22 20:49:55
100	Et minima soluta nisi et nam ut.	36	http://witting.com/	12	1975-01-05	2012-11-24	1975-01-12 00:00:00	2011-04-03 00:54:20
40	Est odit autem eos autem officiis.	34	http://www.maggio.com/	22	1983-08-14	2005-01-19	1983-08-21 00:00:00	1992-11-30 02:35:06
82	Dolores qui voluptas iusto.	64	http://www.kutchherman.net/	25	1972-07-26	1973-01-26	1972-08-02 00:00:00	2019-05-19 09:43:22
44	Eius sunt aliquam repellat minus minima incidunt t	63	http://kessler.org/	16	2000-11-18	2001-05-18	2000-11-25 00:00:00	2017-10-20 21:26:55
52	Est asperiores non quis quis dolorum.	48	http://www.franeckilebsack.com/	25	1978-08-25	1979-02-25	1978-09-01 00:00:00	2017-06-21 10:27:10
46	Ex labore ab a voluptate ut error.	47	http://becker.info/	28	1982-09-26	2004-03-31	1982-10-03 00:00:00	2019-06-19 02:49:23
47	Quasi quis aut nisi et distinctio perferendis aut.	43	http://www.gislason.net/	10	1979-12-08	2012-01-16	1979-12-15 00:00:00	2011-10-21 00:04:00
48	Dicta eligendi aliquid perspiciatis.	40	http://www.witting.com/	11	1979-02-16	1985-11-13	1979-02-23 00:00:00	1994-08-24 17:51:17
49	Repudiandae quod molestias quia pariatur magni mod	56	http://www.rolfson.net/	15	1986-07-19	2001-07-29	1986-07-26 00:00:00	1990-07-19 17:35:35
51	Voluptas esse totam et consequuntur exercitationem	35	http://www.schinner.org/	18	1976-10-25	1988-03-17	1976-11-01 00:00:00	2008-05-12 20:30:10
71	Et et odit repellat nam.	49	http://www.greenfelder.com/	26	1972-07-28	1973-05-29	1972-08-04 00:00:00	2012-09-15 13:42:10
72	Vel sint similique quis velit.	34	http://keeling.com/	25	2004-02-15	2015-05-12	2004-02-22 00:00:00	2016-03-26 05:04:39
77	Placeat accusamus nobis nesciunt sunt corporis quo	41	http://funk.org/	20	1976-05-19	1979-06-26	1976-05-26 00:00:00	2021-09-13 00:08:25
78	Et labore mollitia reiciendis.	34	http://www.hirthe.com/	19	1991-02-16	2000-04-17	1991-02-23 00:00:00	2007-05-15 09:57:21
79	Nulla illo error placeat ut et qui impedit.	65	http://gottliebhettinger.com/	10	1986-10-11	1994-02-02	1986-10-18 00:00:00	2003-10-26 14:54:00
99	Maxime deleniti in autem libero ab nobis non.	50	http://www.strosin.com/	19	1992-09-16	1994-01-29	1992-09-23 00:00:00	2001-06-19 00:08:38
59	Sit omnis accusamus deleniti ut.	53	http://wisozkferry.com/	13	1987-07-26	1988-01-26	1987-08-02 00:00:00	1987-09-13 16:08:03
68	Est laudantium et ea rerum eum reiciendis voluptat	43	http://www.durgandicki.com/	29	2016-07-06	2017-01-06	2016-07-13 00:00:00	2020-03-07 13:31:34
89	Similique expedita tempore veniam omnis deleniti.	65	http://www.cruickshankemmerich.com/	25	1994-09-15	1995-03-15	1994-09-22 00:00:00	2018-02-22 23:15:15
93	Asperiores aut corrupti molestiae corporis in sunt	44	http://www.gislasonrunolfsdottir.org/	22	1999-01-05	1999-07-05	1999-01-12 00:00:00	2016-01-21 07:11:18
94	Aliquam enim aperiam voluptatem aut in.	47	http://www.stehrrippin.com/	16	1990-11-23	1991-05-23	1990-11-30 00:00:00	2003-05-24 07:46:15
66	Aliquid sapiente reiciendis consectetur consectetu	30	http://hermiston.net/	20	2014-08-24	2015-02-24	2014-08-31 00:00:00	2015-02-28 00:00:00
69	Delectus doloribus ea aspernatur.	67	http://www.corkery.com/	26	2017-04-27	2017-10-27	2017-05-04 00:00:00	2017-11-04 00:00:00
75	Est amet non et est distinctio ducimus et.	66	http://swift.net/	29	2019-08-03	2020-02-03	2019-08-10 00:00:00	2020-02-10 00:00:00
83	Vel quia eos consequatur eveniet laboriosam.	67	http://parisianjacobson.info/	26	2015-08-17	2016-02-17	2015-08-24 00:00:00	2016-02-24 00:00:00
96	Nostrum ratione voluptas ut cupiditate quia libero	63	http://jakubowski.biz/	16	2003-05-11	2003-11-11	2003-05-18 00:00:00	2003-11-18 00:00:00
98	Dolorem quasi aut adipisci ut inventore.	33	http://www.braun.com/	14	2003-03-28	2003-09-28	2003-04-04 00:00:00	2003-10-04 00:00:00
14	Est aut consectetur provident qui.	1	http://www.pouros.com/	30	1994-06-27	2005-02-13	1994-07-04 00:00:00	1995-01-04 00:00:00
34	Provident cumque temporibus officiis quibusdam qui	2	http://www.effertz.com/	28	2017-07-08	2018-10-15	2017-07-15 00:00:00	2018-01-15 00:00:00
2	Officia impedit aut molestias.	4	http://hermann.info/	11	2012-08-02	2013-02-02	2012-08-09 00:00:00	2013-02-09 00:00:00
7	Eum porro ratione dolore assumenda.	17	http://konopelski.org/	12	2014-09-27	2015-03-27	2014-10-04 00:00:00	2015-04-04 00:00:00
9	Exercitationem eius earum ipsa saepe.	12	http://nader.com/	23	2017-06-02	2017-12-02	2017-06-09 00:00:00	2017-12-09 00:00:00
20	Et quia debitis voluptatibus ut.	15	http://harber.info/	11	2012-10-10	2013-04-10	2012-10-17 00:00:00	2013-04-17 00:00:00
10	Vel itaque iste veniam rerum qui iusto.	18	http://batz.biz/	19	1993-11-07	2017-03-20	1993-11-14 00:00:00	2015-02-22 00:46:31
26	Consequatur accusamus incidunt voluptatibus vel mo	12	http://www.champlin.info/	29	1997-04-05	1997-10-05	1997-04-12 00:00:00	1997-10-12 00:00:00
33	Corporis nemo qui quia maxime.	34	http://harris.com/	18	2000-02-18	2000-08-18	2000-02-25 00:00:00	2000-08-25 00:00:00
22	Sequi aut est eum fugit sed accusantium repellendu	7	http://www.goldner.info/	20	1972-07-13	2014-01-17	1972-07-20 00:00:00	1991-08-28 22:20:37
23	Quam et officiis laudantium et possimus iure sed.	6	http://www.welch.com/	24	1988-12-07	1991-11-10	1988-12-14 00:00:00	2018-05-19 23:27:58
45	Veniam rem et est deserunt nam tempore sequi.	8	http://greenmarks.com/	27	2010-02-23	2010-08-23	2010-03-02 00:00:00	2010-09-02 00:00:00
55	Voluptas temporibus consectetur quis facere quae a	12	http://streicherdman.com/	13	2002-05-21	2002-11-21	2002-05-28 00:00:00	2002-11-28 00:00:00
36	Dolores nihil eius corrupti quos.	16	http://www.schimmel.org/	12	1970-10-09	2007-04-19	1970-10-16 00:00:00	2010-04-17 09:22:42
38	Fuga fugit consequatur eos nesciunt.	11	http://www.oberbrunner.com/	13	1978-03-31	2013-02-13	1978-04-07 00:00:00	2003-05-29 10:55:44
43	Aliquid et maiores voluptate magni.	10	http://www.kiehn.net/	27	1987-10-03	1991-09-06	1987-10-10 00:00:00	2019-07-27 00:19:22
3	Sit ut modi nam et.	7	http://denesik.org/	16	2007-05-07	2007-11-07	2007-05-14 00:00:00	2018-09-25 03:40:48
4	Amet sapiente et suscipit.	3	http://olson.com/	18	1987-08-13	1988-02-13	1987-08-20 00:00:00	2015-10-27 19:48:46
8	Fugiat recusandae rerum nemo et.	10	http://www.reynoldsschmitt.com/	19	1998-04-21	1998-10-21	1998-04-28 00:00:00	2012-03-01 23:32:19
19	Et eveniet culpa accusamus explicabo sunt aperiam.	17	http://www.lindgren.com/	30	1998-10-01	1999-04-01	1998-10-08 00:00:00	2015-05-24 04:04:26
\.


--
-- Data for Name: resistances; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.resistances (id, name) FROM stdin;
1	абразивный износ
2	авиационное топливо
3	адгезия
4	брызги и проливы химикатов
5	высокая температура
6	горячая вода
7	катодное отслаивание
8	морская вода
9	нефтепродукты
10	питьевая вода
11	под изоляцию
12	пресная вода
13	сырая нефть
14	удар
15	химикаты
16	химически загрязненная вода
17	хранение зерна
18	элекстростатическая электробезопасность
\.


--
-- Data for Name: standards; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.standards (id, name) FROM stdin;
1	Sit nemo et veritatis explicabo perspiciatis sit a
2	Laudantium quae ab sit dolores repudiandae necessi
3	Dolores et illum aperiam tempora voluptas porro es
4	In et necessitatibus vel placeat.
5	Consectetur accusamus enim magnam aperiam facere d
6	Architecto sint tenetur maiores quia molestiae cum
7	Sed provident non sit accusamus aliquam fugit quae
8	Laudantium labore cumque sequi laborum ipsum conse
9	Itaque ex accusamus repellat tempore.
10	Sed nihil quibusdam tempora vero perspiciatis quia
11	Vero non eligendi repudiandae voluptatibus sit.
12	Omnis quis in consequatur autem.
13	Sed harum explicabo quis.
14	Fugiat consequatur aspernatur in minus sequi.
15	Voluptas maxime dolore sint.
16	Nostrum quo consequatur hic sit necessitatibus cul
17	Voluptates sed velit excepturi natus quia.
18	Aut ullam et amet voluptatem vero incidunt dolores
19	Quia at perferendis voluptatem amet assumenda qui 
20	Nemo distinctio nulla provident molestias unde ape
21	Est blanditiis non recusandae et eos.
22	Facere velit dolores earum maxime.
23	Ea possimus ea dolores ipsum pariatur recusandae v
24	Omnis rem voluptas facere iure.
25	Perspiciatis laudantium repellat optio.
26	Magni quasi reiciendis nisi et.
27	Soluta ipsum voluptatem consequatur reprehenderit 
28	Animi magni rerum quis.
29	Totam enim velit ea nulla deserunt nisi enim.
30	Voluptas incidunt alias et alias iste quasi est.
31	Aut aut aut quisquam dolorem qui vitae animi.
32	Suscipit laboriosam sapiente enim consequatur volu
33	Iste vero aut nihil amet et consequuntur.
34	At officiis sit ea consequatur autem numquam.
35	Nulla id id temporibus asperiores sit placeat veli
36	Mollitia eum ipsa et ipsum sit.
37	Hic in tempora distinctio officia qui et aliquid.
38	Nesciunt et atque modi.
39	Vero ea quis dolorum nulla aperiam praesentium tem
40	Non facere unde delectus voluptas quo non reiciend
41	Explicabo non quasi eum et quam.
42	Quos repellat quia vero velit eos dolores eos sed.
43	Eum nihil occaecati vel sapiente assumenda.
44	Voluptas eius sapiente laboriosam vel molestias et
45	Quas est quam consectetur.
46	Consequatur rerum omnis sint doloremque.
47	Odit voluptas quia et dolores qui qui ad.
48	Vel odit sed eaque ut sed quia ex.
49	Quae sint dolor necessitatibus omnis veritatis sae
50	Voluptatem ullam perferendis officiis architecto q
\.


--
-- Data for Name: substrates; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.substrates (id, name) FROM stdin;
1	сталь
3	оцинковка
4	цветные металлы
5	алюминий
6	дерево
2	бетон
\.


--
-- Data for Name: tsr; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.tsr (id, first_name, last_name, email) FROM stdin;
1	Marquis	Predovic	heller.johnny@example.net
2	Sterling	Mante	schaefer.alf@example.com
3	Jerod	Kreiger	smertz@example.com
4	Rogelio	Huels	devonte.konopelski@example.com
5	Anabel	Feil	pwuckert@example.net
6	Walton	Schmidt	quitzon.wilfrid@example.net
7	Gustave	Douglas	ihyatt@example.net
8	Lyda	Krajcik	ahyatt@example.net
9	Lera	Kulas	gilberto13@example.net
10	Shawna	Nicolas	wintheiser.tressie@example.net
11	Zander	Emard	kabbott@example.org
12	Donnie	Rippin	oliver.jenkins@example.com
13	Gino	Murphy	elisa.schumm@example.org
14	Cielo	Kassulke	ona.heller@example.org
15	Woodrow	Jacobson	cristian36@example.net
16	Kenyon	Tillman	amira.heidenreich@example.net
17	Fernando	Robel	shawn.hudson@example.com
18	Ignacio	Wyman	laverna23@example.com
19	Stefan	Miller	ohamill@example.com
20	Marcelina	Kuhic	elliott29@example.net
21	Edward	Pollich	huels.jacinthe@example.com
22	Murray	Kunze	lang.verda@example.org
23	Merritt	Hane	dashawn.ruecker@example.com
24	Margarett	OHara	crolfson@example.com
25	Sofia	Rohan	eldon.walsh@example.net
26	Jazmyne	Hane	houston.west@example.org
27	Kenya	Schinner	crooks.darrion@example.org
28	Eduardo	Fay	zkertzmann@example.net
29	Queen	Kuhlman	delphine24@example.org
30	Rudolph	Abbott	idurgan@example.net
31	Earnestine	Mayer	spencer.tianna@example.com
32	Wilfredo	Kohler	ollie.huel@example.net
33	Rocky	Bradtke	rrempel@example.com
34	Flo	Shanahan	carmel34@example.org
35	Mario	Pagac	roman.hane@example.com
36	Stan	Weissnat	tre83@example.net
37	Cheyanne	Koss	abdullah.frami@example.com
38	Milton	OKeefe	eriberto.weimann@example.com
39	Jaime	Nikolaus	sgrimes@example.com
40	Hailie	Von	konopelski.max@example.com
41	Alexis	Williamson	omari.metz@example.com
42	Rosie	Nitzsche	dmosciski@example.org
43	Derek	Feest	cschulist@example.org
44	Nicole	Hauck	donavon59@example.com
45	Mabel	Fahey	raul.ullrich@example.com
46	Maye	Schultz	yzemlak@example.org
47	Joany	Rodriguez	walsh.sim@example.net
48	Mario	Anderson	qtreutel@example.org
49	Shaylee	Heidenreich	slowe@example.com
50	Astrid	Kerluke	micheal.durgan@example.com
51	Annabell	Roob	ondricka.nadia@example.org
52	Brayan	Rice	stuart28@example.org
53	Lucas	Hodkiewicz	jovanny00@example.org
54	Yadira	Abshire	douglas.luigi@example.org
55	Arlene	Terry	garret20@example.com
56	Niko	Abbott	lesly.douglas@example.net
57	Wade	Gerlach	oberbrunner.corine@example.org
58	Brent	Bartell	xschuppe@example.org
59	Kyra	Zulauf	domenico71@example.com
60	Whitney	Dach	skiles.magali@example.com
61	Nannie	Kris	tanner73@example.com
62	Trever	Hintz	llubowitz@example.org
63	Rhea	Schneider	uriah.dach@example.org
64	Jacklyn	Greenholt	maryam.senger@example.org
65	Euna	Reinger	bruce97@example.org
66	Monica	Kulas	viviane.lang@example.com
67	Norma	Yost	aliya.hammes@example.com
68	Taylor	Kerluke	hoyt58@example.net
69	Selena	Wolff	predovic.bella@example.com
70	Ettie	Littel	njerde@example.org
71	Jackeline	Aufderhar	ogottlieb@example.net
72	Delaney	Carter	eernser@example.com
73	Anita	Mills	bechtelar.vernon@example.org
74	David	Adams	sheller@example.net
75	Esperanza	Kemmer	bernhard.anderson@example.org
76	Danika	Oberbrunner	labadie.emery@example.net
77	Kelsie	Lowe	danyka70@example.com
78	Barry	Turcotte	carissa.grimes@example.net
79	Britney	Ferry	kimberly91@example.org
80	Heber	Murphy	nathan97@example.com
81	Beth	Bernier	maye30@example.org
82	Jordan	OKon	nedra.reilly@example.com
83	Devin	Roberts	brennan32@example.org
84	Elisha	Wilkinson	mlockman@example.com
85	Leila	Dickinson	tamia96@example.com
86	Aniyah	Kuhn	kunde.alexandra@example.com
87	Kim	Swaniawski	horacio31@example.org
88	Otha	Halvorson	bstiedemann@example.com
89	Frederik	Hammes	dahlia.hermiston@example.com
90	Judson	Grady	mayert.jana@example.net
91	Jermey	Hauck	lucas.brakus@example.org
92	Adolphus	Robel	bobby97@example.com
93	Agnes	Torp	reinger.hilma@example.com
94	Abigail	Considine	gisselle64@example.net
95	Simeon	Kemmer	taya.gaylord@example.net
96	Kaylee	Simonis	zwill@example.com
97	Alayna	Welch	katherine95@example.org
98	Adeline	Lesch	dlangosh@example.net
99	Serenity	OKon	quentin01@example.org
100	Melvin	Huel	oconnell.sonia@example.org
\.


--
-- Data for Name: used_systems; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.used_systems (project_id, used_system_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.users (id, nickname, created_at, updated_at, pass_hash, hash, email) FROM stdin;
\.


--
-- Name: additives_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.additives_id_seq', 1, false);


--
-- Name: approved_tests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.approved_tests_id_seq', 1, false);


--
-- Name: binders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.binders_id_seq', 1, false);


--
-- Name: brands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.brands_id_seq', 1, false);


--
-- Name: catalogs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.catalogs_id_seq', 1, false);


--
-- Name: coating_systems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.coating_systems_id_seq', 103, true);


--
-- Name: contractors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.contractors_id_seq', 1, false);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.customers_id_seq', 1, false);


--
-- Name: environments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.environments_id_seq', 1, false);


--
-- Name: labs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.labs_id_seq', 1, false);


--
-- Name: product_functions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.product_functions_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.products_id_seq', 1, false);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.projects_id_seq', 1, false);


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.reports_id_seq', 1, false);


--
-- Name: resistances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.resistances_id_seq', 1, false);


--
-- Name: standards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.standards_id_seq', 1, false);


--
-- Name: substrates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.substrates_id_seq', 1, false);


--
-- Name: tsr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.tsr_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: additives additives_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.additives
    ADD CONSTRAINT additives_name_key UNIQUE (name);


--
-- Name: additives additives_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.additives
    ADD CONSTRAINT additives_pkey PRIMARY KEY (id);


--
-- Name: approved_tests approved_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.approved_tests
    ADD CONSTRAINT approved_tests_pkey PRIMARY KEY (id);


--
-- Name: approved_tests approved_tests_url_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.approved_tests
    ADD CONSTRAINT approved_tests_url_key UNIQUE (url);


--
-- Name: binders binders_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.binders
    ADD CONSTRAINT binders_name_key UNIQUE (name);


--
-- Name: binders binders_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.binders
    ADD CONSTRAINT binders_pkey PRIMARY KEY (id);


--
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);


--
-- Name: catalogs catalogs_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.catalogs
    ADD CONSTRAINT catalogs_pkey PRIMARY KEY (id);


--
-- Name: coating_systems coating_systems_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.coating_systems
    ADD CONSTRAINT coating_systems_pkey PRIMARY KEY (id);


--
-- Name: contractors contractors_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.contractors
    ADD CONSTRAINT contractors_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: environments environments_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.environments
    ADD CONSTRAINT environments_name_key UNIQUE (name);


--
-- Name: environments environments_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.environments
    ADD CONSTRAINT environments_pkey PRIMARY KEY (id);


--
-- Name: labs labs_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.labs
    ADD CONSTRAINT labs_pkey PRIMARY KEY (id);


--
-- Name: pds pds_url_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.pds
    ADD CONSTRAINT pds_url_key UNIQUE (url);


--
-- Name: prod_func_in_systems prod_func; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.prod_func_in_systems
    ADD CONSTRAINT prod_func UNIQUE (product_id, function_id);


--
-- Name: product_additives product_additives_product_id_additive_id_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_additives
    ADD CONSTRAINT product_additives_product_id_additive_id_key UNIQUE (product_id, additive_id);


--
-- Name: product_binders product_binders_product_id_binder_id_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_binders
    ADD CONSTRAINT product_binders_product_id_binder_id_key UNIQUE (product_id, binder_id);


--
-- Name: product_environments product_environments_product_id_environment_id_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_environments
    ADD CONSTRAINT product_environments_product_id_environment_id_key UNIQUE (product_id, environment_id);


--
-- Name: product_functions product_functions_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_functions
    ADD CONSTRAINT product_functions_pkey PRIMARY KEY (id);


--
-- Name: product_resistances product_resistances_product_id_resistance_id_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_resistances
    ADD CONSTRAINT product_resistances_product_id_resistance_id_key UNIQUE (product_id, resistance_id);


--
-- Name: product_substrates product_substrates_product_id_substrate_id_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_substrates
    ADD CONSTRAINT product_substrates_product_id_substrate_id_key UNIQUE (product_id, substrate_id);


--
-- Name: products products_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_name_key UNIQUE (name);


--
-- Name: products products_name_key1; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_name_key1 UNIQUE (name);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: reports reports_url_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_url_key UNIQUE (url);


--
-- Name: resistances resistances_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.resistances
    ADD CONSTRAINT resistances_name_key UNIQUE (name);


--
-- Name: resistances resistances_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.resistances
    ADD CONSTRAINT resistances_pkey PRIMARY KEY (id);


--
-- Name: standards standards_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.standards
    ADD CONSTRAINT standards_pkey PRIMARY KEY (id);


--
-- Name: substrates substrates_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.substrates
    ADD CONSTRAINT substrates_name_key UNIQUE (name);


--
-- Name: substrates substrates_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.substrates
    ADD CONSTRAINT substrates_pkey PRIMARY KEY (id);


--
-- Name: tsr tsr_email_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.tsr
    ADD CONSTRAINT tsr_email_key UNIQUE (email);


--
-- Name: tsr tsr_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.tsr
    ADD CONSTRAINT tsr_pkey PRIMARY KEY (id);


--
-- Name: used_systems used_systems_project_id_used_system_id_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.used_systems
    ADD CONSTRAINT used_systems_project_id_used_system_id_key UNIQUE (project_id, used_system_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: coating_systems check_catalog_type; Type: TRIGGER; Schema: public; Owner: gb_user
--

CREATE TRIGGER check_catalog_type BEFORE INSERT OR UPDATE OF primer_id, intermediate_id, finish_id ON public.coating_systems FOR EACH ROW EXECUTE FUNCTION public.check_coat_types();


--
-- Name: product_additives additives_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_additives
    ADD CONSTRAINT additives_id_fk FOREIGN KEY (additive_id) REFERENCES public.additives(id);


--
-- Name: product_additives additives_product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_additives
    ADD CONSTRAINT additives_product_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: product_binders binder_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_binders
    ADD CONSTRAINT binder_id_fk FOREIGN KEY (binder_id) REFERENCES public.binders(id);


--
-- Name: product_binders binder_product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_binders
    ADD CONSTRAINT binder_product_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: products brand_name_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT brand_name_id_fk FOREIGN KEY (brand_name_id) REFERENCES public.brands(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: products catalog_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT catalog_id_fk FOREIGN KEY (catalog_id) REFERENCES public.catalogs(id);


--
-- Name: projects contractor_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT contractor_id_fk FOREIGN KEY (contractor_id) REFERENCES public.contractors(id);


--
-- Name: projects customer_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT customer_id_fk FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: product_environments environment_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_environments
    ADD CONSTRAINT environment_id_fk FOREIGN KEY (environment_id) REFERENCES public.environments(id);


--
-- Name: product_environments environment_product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_environments
    ADD CONSTRAINT environment_product_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: coating_systems finish_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.coating_systems
    ADD CONSTRAINT finish_id_fk FOREIGN KEY (finish_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: prod_func_in_systems function_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.prod_func_in_systems
    ADD CONSTRAINT function_id_fk FOREIGN KEY (function_id) REFERENCES public.product_functions(id);


--
-- Name: prod_func_in_systems function_product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.prod_func_in_systems
    ADD CONSTRAINT function_product_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: coating_systems intermediate_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.coating_systems
    ADD CONSTRAINT intermediate_id_fk FOREIGN KEY (intermediate_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: approved_tests lab_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.approved_tests
    ADD CONSTRAINT lab_id_fk FOREIGN KEY (lab_id) REFERENCES public.labs(id);


--
-- Name: coating_systems primer_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.coating_systems
    ADD CONSTRAINT primer_id_fk FOREIGN KEY (primer_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pds product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.pds
    ADD CONSTRAINT product_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: main_technical_data product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.main_technical_data
    ADD CONSTRAINT product_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reports project_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT project_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: product_resistances resistance_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_resistances
    ADD CONSTRAINT resistance_id_fk FOREIGN KEY (resistance_id) REFERENCES public.resistances(id);


--
-- Name: product_resistances resistance_product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_resistances
    ADD CONSTRAINT resistance_product_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: approved_tests standard_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.approved_tests
    ADD CONSTRAINT standard_id_fk FOREIGN KEY (standard_id) REFERENCES public.standards(id);


--
-- Name: product_substrates substrate_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_substrates
    ADD CONSTRAINT substrate_id_fk FOREIGN KEY (substrate_id) REFERENCES public.substrates(id);


--
-- Name: product_substrates substrate_product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.product_substrates
    ADD CONSTRAINT substrate_product_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: approved_tests system_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.approved_tests
    ADD CONSTRAINT system_id_fk FOREIGN KEY (system_id) REFERENCES public.coating_systems(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: used_systems system_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.used_systems
    ADD CONSTRAINT system_id_fk FOREIGN KEY (used_system_id) REFERENCES public.coating_systems(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reports tsr_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT tsr_id_fk FOREIGN KEY (tsr_id) REFERENCES public.tsr(id);


--
-- Name: used_systems used_systems_project_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.used_systems
    ADD CONSTRAINT used_systems_project_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- PostgreSQL database dump complete
--

