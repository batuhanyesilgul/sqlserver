
--DATABASE COLLACTÝON DEÐÝÞTÝRME


GO
-- Set to single-user mode
ALTER DATABASE [ELEKTRA]
SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
  
 
ALTER DATABASE [ELEKTRA]
COLLATE SQL_Latin1_General_CP1_CI_AI
GO  
 
-- Set to multi-user mode
ALTER DATABASE [ELEKTRA]
SET MULTI_USER WITH ROLLBACK IMMEDIATE;
GO  
 
 --SELECT name, Uighur_100_CI_AI; 
--FROM sys.databases  
--WHERE name = 'Uighur_100_CI_AI;';  
--GO






--USE master;
--GO
--ALTER DATABASE [DatabaseName]
--COLLATE SQL_Latin1_General_CP1_CI_AS ;
--GO
 

--SELECT name, collation_name
--FROM sys.databases
--WHERE name = N'[DatabaseName]';
--GO

--drop trigger[DBTRG_VIEW_FUNC_SP_DONT_DROP]