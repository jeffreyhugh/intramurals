--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
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

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: pgsodium; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pgsodium;


ALTER SCHEMA pgsodium OWNER TO postgres;

--
-- Name: pgsodium; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgsodium WITH SCHEMA pgsodium;


--
-- Name: EXTENSION pgsodium; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgsodium IS 'Pgsodium is a modern cryptography library for Postgres.';


--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA extensions;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA extensions;


--
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat access method';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  schema_is_cron bool;
BEGIN
  schema_is_cron = (
    SELECT n.nspname = 'cron'
    FROM pg_event_trigger_ddl_commands() AS ev
    LEFT JOIN pg_catalog.pg_namespace AS n
      ON ev.objid = n.oid
  );

  IF schema_is_cron
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;

  END IF;

END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: postgres
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    RAISE WARNING 'PgBouncer auth request: %', p_usename;

    RETURN QUERY
    SELECT usename::TEXT, passwd::TEXT FROM pg_catalog.pg_shadow
    WHERE usename = p_usename;
END;
$$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO postgres;

--
-- Name: add_captain_membership(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_captain_membership() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO 
    team_memberships (team_id, user_id)
  VALUES
    (new.id, new.captain_id);
  RETURN new;
END;
$$;


ALTER FUNCTION public.add_captain_membership() OWNER TO postgres;

--
-- Name: create_metadata(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_metadata() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
begin
  insert into public.user_metadata (id, student_id, first_name)
  values (new.id, '101xxxxxx', 'ChangeMe');
  return new;
end;
$$;


ALTER FUNCTION public.create_metadata() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: user_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_metadata (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    student_id text NOT NULL,
    first_name text NOT NULL,
    last_name text,
    pfp_url text,
    wins bigint,
    loses bigint,
    ties bigint
);


ALTER TABLE public.user_metadata OWNER TO postgres;

--
-- Name: users_without_team(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.users_without_team(e_id uuid) RETURNS SETOF public.user_metadata
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
    SELECT u.*
    FROM user_metadata u
    LEFT JOIN team_memberships tm ON u.id = tm.user_id
    LEFT JOIN teams t ON tm.team_id = t.id AND t.event_id = e_id
    WHERE t.id IS NULL;
END;
$$;


ALTER FUNCTION public.users_without_team(e_id uuid) OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
    declare
        -- Regclass of the table e.g. public.notes
        entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

        -- I, U, D, T: insert, update ...
        action realtime.action = (
            case wal ->> 'action'
                when 'I' then 'INSERT'
                when 'U' then 'UPDATE'
                when 'D' then 'DELETE'
                else 'ERROR'
            end
        );

        -- Is row level security enabled for the table
        is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

        subscriptions realtime.subscription[] = array_agg(subs)
            from
                realtime.subscription subs
            where
                subs.entity = entity_;

        -- Subscription vars
        roles regrole[] = array_agg(distinct us.claims_role)
            from
                unnest(subscriptions) us;

        working_role regrole;
        claimed_role regrole;
        claims jsonb;

        subscription_id uuid;
        subscription_has_access bool;
        visible_to_subscription_ids uuid[] = '{}';

        -- structured info for wal's columns
        columns realtime.wal_column[];
        -- previous identity values for update/delete
        old_columns realtime.wal_column[];

        error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

        -- Primary jsonb output for record
        output jsonb;

    begin
        perform set_config('role', null, true);

        columns =
            array_agg(
                (
                    x->>'name',
                    x->>'type',
                    x->>'typeoid',
                    realtime.cast(
                        (x->'value') #>> '{}',
                        coalesce(
                            (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                            (x->>'type')::regtype
                        )
                    ),
                    (pks ->> 'name') is not null,
                    true
                )::realtime.wal_column
            )
            from
                jsonb_array_elements(wal -> 'columns') x
                left join jsonb_array_elements(wal -> 'pk') pks
                    on (x ->> 'name') = (pks ->> 'name');

        old_columns =
            array_agg(
                (
                    x->>'name',
                    x->>'type',
                    x->>'typeoid',
                    realtime.cast(
                        (x->'value') #>> '{}',
                        coalesce(
                            (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                            (x->>'type')::regtype
                        )
                    ),
                    (pks ->> 'name') is not null,
                    true
                )::realtime.wal_column
            )
            from
                jsonb_array_elements(wal -> 'identity') x
                left join jsonb_array_elements(wal -> 'pk') pks
                    on (x ->> 'name') = (pks ->> 'name');

        for working_role in select * from unnest(roles) loop

            -- Update `is_selectable` for columns and old_columns
            columns =
                array_agg(
                    (
                        c.name,
                        c.type_name,
                        c.type_oid,
                        c.value,
                        c.is_pkey,
                        pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                    )::realtime.wal_column
                )
                from
                    unnest(columns) c;

            old_columns =
                    array_agg(
                        (
                            c.name,
                            c.type_name,
                            c.type_oid,
                            c.value,
                            c.is_pkey,
                            pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                        )::realtime.wal_column
                    )
                    from
                        unnest(old_columns) c;

            if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    -- subscriptions is already filtered by entity
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
                    array['Error 400: Bad Request, no primary key']
                )::realtime.wal_rls;

            -- The claims role does not have SELECT permission to the primary key of entity
            elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
                    array['Error 401: Unauthorized']
                )::realtime.wal_rls;

            else
                output = jsonb_build_object(
                    'schema', wal ->> 'schema',
                    'table', wal ->> 'table',
                    'type', action,
                    'commit_timestamp', to_char(
                        ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                        'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
                    ),
                    'columns', (
                        select
                            jsonb_agg(
                                jsonb_build_object(
                                    'name', pa.attname,
                                    'type', pt.typname
                                )
                                order by pa.attnum asc
                            )
                        from
                            pg_attribute pa
                            join pg_type pt
                                on pa.atttypid = pt.oid
                        where
                            attrelid = entity_
                            and attnum > 0
                            and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
                    )
                )
                -- Add "record" key for insert and update
                || case
                    when action in ('INSERT', 'UPDATE') then
                        jsonb_build_object(
                            'record',
                            (
                                select
                                    jsonb_object_agg(
                                        -- if unchanged toast, get column name and value from old record
                                        coalesce((c).name, (oc).name),
                                        case
                                            when (c).name is null then (oc).value
                                            else (c).value
                                        end
                                    )
                                from
                                    unnest(columns) c
                                    full outer join unnest(old_columns) oc
                                        on (c).name = (oc).name
                                where
                                    coalesce((c).is_selectable, (oc).is_selectable)
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            )
                        )
                    else '{}'::jsonb
                end
                -- Add "old_record" key for update and delete
                || case
                    when action = 'UPDATE' then
                        jsonb_build_object(
                                'old_record',
                                (
                                    select jsonb_object_agg((c).name, (c).value)
                                    from unnest(old_columns) c
                                    where
                                        (c).is_selectable
                                        and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                )
                            )
                    when action = 'DELETE' then
                        jsonb_build_object(
                            'old_record',
                            (
                                select jsonb_object_agg((c).name, (c).value)
                                from unnest(old_columns) c
                                where
                                    (c).is_selectable
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                    and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                            )
                        )
                    else '{}'::jsonb
                end;

                -- Create the prepared statement
                if is_rls_enabled and action <> 'DELETE' then
                    if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                        deallocate walrus_rls_stmt;
                    end if;
                    execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
                end if;

                visible_to_subscription_ids = '{}';

                for subscription_id, claims in (
                        select
                            subs.subscription_id,
                            subs.claims
                        from
                            unnest(subscriptions) subs
                        where
                            subs.entity = entity_
                            and subs.claims_role = working_role
                            and (
                                realtime.is_visible_through_filters(columns, subs.filters)
                                or action = 'DELETE'
                            )
                ) loop

                    if not is_rls_enabled or action = 'DELETE' then
                        visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                    else
                        -- Check if RLS allows the role to see the record
                        perform
                            set_config('role', working_role::text, true),
                            set_config('request.jwt.claims', claims::text, true);

                        execute 'execute walrus_rls_stmt' into subscription_has_access;

                        if subscription_has_access then
                            visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                        end if;
                    end if;
                end loop;

                perform set_config('role', null, true);

                return next (
                    output,
                    is_rls_enabled,
                    visible_to_subscription_ids,
                    case
                        when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                        else '{}'
                    end
                )::realtime.wal_rls;

            end if;
        end loop;

        perform set_config('role', null, true);
    end;
    $$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
    select string_to_array(name, '/') into _parts;
    select _parts[array_length(_parts,1)] into _filename;
    -- @todo return the last part instead of 2
    return split_part(_filename, '.', 2);
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
    select string_to_array(name, '/') into _parts;
    return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
    select string_to_array(name, '/') into _parts;
    return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(regexp_split_to_array(objects.name, ''/''), 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(regexp_split_to_array(objects.name, ''/''), 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    from_ip_address inet,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    friendly_name text NOT NULL,
    registration_start timestamp with time zone NOT NULL,
    registration_end timestamp with time zone NOT NULL,
    preseason_start timestamp with time zone,
    preseason_end timestamp with time zone,
    meets_on text,
    time_start timestamp with time zone,
    time_end timestamp with time zone,
    icon_url text,
    max_teams bigint NOT NULL,
    min_team_size bigint NOT NULL,
    max_team_size bigint NOT NULL,
    higher_is_better boolean DEFAULT true NOT NULL,
    default_location_id uuid,
    division text,
    event_name text
);


ALTER TABLE public.events OWNER TO postgres;

--
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    event_id uuid NOT NULL,
    home_team_id uuid NOT NULL,
    away_team_id uuid,
    home_score bigint DEFAULT '0'::bigint NOT NULL,
    away_score bigint DEFAULT '0'::bigint NOT NULL,
    played_at timestamp with time zone NOT NULL,
    override_location_id uuid
);


ALTER TABLE public.games OWNER TO postgres;

--
-- Name: groupchat_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groupchat_data (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    from_user_id uuid NOT NULL,
    to_group_id uuid NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.groupchat_data OWNER TO postgres;

--
-- Name: groupchat_memberships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groupchat_memberships (
    groupchat_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.groupchat_memberships OWNER TO postgres;

--
-- Name: groupchat_memberships_friendly; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.groupchat_memberships_friendly AS
 SELECT m.user_id,
    m.member_since,
    m.student_id,
    m.first_name,
    m.last_name,
    m.pfp_url,
    m.email,
    gm.groupchat_id
   FROM (( SELECT a.id AS user_id,
            meta.created_at AS member_since,
            meta.student_id,
            meta.first_name,
            meta.last_name,
            meta.pfp_url,
            a.email
           FROM (public.user_metadata meta
             RIGHT JOIN auth.users a ON ((a.id = meta.id)))) m
     RIGHT JOIN public.groupchat_memberships gm ON ((m.user_id = gm.user_id)));


ALTER TABLE public.groupchat_memberships_friendly OWNER TO postgres;

--
-- Name: groupchat_data_friendly; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.groupchat_data_friendly AS
 SELECT gmf.user_id,
    gmf.member_since,
    gmf.student_id,
    gmf.first_name,
    gmf.last_name,
    gmf.pfp_url,
    gmf.email,
    gmf.groupchat_id,
    gd.created_at AS message_time,
    gd.to_group_id,
    gd.content
   FROM (public.groupchat_memberships_friendly gmf
     RIGHT JOIN public.groupchat_data gd ON (((gmf.user_id = gd.from_user_id) AND (gmf.groupchat_id = gd.to_group_id))));


ALTER TABLE public.groupchat_data_friendly OWNER TO postgres;

--
-- Name: groupchats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groupchats (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    friendly_name text NOT NULL
);


ALTER TABLE public.groupchats OWNER TO postgres;

--
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    friendly_name text NOT NULL,
    latlong extensions.vector(2) NOT NULL
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- Name: team_memberships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team_memberships (
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    team_id uuid NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.team_memberships OWNER TO postgres;

--
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    event_id uuid NOT NULL,
    friendly_name text NOT NULL,
    team_logo_url text,
    captain_id uuid DEFAULT auth.uid() NOT NULL
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- Name: my_teams; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.my_teams AS
 SELECT teams.id,
    teams.created_at,
    teams.event_id,
    teams.friendly_name,
    teams.team_logo_url AS icon_url,
    teams.captain_id
   FROM public.teams
  WHERE ((teams.id IN ( SELECT team_memberships.team_id
           FROM public.team_memberships
          WHERE (team_memberships.user_id = auth.uid()))) OR (teams.captain_id = auth.uid()));


ALTER TABLE public.my_teams OWNER TO postgres;

--
-- Name: my_events; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.my_events AS
 SELECT events.id,
    events.created_at,
    events.friendly_name,
    events.registration_start,
    events.registration_end,
    events.preseason_start,
    events.preseason_end,
    events.meets_on,
    events.time_start,
    events.time_end,
    events.icon_url,
    events.max_teams,
    events.min_team_size,
    events.max_team_size,
    events.higher_is_better,
    events.default_location_id
   FROM public.events
  WHERE (events.id IN ( SELECT my_teams.event_id
           FROM public.my_teams));


ALTER TABLE public.my_events OWNER TO postgres;

--
-- Name: team_memberships_friendly; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.team_memberships_friendly AS
 SELECT tm.user_id,
    tm.team_id,
    u.first_name,
    u.last_name,
    u.pfp_url,
    t.event_id,
    t.friendly_name AS team_friendly_name,
    t.captain_id,
    t.team_logo_url
   FROM ((public.team_memberships tm
     LEFT JOIN public.user_metadata u ON ((u.id = tm.user_id)))
     LEFT JOIN public.teams t ON ((t.id = tm.team_id)));


ALTER TABLE public.team_memberships_friendly OWNER TO postgres;

--
-- Name: my_games; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.my_games AS
 SELECT games.id,
    games.created_at,
    games.event_id,
    games.home_team_id,
    games.away_team_id,
    games.home_score,
    games.away_score,
    games.played_at,
    games.override_location_id
   FROM public.games
  WHERE ((games.home_team_id IN ( SELECT DISTINCT team_memberships_friendly.team_id
           FROM public.team_memberships_friendly
          WHERE (team_memberships_friendly.user_id = 'd7adfe14-6201-4ec1-ab1f-565a4b3ab7c8'::uuid))) OR (games.away_team_id IN ( SELECT DISTINCT team_memberships_friendly.team_id
           FROM public.team_memberships_friendly
          WHERE (team_memberships_friendly.user_id = 'd7adfe14-6201-4ec1-ab1f-565a4b3ab7c8'::uuid))));


ALTER TABLE public.my_games OWNER TO postgres;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[]
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (provider, id);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: admins admins_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_user_id_key UNIQUE (user_id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: groupchat_data groupchats_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupchat_data
    ADD CONSTRAINT groupchats_data_pkey PRIMARY KEY (id);


--
-- Name: groupchat_memberships groupchats_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupchat_memberships
    ADD CONSTRAINT groupchats_memberships_pkey PRIMARY KEY (groupchat_id, user_id);


--
-- Name: groupchats groupchats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupchats
    ADD CONSTRAINT groupchats_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: user_metadata user_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_metadata
    ADD CONSTRAINT user_metadata_pkey PRIMARY KEY (id);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING hash (entity);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.create_metadata();


--
-- Name: teams add_captain_membership_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER add_captain_membership_trigger AFTER INSERT ON public.teams FOR EACH ROW EXECUTE FUNCTION public.add_captain_membership();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: admins admins_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: events events_default_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_default_location_id_fkey FOREIGN KEY (default_location_id) REFERENCES public.locations(id);


--
-- Name: games games_away_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_away_team_id_fkey FOREIGN KEY (away_team_id) REFERENCES public.teams(id);


--
-- Name: games games_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id);


--
-- Name: games games_home_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_home_team_id_fkey FOREIGN KEY (home_team_id) REFERENCES public.teams(id);


--
-- Name: games games_override_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_override_location_id_fkey FOREIGN KEY (override_location_id) REFERENCES public.locations(id);


--
-- Name: groupchat_data groupchat_data_from_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupchat_data
    ADD CONSTRAINT groupchat_data_from_user_id_fkey FOREIGN KEY (from_user_id) REFERENCES auth.users(id);


--
-- Name: groupchat_data groupchat_data_to_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupchat_data
    ADD CONSTRAINT groupchat_data_to_group_id_fkey FOREIGN KEY (to_group_id) REFERENCES public.groupchats(id);


--
-- Name: groupchat_memberships groupchat_memberships_groupchat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupchat_memberships
    ADD CONSTRAINT groupchat_memberships_groupchat_id_fkey FOREIGN KEY (groupchat_id) REFERENCES public.groupchats(id);


--
-- Name: groupchat_memberships groupchat_memberships_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupchat_memberships
    ADD CONSTRAINT groupchat_memberships_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: team_memberships team_memberships_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_memberships
    ADD CONSTRAINT team_memberships_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id) ON DELETE CASCADE;


--
-- Name: team_memberships team_memberships_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_memberships
    ADD CONSTRAINT team_memberships_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: teams teams_captain_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_captain_id_fkey FOREIGN KEY (captain_id) REFERENCES auth.users(id);


--
-- Name: teams teams_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id);


--
-- Name: user_metadata user_metadata_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_metadata
    ADD CONSTRAINT user_metadata_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id);


--
-- Name: buckets buckets_owner_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_owner_fkey FOREIGN KEY (owner) REFERENCES auth.users(id);


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: objects objects_owner_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_owner_fkey FOREIGN KEY (owner) REFERENCES auth.users(id);


--
-- Name: admins Admin only delete; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin only delete" ON public.admins FOR DELETE USING (( SELECT (EXISTS ( SELECT 1
           FROM public.admins admins_1
          WHERE (admins_1.user_id = auth.uid()))) AS "exists"));


