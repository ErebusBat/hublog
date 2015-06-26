+++
title   = "Calculating Table Sizes in MySQL"
date    =   "2014-04-15T13:57:40-06:00"
Tags = ["mysql"]
Aliases = ["wiki/2014/04/15/mysql-size_calculations.html"]
+++

###### Links
  * [SO: how-can-you-determine-how-much-disk-space-a-particular-mysql-table-is-taking-up](http://stackoverflow.com/a/6474642/3683)

~~~ sql
--BYTES
SELECT (data_length+index_length) tablesize
FROM information_schema.tables
WHERE table_schema='mydb' and table_name='mytable';

--KILOBYTES
SELECT (data_length+index_length)/power(1024,1) tablesize_kb
FROM information_schema.tables
WHERE table_schema='mydb' and table_name='mytable';

--MEGABYTES
SELECT (data_length+index_length)/power(1024,2) tablesize_mb
FROM information_schema.tables
WHERE table_schema='mydb' and table_name='mytable';

--GIGABYTES
SELECT (data_length+index_length)/power(1024,3) tablesize_gb
FROM information_schema.tables
WHERE table_schema='mydb' and table_name='mytable';


--GENERIC
--Here is a generic query where the maximum unit display is TB (TeraBytes)
SELECT
    CONCAT(FORMAT(DAT/POWER(1024,pw1),2),' ',SUBSTR(units,pw1*2+1,2)) DATSIZE,
    CONCAT(FORMAT(NDX/POWER(1024,pw2),2),' ',SUBSTR(units,pw2*2+1,2)) NDXSIZE,
    CONCAT(FORMAT(TBL/POWER(1024,pw3),2),' ',SUBSTR(units,pw3*2+1,2)) TBLSIZE
FROM
(
    SELECT DAT,NDX,TBL,IF(px>4,4,px) pw1,IF(py>4,4,py) pw2,IF(pz>4,4,pz) pw3
    FROM
    (
        SELECT data_length DAT,index_length NDX,data_length+index_length TBL,
        FLOOR(LOG(IF(data_length=0,1,data_length))/LOG(1024)) px,
        FLOOR(LOG(IF(index_length=0,1,index_length))/LOG(1024)) py,
        FLOOR(LOG(IF(data_length+index_length=0,1,data_length+index_length))/LOG(1024)) pz
        FROM information_schema.tables
        WHERE table_schema='mydb'
        AND table_name='mytable'
    ) AA
) A,(SELECT 'B KBMBGBTB' units) B;
~~~
