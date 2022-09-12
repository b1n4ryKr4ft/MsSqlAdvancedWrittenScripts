Postgres Important scripts:
===========================

1] Database Uptime
-------------------
select date_trunc('second', current_timestamp - pg_postmaster_start_time()) as uptime;

2] Show data directory
----------------------
show data_directory;

3] Get databases
-----------------
select datname from pg_database;

4] Get all tables
------------------
select count(*) from information_schema.tables
where table_schema not in ('information_schema', 'pg_catalog');