--
-- Name: events Admin only delete; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin only delete" ON public.events FOR DELETE USING (( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists"));


--
-- Name: games Admin only delete; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin only delete" ON public.games FOR DELETE USING (( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists"));


--
-- Name: locations Admin only delete; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin only delete" ON public.locations FOR DELETE USING (( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists"));


--
-- Name: admins Admin only insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin only insert" ON public.admins FOR INSERT WITH CHECK (( SELECT (EXISTS ( SELECT 1
           FROM public.admins admins_1
          WHERE (admins_1.user_id = auth.uid()))) AS "exists"));


--
-- Name: events Admin only insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin only insert" ON public.events FOR INSERT WITH CHECK (( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists"));


--
-- Name: games Admin only insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin only insert" ON public.games FOR INSERT WITH CHECK (( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists"));


--
-- Name: locations Admin only insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin only insert" ON public.locations FOR INSERT WITH CHECK (( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists"));


--
-- Name: admins Admin only update; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin only update" ON public.admins FOR UPDATE USING (( SELECT (EXISTS ( SELECT 1
           FROM public.admins admins_1
          WHERE (admins_1.user_id = auth.uid()))) AS "exists")) WITH CHECK (( SELECT (EXISTS ( SELECT 1
           FROM public.admins admins_1
          WHERE (admins_1.user_id = auth.uid()))) AS "exists"));


--
-- Name: events Admin only update; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin only update" ON public.events FOR UPDATE USING (( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists")) WITH CHECK (( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists"));


--
-- Name: games Admin only update; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin only update" ON public.games FOR UPDATE USING (( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists")) WITH CHECK (( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists"));


--
-- Name: locations Admin only update; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin only update" ON public.locations FOR UPDATE USING (( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists")) WITH CHECK (( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists"));


--
-- Name: team_memberships Captain only insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Captain only insert" ON public.team_memberships FOR INSERT WITH CHECK ((( SELECT (EXISTS ( SELECT 1
           FROM public.teams
          WHERE ((teams.id = team_memberships.team_id) AND (teams.captain_id = auth.uid())))) AS "exists") OR ( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists")));


--
-- Name: team_memberships Captain or self delete; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Captain or self delete" ON public.team_memberships FOR DELETE USING (((user_id = auth.uid()) OR ( SELECT (EXISTS ( SELECT 1
           FROM public.teams
          WHERE ((teams.id = team_memberships.team_id) AND (teams.captain_id = auth.uid())))) AS "exists") OR ( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists")));


--
-- Name: teams Delete own teams; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Delete own teams" ON public.teams FOR DELETE USING (((captain_id = auth.uid()) OR ( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists")));


--
-- Name: events General read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "General read" ON public.events FOR SELECT USING (true);


--
-- Name: games General read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "General read" ON public.games FOR SELECT USING (true);


--
-- Name: locations General read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "General read" ON public.locations FOR SELECT USING (true);


--
-- Name: team_memberships General read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "General read" ON public.team_memberships FOR SELECT USING (true);


--
-- Name: teams General read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "General read" ON public.teams FOR SELECT USING (true);


--
-- Name: teams Insert own teams; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Insert own teams" ON public.teams FOR INSERT WITH CHECK (((captain_id = auth.uid()) OR ( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists")));


--
-- Name: team_memberships No update; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "No update" ON public.team_memberships FOR UPDATE USING (false) WITH CHECK (false);


--
-- Name: admins Read own admin status; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Read own admin status" ON public.admins FOR SELECT USING ((user_id = auth.uid()));


