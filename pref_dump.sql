--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

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

DROP DATABASE IF EXISTS postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: countries; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA countries;


ALTER SCHEMA countries OWNER TO postgres;

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: countries; Type: TABLE; Schema: countries; Owner: postgres
--

CREATE TABLE countries.countries (
    name character varying(100)
);


ALTER TABLE countries.countries OWNER TO postgres;

--
-- Name: hand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hand (
    id integer NOT NULL,
    game_id integer NOT NULL,
    licitacija character varying(50),
    status character varying(50)
);


ALTER TABLE public.hand OWNER TO postgres;

--
-- Name: Hand_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Hand_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Hand_id_seq" OWNER TO postgres;

--
-- Name: Hand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Hand_id_seq" OWNED BY public.hand.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(200) NOT NULL,
    email character varying(200) NOT NULL,
    password character varying(200) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    last_login timestamp with time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: Players_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Players_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Players_id_seq" OWNER TO postgres;

--
-- Name: Players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Players_id_seq" OWNED BY public.users.id;


--
-- Name: buli; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buli (
    user_id integer NOT NULL,
    game_id integer NOT NULL,
    value integer NOT NULL
);


ALTER TABLE public.buli OWNER TO postgres;

--
-- Name: cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cards (
    id integer NOT NULL,
    number integer NOT NULL,
    sign character varying(20),
    color character varying(20)
);


ALTER TABLE public.cards OWNER TO postgres;

--
-- Name: cards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cards_id_seq OWNER TO postgres;

--
-- Name: cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cards_id_seq OWNED BY public.cards.id;


--
-- Name: game_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_status (
    name character varying(50) NOT NULL
);


ALTER TABLE public.game_status OWNER TO postgres;

--
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    started_at timestamp with time zone,
    completed_at timestamp with time zone,
    status character varying(50),
    admin integer NOT NULL,
    player1 integer,
    player2 integer,
    current_hand integer,
    hand_number integer DEFAULT 0
);


ALTER TABLE public.games OWNER TO postgres;

--
-- Name: games_hands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_hands (
    games_id integer NOT NULL,
    hand_id integer NOT NULL,
    hand_number integer
);


ALTER TABLE public.games_hands OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_id_seq OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_id_seq OWNED BY public.games.id;


--
-- Name: hand_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hand_status (
    name character varying(50) NOT NULL
);


ALTER TABLE public.hand_status OWNER TO postgres;

--
-- Name: licitacija_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.licitacija_status (
    name character varying(30) NOT NULL
);


ALTER TABLE public.licitacija_status OWNER TO postgres;

--
-- Name: licitacije; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.licitacije (
    id integer NOT NULL,
    status character varying NOT NULL,
    igra boolean DEFAULT false NOT NULL
);


ALTER TABLE public.licitacije OWNER TO postgres;

--
-- Name: licitacije_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.licitacije_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.licitacije_id_seq OWNER TO postgres;

--
-- Name: licitacije_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.licitacije_id_seq OWNED BY public.licitacije.id;


--
-- Name: player_deck; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_deck (
    user_id integer NOT NULL,
    hand_id integer NOT NULL,
    card_id integer NOT NULL,
    used boolean DEFAULT false NOT NULL
);


ALTER TABLE public.player_deck OWNER TO postgres;

--
-- Name: player_move; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_move (
    user_id integer NOT NULL,
    hand_id integer NOT NULL,
    card_id integer NOT NULL,
    number integer NOT NULL
);


ALTER TABLE public.player_move OWNER TO postgres;

--
-- Name: results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.results (
    user_id integer NOT NULL,
    game_id integer NOT NULL,
    buli integer NOT NULL,
    supa integer NOT NULL
);


ALTER TABLE public.results OWNER TO postgres;

--
-- Name: table_deck; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.table_deck (
    hand_id integer NOT NULL,
    card_id integer NOT NULL
);


ALTER TABLE public.table_deck OWNER TO postgres;

--
-- Name: cards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards ALTER COLUMN id SET DEFAULT nextval('public.cards_id_seq'::regclass);


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Name: hand id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hand ALTER COLUMN id SET DEFAULT nextval('public."Hand_id_seq"'::regclass);


--
-- Name: licitacije id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licitacije ALTER COLUMN id SET DEFAULT nextval('public.licitacije_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public."Players_id_seq"'::regclass);


