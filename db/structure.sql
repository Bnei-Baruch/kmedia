--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

--
-- Name: catalog_descriptions_catnodedescid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE catalog_descriptions_catnodedescid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: catalog_descriptions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE catalog_descriptions (
    id integer DEFAULT nextval('catalog_descriptions_catnodedescid_seq'::regclass) NOT NULL,
    catalog_id integer DEFAULT 0 NOT NULL,
    name character varying(255),
    lang character(3),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: catalogs_catalognodeid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE catalogs_catalognodeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: catalogs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE catalogs (
    id integer DEFAULT nextval('catalogs_catalognodeid_seq'::regclass) NOT NULL,
    name character varying(100) DEFAULT ''::character varying NOT NULL,
    parent_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    catorder integer DEFAULT 999 NOT NULL,
    secure integer DEFAULT 0 NOT NULL,
    visible boolean DEFAULT true,
    open boolean DEFAULT true,
    label character varying(255),
    selected_catalog integer,
    user_id integer,
    books_catalog boolean
);


--
-- Name: catalogs_container_description_patterns; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE catalogs_container_description_patterns (
    container_description_pattern_id integer,
    catalog_id integer
);


--
-- Name: catalogs_containers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE catalogs_containers (
    catalog_id integer DEFAULT 0 NOT NULL,
    container_id integer DEFAULT 0 NOT NULL
);


--
-- Name: ckeditor_assets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ckeditor_assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ckeditor_assets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ckeditor_assets (
    id integer DEFAULT nextval('ckeditor_assets_id_seq'::regclass) NOT NULL,
    data_file_name character varying(255) NOT NULL,
    data_content_type character varying(255),
    data_file_size integer,
    assetable_id integer,
    assetable_type character varying(30),
    type character varying(30),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer DEFAULT nextval('comments_id_seq'::regclass) NOT NULL,
    name character varying(255),
    email character varying(255),
    subject character varying(255),
    comment text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: container_creation_patterns; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE container_creation_patterns (
    id integer NOT NULL,
    pattern character varying(255),
    result character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: container_creation_patterns_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE container_creation_patterns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: container_creation_patterns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE container_creation_patterns_id_seq OWNED BY container_creation_patterns.id;


--
-- Name: container_description_patterns_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE container_description_patterns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: container_description_patterns; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE container_description_patterns (
    id integer DEFAULT nextval('container_description_patterns_id_seq'::regclass) NOT NULL,
    pattern character varying(255),
    description character varying(255),
    lang character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: container_descriptions_lessondescid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE container_descriptions_lessondescid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: container_descriptions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE container_descriptions (
    id integer DEFAULT nextval('container_descriptions_lessondescid_seq'::regclass) NOT NULL,
    container_id integer DEFAULT 0 NOT NULL,
    container_desc character varying(255),
    lang character(3),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    descr text
);


--
-- Name: container_transcripts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE container_transcripts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: container_transcripts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE container_transcripts (
    id integer DEFAULT nextval('container_transcripts_id_seq'::regclass) NOT NULL,
    container_id integer,
    toc character varying(255),
    transcript text,
    lang character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: containers_lessonid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE containers_lessonid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: containers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE containers (
    id integer DEFAULT nextval('containers_lessonid_seq'::regclass) NOT NULL,
    name character varying(100),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    filmdate date,
    lang character(3),
    lecturer_id integer,
    secure integer DEFAULT 0 NOT NULL,
    content_type_id integer,
    marked_for_merge boolean,
    secure_changed boolean DEFAULT false,
    auto_parsed boolean DEFAULT false,
    virtual_lesson_id integer,
    playtime_secs integer,
    user_id integer,
    for_censorship boolean DEFAULT false,
    opened_by_censor boolean DEFAULT false,
    closed_by_censor boolean DEFAULT false,
    censor_id integer,
    "position" integer
);


--
-- Name: containers_file_assets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE containers_file_assets (
    container_id integer DEFAULT 0 NOT NULL,
    file_asset_id integer DEFAULT 0 NOT NULL
);


--
-- Name: containers_labels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE containers_labels (
    label_id integer NOT NULL,
    container_id integer NOT NULL
);


--
-- Name: content_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE content_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: content_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE content_types (
    id integer DEFAULT nextval('content_types_id_seq'::regclass) NOT NULL,
    name character varying(255),
    pattern character varying(255),
    secure integer DEFAULT 0
);


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delayed_jobs (
    id integer DEFAULT nextval('delayed_jobs_id_seq'::regclass) NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    handler text NOT NULL,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    queue character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE departments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE departments (
    id integer DEFAULT nextval('departments_id_seq'::regclass) NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: dictionaries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dictionaries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dictionaries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dictionaries (
    id integer DEFAULT nextval('dictionaries_id_seq'::regclass) NOT NULL,
    suid character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: dictionary_descriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dictionary_descriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dictionary_descriptions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dictionary_descriptions (
    id integer DEFAULT nextval('dictionary_descriptions_id_seq'::regclass) NOT NULL,
    dictionary_id integer,
    topic character varying(255),
    lang character varying(3) DEFAULT 'HEB'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: file_asset_descriptions_filedescid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE file_asset_descriptions_filedescid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: file_asset_descriptions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE file_asset_descriptions (
    id integer DEFAULT nextval('file_asset_descriptions_filedescid_seq'::regclass) NOT NULL,
    file_id integer DEFAULT 0 NOT NULL,
    filedesc character varying(255),
    lang character(3),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: file_assets_fileid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE file_assets_fileid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: file_assets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE file_assets (
    id integer DEFAULT nextval('file_assets_fileid_seq'::regclass) NOT NULL,
    name character varying(150),
    lang character(3),
    asset_type character varying(10),
    date timestamp without time zone,
    size integer,
    servername character varying(30) DEFAULT 'DEFAULT'::character varying,
    status character varying(10),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    lastuser character varying(7),
    clicks integer DEFAULT 0,
    secure integer DEFAULT 0,
    playtime_secs integer,
    user_id integer
);


--
-- Name: file_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE file_types (
    name character varying(20) DEFAULT ''::character varying NOT NULL,
    extlist character varying(255),
    pic character varying(20)
);


--
-- Name: label_descriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE label_descriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: label_descriptions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE label_descriptions (
    id integer DEFAULT nextval('label_descriptions_id_seq'::regclass) NOT NULL,
    label_id integer,
    text character varying(255),
    lang character varying(3) DEFAULT 'HEB'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: labels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE labels (
    id integer NOT NULL,
    dictionary_id integer,
    suid character varying(20),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: labels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE labels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE labels_id_seq OWNED BY labels.id;


--
-- Name: languages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE languages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: languages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE languages (
    id integer DEFAULT nextval('languages_id_seq'::regclass) NOT NULL,
    locale character varying(255),
    code3 character varying(255),
    language character varying(255)
);


--
-- Name: lecturer_descriptions_lecturerdescid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lecturer_descriptions_lecturerdescid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lecturer_descriptions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lecturer_descriptions (
    id integer DEFAULT nextval('lecturer_descriptions_lecturerdescid_seq'::regclass) NOT NULL,
    lecturer_id integer DEFAULT 0 NOT NULL,
    "desc" character(100) DEFAULT ''::character(1) NOT NULL,
    lang character(3) DEFAULT ''::character(1) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: lecturers_lecturerid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lecturers_lecturerid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lecturers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lecturers (
    id integer DEFAULT nextval('lecturers_lecturerid_seq'::regclass) NOT NULL,
    name character(100) DEFAULT ''::character(1) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    ordnum integer DEFAULT 0 NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer DEFAULT nextval('roles_id_seq'::regclass) NOT NULL,
    name character varying(255),
    description character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: roles_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles_users (
    role_id integer,
    user_id integer
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: servers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE servers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: servers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE servers (
    servername character varying(30) DEFAULT ''::character varying NOT NULL,
    httpurl character varying(255),
    created timestamp without time zone,
    updated timestamp without time zone,
    lastuser character varying(16),
    path character varying(255),
    id integer DEFAULT nextval('servers_id_seq'::regclass) NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer DEFAULT nextval('users_id_seq'::regclass) NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(128) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    first_name character varying(255) DEFAULT ''::character varying,
    last_name character varying(255) DEFAULT ''::character varying,
    authentication_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    department_id integer
);


--
-- Name: virtual_lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE virtual_lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: virtual_lessons; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE virtual_lessons (
    id integer DEFAULT nextval('virtual_lessons_id_seq'::regclass) NOT NULL,
    film_date date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY container_creation_patterns ALTER COLUMN id SET DEFAULT nextval('container_creation_patterns_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY labels ALTER COLUMN id SET DEFAULT nextval('labels_id_seq'::regclass);


--
-- Name: catalognode_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY catalogs
    ADD CONSTRAINT catalognode_pkey PRIMARY KEY (id);


--
-- Name: catnodedesc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY catalog_descriptions
    ADD CONSTRAINT catnodedesc_pkey PRIMARY KEY (id);


--
-- Name: catnodelessons_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY catalogs_containers
    ADD CONSTRAINT catnodelessons_pkey PRIMARY KEY (catalog_id, container_id);


--
-- Name: ckeditor_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ckeditor_assets
    ADD CONSTRAINT ckeditor_assets_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: container_creation_patterns_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY container_creation_patterns
    ADD CONSTRAINT container_creation_patterns_pkey PRIMARY KEY (id);


--
-- Name: content_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY content_types
    ADD CONSTRAINT content_types_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: departments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: dictionaries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dictionaries
    ADD CONSTRAINT dictionaries_pkey PRIMARY KEY (id);


--
-- Name: dictionary_descriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dictionary_descriptions
    ADD CONSTRAINT dictionary_descriptions_pkey PRIMARY KEY (id);


--
-- Name: filedesc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY file_asset_descriptions
    ADD CONSTRAINT filedesc_pkey PRIMARY KEY (id);


--
-- Name: files_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY file_assets
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: filetypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY file_types
    ADD CONSTRAINT filetypes_pkey PRIMARY KEY (name);


--
-- Name: label_descriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY label_descriptions
    ADD CONSTRAINT label_descriptions_pkey PRIMARY KEY (id);


--
-- Name: labels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY labels
    ADD CONSTRAINT labels_pkey PRIMARY KEY (id);


--
-- Name: languages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- Name: lecturer_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lecturers
    ADD CONSTRAINT lecturer_pkey PRIMARY KEY (id);


--
-- Name: lecturerdesc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lecturer_descriptions
    ADD CONSTRAINT lecturerdesc_pkey PRIMARY KEY (id);


--
-- Name: lesson_transcripts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY container_transcripts
    ADD CONSTRAINT lesson_transcripts_pkey PRIMARY KEY (id);


--
-- Name: lessondesc_patterns_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY container_description_patterns
    ADD CONSTRAINT lessondesc_patterns_pkey PRIMARY KEY (id);


--
-- Name: lessondesc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY container_descriptions
    ADD CONSTRAINT lessondesc_pkey PRIMARY KEY (id);


--
-- Name: lessonfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY containers_file_assets
    ADD CONSTRAINT lessonfiles_pkey PRIMARY KEY (container_id, file_asset_id);


--
-- Name: lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY containers
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: servers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY servers
    ADD CONSTRAINT servers_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: virtual_lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY virtual_lessons
    ADD CONSTRAINT virtual_lessons_pkey PRIMARY KEY (id);


--
-- Name: catalognodeid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX catalognodeid ON catalog_descriptions USING btree (catalog_id);


--
-- Name: cnd_name_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX cnd_name_idx ON catalog_descriptions USING btree (name);


--
-- Name: cnnamepid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX cnnamepid ON catalogs USING btree (name, parent_id);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: fd_name_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fd_name_idx ON file_asset_descriptions USING btree (filedesc);


--
-- Name: fileid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fileid ON file_asset_descriptions USING btree (file_id);


--
-- Name: filename; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX filename ON file_assets USING btree (name);


--
-- Name: idx_ckeditor_assetable; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_ckeditor_assetable ON ckeditor_assets USING btree (assetable_type, assetable_id);


--
-- Name: idx_ckeditor_assetable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_ckeditor_assetable_type ON ckeditor_assets USING btree (assetable_type, type, assetable_id);


--
-- Name: index_catnodelessons_on_lessonid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_catnodelessons_on_lessonid ON catalogs_containers USING btree (container_id);


--
-- Name: index_labels_lessons_on_label_id_and_lesson_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_labels_lessons_on_label_id_and_lesson_id ON containers_labels USING btree (label_id, container_id);


--
-- Name: index_labels_lessons_on_lesson_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_labels_lessons_on_lesson_id ON containers_labels USING btree (container_id);


--
-- Name: index_lessons_on_virtual_lesson_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_lessons_on_virtual_lesson_id ON containers USING btree (virtual_lesson_id);


--
-- Name: index_servers_on_servername; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_servers_on_servername ON servers USING btree (servername);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: ld_name_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX ld_name_idx ON container_descriptions USING btree (container_desc);


--
-- Name: lecturerid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX lecturerid ON lecturer_descriptions USING btree (lecturer_id, lang);


--
-- Name: lessondateidx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX lessondateidx ON containers USING btree (filmdate);


--
-- Name: lessonid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX lessonid ON container_descriptions USING btree (container_id);


--
-- Name: lessonlangidx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX lessonlangidx ON containers USING btree (lang);


--
-- Name: lessonname; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX lessonname ON containers USING btree (name);


--
-- Name: lessonnameidx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX lessonnameidx ON containers USING btree (name);


--
-- Name: parentnodeid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX parentnodeid ON catalogs USING btree (parent_id);


--
-- Name: servername; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX servername ON file_assets USING btree (servername);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: updated; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated ON file_assets USING btree (updated_at);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20100101000000');

INSERT INTO schema_migrations (version) VALUES ('20110310095455');

INSERT INTO schema_migrations (version) VALUES ('20110322081527');

INSERT INTO schema_migrations (version) VALUES ('20110403094043');

INSERT INTO schema_migrations (version) VALUES ('20110403102720');

INSERT INTO schema_migrations (version) VALUES ('20110403102831');

INSERT INTO schema_migrations (version) VALUES ('20110410132936');

INSERT INTO schema_migrations (version) VALUES ('20110411082602');

INSERT INTO schema_migrations (version) VALUES ('20110411085856');

INSERT INTO schema_migrations (version) VALUES ('20110412094822');

INSERT INTO schema_migrations (version) VALUES ('20110413070403');

INSERT INTO schema_migrations (version) VALUES ('20110501142819');

INSERT INTO schema_migrations (version) VALUES ('20110529144428');

INSERT INTO schema_migrations (version) VALUES ('20110907140500');

INSERT INTO schema_migrations (version) VALUES ('20120129152039');

INSERT INTO schema_migrations (version) VALUES ('20120129155236');

INSERT INTO schema_migrations (version) VALUES ('20120224182559');

INSERT INTO schema_migrations (version) VALUES ('20120225083015');

INSERT INTO schema_migrations (version) VALUES ('20120226090927');

INSERT INTO schema_migrations (version) VALUES ('20120228080706');

INSERT INTO schema_migrations (version) VALUES ('20120228145528');

INSERT INTO schema_migrations (version) VALUES ('20120228160046');

INSERT INTO schema_migrations (version) VALUES ('20120302115434');

INSERT INTO schema_migrations (version) VALUES ('20120304101228');

INSERT INTO schema_migrations (version) VALUES ('20120305050019');

INSERT INTO schema_migrations (version) VALUES ('20120305050129');

INSERT INTO schema_migrations (version) VALUES ('20120316095501');

INSERT INTO schema_migrations (version) VALUES ('20120316102250');

INSERT INTO schema_migrations (version) VALUES ('20120401124528');

INSERT INTO schema_migrations (version) VALUES ('20120405142755');

INSERT INTO schema_migrations (version) VALUES ('20120415184654');

INSERT INTO schema_migrations (version) VALUES ('20120503083818');

INSERT INTO schema_migrations (version) VALUES ('20120513100454');

INSERT INTO schema_migrations (version) VALUES ('20120513133127');

INSERT INTO schema_migrations (version) VALUES ('20120606103723');

INSERT INTO schema_migrations (version) VALUES ('20120725132233');

INSERT INTO schema_migrations (version) VALUES ('20120802043344');

INSERT INTO schema_migrations (version) VALUES ('20120808160946');

INSERT INTO schema_migrations (version) VALUES ('20120908081052');

INSERT INTO schema_migrations (version) VALUES ('20121029073721');

INSERT INTO schema_migrations (version) VALUES ('20121122094357');

INSERT INTO schema_migrations (version) VALUES ('20121216085823');

INSERT INTO schema_migrations (version) VALUES ('20121216092634');

INSERT INTO schema_migrations (version) VALUES ('20130127123443');

INSERT INTO schema_migrations (version) VALUES ('20130127154919');

INSERT INTO schema_migrations (version) VALUES ('20130210100112');

INSERT INTO schema_migrations (version) VALUES ('20130217145626');

INSERT INTO schema_migrations (version) VALUES ('20130315014404');

INSERT INTO schema_migrations (version) VALUES ('20130319105613');

INSERT INTO schema_migrations (version) VALUES ('20130407101437');

INSERT INTO schema_migrations (version) VALUES ('20130418110439');

INSERT INTO schema_migrations (version) VALUES ('20130425100231');

INSERT INTO schema_migrations (version) VALUES ('20130507113905');

INSERT INTO schema_migrations (version) VALUES ('20130531011056');

INSERT INTO schema_migrations (version) VALUES ('20130702135827');

INSERT INTO schema_migrations (version) VALUES ('20130707065943');

INSERT INTO schema_migrations (version) VALUES ('20140101030058');

INSERT INTO schema_migrations (version) VALUES ('20140425024109');

INSERT INTO schema_migrations (version) VALUES ('20140509012903');

INSERT INTO schema_migrations (version) VALUES ('20140512023928');

INSERT INTO schema_migrations (version) VALUES ('20140516014828');

INSERT INTO schema_migrations (version) VALUES ('20140516015444');

INSERT INTO schema_migrations (version) VALUES ('20140519015703');

INSERT INTO schema_migrations (version) VALUES ('20140624074848');

INSERT INTO schema_migrations (version) VALUES ('20141006000735');

INSERT INTO schema_migrations (version) VALUES ('20141006001254');

INSERT INTO schema_migrations (version) VALUES ('20141026130113');