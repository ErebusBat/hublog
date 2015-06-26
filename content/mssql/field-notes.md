+++
# Original file converted from DokuWiki on 2015-03-02T22:26:10-07:00:
#    /data/opt/wiki/data/pages/apps/mssql.txt
title =  "Microsoft SQL Server Field Notes"
date =   "2014-03-26T16:41:06-06:00"
category = "wiki"
tags = ["mssql", "field-notes", "DokuWiki"]
aliases = ["/wiki/2014/03/26/mssql.html"]
+++

Random field notes on Microsoft SQL Server

------------------------------------------------------------------------
## Misc Snippets
~~~ sql
-- Create new table from select:
SELECT [WHFCustomerID], [CustomerNumber], [LastName], [FirstName], [MiddleInitial], [Address], [City], [State], [Zip], [PhoneNumber], [SocialSecurityNumber], [MedicaidID], [EmailAddress], [DateOfBirth], [Sex], [DateCreated], [DateUpdated], [WHFConvertDate], [MayoEventCode], [MayoUpdateDate]
INTO Roundup_Test.dbo.Customers
FROM Roundup.[dbo].[Customers];

-- Insert into existing table from select
INSERT INTO Customers
SELECT [WHFCustomerID], [CustomerNumber], [LastName], [FirstName], [MiddleInitial], [Address], [City], [State], [Zip], [PhoneNumber], [SocialSecurityNumber], [MedicaidID], [EmailAddress], [DateOfBirth], [Sex], [DateCreated], [DateUpdated], [WHFConvertDate], [MayoEventCode], [MayoUpdateDate]
FROM Roundup.[dbo].[Customers];

--Strip time component
update C
SET C.DateOfBirth=DATEADD(dd, DATEDIFF(dd, 0, C.DateOfBirth), 0)
from Customers C
where C.CustomerNumber like 'W85%';

-- Display date as mm/dd/yyyy (text)
select convert(char(10),getdate(), 0),101) as Today
select convert(char(10),DATEADD(dd, DATEDIFF(dd, 0, CD.DateCollected), 0),101) as DateCollected

-- bundle_participants

-- TRUNCATE TABLE Roundup_Test.dbo.bundle_participants;
-- DROP TABLE Roundup_Test.dbo.bundle_participants;

SET IDENTITY_INSERT Roundup_Test.dbo.bundle_participants ON;
INSERT INTO Roundup_Test.dbo.bundle_participants
(id,portal_id, family_id, family_seq_number, customer_number, member_id, ssn, dob, last_name, first_name, member_class, relationship_code, relationship_desc, is_split, address, city, state, zipcode, start_date, end_date, agency_code, gender, activation_date, sub_agency1, sub_agency2, is_termed, member_uid, phone_number, email, bundle_id, matched_by, created_at, updated_at )
SELECT *
  FROM Roundup.dbo.bundle_participants;
SET IDENTITY_INSERT Roundup_Test.dbo.bundle_participants OFF;


delete from Roundup.dbo.bundle_participants where portal_id=1;
INSERT INTO Roundup.dbo.bundle_participants
SELECT  [portal_id], [family_id], [family_seq_number], [customer_number], [member_id], [ssn], [dob], [last_name], [first_name], [member_class], [relationship_code], [relationship_desc], [is_split], [address], [city], [state], [zipcode], [start_date], [end_date], [agency_code], [gender], [activation_date], [sub_agency1], [sub_agency2], [is_termed], [phone_number], [email], [bundle_id], [matched_by], [created_at], [updated_at]
	FROM Roundup_test.[dbo].[bundle_participants]
 where portal_id=1;



--Update with JOIN
-- http://stackoverflow.com/questions/1604091/update-a-table-using-join-in-sql-server
UPDATE t1
  SET t1.CalculatedColumn = t2.[Calculated Column]
  FROM dbo.Table1 AS t1
  INNER JOIN dbo.Table2 AS t2
  ON t1.CommonField = t2.[Common Field]
  WHERE t1.BatchNo = '110';

~~~

## DDL/Management
~~~ sql
-- Find FK References
SELECT
    f.name AS ForeignKey,
    OBJECT_NAME(f.parent_object_id) AS TableName,
    COL_NAME(fc.parent_object_id,
    fc.parent_column_id) AS ColumnName,
    OBJECT_NAME (f.referenced_object_id) AS ReferenceTableName,
    COL_NAME(fc.referenced_object_id,
    fc.referenced_column_id) AS ReferenceColumnName
FROM
    sys.foreign_keys AS f
    INNER JOIN sys.foreign_key_columns AS fc ON f.OBJECT_ID = fc.constraint_object_id
ORDER BY ReferenceTableName;
~~~
