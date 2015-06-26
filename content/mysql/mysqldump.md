+++
Tags = ["mysql", "field-notes"]
Description = ""
date = "2014-04-15T20:07:28-06:00"
title = "MySQL Dump Field Notes"
Aliases = ["/wiki/2014/04/15/mysql-dump.html"]
+++

#### Large Tables
  * http://stackoverflow.com/questions/5666784/how-can-i-slow-down-a-mysql-dump-as-to-not-affect-current-load-on-the-server

~~~ bash
# http://stackoverflow.com/a/12142501/3683
mysqldump -u USER -p --single-transaction --quick \
  --lock-tables=false DATABASE | gzip > OUTPUT.gz
~~~

#### Examples
~~~ bash
mysqldump [options] [db_name [tbl_name ...]]

# Copy a subset of content to another server (-t no create table, -i add info comments):
mysqldump -i -t -uroot database_development contents \
  --where="url LIKE 'corporate/protected%'" \
  | ssh devsrv "mysql database_production"

mysqldump database_production widgets \
  | bzip2 -c > production_widgets.sql.bz2

bzcat db/sql/production_widgets.sql.bz2 \
  | mysql -uroot database_development

# Dump table over SSH tunnel w/o temp file
ssh prodsrv "mysqldump database_production widgets" \
  | mysql -uroot database_development
ssh prodsrv "mysqldump database_production contents" \
  | mysql -uroot database_development

# Dump table over SSH, compress
ssh prodsrv "mysqldump database_production widgets \
  | gzip" \
  | gzip -d \
  | mysql -uroot database_development

# Dump table to date/time stamped GPG encrypted file
mysqldump database_production widgets \
  | gpg -e -r user@domain.com -o "widgets-$(date +%Y%m%d-%H%M%S).sql.gpg"
~~~


#### Move tables/data around
~~~ bash
# Copy table from local server to remote server, compressing the transport
mysqldump -uroot database_development portal_agencies \
  | gzip \
  | ssh prodsrv "gzip -d | mysql database_production"

# Copy table from remote server to local, compress
ssh prodsrv "mysqldump database_production portal_agencies | gzip" \
  | gzip -d \
  | mysql -uroot database_development

# Copy table from production to file on local workstation
ssh prodsrv "mysqldump database_production --comments widgets \
  | bzip2 -c" > widgets.sql.bz2
~~~
