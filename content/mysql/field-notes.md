+++
Tags = ["mysql", "field-notes"]
Description = ""
date = "2012-09-13T20:51:28-06:00"
title = "MySQL Field Notes"
Aliases = ["/wiki/2012/09/13/mysql.html"]
+++

Misc notes and snippets in a _Field Notes_ style
<!--more-->

## Create DB / User
Make sure the DB exists with a ''mysqladmin create jira'' first

~~~ sql
-- Create User
CREATE USER 'jira'@'localhost' IDENTIFIED BY 'password';

-- Grant root on jira DB
GRANT ALL PRIVILEGES ON jira.* TO 'jira'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- Grant root on all DBs/tables
GRANT ALL PRIVILEGES ON *.* TO 'jira'@'localhost' WITH GRANT OPTION;
~~~

## Dates
http://dev.mysql.com/doc/refman/5.5/en/date-and-time-functions.html

~~~ sql
SELECT DATE_FORMAT(created_at,GET_FORMAT(DATE,'USA')) FROM users ;
-- 12.07.2011
~~~

## Coderwalls
[Move Homebrew MySql datadir](https://coderwall.com/p/gfwcfw)

## Commands

~~~ sql
use database;
drop user 'database'@'127.0.0.1';
show tables;
describe table;
select Host,User from user;
delete from user where Host='192.168.85.70';
FLUSH PRIVILEGES;
~~~

## Update User Passwords

~~~ sql
--# Method 1
use mysql;
SET PASSWORD FOR 'user-name-here'@'hostname-name-here' = PASSWORD('new-password-here');

--# Method 2
UPDATE mysql.user SET Password=PASSWORD('new-password-here') WHERE User='user-name-here' AND Host='host-name-here';
FLUSH PRIVILEGES;

~~~
