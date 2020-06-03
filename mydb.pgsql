--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: blocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blocks (
    id integer NOT NULL,
    blocker_id integer NOT NULL,
    blocked_id integer NOT NULL,
    dateblocked date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.blocks OWNER TO postgres;

--
-- Name: blocks_blocked_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blocks_blocked_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blocks_blocked_id_seq OWNER TO postgres;

--
-- Name: blocks_blocked_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blocks_blocked_id_seq OWNED BY public.blocks.blocked_id;


--
-- Name: blocks_blocker_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blocks_blocker_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blocks_blocker_id_seq OWNER TO postgres;

--
-- Name: blocks_blocker_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blocks_blocker_id_seq OWNED BY public.blocks.blocker_id;


--
-- Name: blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blocks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blocks_id_seq OWNER TO postgres;

--
-- Name: blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blocks_id_seq OWNED BY public.blocks.id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.images (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(40) NOT NULL,
    date_posted date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.images OWNER TO postgres;

--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_id_seq OWNER TO postgres;

--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;


--
-- Name: images_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_user_id_seq OWNER TO postgres;

--
-- Name: images_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.images_user_id_seq OWNED BY public.images.user_id;


--
-- Name: likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.likes (
    id integer NOT NULL,
    image_id integer NOT NULL,
    user_id integer NOT NULL,
    dateliked date DEFAULT CURRENT_DATE NOT NULL,
    type character varying(10) NOT NULL
);


ALTER TABLE public.likes OWNER TO postgres;

--
-- Name: likes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.likes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.likes_id_seq OWNER TO postgres;

--
-- Name: likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.likes_id_seq OWNED BY public.likes.id;


--
-- Name: likes_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.likes_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.likes_image_id_seq OWNER TO postgres;

--
-- Name: likes_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.likes_image_id_seq OWNED BY public.likes.image_id;


--
-- Name: likes_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.likes_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.likes_user_id_seq OWNER TO postgres;

--
-- Name: likes_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.likes_user_id_seq OWNED BY public.likes.user_id;


--
-- Name: logins; Type: TABLE; Schema: public; Owner: home
--

CREATE TABLE public.logins (
    id integer NOT NULL,
    user_id integer NOT NULL,
    validate_string character varying(20),
    dateloggedin date DEFAULT CURRENT_DATE,
    logout boolean DEFAULT false
);


ALTER TABLE public.logins OWNER TO home;

--
-- Name: logins_id_seq; Type: SEQUENCE; Schema: public; Owner: home
--

CREATE SEQUENCE public.logins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logins_id_seq OWNER TO home;

--
-- Name: logins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: home
--

ALTER SEQUENCE public.logins_id_seq OWNED BY public.logins.id;


--
-- Name: logins_user_id_seq; Type: SEQUENCE; Schema: public; Owner: home
--

CREATE SEQUENCE public.logins_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logins_user_id_seq OWNER TO home;

--
-- Name: logins_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: home
--

ALTER SEQUENCE public.logins_user_id_seq OWNED BY public.logins.user_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(40),
    email character varying(80) NOT NULL,
    password character varying(80) NOT NULL,
    datecreated date DEFAULT CURRENT_DATE NOT NULL
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
-- Name: blocks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocks ALTER COLUMN id SET DEFAULT nextval('public.blocks_id_seq'::regclass);


--
-- Name: blocks blocker_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocks ALTER COLUMN blocker_id SET DEFAULT nextval('public.blocks_blocker_id_seq'::regclass);


--
-- Name: blocks blocked_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocks ALTER COLUMN blocked_id SET DEFAULT nextval('public.blocks_blocked_id_seq'::regclass);


--
-- Name: images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);


--
-- Name: images user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images ALTER COLUMN user_id SET DEFAULT nextval('public.images_user_id_seq'::regclass);


--
-- Name: likes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes ALTER COLUMN id SET DEFAULT nextval('public.likes_id_seq'::regclass);


--
-- Name: likes image_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes ALTER COLUMN image_id SET DEFAULT nextval('public.likes_image_id_seq'::regclass);


--
-- Name: likes user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes ALTER COLUMN user_id SET DEFAULT nextval('public.likes_user_id_seq'::regclass);


--
-- Name: logins id; Type: DEFAULT; Schema: public; Owner: home
--

ALTER TABLE ONLY public.logins ALTER COLUMN id SET DEFAULT nextval('public.logins_id_seq'::regclass);


--
-- Name: logins user_id; Type: DEFAULT; Schema: public; Owner: home
--

ALTER TABLE ONLY public.logins ALTER COLUMN user_id SET DEFAULT nextval('public.logins_user_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: blocks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blocks (id, blocker_id, blocked_id, dateblocked) FROM stdin;
\.


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.images (id, user_id, name, date_posted) FROM stdin;
1	1	31.jpg	2020-06-02
2	2	35.jpg	2020-06-02
3	3	45.jpg	2020-06-02
4	4	77.jpg	2020-06-02
5	5	84.jpg	2020-06-02
6	6	87.jpg	2020-06-02
7	7	8.jpg	2020-06-02
8	8	44.jpg	2020-06-02
9	9	82.jpg	2020-06-02
10	10	88.jpg	2020-06-02
\.


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.likes (id, image_id, user_id, dateliked, type) FROM stdin;
\.


--
-- Data for Name: logins; Type: TABLE DATA; Schema: public; Owner: home
--

COPY public.logins (id, user_id, validate_string, dateloggedin, logout) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, datecreated) FROM stdin;
1	Ralph	nec@maurisIntegersem.com	$2b$10$Nl/mKTS6nsiOMdnKFb/RJeCZHR/ilTmV2KcbHF4l6XCGyORrdrYMW	2020-06-02
2	Nicholas	id.mollis.nec@Sednecmetus.org	$2b$10$ibS6n7s8Gp5zRlrLxaxPYOESuqr5ZM1ebbwzqiI8qFspo7IPIirQe	2020-06-02
3	Zane	tempor.augue.ac@Cras.co.uk	$2b$10$NNfbr/wNtVuXCXovKdpzsuIOWkn9.paZj4YOtRoEumxoCy60twWBC	2020-06-02
4	Zephania	neque.pellentesque.massa@anteNuncmauris.co.uk	$2b$10$.iFdVPEV5pvzElzYjZwdaes44Zo7krHUhXtbqMO.JxxYQ1joew8cK	2020-06-02
5	Berk	nec@velit.co.uk	$2b$10$GYXwUsE0N.bwAQOA93GAluRxbtLhP2zjdWE3Fx6Uw9C4DAlsXBFDO	2020-06-02
6	Jenna	ipsum.primis.in@aliquetlobortis.org	$2b$10$CoPwq.g9tioDK9IU0hqzTOvNBeYye/IHyF6NOYfgBVKp4G5YMk4/a	2020-06-02
7	Melodie	lorem.ac.risus@lorem.edu	$2b$10$w84RHCczX3QNNrGwo4jANuZS93uXu7UhaumkCPCoYY3PrCO4ckuQq	2020-06-02
8	Iona	magnis.dis.parturient@dui.co.uk	$2b$10$tUPAwV2MMDv6VQyimfzkPu5G9YCLg81sVyxHwoNz/JgmPp/Z/81j.	2020-06-02
9	Maisie	nisi.Cum@ligulaDonecluctus.co.uk	$2b$10$UzcDPCxoNPadfW34fRdRXONu1HRaxwcGUKvekJFR5w5nKizL2X8s.	2020-06-02
10	Hedwig	tristique.aliquet@tristiquealiquetPhasellus.net	$2b$10$K0zjup2/ZwJ/7qluYwFN6OH97N3U8u.sLOJjv.fzwUx4SqK6ctKoS	2020-06-02
11	lorem	lorem@ipsum.com	$2b$10$pA92LGL4/aAtV/0NgsLKeOkAfZPJDg83GhqbPHtQFncP4O185PAXC	2020-06-03
12		carl@gmail.com	$2b$10$S06L87Z5ilOy2zZu1vROhuZqnB5fyxK.6EDM4I.VjS1EABZyI/gve	2020-06-03
\.


--
-- Name: blocks_blocked_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blocks_blocked_id_seq', 1, false);


--
-- Name: blocks_blocker_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blocks_blocker_id_seq', 1, false);


--
-- Name: blocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blocks_id_seq', 1, true);


--
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.images_id_seq', 10, true);


--
-- Name: images_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.images_user_id_seq', 1, false);


--
-- Name: likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.likes_id_seq', 9, true);


--
-- Name: likes_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.likes_image_id_seq', 1, false);


--
-- Name: likes_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.likes_user_id_seq', 1, false);


--
-- Name: logins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: home
--

SELECT pg_catalog.setval('public.logins_id_seq', 4, true);


--
-- Name: logins_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: home
--

SELECT pg_catalog.setval('public.logins_user_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 12, true);


--
-- Name: blocks blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (id);


--
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: likes likes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);


--
-- Name: logins logins_pkey; Type: CONSTRAINT; Schema: public; Owner: home
--

ALTER TABLE ONLY public.logins
    ADD CONSTRAINT logins_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: blocks blocks_blocked_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT blocks_blocked_id_fkey FOREIGN KEY (blocked_id) REFERENCES public.users(id);


--
-- Name: blocks blocks_blocker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT blocks_blocker_id_fkey FOREIGN KEY (blocker_id) REFERENCES public.users(id);


--
-- Name: images images_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: likes likes_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.images(id);


--
-- Name: likes likes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: logins logins_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: home
--

ALTER TABLE ONLY public.logins
    ADD CONSTRAINT logins_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