--
-- Data for Name: countries; Type: TABLE DATA; Schema: countries; Owner: postgres
--

COPY countries.countries (name) FROM stdin;
\.


--
-- Data for Name: buli; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buli (user_id, game_id, value) FROM stdin;
\.


--
-- Data for Name: cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cards (id, number, sign, color) FROM stdin;
1	1	pik	black
2	2	pik	black
3	3	pik	black
4	4	pik	black
5	5	pik	black
6	6	pik	black
7	7	pik	black
8	8	pik	black
9	9	pik	black
10	10	pik	black
11	12	pik	black
12	13	pik	black
13	14	pik	black
14	1	karo	red
15	2	karo	red
16	3	karo	red
17	4	karo	red
18	5	karo	red
19	6	karo	red
20	7	karo	red
21	8	karo	red
22	9	karo	red
23	10	karo	red
24	12	karo	red
25	13	karo	red
26	14	karo	red
27	1	herc	red
28	2	herc	red
29	3	herc	red
30	4	herc	red
31	5	herc	red
32	6	herc	red
33	7	herc	red
34	8	herc	red
35	9	herc	red
36	10	herc	red
37	12	herc	red
38	13	herc	red
39	14	herc	red
40	1	tref	black
41	2	tref	black
42	3	tref	black
43	4	tref	black
44	5	tref	black
45	6	tref	black
46	7	tref	black
47	8	tref	black
48	9	tref	black
49	10	tref	black
50	12	tref	black
51	13	tref	black
52	14	tref	black
\.


--
-- Data for Name: game_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_status (name) FROM stdin;
created
started
paused
resumed
finished
aborted
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games (id, created_at, started_at, completed_at, status, admin, player1, player2, current_hand, hand_number) FROM stdin;
31	2023-04-20 15:39:18.695+02	\N	\N	created	1	\N	\N	\N	0
32	2023-04-20 15:40:14.982+02	\N	\N	created	1	\N	\N	\N	0
33	2023-04-20 15:40:37.021+02	\N	\N	created	1	\N	\N	\N	0
34	2023-04-20 15:42:44.268+02	\N	\N	created	5	1	2	\N	0
\.


--
-- Data for Name: games_hands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games_hands (games_id, hand_id, hand_number) FROM stdin;
\.


--
-- Data for Name: hand; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hand (id, game_id, licitacija, status) FROM stdin;
\.


--
-- Data for Name: hand_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hand_status (name) FROM stdin;
licitation
dealt
over
\.


--
-- Data for Name: licitacija_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.licitacija_status (name) FROM stdin;
dva-pik
tri-karo
cetiri-herc
pet-tref
sest-betl
sedam-sans
none
\.


--
-- Data for Name: licitacije; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.licitacije (id, status, igra) FROM stdin;
\.


--
-- Data for Name: player_deck; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_deck (user_id, hand_id, card_id, used) FROM stdin;
\.


--
-- Data for Name: player_move; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_move (user_id, hand_id, card_id, number) FROM stdin;
\.


--
-- Data for Name: results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.results (user_id, game_id, buli, supa) FROM stdin;
\.


--
-- Data for Name: table_deck; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.table_deck (hand_id, card_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password, created_at, last_login) FROM stdin;
1	test	test@test.com	admin	2023-03-31 02:00:00+02	2023-03-31 02:00:00+02
2	test2	test2@test.com	admin2	2023-04-06 02:00:00+02	2023-04-06 02:00:00+02
3	test3	test3@test.com	admin3	2023-04-06 02:00:00+02	2023-04-06 02:00:00+02
5	admin	admin@admin.com	admin	2023-04-20 17:32:08.149+02	2023-04-20 17:32:10.191+02
\.


--
-- Name: Hand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Hand_id_seq"', 1, false);


--
-- Name: Players_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Players_id_seq"', 5, true);


--
-- Name: cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cards_id_seq', 52, true);


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.games_id_seq', 34, true);


--
-- Name: licitacije_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.licitacije_id_seq', 1, false);


--
-- Name: buli Buli_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buli
    ADD CONSTRAINT "Buli_pk" PRIMARY KEY (user_id, game_id);


