+++
# Original file converted from DokuWiki on 2015-07-01T11:05:17-06:00:
#    /data/opt/wiki/data/pages/pgsql/initdb.txt
title = "initdb.txt pgsql initdb"
date  = "2014-06-27T21:10:29-06:00"
tags  = ["pgsql","DokuWiki"]
+++

## PostgreSQL
  * http://www.postgresql.org/docs/9.4/static/app-initdb.html

`initdb` creates a new PostgreSQL database cluster. A database cluster is a collection of databases that are managed by a single server instance.

`initdb` must be run as the user that will own the server process, because the server needs to have access to the files and directories that initdb creates.


~~~
$ initdb -D /usr/local/var/postgres                                                                       The files belonging to this database system will be owned by user "aburns".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.UTF-8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /usr/local/var/postgres ... ok
creating subdirectories ... ok
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
creating configuration files ... ok
creating template1 database in /usr/local/var/postgres/base/1 ... ok
initializing pg_authid ... ok
initializing dependencies ... ok
creating system views ... ok
loading system objects' descriptions ... ok
creating collations ... ok
creating conversions ... ok
creating dictionaries ... ok
setting privileges on built-in objects ... ok
creating information schema ... ok
loading PL/pgSQL server-side language ... ok
vacuuming database template1 ... ok
copying template1 to template0 ... ok
copying template1 to postgres ... ok
syncing data to disk ... ok

WARNING: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.

Success. You can now start the database server using:

    postgres -D /usr/local/var/postgres
or
    pg_ctl -D /usr/local/var/postgres -l logfile start
~~~