--
-- Name: teams Update own teams; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Update own teams" ON public.teams FOR UPDATE USING (((captain_id = auth.uid()) OR ( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists"))) WITH CHECK (((captain_id = auth.uid()) OR ( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists")));


--
-- Name: admins; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.admins ENABLE ROW LEVEL SECURITY;

--
-- Name: groupchat_data delete own message; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "delete own message" ON public.groupchat_data FOR DELETE USING ((auth.uid() = from_user_id));


--
-- Name: events; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.events ENABLE ROW LEVEL SECURITY;

--
-- Name: games; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.games ENABLE ROW LEVEL SECURITY;

--
-- Name: groupchat_memberships general insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "general insert" ON public.groupchat_memberships FOR INSERT WITH CHECK (true);


--
-- Name: groupchats general insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "general insert" ON public.groupchats FOR INSERT WITH CHECK (true);


--
-- Name: user_metadata general read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "general read" ON public.user_metadata FOR SELECT USING (true);


--
-- Name: groupchat_data; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.groupchat_data ENABLE ROW LEVEL SECURITY;

--
-- Name: groupchat_memberships; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.groupchat_memberships ENABLE ROW LEVEL SECURITY;

--
-- Name: groupchats; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.groupchats ENABLE ROW LEVEL SECURITY;

--
-- Name: user_metadata insert self (or admin); Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "insert self (or admin)" ON public.user_metadata FOR INSERT WITH CHECK (((id = auth.uid()) OR ( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists")));


--
-- Name: locations; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.locations ENABLE ROW LEVEL SECURITY;

--
-- Name: groupchats member only read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "member only read" ON public.groupchats FOR SELECT USING (( SELECT (EXISTS ( SELECT 1
           FROM ( SELECT groupchat_memberships.groupchat_id
                   FROM public.groupchat_memberships
                  WHERE (groupchat_memberships.user_id = auth.uid())) available_groupchats
          WHERE (groupchats.id = available_groupchats.groupchat_id))) AS "exists"));


--
-- Name: groupchats no delete; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "no delete" ON public.groupchats FOR DELETE USING (false);


--
-- Name: user_metadata no delete; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "no delete" ON public.user_metadata FOR DELETE USING (false);


--
-- Name: groupchat_data no update; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "no update" ON public.groupchat_data FOR UPDATE USING (false) WITH CHECK (false);


--
-- Name: groupchat_memberships no update; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "no update" ON public.groupchat_memberships FOR UPDATE USING (false) WITH CHECK (false);


--
-- Name: groupchats no update; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "no update" ON public.groupchats FOR UPDATE USING (false) WITH CHECK (false);


--
-- Name: groupchat_memberships self delete; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "self delete" ON public.groupchat_memberships FOR DELETE USING ((auth.uid() = user_id));


--
-- Name: groupchat_data send own message; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "send own message" ON public.groupchat_data FOR INSERT WITH CHECK ((( SELECT (EXISTS ( SELECT 1
           FROM ( SELECT groupchat_memberships.groupchat_id
                   FROM public.groupchat_memberships
                  WHERE (groupchat_memberships.user_id = auth.uid())) available_groupchats
          WHERE (groupchat_data.to_group_id = available_groupchats.groupchat_id))) AS "exists") AND (auth.uid() = from_user_id)));


--
-- Name: team_memberships; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.team_memberships ENABLE ROW LEVEL SECURITY;

--
-- Name: teams; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.teams ENABLE ROW LEVEL SECURITY;

--
-- Name: user_metadata update self (or admin); Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "update self (or admin)" ON public.user_metadata FOR UPDATE USING (((id = auth.uid()) OR ( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists"))) WITH CHECK (((id = auth.uid()) OR ( SELECT (EXISTS ( SELECT 1
           FROM public.admins
          WHERE (admins.user_id = auth.uid()))) AS "exists")));


--
-- Name: user_metadata; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_metadata ENABLE ROW LEVEL SECURITY;

--
-- Name: groupchat_data view messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "view messages" ON public.groupchat_data FOR SELECT USING (( SELECT (EXISTS ( SELECT 1
           FROM ( SELECT groupchat_memberships.groupchat_id
                   FROM public.groupchat_memberships
                  WHERE (groupchat_memberships.user_id = auth.uid())) available_groupchats
          WHERE (groupchat_data.id = available_groupchats.groupchat_id))) AS "exists"));


--
-- Name: groupchat_memberships view own groups; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "view own groups" ON public.groupchat_memberships FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: objects Self update profile pic 2xpy0i_0; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Self update profile pic 2xpy0i_0" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'profilePics'::text) AND (name = concat((auth.uid())::text, '.png'))));


--
-- Name: objects Self update profile pic 2xpy0i_1; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Self update profile pic 2xpy0i_1" ON storage.objects FOR UPDATE USING (((bucket_id = 'profilePics'::text) AND (name = concat((auth.uid())::text, '.png'))));


--
-- Name: objects Self update profile pic 2xpy0i_2; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Self update profile pic 2xpy0i_2" ON storage.objects FOR DELETE USING (((bucket_id = 'profilePics'::text) AND (name = concat((auth.uid())::text, '.png'))));


--
-- Name: objects Self update profile pic 2xpy0i_3; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Self update profile pic 2xpy0i_3" ON storage.objects FOR SELECT USING (((bucket_id = 'profilePics'::text) AND (name = concat((auth.uid())::text, '.png'))));


--
-- Name: objects allow all 17fjq20_0; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "allow all 17fjq20_0" ON storage.objects FOR INSERT WITH CHECK ((bucket_id = 'teamLogo'::text));


--
-- Name: objects allow all 17fjq20_1; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "allow all 17fjq20_1" ON storage.objects FOR SELECT USING ((bucket_id = 'teamLogo'::text));


--
-- Name: objects allow all 17fjq20_2; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "allow all 17fjq20_2" ON storage.objects FOR UPDATE USING ((bucket_id = 'teamLogo'::text));


--
-- Name: objects allow all 17fjq20_3; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "allow all 17fjq20_3" ON storage.objects FOR DELETE USING ((bucket_id = 'teamLogo'::text));


--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: supabase_realtime groupchat_data; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.groupchat_data;


--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT ALL ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA graphql_public; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA graphql_public TO postgres;
GRANT USAGE ON SCHEMA graphql_public TO anon;
GRANT USAGE ON SCHEMA graphql_public TO authenticated;
GRANT USAGE ON SCHEMA graphql_public TO service_role;


--
-- Name: SCHEMA pgsodium; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA pgsodium FROM supabase_admin;
REVOKE USAGE ON SCHEMA pgsodium FROM PUBLIC;
GRANT ALL ON SCHEMA pgsodium TO postgres;
GRANT USAGE ON SCHEMA pgsodium TO PUBLIC;


--
-- Name: SCHEMA pgsodium_masks; Type: ACL; Schema: -; Owner: supabase_admin
--

REVOKE ALL ON SCHEMA pgsodium_masks FROM supabase_admin;
GRANT ALL ON SCHEMA pgsodium_masks TO postgres;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT ALL ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: FUNCTION box2d_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2d_in(cstring) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION box2d_out(extensions.box2d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2d_out(extensions.box2d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION box2df_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2df_in(cstring) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION box2df_out(extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2df_out(extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION box3d_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3d_in(cstring) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION box3d_out(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3d_out(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_analyze(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_analyze(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_in(cstring, oid, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_in(cstring, oid, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_out(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_out(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_recv(internal, oid, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_recv(internal, oid, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_send(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_send(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_typmod_in(cstring[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_typmod_in(cstring[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_typmod_out(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_typmod_out(integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_analyze(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_analyze(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_in(cstring) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_out(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_out(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_recv(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_recv(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_send(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_send(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_typmod_in(cstring[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_typmod_in(cstring[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_typmod_out(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_typmod_out(integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gidx_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gidx_in(cstring) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gidx_out(extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gidx_out(extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION spheroid_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.spheroid_in(cstring) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION spheroid_out(extensions.spheroid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.spheroid_out(extensions.spheroid) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_in(cstring, oid, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_in(cstring, oid, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_out(extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_out(extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_recv(internal, oid, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_recv(internal, oid, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_send(extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_send(extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_typmod_in(cstring[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_typmod_in(cstring[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_vector(real[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_vector(real[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_vector(double precision[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_vector(double precision[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_vector(integer[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_vector(integer[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_vector(numeric[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_vector(numeric[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION box3d(extensions.box2d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3d(extensions.box2d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry(extensions.box2d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(extensions.box2d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION box(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION box2d(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2d(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION bytea(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.bytea(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography(extensions.geography, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography(extensions.geography, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION box(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION box2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION box3d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION bytea(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.bytea(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry(extensions.geometry, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(extensions.geometry, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION json(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.json(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION jsonb(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.jsonb(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION path(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.path(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION point(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.point(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION polygon(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.polygon(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION text(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.text(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry(path); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(path) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry(point); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(point) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry(polygon); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(polygon) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_to_float4(extensions.vector, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_to_float4(extensions.vector, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector(extensions.vector, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector(extensions.vector, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;
GRANT ALL ON FUNCTION auth.email() TO postgres;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;
GRANT ALL ON FUNCTION auth.role() TO postgres;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;
GRANT ALL ON FUNCTION auth.uid() TO postgres;


--
-- Name: FUNCTION _postgis_deprecate(oldname text, newname text, version text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_deprecate(oldname text, newname text, version text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _postgis_index_extent(tbl regclass, col text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_index_extent(tbl regclass, col text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _postgis_join_selectivity(regclass, text, regclass, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_join_selectivity(regclass, text, regclass, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _postgis_pgsql_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_pgsql_version() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _postgis_scripts_pgsql_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_scripts_pgsql_version() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _postgis_selectivity(tbl regclass, att_name text, geom extensions.geometry, mode text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_selectivity(tbl regclass, att_name text, geom extensions.geometry, mode text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _postgis_stats(tbl regclass, att_name text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_stats(tbl regclass, att_name text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_3ddfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_3ddfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_3ddwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_3ddwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_3dintersects(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_3dintersects(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_asgml(integer, extensions.geometry, integer, integer, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_asgml(integer, extensions.geometry, integer, integer, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_asx3d(integer, extensions.geometry, integer, integer, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_asx3d(integer, extensions.geometry, integer, integer, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_bestsrid(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_bestsrid(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_bestsrid(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_bestsrid(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_concavehull(param_inputgeom extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_concavehull(param_inputgeom extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_contains(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_contains(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_containsproperly(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_containsproperly(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_coveredby(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_coveredby(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_coveredby(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_coveredby(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_covers(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_covers(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_covers(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_covers(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_crosses(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_crosses(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_dfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_distancetree(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distancetree(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_distancetree(extensions.geography, extensions.geography, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distancetree(extensions.geography, extensions.geography, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_distanceuncached(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distanceuncached(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_distanceuncached(extensions.geography, extensions.geography, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distanceuncached(extensions.geography, extensions.geography, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_distanceuncached(extensions.geography, extensions.geography, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distanceuncached(extensions.geography, extensions.geography, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_dwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_dwithin(geog1 extensions.geography, geog2 extensions.geography, tolerance double precision, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dwithin(geog1 extensions.geography, geog2 extensions.geography, tolerance double precision, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_dwithinuncached(extensions.geography, extensions.geography, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dwithinuncached(extensions.geography, extensions.geography, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_dwithinuncached(extensions.geography, extensions.geography, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dwithinuncached(extensions.geography, extensions.geography, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_equals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_equals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_expand(extensions.geography, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_expand(extensions.geography, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_geomfromgml(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_geomfromgml(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_intersects(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_intersects(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_linecrossingdirection(line1 extensions.geometry, line2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_linecrossingdirection(line1 extensions.geometry, line2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_longestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_longestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_maxdistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_maxdistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_orderingequals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_orderingequals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_overlaps(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_overlaps(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_pointoutside(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_pointoutside(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_sortablehash(geom extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_sortablehash(geom extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_touches(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_touches(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_voronoi(g1 extensions.geometry, clip extensions.geometry, tolerance double precision, return_polygons boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_voronoi(g1 extensions.geometry, clip extensions.geometry, tolerance double precision, return_polygons boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION _st_within(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_within(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION addauth(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.addauth(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION box3dtobox(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3dtobox(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION checkauth(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.checkauth(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION checkauth(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.checkauth(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION checkauthtrigger(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.checkauthtrigger() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION contains_2d(extensions.box2df, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.contains_2d(extensions.box2df, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION contains_2d(extensions.box2df, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.contains_2d(extensions.box2df, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION contains_2d(extensions.geometry, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.contains_2d(extensions.geometry, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION cosine_distance(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.cosine_distance(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION disablelongtransactions(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.disablelongtransactions() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION dropgeometrycolumn(table_name character varying, column_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrycolumn(table_name character varying, column_name character varying) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION dropgeometrytable(table_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrytable(table_name character varying) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION dropgeometrytable(schema_name character varying, table_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrytable(schema_name character varying, table_name character varying) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION enablelongtransactions(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.enablelongtransactions() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION equals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.equals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION find_srid(character varying, character varying, character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.find_srid(character varying, character varying, character varying) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geog_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geog_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_cmp(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_cmp(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_distance_knn(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_distance_knn(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_eq(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_eq(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_ge(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_ge(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_gist_compress(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_compress(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_gist_consistent(internal, extensions.geography, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_consistent(internal, extensions.geography, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_gist_decompress(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_decompress(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_gist_distance(internal, extensions.geography, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_distance(internal, extensions.geography, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_gist_penalty(internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_penalty(internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_gist_picksplit(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_picksplit(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_gist_same(extensions.box2d, extensions.box2d, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_same(extensions.box2d, extensions.box2d, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_gist_union(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_union(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_gt(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gt(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_le(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_le(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_lt(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_lt(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_overlaps(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_overlaps(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_spgist_choose_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_choose_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_spgist_compress_nd(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_compress_nd(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_spgist_config_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_config_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_spgist_inner_consistent_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_inner_consistent_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_spgist_leaf_consistent_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_leaf_consistent_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geography_spgist_picksplit_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_picksplit_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geom2d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geom2d_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geom3d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geom3d_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geom4d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geom4d_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_above(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_above(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_below(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_below(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_cmp(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_cmp(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_contained_3d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_contained_3d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_contains(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_contains(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_contains_3d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_contains_3d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_contains_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_contains_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_distance_box(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_distance_box(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_distance_centroid(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_distance_centroid(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_distance_centroid_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_distance_centroid_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_distance_cpa(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_distance_cpa(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_eq(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_eq(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_ge(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_ge(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_compress_2d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_compress_2d(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_compress_nd(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_compress_nd(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_consistent_2d(internal, extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_consistent_2d(internal, extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_consistent_nd(internal, extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_consistent_nd(internal, extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_decompress_2d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_decompress_2d(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_decompress_nd(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_decompress_nd(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_distance_2d(internal, extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_distance_2d(internal, extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_distance_nd(internal, extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_distance_nd(internal, extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_penalty_2d(internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_penalty_2d(internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_penalty_nd(internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_penalty_nd(internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_picksplit_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_picksplit_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_picksplit_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_picksplit_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_same_2d(geom1 extensions.geometry, geom2 extensions.geometry, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_same_2d(geom1 extensions.geometry, geom2 extensions.geometry, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_same_nd(extensions.geometry, extensions.geometry, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_same_nd(extensions.geometry, extensions.geometry, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_sortsupport_2d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_sortsupport_2d(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_union_2d(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_union_2d(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gist_union_nd(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_union_nd(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_gt(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gt(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_hash(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_hash(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_le(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_le(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_left(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_left(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_lt(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_lt(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_overabove(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overabove(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_overbelow(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overbelow(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_overlaps(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overlaps(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_overlaps_3d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overlaps_3d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_overlaps_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overlaps_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_overleft(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overleft(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_overright(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overright(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_right(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_right(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_same(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_same(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_same_3d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_same_3d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_same_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_same_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_sortsupport(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_sortsupport(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_choose_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_choose_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_choose_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_choose_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_choose_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_choose_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_compress_2d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_compress_2d(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_compress_3d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_compress_3d(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_compress_nd(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_compress_nd(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_config_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_config_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_config_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_config_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_config_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_config_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_inner_consistent_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_inner_consistent_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_inner_consistent_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_inner_consistent_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_inner_consistent_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_inner_consistent_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_leaf_consistent_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_leaf_consistent_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_leaf_consistent_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_leaf_consistent_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_leaf_consistent_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_leaf_consistent_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_picksplit_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_picksplit_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_picksplit_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_picksplit_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_spgist_picksplit_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_picksplit_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_within(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_within(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometry_within_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_within_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometrytype(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometrytype(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geometrytype(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometrytype(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geomfromewkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geomfromewkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION geomfromewkt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geomfromewkt(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION get_proj4_from_srid(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.get_proj4_from_srid(integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gettransactionid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gettransactionid() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION gserialized_gist_joinsel_2d(internal, oid, internal, smallint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gserialized_gist_joinsel_2d(internal, oid, internal, smallint) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gserialized_gist_joinsel_nd(internal, oid, internal, smallint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gserialized_gist_joinsel_nd(internal, oid, internal, smallint) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gserialized_gist_sel_2d(internal, oid, internal, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gserialized_gist_sel_2d(internal, oid, internal, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gserialized_gist_sel_nd(internal, oid, internal, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gserialized_gist_sel_nd(internal, oid, internal, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION inner_product(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.inner_product(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION is_contained_2d(extensions.box2df, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.is_contained_2d(extensions.box2df, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION is_contained_2d(extensions.box2df, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.is_contained_2d(extensions.box2df, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION is_contained_2d(extensions.geometry, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.is_contained_2d(extensions.geometry, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION ivfflathandler(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.ivfflathandler(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION l2_distance(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.l2_distance(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION lockrow(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.lockrow(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION lockrow(text, text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.lockrow(text, text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION lockrow(text, text, text, timestamp without time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.lockrow(text, text, text, timestamp without time zone) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION lockrow(text, text, text, text, timestamp without time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.lockrow(text, text, text, text, timestamp without time zone) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION longtransactionsenabled(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.longtransactionsenabled() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION overlaps_2d(extensions.box2df, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_2d(extensions.box2df, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION overlaps_2d(extensions.box2df, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_2d(extensions.box2df, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION overlaps_2d(extensions.geometry, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_2d(extensions.geometry, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION overlaps_geog(extensions.geography, extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_geog(extensions.geography, extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION overlaps_geog(extensions.gidx, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_geog(extensions.gidx, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION overlaps_geog(extensions.gidx, extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_geog(extensions.gidx, extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION overlaps_nd(extensions.geometry, extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_nd(extensions.geometry, extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION overlaps_nd(extensions.gidx, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_nd(extensions.gidx, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION overlaps_nd(extensions.gidx, extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_nd(extensions.gidx, extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asflatgeobuf_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asflatgeobuf_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asflatgeobuf_transfn(internal, anyelement) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asflatgeobuf_transfn(internal, anyelement, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement, boolean, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asflatgeobuf_transfn(internal, anyelement, boolean, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asgeobuf_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asgeobuf_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asgeobuf_transfn(internal, anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asgeobuf_transfn(internal, anyelement) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asgeobuf_transfn(internal, anyelement, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asgeobuf_transfn(internal, anyelement, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asmvt_combinefn(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_combinefn(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asmvt_deserialfn(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_deserialfn(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asmvt_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asmvt_serialfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_serialfn(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement, text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement, text, integer, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement, text, integer, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_accum_transfn(internal, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_accum_transfn(internal, extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, extensions.geometry, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_accum_transfn(internal, extensions.geometry, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_geometry_clusterintersecting_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_clusterintersecting_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_geometry_clusterwithin_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_clusterwithin_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_geometry_collect_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_collect_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_geometry_makeline_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_makeline_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_geometry_polygonize_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_polygonize_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_geometry_union_parallel_combinefn(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_combinefn(internal, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_geometry_union_parallel_deserialfn(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_deserialfn(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_geometry_union_parallel_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_geometry_union_parallel_serialfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_serialfn(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_geometry_union_parallel_transfn(internal, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_transfn(internal, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgis_geometry_union_parallel_transfn(internal, extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_transfn(internal, extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION populate_geometry_columns(use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.populate_geometry_columns(use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION populate_geometry_columns(tbl_oid oid, use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.populate_geometry_columns(tbl_oid oid, use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_addbbox(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_addbbox(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_cache_bbox(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_cache_bbox() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_constraint_type(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_constraint_type(geomschema text, geomtable text, geomcolumn text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_dropbbox(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_dropbbox(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_extensions_upgrade(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_extensions_upgrade() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_full_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_full_version() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_geos_noop(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_geos_noop(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_geos_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_geos_version() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_getbbox(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_getbbox(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_hasbbox(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_hasbbox(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_index_supportfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_index_supportfn(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_lib_build_date(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_lib_build_date() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_lib_revision(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_lib_revision() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_lib_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_lib_version() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_libjson_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_libjson_version() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_liblwgeom_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_liblwgeom_version() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_libprotobuf_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_libprotobuf_version() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_libxml_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_libxml_version() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_noop(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_noop(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_proj_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_proj_version() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_scripts_build_date(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_scripts_build_date() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_scripts_installed(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_scripts_installed() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_scripts_released(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_scripts_released() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_svn_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_svn_version() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_transform_geometry(geom extensions.geometry, text, text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_transform_geometry(geom extensions.geometry, text, text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_typmod_dims(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_typmod_dims(integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_typmod_srid(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_typmod_srid(integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_typmod_type(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_typmod_type(integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_version() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION postgis_wagyu_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_wagyu_version() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_3dclosestpoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dclosestpoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_3ddfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3ddfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_3ddistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3ddistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_3ddwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3ddwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_3dintersects(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dintersects(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_3dlength(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dlength(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_3dlineinterpolatepoint(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dlineinterpolatepoint(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_3dlongestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dlongestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_3dmakebox(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dmakebox(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_3dmaxdistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dmaxdistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_3dperimeter(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dperimeter(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_3dshortestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dshortestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_addmeasure(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_addmeasure(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_addpoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_addpoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_addpoint(geom1 extensions.geometry, geom2 extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_addpoint(geom1 extensions.geometry, geom2 extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_affine(extensions.geometry, double precision, double precision, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_affine(extensions.geometry, double precision, double precision, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_affine(extensions.geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_affine(extensions.geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_angle(line1 extensions.geometry, line2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_angle(line1 extensions.geometry, line2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_angle(pt1 extensions.geometry, pt2 extensions.geometry, pt3 extensions.geometry, pt4 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_angle(pt1 extensions.geometry, pt2 extensions.geometry, pt3 extensions.geometry, pt4 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_area(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_area(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_area(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_area(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_area(geog extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_area(geog extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_area2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_area2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asbinary(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asbinary(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asbinary(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asbinary(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asbinary(extensions.geography, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asbinary(extensions.geography, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asbinary(extensions.geometry, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asbinary(extensions.geometry, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asencodedpolyline(geom extensions.geometry, nprecision integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asencodedpolyline(geom extensions.geometry, nprecision integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asewkb(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkb(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asewkb(extensions.geometry, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkb(extensions.geometry, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asewkt(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asewkt(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asewkt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asewkt(extensions.geography, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(extensions.geography, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asewkt(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asgeojson(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeojson(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asgeojson(geog extensions.geography, maxdecimaldigits integer, options integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeojson(geog extensions.geography, maxdecimaldigits integer, options integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asgeojson(geom extensions.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeojson(geom extensions.geometry, maxdecimaldigits integer, options integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asgeojson(r record, geom_column text, maxdecimaldigits integer, pretty_bool boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeojson(r record, geom_column text, maxdecimaldigits integer, pretty_bool boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asgml(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asgml(geom extensions.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(geom extensions.geometry, maxdecimaldigits integer, options integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asgml(geog extensions.geography, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(geog extensions.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asgml(version integer, geog extensions.geography, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(version integer, geog extensions.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asgml(version integer, geom extensions.geometry, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(version integer, geom extensions.geometry, maxdecimaldigits integer, options integer, nprefix text, id text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_ashexewkb(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ashexewkb(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_ashexewkb(extensions.geometry, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ashexewkb(extensions.geometry, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_askml(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_askml(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_askml(geog extensions.geography, maxdecimaldigits integer, nprefix text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_askml(geog extensions.geography, maxdecimaldigits integer, nprefix text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_askml(geom extensions.geometry, maxdecimaldigits integer, nprefix text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_askml(geom extensions.geometry, maxdecimaldigits integer, nprefix text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_aslatlontext(geom extensions.geometry, tmpl text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_aslatlontext(geom extensions.geometry, tmpl text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asmarc21(geom extensions.geometry, format text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmarc21(geom extensions.geometry, format text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asmvtgeom(geom extensions.geometry, bounds extensions.box2d, extent integer, buffer integer, clip_geom boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvtgeom(geom extensions.geometry, bounds extensions.box2d, extent integer, buffer integer, clip_geom boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_assvg(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_assvg(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_assvg(geog extensions.geography, rel integer, maxdecimaldigits integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_assvg(geog extensions.geography, rel integer, maxdecimaldigits integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_assvg(geom extensions.geometry, rel integer, maxdecimaldigits integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_assvg(geom extensions.geometry, rel integer, maxdecimaldigits integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_astext(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_astext(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_astext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_astext(extensions.geography, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(extensions.geography, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_astext(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_astwkb(geom extensions.geometry, prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astwkb(geom extensions.geometry, prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_astwkb(geom extensions.geometry[], ids bigint[], prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astwkb(geom extensions.geometry[], ids bigint[], prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asx3d(geom extensions.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asx3d(geom extensions.geometry, maxdecimaldigits integer, options integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_azimuth(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_azimuth(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_azimuth(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_azimuth(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_bdmpolyfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_bdmpolyfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_bdpolyfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_bdpolyfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_boundary(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_boundary(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_boundingdiagonal(geom extensions.geometry, fits boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_boundingdiagonal(geom extensions.geometry, fits boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_box2dfromgeohash(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_box2dfromgeohash(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_buffer(extensions.geography, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(extensions.geography, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_buffer(text, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(text, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_buffer(extensions.geography, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(extensions.geography, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_buffer(extensions.geography, double precision, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(extensions.geography, double precision, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_buffer(geom extensions.geometry, radius double precision, quadsegs integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(geom extensions.geometry, radius double precision, quadsegs integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_buffer(geom extensions.geometry, radius double precision, options text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(geom extensions.geometry, radius double precision, options text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_buffer(text, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(text, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_buffer(text, double precision, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(text, double precision, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_buildarea(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buildarea(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_centroid(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_centroid(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_centroid(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_centroid(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_centroid(extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_centroid(extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_chaikinsmoothing(extensions.geometry, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_chaikinsmoothing(extensions.geometry, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_cleangeometry(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_cleangeometry(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_clipbybox2d(geom extensions.geometry, box extensions.box2d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clipbybox2d(geom extensions.geometry, box extensions.box2d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_closestpoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_closestpoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_closestpointofapproach(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_closestpointofapproach(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_clusterdbscan(extensions.geometry, eps double precision, minpoints integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterdbscan(extensions.geometry, eps double precision, minpoints integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_clusterintersecting(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterintersecting(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_clusterkmeans(geom extensions.geometry, k integer, max_radius double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterkmeans(geom extensions.geometry, k integer, max_radius double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_clusterwithin(extensions.geometry[], double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterwithin(extensions.geometry[], double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_collect(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collect(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_collect(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collect(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_collectionextract(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collectionextract(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_collectionextract(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collectionextract(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_collectionhomogenize(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collectionhomogenize(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_combinebbox(extensions.box2d, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_combinebbox(extensions.box2d, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_combinebbox(extensions.box3d, extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_combinebbox(extensions.box3d, extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_combinebbox(extensions.box3d, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_combinebbox(extensions.box3d, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_concavehull(param_geom extensions.geometry, param_pctconvex double precision, param_allow_holes boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_concavehull(param_geom extensions.geometry, param_pctconvex double precision, param_allow_holes boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_contains(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_contains(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_containsproperly(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_containsproperly(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_convexhull(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_convexhull(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_coorddim(geometry extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_coorddim(geometry extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_coveredby(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_coveredby(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_coveredby(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_coveredby(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_coveredby(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_coveredby(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_covers(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_covers(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_covers(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_covers(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_covers(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_covers(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_cpawithin(extensions.geometry, extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_cpawithin(extensions.geometry, extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_crosses(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_crosses(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_curvetoline(geom extensions.geometry, tol double precision, toltype integer, flags integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_curvetoline(geom extensions.geometry, tol double precision, toltype integer, flags integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_delaunaytriangles(g1 extensions.geometry, tolerance double precision, flags integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_delaunaytriangles(g1 extensions.geometry, tolerance double precision, flags integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_dfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_difference(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_difference(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_dimension(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dimension(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_disjoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_disjoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_distance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_distance(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distance(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_distance(geog1 extensions.geography, geog2 extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distance(geog1 extensions.geography, geog2 extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_distancecpa(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancecpa(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_distancesphere(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancesphere(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_distancesphere(geom1 extensions.geometry, geom2 extensions.geometry, radius double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancesphere(geom1 extensions.geometry, geom2 extensions.geometry, radius double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_distancespheroid(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancespheroid(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_distancespheroid(geom1 extensions.geometry, geom2 extensions.geometry, extensions.spheroid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancespheroid(geom1 extensions.geometry, geom2 extensions.geometry, extensions.spheroid) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_dump(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dump(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_dumppoints(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dumppoints(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_dumprings(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dumprings(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_dumpsegments(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dumpsegments(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_dwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_dwithin(text, text, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dwithin(text, text, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_dwithin(geog1 extensions.geography, geog2 extensions.geography, tolerance double precision, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dwithin(geog1 extensions.geography, geog2 extensions.geography, tolerance double precision, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_endpoint(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_endpoint(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_envelope(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_envelope(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_equals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_equals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_estimatedextent(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_estimatedextent(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_estimatedextent(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_estimatedextent(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_estimatedextent(text, text, text, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_estimatedextent(text, text, text, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_expand(extensions.box2d, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(extensions.box2d, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_expand(extensions.box3d, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(extensions.box3d, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_expand(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_expand(box extensions.box2d, dx double precision, dy double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(box extensions.box2d, dx double precision, dy double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_expand(box extensions.box3d, dx double precision, dy double precision, dz double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(box extensions.box3d, dx double precision, dy double precision, dz double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_expand(geom extensions.geometry, dx double precision, dy double precision, dz double precision, dm double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(geom extensions.geometry, dx double precision, dy double precision, dz double precision, dm double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_exteriorring(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_exteriorring(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_filterbym(extensions.geometry, double precision, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_filterbym(extensions.geometry, double precision, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_findextent(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_findextent(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_findextent(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_findextent(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_flipcoordinates(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_flipcoordinates(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_force2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_force3d(geom extensions.geometry, zvalue double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force3d(geom extensions.geometry, zvalue double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_force3dm(geom extensions.geometry, mvalue double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force3dm(geom extensions.geometry, mvalue double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_force3dz(geom extensions.geometry, zvalue double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force3dz(geom extensions.geometry, zvalue double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_force4d(geom extensions.geometry, zvalue double precision, mvalue double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force4d(geom extensions.geometry, zvalue double precision, mvalue double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_forcecollection(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcecollection(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_forcecurve(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcecurve(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_forcepolygonccw(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcepolygonccw(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_forcepolygoncw(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcepolygoncw(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_forcerhr(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcerhr(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_forcesfs(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcesfs(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_forcesfs(extensions.geometry, version text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcesfs(extensions.geometry, version text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_frechetdistance(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_frechetdistance(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_fromflatgeobuf(anyelement, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_fromflatgeobuf(anyelement, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_fromflatgeobuftotable(text, text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_fromflatgeobuftotable(text, text, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_generatepoints(area extensions.geometry, npoints integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_generatepoints(area extensions.geometry, npoints integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_generatepoints(area extensions.geometry, npoints integer, seed integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_generatepoints(area extensions.geometry, npoints integer, seed integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geogfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geogfromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geogfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geogfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geographyfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geographyfromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geohash(geog extensions.geography, maxchars integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geohash(geog extensions.geography, maxchars integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geohash(geom extensions.geometry, maxchars integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geohash(geom extensions.geometry, maxchars integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomcollfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomcollfromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomcollfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomcollfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomcollfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomcollfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomcollfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomcollfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geometricmedian(g extensions.geometry, tolerance double precision, max_iter integer, fail_if_not_converged boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometricmedian(g extensions.geometry, tolerance double precision, max_iter integer, fail_if_not_converged boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geometryfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometryfromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geometryfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometryfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geometryn(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometryn(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geometrytype(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometrytype(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfromewkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromewkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfromewkt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromewkt(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfromgeohash(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgeohash(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfromgeojson(json); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgeojson(json) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfromgeojson(jsonb); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgeojson(jsonb) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfromgeojson(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgeojson(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfromgml(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgml(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfromgml(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgml(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfromkml(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromkml(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfrommarc21(marc21xml text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfrommarc21(marc21xml text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfromtwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromtwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_geomfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_gmltosql(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_gmltosql(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_gmltosql(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_gmltosql(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_hasarc(geometry extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hasarc(geometry extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_hausdorffdistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hausdorffdistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_hausdorffdistance(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hausdorffdistance(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_hexagon(size double precision, cell_i integer, cell_j integer, origin extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hexagon(size double precision, cell_i integer, cell_j integer, origin extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_hexagongrid(size double precision, bounds extensions.geometry, OUT geom extensions.geometry, OUT i integer, OUT j integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hexagongrid(size double precision, bounds extensions.geometry, OUT geom extensions.geometry, OUT i integer, OUT j integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_interiorringn(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_interiorringn(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_interpolatepoint(line extensions.geometry, point extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_interpolatepoint(line extensions.geometry, point extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_intersection(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersection(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_intersection(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersection(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_intersection(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersection(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_intersects(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersects(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_intersects(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersects(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_intersects(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersects(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_isclosed(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isclosed(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_iscollection(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_iscollection(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_isempty(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isempty(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_ispolygonccw(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ispolygonccw(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_ispolygoncw(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ispolygoncw(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_isring(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isring(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_issimple(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_issimple(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_isvalid(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalid(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_isvalid(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalid(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_isvaliddetail(geom extensions.geometry, flags integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvaliddetail(geom extensions.geometry, flags integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_isvalidreason(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalidreason(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_isvalidreason(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalidreason(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_isvalidtrajectory(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalidtrajectory(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_length(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_length(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_length(geog extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length(geog extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_length2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_length2dspheroid(extensions.geometry, extensions.spheroid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length2dspheroid(extensions.geometry, extensions.spheroid) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_lengthspheroid(extensions.geometry, extensions.spheroid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_lengthspheroid(extensions.geometry, extensions.spheroid) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_letters(letters text, font json); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_letters(letters text, font json) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_linecrossingdirection(line1 extensions.geometry, line2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linecrossingdirection(line1 extensions.geometry, line2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_linefromencodedpolyline(txtin text, nprecision integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromencodedpolyline(txtin text, nprecision integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_linefrommultipoint(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefrommultipoint(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_linefromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_linefromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_linefromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_linefromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_lineinterpolatepoint(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_lineinterpolatepoint(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_lineinterpolatepoints(extensions.geometry, double precision, repeat boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_lineinterpolatepoints(extensions.geometry, double precision, repeat boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_linelocatepoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linelocatepoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_linemerge(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linemerge(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_linemerge(extensions.geometry, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linemerge(extensions.geometry, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_linestringfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linestringfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_linestringfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linestringfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_linesubstring(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linesubstring(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_linetocurve(geometry extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linetocurve(geometry extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_locatealong(geometry extensions.geometry, measure double precision, leftrightoffset double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_locatealong(geometry extensions.geometry, measure double precision, leftrightoffset double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_locatebetween(geometry extensions.geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_locatebetween(geometry extensions.geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_locatebetweenelevations(geometry extensions.geometry, fromelevation double precision, toelevation double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_locatebetweenelevations(geometry extensions.geometry, fromelevation double precision, toelevation double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_longestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_longestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_m(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_m(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_makebox2d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makebox2d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_makeenvelope(double precision, double precision, double precision, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makeenvelope(double precision, double precision, double precision, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_makeline(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makeline(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_makeline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makeline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_makepoint(double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepoint(double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_makepoint(double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepoint(double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_makepoint(double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepoint(double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_makepointm(double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepointm(double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_makepolygon(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepolygon(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_makepolygon(extensions.geometry, extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepolygon(extensions.geometry, extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_makevalid(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makevalid(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_makevalid(geom extensions.geometry, params text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makevalid(geom extensions.geometry, params text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_maxdistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_maxdistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_maximuminscribedcircle(extensions.geometry, OUT center extensions.geometry, OUT nearest extensions.geometry, OUT radius double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_maximuminscribedcircle(extensions.geometry, OUT center extensions.geometry, OUT nearest extensions.geometry, OUT radius double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_memsize(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_memsize(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_minimumboundingcircle(inputgeom extensions.geometry, segs_per_quarter integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_minimumboundingcircle(inputgeom extensions.geometry, segs_per_quarter integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_minimumboundingradius(extensions.geometry, OUT center extensions.geometry, OUT radius double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_minimumboundingradius(extensions.geometry, OUT center extensions.geometry, OUT radius double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_minimumclearance(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_minimumclearance(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_minimumclearanceline(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_minimumclearanceline(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_mlinefromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mlinefromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_mlinefromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mlinefromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_mlinefromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mlinefromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_mlinefromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mlinefromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_mpointfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpointfromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_mpointfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpointfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_mpointfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpointfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_mpointfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpointfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_mpolyfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpolyfromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_mpolyfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpolyfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_mpolyfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpolyfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_mpolyfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpolyfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_multi(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multi(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_multilinefromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multilinefromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_multilinestringfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multilinestringfromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_multilinestringfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multilinestringfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_multipointfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipointfromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_multipointfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipointfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_multipointfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipointfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_multipolyfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipolyfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_multipolyfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipolyfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_multipolygonfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipolygonfromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_multipolygonfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipolygonfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_ndims(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ndims(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_node(g extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_node(g extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_normalize(geom extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_normalize(geom extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_npoints(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_npoints(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_nrings(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_nrings(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_numgeometries(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numgeometries(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_numinteriorring(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numinteriorring(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_numinteriorrings(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numinteriorrings(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_numpatches(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numpatches(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_numpoints(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numpoints(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_offsetcurve(line extensions.geometry, distance double precision, params text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_offsetcurve(line extensions.geometry, distance double precision, params text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_orderingequals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_orderingequals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_orientedenvelope(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_orientedenvelope(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_overlaps(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_overlaps(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_patchn(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_patchn(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_perimeter(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_perimeter(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_perimeter(geog extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_perimeter(geog extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_perimeter2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_perimeter2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_point(double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_point(double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_point(double precision, double precision, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_point(double precision, double precision, srid integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_pointfromgeohash(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromgeohash(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_pointfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_pointfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_pointfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_pointfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_pointinsidecircle(extensions.geometry, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointinsidecircle(extensions.geometry, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_pointm(xcoordinate double precision, ycoordinate double precision, mcoordinate double precision, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointm(xcoordinate double precision, ycoordinate double precision, mcoordinate double precision, srid integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_pointn(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointn(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_pointonsurface(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointonsurface(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_points(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_points(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_pointz(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointz(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, srid integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_pointzm(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, mcoordinate double precision, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointzm(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, mcoordinate double precision, srid integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_polyfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polyfromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_polyfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polyfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_polyfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polyfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_polyfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polyfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_polygon(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygon(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_polygonfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonfromtext(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_polygonfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_polygonfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_polygonfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_polygonize(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonize(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_project(geog extensions.geography, distance double precision, azimuth double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_project(geog extensions.geography, distance double precision, azimuth double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_quantizecoordinates(g extensions.geometry, prec_x integer, prec_y integer, prec_z integer, prec_m integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_quantizecoordinates(g extensions.geometry, prec_x integer, prec_y integer, prec_z integer, prec_m integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_reduceprecision(geom extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_reduceprecision(geom extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_relate(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_relate(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_relate(geom1 extensions.geometry, geom2 extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_relate(geom1 extensions.geometry, geom2 extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_relate(geom1 extensions.geometry, geom2 extensions.geometry, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_relate(geom1 extensions.geometry, geom2 extensions.geometry, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_relatematch(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_relatematch(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_removepoint(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_removepoint(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_removerepeatedpoints(geom extensions.geometry, tolerance double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_removerepeatedpoints(geom extensions.geometry, tolerance double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_reverse(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_reverse(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_rotate(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotate(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_rotate(extensions.geometry, double precision, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotate(extensions.geometry, double precision, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_rotate(extensions.geometry, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotate(extensions.geometry, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_rotatex(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotatex(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_rotatey(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotatey(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_rotatez(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotatez(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_scale(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scale(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_scale(extensions.geometry, extensions.geometry, origin extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scale(extensions.geometry, extensions.geometry, origin extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_scale(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scale(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_scale(extensions.geometry, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scale(extensions.geometry, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_scroll(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scroll(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_segmentize(geog extensions.geography, max_segment_length double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_segmentize(geog extensions.geography, max_segment_length double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_segmentize(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_segmentize(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_seteffectivearea(extensions.geometry, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_seteffectivearea(extensions.geometry, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_setpoint(extensions.geometry, integer, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_setpoint(extensions.geometry, integer, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_setsrid(geog extensions.geography, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_setsrid(geog extensions.geography, srid integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_setsrid(geom extensions.geometry, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_setsrid(geom extensions.geometry, srid integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_sharedpaths(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_sharedpaths(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_shiftlongitude(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_shiftlongitude(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_shortestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_shortestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_simplify(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplify(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_simplify(extensions.geometry, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplify(extensions.geometry, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_simplifypolygonhull(geom extensions.geometry, vertex_fraction double precision, is_outer boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplifypolygonhull(geom extensions.geometry, vertex_fraction double precision, is_outer boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_simplifypreservetopology(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplifypreservetopology(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_simplifyvw(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplifyvw(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_snap(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snap(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_snaptogrid(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snaptogrid(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_snaptogrid(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snaptogrid(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_snaptogrid(extensions.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snaptogrid(extensions.geometry, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_snaptogrid(geom1 extensions.geometry, geom2 extensions.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snaptogrid(geom1 extensions.geometry, geom2 extensions.geometry, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_split(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_split(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_square(size double precision, cell_i integer, cell_j integer, origin extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_square(size double precision, cell_i integer, cell_j integer, origin extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_squaregrid(size double precision, bounds extensions.geometry, OUT geom extensions.geometry, OUT i integer, OUT j integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_squaregrid(size double precision, bounds extensions.geometry, OUT geom extensions.geometry, OUT i integer, OUT j integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_srid(geog extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_srid(geog extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_srid(geom extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_srid(geom extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_startpoint(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_startpoint(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_subdivide(geom extensions.geometry, maxvertices integer, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_subdivide(geom extensions.geometry, maxvertices integer, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_summary(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_summary(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_summary(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_summary(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_swapordinates(geom extensions.geometry, ords cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_swapordinates(geom extensions.geometry, ords cstring) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_symdifference(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_symdifference(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_symmetricdifference(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_symmetricdifference(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_tileenvelope(zoom integer, x integer, y integer, bounds extensions.geometry, margin double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_tileenvelope(zoom integer, x integer, y integer, bounds extensions.geometry, margin double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_touches(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_touches(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_transform(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transform(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_transform(geom extensions.geometry, to_proj text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transform(geom extensions.geometry, to_proj text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_transform(geom extensions.geometry, from_proj text, to_srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transform(geom extensions.geometry, from_proj text, to_srid integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_transform(geom extensions.geometry, from_proj text, to_proj text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transform(geom extensions.geometry, from_proj text, to_proj text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_translate(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_translate(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_translate(extensions.geometry, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_translate(extensions.geometry, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_transscale(extensions.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transscale(extensions.geometry, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_triangulatepolygon(g1 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_triangulatepolygon(g1 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_unaryunion(extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_unaryunion(extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_union(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_union(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_union(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_voronoilines(g1 extensions.geometry, tolerance double precision, extend_to extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_voronoilines(g1 extensions.geometry, tolerance double precision, extend_to extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_voronoipolygons(g1 extensions.geometry, tolerance double precision, extend_to extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_voronoipolygons(g1 extensions.geometry, tolerance double precision, extend_to extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_within(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_within(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_wkbtosql(wkb bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_wkbtosql(wkb bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_wkttosql(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_wkttosql(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_wrapx(geom extensions.geometry, wrap double precision, move double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_wrapx(geom extensions.geometry, wrap double precision, move double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_x(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_x(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_xmax(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_xmax(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_xmin(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_xmin(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_y(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_y(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_ymax(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ymax(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_ymin(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ymin(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_z(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_z(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_zmax(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_zmax(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_zmflag(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_zmflag(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_zmin(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_zmin(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION unlockrows(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.unlockrows(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION updategeometrysrid(character varying, character varying, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.updategeometrysrid(character varying, character varying, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION updategeometrysrid(character varying, character varying, character varying, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.updategeometrysrid(character varying, character varying, character varying, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_accum(double precision[], extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_accum(double precision[], extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_add(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_add(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_avg(double precision[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_avg(double precision[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_cmp(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_cmp(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_combine(double precision[], double precision[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_combine(double precision[], double precision[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_dims(extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_dims(extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_eq(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_eq(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_ge(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_ge(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_gt(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_gt(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_l2_squared_distance(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_l2_squared_distance(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_le(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_le(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_lt(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_lt(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_ne(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_ne(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_negative_inner_product(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_negative_inner_product(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_norm(extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_norm(extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_spherical_distance(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_spherical_distance(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_sub(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_sub(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION comment_directive(comment_ text); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO postgres;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO anon;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO authenticated;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO service_role;


--
-- Name: FUNCTION exception(message text); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.exception(message text) TO postgres;
GRANT ALL ON FUNCTION graphql.exception(message text) TO anon;
GRANT ALL ON FUNCTION graphql.exception(message text) TO authenticated;
GRANT ALL ON FUNCTION graphql.exception(message text) TO service_role;


--
-- Name: FUNCTION get_schema_version(); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.get_schema_version() TO postgres;
GRANT ALL ON FUNCTION graphql.get_schema_version() TO anon;
GRANT ALL ON FUNCTION graphql.get_schema_version() TO authenticated;
GRANT ALL ON FUNCTION graphql.get_schema_version() TO service_role;


--
-- Name: FUNCTION increment_schema_version(); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.increment_schema_version() TO postgres;
GRANT ALL ON FUNCTION graphql.increment_schema_version() TO anon;
GRANT ALL ON FUNCTION graphql.increment_schema_version() TO authenticated;
GRANT ALL ON FUNCTION graphql.increment_schema_version() TO service_role;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: postgres
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: TABLE key; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON TABLE pgsodium.key FROM supabase_admin;
GRANT ALL ON TABLE pgsodium.key TO postgres;


--
-- Name: TABLE valid_key; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON TABLE pgsodium.valid_key FROM supabase_admin;
GRANT ALL ON TABLE pgsodium.valid_key TO postgres;


--
-- Name: FUNCTION crypto_aead_det_decrypt(ciphertext bytea, additional bytea, key bytea, nonce bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(ciphertext bytea, additional bytea, key bytea, nonce bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(ciphertext bytea, additional bytea, key bytea, nonce bytea) TO postgres;


--
-- Name: FUNCTION crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres;


--
-- Name: FUNCTION crypto_aead_det_encrypt(message bytea, additional bytea, key bytea, nonce bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key bytea, nonce bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key bytea, nonce bytea) TO postgres;


--
-- Name: FUNCTION crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_encrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres;


--
-- Name: FUNCTION crypto_aead_det_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_aead_det_keygen() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_keygen() TO service_role;
GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_keygen() TO postgres;


--
-- Name: FUNCTION crypto_aead_det_noncegen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_aead_det_noncegen() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_noncegen() TO postgres;


--
-- Name: FUNCTION crypto_aead_ietf_decrypt(message bytea, additional bytea, nonce bytea, key bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_aead_ietf_decrypt(message bytea, additional bytea, nonce bytea, key bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_aead_ietf_decrypt(message bytea, additional bytea, nonce bytea, key bytea) TO postgres;


--
-- Name: FUNCTION crypto_aead_ietf_decrypt(message bytea, additional bytea, nonce bytea, key_id bigint, context bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_aead_ietf_decrypt(message bytea, additional bytea, nonce bytea, key_id bigint, context bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_aead_ietf_decrypt(message bytea, additional bytea, nonce bytea, key_id bigint, context bytea) TO postgres;


--
-- Name: FUNCTION crypto_aead_ietf_encrypt(message bytea, additional bytea, nonce bytea, key bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_aead_ietf_encrypt(message bytea, additional bytea, nonce bytea, key bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_aead_ietf_encrypt(message bytea, additional bytea, nonce bytea, key bytea) TO postgres;


--
-- Name: FUNCTION crypto_aead_ietf_encrypt(message bytea, additional bytea, nonce bytea, key_id bigint, context bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_aead_ietf_encrypt(message bytea, additional bytea, nonce bytea, key_id bigint, context bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_aead_ietf_encrypt(message bytea, additional bytea, nonce bytea, key_id bigint, context bytea) TO postgres;


--
-- Name: FUNCTION crypto_aead_ietf_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_aead_ietf_keygen() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_aead_ietf_keygen() TO postgres;


--
-- Name: FUNCTION crypto_aead_ietf_noncegen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_aead_ietf_noncegen() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_aead_ietf_noncegen() TO postgres;


--
-- Name: FUNCTION crypto_auth(message bytea, key bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_auth(message bytea, key bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_auth(message bytea, key bytea) TO postgres;


--
-- Name: FUNCTION crypto_auth(message bytea, key_id bigint, context bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_auth(message bytea, key_id bigint, context bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_auth(message bytea, key_id bigint, context bytea) TO postgres;


--
-- Name: FUNCTION crypto_auth_hmacsha256(message bytea, secret bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_auth_hmacsha256(message bytea, secret bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_auth_hmacsha256(message bytea, secret bytea) TO postgres;


--
-- Name: FUNCTION crypto_auth_hmacsha256(message bytea, key_id bigint, context bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_auth_hmacsha256(message bytea, key_id bigint, context bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_auth_hmacsha256(message bytea, key_id bigint, context bytea) TO postgres;


--
-- Name: FUNCTION crypto_auth_hmacsha256_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_auth_hmacsha256_keygen() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_auth_hmacsha256_keygen() TO postgres;


--
-- Name: FUNCTION crypto_auth_hmacsha256_verify(hash bytea, message bytea, secret bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_auth_hmacsha256_verify(hash bytea, message bytea, secret bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_auth_hmacsha256_verify(hash bytea, message bytea, secret bytea) TO postgres;


--
-- Name: FUNCTION crypto_auth_hmacsha256_verify(hash bytea, message bytea, key_id bigint, context bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_auth_hmacsha256_verify(hash bytea, message bytea, key_id bigint, context bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_auth_hmacsha256_verify(hash bytea, message bytea, key_id bigint, context bytea) TO postgres;


--
-- Name: FUNCTION crypto_auth_hmacsha512(message bytea, secret bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_auth_hmacsha512(message bytea, secret bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_auth_hmacsha512(message bytea, secret bytea) TO postgres;


--
-- Name: FUNCTION crypto_auth_hmacsha512(message bytea, key_id bigint, context bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_auth_hmacsha512(message bytea, key_id bigint, context bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_auth_hmacsha512(message bytea, key_id bigint, context bytea) TO postgres;


--
-- Name: FUNCTION crypto_auth_hmacsha512_verify(hash bytea, message bytea, secret bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_auth_hmacsha512_verify(hash bytea, message bytea, secret bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_auth_hmacsha512_verify(hash bytea, message bytea, secret bytea) TO postgres;


--
-- Name: FUNCTION crypto_auth_hmacsha512_verify(hash bytea, message bytea, key_id bigint, context bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_auth_hmacsha512_verify(hash bytea, message bytea, key_id bigint, context bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_auth_hmacsha512_verify(hash bytea, message bytea, key_id bigint, context bytea) TO postgres;


--
-- Name: FUNCTION crypto_auth_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_auth_keygen() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_auth_keygen() TO postgres;


--
-- Name: FUNCTION crypto_auth_verify(mac bytea, message bytea, key bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_auth_verify(mac bytea, message bytea, key bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_auth_verify(mac bytea, message bytea, key bytea) TO postgres;


--
-- Name: FUNCTION crypto_auth_verify(mac bytea, message bytea, key_id bigint, context bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_auth_verify(mac bytea, message bytea, key_id bigint, context bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_auth_verify(mac bytea, message bytea, key_id bigint, context bytea) TO postgres;


--
-- Name: FUNCTION crypto_box(message bytea, nonce bytea, public bytea, secret bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_box(message bytea, nonce bytea, public bytea, secret bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_box(message bytea, nonce bytea, public bytea, secret bytea) TO postgres;


--
-- Name: FUNCTION crypto_box_new_keypair(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_box_new_keypair() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_box_new_keypair() TO postgres;


--
-- Name: FUNCTION crypto_box_noncegen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_box_noncegen() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_box_noncegen() TO postgres;


--
-- Name: FUNCTION crypto_box_open(ciphertext bytea, nonce bytea, public bytea, secret bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_box_open(ciphertext bytea, nonce bytea, public bytea, secret bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_box_open(ciphertext bytea, nonce bytea, public bytea, secret bytea) TO postgres;


--
-- Name: FUNCTION crypto_box_seed_new_keypair(seed bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_box_seed_new_keypair(seed bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_box_seed_new_keypair(seed bytea) TO postgres;


--
-- Name: FUNCTION crypto_generichash(message bytea, key bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_generichash(message bytea, key bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_generichash(message bytea, key bytea) TO postgres;


--
-- Name: FUNCTION crypto_generichash_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_generichash_keygen() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_generichash_keygen() TO postgres;


--
-- Name: FUNCTION crypto_kdf_derive_from_key(subkey_size bigint, subkey_id bigint, context bytea, primary_key bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_kdf_derive_from_key(subkey_size bigint, subkey_id bigint, context bytea, primary_key bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_kdf_derive_from_key(subkey_size bigint, subkey_id bigint, context bytea, primary_key bytea) TO postgres;


--
-- Name: FUNCTION crypto_kdf_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_kdf_keygen() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_kdf_keygen() TO postgres;


--
-- Name: FUNCTION crypto_kx_new_keypair(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_kx_new_keypair() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_kx_new_keypair() TO postgres;


--
-- Name: FUNCTION crypto_kx_new_seed(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_kx_new_seed() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_kx_new_seed() TO postgres;


--
-- Name: FUNCTION crypto_kx_seed_new_keypair(seed bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_kx_seed_new_keypair(seed bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_kx_seed_new_keypair(seed bytea) TO postgres;


--
-- Name: FUNCTION crypto_secretbox(message bytea, nonce bytea, key bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_secretbox(message bytea, nonce bytea, key bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_secretbox(message bytea, nonce bytea, key bytea) TO postgres;


--
-- Name: FUNCTION crypto_secretbox(message bytea, nonce bytea, key_id bigint, context bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_secretbox(message bytea, nonce bytea, key_id bigint, context bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_secretbox(message bytea, nonce bytea, key_id bigint, context bytea) TO postgres;


--
-- Name: FUNCTION crypto_secretbox_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_secretbox_keygen() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_secretbox_keygen() TO postgres;


--
-- Name: FUNCTION crypto_secretbox_noncegen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_secretbox_noncegen() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_secretbox_noncegen() TO postgres;


--
-- Name: FUNCTION crypto_secretbox_open(ciphertext bytea, nonce bytea, key bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_secretbox_open(ciphertext bytea, nonce bytea, key bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_secretbox_open(ciphertext bytea, nonce bytea, key bytea) TO postgres;


--
-- Name: FUNCTION crypto_secretbox_open(message bytea, nonce bytea, key_id bigint, context bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_secretbox_open(message bytea, nonce bytea, key_id bigint, context bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_secretbox_open(message bytea, nonce bytea, key_id bigint, context bytea) TO postgres;


--
-- Name: FUNCTION crypto_shorthash(message bytea, key bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_shorthash(message bytea, key bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_shorthash(message bytea, key bytea) TO postgres;


--
-- Name: FUNCTION crypto_shorthash_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_shorthash_keygen() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_shorthash_keygen() TO postgres;


--
-- Name: FUNCTION crypto_sign_final_create(state bytea, key bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_sign_final_create(state bytea, key bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_sign_final_create(state bytea, key bytea) TO postgres;


--
-- Name: FUNCTION crypto_sign_final_verify(state bytea, signature bytea, key bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_sign_final_verify(state bytea, signature bytea, key bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_sign_final_verify(state bytea, signature bytea, key bytea) TO postgres;


--
-- Name: FUNCTION crypto_sign_init(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_sign_init() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_sign_init() TO postgres;


--
-- Name: FUNCTION crypto_sign_new_keypair(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_sign_new_keypair() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_sign_new_keypair() TO postgres;


--
-- Name: FUNCTION crypto_sign_update(state bytea, message bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_sign_update(state bytea, message bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_sign_update(state bytea, message bytea) TO postgres;


--
-- Name: FUNCTION crypto_sign_update_agg1(state bytea, message bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_sign_update_agg1(state bytea, message bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_sign_update_agg1(state bytea, message bytea) TO postgres;


--
-- Name: FUNCTION crypto_sign_update_agg2(cur_state bytea, initial_state bytea, message bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_sign_update_agg2(cur_state bytea, initial_state bytea, message bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_sign_update_agg2(cur_state bytea, initial_state bytea, message bytea) TO postgres;


--
-- Name: FUNCTION crypto_signcrypt_new_keypair(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_signcrypt_new_keypair() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_signcrypt_new_keypair() TO postgres;


--
-- Name: FUNCTION crypto_signcrypt_sign_after(state bytea, sender_sk bytea, ciphertext bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_signcrypt_sign_after(state bytea, sender_sk bytea, ciphertext bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_signcrypt_sign_after(state bytea, sender_sk bytea, ciphertext bytea) TO postgres;


--
-- Name: FUNCTION crypto_signcrypt_sign_before(sender bytea, recipient bytea, sender_sk bytea, recipient_pk bytea, additional bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_signcrypt_sign_before(sender bytea, recipient bytea, sender_sk bytea, recipient_pk bytea, additional bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_signcrypt_sign_before(sender bytea, recipient bytea, sender_sk bytea, recipient_pk bytea, additional bytea) TO postgres;


--
-- Name: FUNCTION crypto_signcrypt_verify_after(state bytea, signature bytea, sender_pk bytea, ciphertext bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_signcrypt_verify_after(state bytea, signature bytea, sender_pk bytea, ciphertext bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_signcrypt_verify_after(state bytea, signature bytea, sender_pk bytea, ciphertext bytea) TO postgres;


--
-- Name: FUNCTION crypto_signcrypt_verify_before(signature bytea, sender bytea, recipient bytea, additional bytea, sender_pk bytea, recipient_sk bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_signcrypt_verify_before(signature bytea, sender bytea, recipient bytea, additional bytea, sender_pk bytea, recipient_sk bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_signcrypt_verify_before(signature bytea, sender bytea, recipient bytea, additional bytea, sender_pk bytea, recipient_sk bytea) TO postgres;


--
-- Name: FUNCTION crypto_signcrypt_verify_public(signature bytea, sender bytea, recipient bytea, additional bytea, sender_pk bytea, ciphertext bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.crypto_signcrypt_verify_public(signature bytea, sender bytea, recipient bytea, additional bytea, sender_pk bytea, ciphertext bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.crypto_signcrypt_verify_public(signature bytea, sender bytea, recipient bytea, additional bytea, sender_pk bytea, ciphertext bytea) TO postgres;


--
-- Name: FUNCTION derive_key(key_id bigint, key_len integer, context bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.derive_key(key_id bigint, key_len integer, context bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.derive_key(key_id bigint, key_len integer, context bytea) TO postgres;


--
-- Name: FUNCTION pgsodium_derive(key_id bigint, key_len integer, context bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.pgsodium_derive(key_id bigint, key_len integer, context bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.pgsodium_derive(key_id bigint, key_len integer, context bytea) TO postgres;


--
-- Name: FUNCTION randombytes_buf(size integer); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.randombytes_buf(size integer) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.randombytes_buf(size integer) TO postgres;


--
-- Name: FUNCTION randombytes_buf_deterministic(size integer, seed bytea); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.randombytes_buf_deterministic(size integer, seed bytea) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.randombytes_buf_deterministic(size integer, seed bytea) TO postgres;


--
-- Name: FUNCTION randombytes_new_seed(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.randombytes_new_seed() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.randombytes_new_seed() TO postgres;


--
-- Name: FUNCTION randombytes_random(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.randombytes_random() FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.randombytes_random() TO postgres;


--
-- Name: FUNCTION randombytes_uniform(upper_bound integer); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgsodium.randombytes_uniform(upper_bound integer) FROM supabase_admin;
GRANT ALL ON FUNCTION pgsodium.randombytes_uniform(upper_bound integer) TO postgres;


--
-- Name: FUNCTION add_captain_membership(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.add_captain_membership() TO anon;
GRANT ALL ON FUNCTION public.add_captain_membership() TO authenticated;
GRANT ALL ON FUNCTION public.add_captain_membership() TO service_role;


--
-- Name: FUNCTION create_metadata(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.create_metadata() TO anon;
GRANT ALL ON FUNCTION public.create_metadata() TO authenticated;
GRANT ALL ON FUNCTION public.create_metadata() TO service_role;


--
-- Name: TABLE user_metadata; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_metadata TO anon;
GRANT ALL ON TABLE public.user_metadata TO authenticated;
GRANT ALL ON TABLE public.user_metadata TO service_role;


--
-- Name: FUNCTION users_without_team(e_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.users_without_team(e_id uuid) TO anon;
GRANT ALL ON FUNCTION public.users_without_team(e_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.users_without_team(e_id uuid) TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;


--
-- Name: FUNCTION extension(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.extension(name text) TO anon;
GRANT ALL ON FUNCTION storage.extension(name text) TO authenticated;
GRANT ALL ON FUNCTION storage.extension(name text) TO service_role;
GRANT ALL ON FUNCTION storage.extension(name text) TO dashboard_user;
GRANT ALL ON FUNCTION storage.extension(name text) TO postgres;


--
-- Name: FUNCTION filename(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.filename(name text) TO anon;
GRANT ALL ON FUNCTION storage.filename(name text) TO authenticated;
GRANT ALL ON FUNCTION storage.filename(name text) TO service_role;
GRANT ALL ON FUNCTION storage.filename(name text) TO dashboard_user;
GRANT ALL ON FUNCTION storage.filename(name text) TO postgres;


--
-- Name: FUNCTION foldername(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.foldername(name text) TO anon;
GRANT ALL ON FUNCTION storage.foldername(name text) TO authenticated;
GRANT ALL ON FUNCTION storage.foldername(name text) TO service_role;
GRANT ALL ON FUNCTION storage.foldername(name text) TO dashboard_user;
GRANT ALL ON FUNCTION storage.foldername(name text) TO postgres;


--
-- Name: FUNCTION get_size_by_bucket(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.get_size_by_bucket() TO postgres;


--
-- Name: FUNCTION search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) TO postgres;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.update_updated_at_column() TO postgres;


--
-- Name: FUNCTION avg(extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.avg(extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_3dextent(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dextent(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asflatgeobuf(anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asflatgeobuf(anyelement) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asflatgeobuf(anyelement, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asflatgeobuf(anyelement, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asflatgeobuf(anyelement, boolean, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asflatgeobuf(anyelement, boolean, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asgeobuf(anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeobuf(anyelement) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asgeobuf(anyelement, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeobuf(anyelement, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asmvt(anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asmvt(anyelement, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asmvt(anyelement, text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement, text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asmvt(anyelement, text, integer, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement, text, integer, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_asmvt(anyelement, text, integer, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement, text, integer, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_clusterintersecting(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterintersecting(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_clusterwithin(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterwithin(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_collect(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collect(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_extent(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_extent(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_makeline(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makeline(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_memcollect(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_memcollect(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_memunion(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_memunion(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_polygonize(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonize(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_union(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION st_union(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT ALL ON TABLE auth.audit_log_entries TO postgres;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.flow_state TO postgres;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.identities TO postgres;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT ALL ON TABLE auth.instances TO postgres;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.mfa_amr_claims TO postgres;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.mfa_challenges TO postgres;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.mfa_factors TO postgres;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT ALL ON TABLE auth.refresh_tokens TO postgres;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.saml_providers TO postgres;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.saml_relay_states TO postgres;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.schema_migrations TO dashboard_user;
GRANT ALL ON TABLE auth.schema_migrations TO postgres;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.sessions TO postgres;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.sso_domains TO postgres;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.sso_providers TO postgres;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT ALL ON TABLE auth.users TO postgres;


--
-- Name: TABLE geography_columns; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.geography_columns TO postgres WITH GRANT OPTION;


--
-- Name: TABLE geometry_columns; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.geometry_columns TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;


--
-- Name: TABLE spatial_ref_sys; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.spatial_ref_sys TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE seq_schema_version; Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE graphql.seq_schema_version TO postgres;
GRANT ALL ON SEQUENCE graphql.seq_schema_version TO anon;
GRANT ALL ON SEQUENCE graphql.seq_schema_version TO authenticated;
GRANT ALL ON SEQUENCE graphql.seq_schema_version TO service_role;


--
-- Name: TABLE decrypted_key; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.decrypted_key TO pgsodium_keyholder;


--
-- Name: SEQUENCE key_key_id_seq; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

REVOKE ALL ON SEQUENCE pgsodium.key_key_id_seq FROM supabase_admin;
GRANT ALL ON SEQUENCE pgsodium.key_key_id_seq TO postgres;


--
-- Name: TABLE masking_rule; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.masking_rule TO pgsodium_keyholder;


--
-- Name: TABLE mask_columns; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.mask_columns TO pgsodium_keyholder;


--
-- Name: TABLE admins; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.admins TO anon;
GRANT ALL ON TABLE public.admins TO authenticated;
GRANT ALL ON TABLE public.admins TO service_role;


--
-- Name: TABLE events; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.events TO anon;
GRANT ALL ON TABLE public.events TO authenticated;
GRANT ALL ON TABLE public.events TO service_role;


--
-- Name: TABLE games; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.games TO anon;
GRANT ALL ON TABLE public.games TO authenticated;
GRANT ALL ON TABLE public.games TO service_role;


--
-- Name: TABLE groupchat_data; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.groupchat_data TO anon;
GRANT ALL ON TABLE public.groupchat_data TO authenticated;
GRANT ALL ON TABLE public.groupchat_data TO service_role;


--
-- Name: TABLE groupchat_memberships; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.groupchat_memberships TO anon;
GRANT ALL ON TABLE public.groupchat_memberships TO authenticated;
GRANT ALL ON TABLE public.groupchat_memberships TO service_role;


--
-- Name: TABLE groupchat_memberships_friendly; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.groupchat_memberships_friendly TO anon;
GRANT ALL ON TABLE public.groupchat_memberships_friendly TO authenticated;
GRANT ALL ON TABLE public.groupchat_memberships_friendly TO service_role;


--
-- Name: TABLE groupchat_data_friendly; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.groupchat_data_friendly TO anon;
GRANT ALL ON TABLE public.groupchat_data_friendly TO authenticated;
GRANT ALL ON TABLE public.groupchat_data_friendly TO service_role;


--
-- Name: TABLE groupchats; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.groupchats TO anon;
GRANT ALL ON TABLE public.groupchats TO authenticated;
GRANT ALL ON TABLE public.groupchats TO service_role;


--
-- Name: TABLE locations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.locations TO anon;
GRANT ALL ON TABLE public.locations TO authenticated;
GRANT ALL ON TABLE public.locations TO service_role;


--
-- Name: TABLE team_memberships; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.team_memberships TO anon;
GRANT ALL ON TABLE public.team_memberships TO authenticated;
GRANT ALL ON TABLE public.team_memberships TO service_role;


--
-- Name: TABLE teams; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.teams TO anon;
GRANT ALL ON TABLE public.teams TO authenticated;
GRANT ALL ON TABLE public.teams TO service_role;


--
-- Name: TABLE my_teams; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.my_teams TO anon;
GRANT ALL ON TABLE public.my_teams TO authenticated;
GRANT ALL ON TABLE public.my_teams TO service_role;


--
-- Name: TABLE my_events; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.my_events TO anon;
GRANT ALL ON TABLE public.my_events TO authenticated;
GRANT ALL ON TABLE public.my_events TO service_role;


--
-- Name: TABLE team_memberships_friendly; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.team_memberships_friendly TO anon;
GRANT ALL ON TABLE public.team_memberships_friendly TO authenticated;
GRANT ALL ON TABLE public.team_memberships_friendly TO service_role;


--
-- Name: TABLE my_games; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.my_games TO anon;
GRANT ALL ON TABLE public.my_games TO authenticated;
GRANT ALL ON TABLE public.my_games TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres;


--
-- Name: TABLE migrations; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.migrations TO anon;
GRANT ALL ON TABLE storage.migrations TO authenticated;
GRANT ALL ON TABLE storage.migrations TO service_role;
GRANT ALL ON TABLE storage.migrations TO postgres;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON SEQUENCES  TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON TABLES  TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON SEQUENCES  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON FUNCTIONS  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON TABLES  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE SCHEMA')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