--
-- Name: hand Hand_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hand
    ADD CONSTRAINT "Hand_pk" PRIMARY KEY (id);


--
-- Name: users Players_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "Players_pk" PRIMARY KEY (id);


--
-- Name: results Results_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT "Results_pk" PRIMARY KEY (user_id, game_id);


--
-- Name: cards cards_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_pk PRIMARY KEY (id);


--
-- Name: users email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT email_unique UNIQUE (email);


--
-- Name: game_status game_statuses_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_status
    ADD CONSTRAINT game_statuses_pk PRIMARY KEY (name);


--
-- Name: games_hands games_hands_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_hands
    ADD CONSTRAINT games_hands_pk PRIMARY KEY (hand_id, games_id);


--
-- Name: games games_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pk PRIMARY KEY (id);


--
-- Name: hand_status hand_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hand_status
    ADD CONSTRAINT hand_status_pk PRIMARY KEY (name);


--
-- Name: licitacija_status licitacija_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licitacija_status
    ADD CONSTRAINT licitacija_pk PRIMARY KEY (name);


--
-- Name: licitacije licitacije_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licitacije
    ADD CONSTRAINT licitacije_pk PRIMARY KEY (id);


--
-- Name: player_deck player_deck_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_deck
    ADD CONSTRAINT player_deck_pk PRIMARY KEY (user_id, hand_id, card_id);


--
-- Name: player_move player_move_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_move
    ADD CONSTRAINT player_move_pk PRIMARY KEY (user_id, card_id, hand_id);


--
-- Name: table_deck table_deck_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.table_deck
    ADD CONSTRAINT table_deck_pk PRIMARY KEY (hand_id, card_id);


--
-- Name: users username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT username_unique UNIQUE (username);


--
-- Name: buli Buli_games_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buli
    ADD CONSTRAINT "Buli_games_null_fk" FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: buli Buli_users_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buli
    ADD CONSTRAINT "Buli_users_null_fk" FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: hand Hand_games_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hand
    ADD CONSTRAINT "Hand_games_fk" FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: results Results_games_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT "Results_games_null_fk" FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: results Results_users_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT "Results_users_null_fk" FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: games games_game_statuses_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_game_statuses_null_fk FOREIGN KEY (status) REFERENCES public.game_status(name);


--
-- Name: games games_hand_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_hand_null_fk FOREIGN KEY (current_hand) REFERENCES public.hand(id);


--
-- Name: games_hands games_hands_games_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_hands
    ADD CONSTRAINT games_hands_games_null_fk FOREIGN KEY (games_id) REFERENCES public.games(id);


--
-- Name: games_hands games_hands_hand_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_hands
    ADD CONSTRAINT games_hands_hand_null_fk FOREIGN KEY (hand_id) REFERENCES public.hand(id);


--
-- Name: games games_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_users_id_fk FOREIGN KEY (player1) REFERENCES public.users(id);


--
-- Name: games games_users_id_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_users_id_fk_2 FOREIGN KEY (player2) REFERENCES public.users(id);


--
-- Name: games games_users_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_users_null_fk FOREIGN KEY (admin) REFERENCES public.users(id);


--
-- Name: hand hand_hand_status_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hand
    ADD CONSTRAINT hand_hand_status_null_fk FOREIGN KEY (status) REFERENCES public.hand_status(name);


--
-- Name: licitacije licitacije_licitacija_status_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licitacije
    ADD CONSTRAINT licitacije_licitacija_status_null_fk FOREIGN KEY (status) REFERENCES public.licitacija_status(name);


--
-- Name: player_deck player_deck_cards_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_deck
    ADD CONSTRAINT player_deck_cards_null_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: player_deck player_deck_hand_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_deck
    ADD CONSTRAINT player_deck_hand_null_fk FOREIGN KEY (hand_id) REFERENCES public.hand(id);


--
-- Name: player_deck player_deck_users_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_deck
    ADD CONSTRAINT player_deck_users_null_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: player_move player_move_cards_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_move
    ADD CONSTRAINT player_move_cards_null_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: player_move player_move_hand_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_move
    ADD CONSTRAINT player_move_hand_fk FOREIGN KEY (hand_id) REFERENCES public.hand(id);


--
-- Name: player_move player_move_users_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_move
    ADD CONSTRAINT player_move_users_null_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

