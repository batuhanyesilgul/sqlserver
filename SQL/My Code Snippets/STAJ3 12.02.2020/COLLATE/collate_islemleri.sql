SELECT * FROM fn_helpcollations()

SELECT SERVERPROPERTY('collation')
--EXEC sp_configure
EXEC sp_helpsort

SELECT name, collation_name FROM sys.databases  --kayýtlý olan database ve collateleri


SELECT name, COLLATIONPROPERTY(name, 'CodePage') as Code_Page, description FROM sys.fn_HelpCollations()