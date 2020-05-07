SELECT CONVERT (varchar, SERVERPROPERTY('collation'))AS 'Server Collation'
SELECT name,collation_name FROM sys.databases WHERE name='ELEKTRA';
SELECT name,collation_name FROM sys.databases WHERE name='Product';
SELECT COLUMN_NAME,COLLATION_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='
ProductGuid'
