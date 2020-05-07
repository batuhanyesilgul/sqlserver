
alter proc pr_collated(@table_name nvarchar(max),@ecollation nvarchar(max)='',@ycollation nvarchar(max)='')

AS
BEGIN
		DECLARE @column_name nvarchar(100)
		DECLARE @data_type nvarchar(50)
		DECLARE @uzunluk nvarchar(50)
		DECLARE @collate_degistir nvarchar(100)
		DECLARE crs_collated CURSOR FOR
		SELECT COLUMN_NAME,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH,TABLE_NAME  FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE (@table_name is null or  TABLE_NAME=@table_name) and DATA_TYPE  LIKE '%char%' and COLLATION_NAME=@ecollation 
		OPEN crs_collated
		FETCH NEXT FROM crs_collated INTO @column_name,@data_type,@uzunluk,@table_name
		WHILE @@FETCH_STATUS=0
		BEGIN
		--print 'ALTER TABLE '+@table_name+' ALTER COLUMN '+@column_name+' '+@data_type+'('+@uzunluk +')'+' COLLATE '+@ecollation
		SET @collate_degistir='ALTER TABLE '+@table_name+' ALTER COLUMN '+@column_name+' '+@data_type+'('+@uzunluk +')'+' COLLATE '+@ycollation
		print @collate_degistir
		exec (@collate_degistir)
		FETCH NEXT FROM crs_collated INTO @column_name,@data_type,@uzunluk,@table_name
		END
		CLOSE crs_collated
		DEALLOCATE crs_collated
		end



exec pr_collated NULL,'Turkish_CI_AS','Albanian_CS_AI_KS'

Turkish_CI_AS

SELECT TABLE_NAME,COLUMN_NAME,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH,COLLATION_NAME  FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE DATA_TYPE NOT LIKE '%t%' AND COLLATION_NAME  NOT LIKE '%NULL%' and TABLE_NAME='ACENTA'   ORDER BY COLLATION_NAME

		
		ALTER TABLE ACENTA
		ALTER COLUMN KODU nvarchar(80)  COLLATE Albanian_CS_AI_KS

		SELECT * FROM INFORMATION_SCHEMA.COLUMNS
		SELECT * FROM SYS.schemas
		SELECT * FROM SYS.tables
		SELECT * FROM SYS.views
		select * from sys.columns


		Albanian_CS_AI_KS
		


-----------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--EXECUTE sp_refreshview [ @viewname = ] 'viewname' -- sp_refreshview syntax
--Execute sp_refreshview 'ADISYON' -- as an example



------------------------------------------------------------------------------------------------------------------
--		IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'exe')) þema oluþturma                           --
--BEGIN                                                                                                         --
--    EXEC ('CREATE SCHEMA [exe] AUTHORIZATION [dbo]')
--END
		

--ALTER SCHEMA dbo 
--    TRANSFER dbo.QFO4_REZKISIþema deðiþtirme

--		ALTER SCHEMA [EXE]
--    TRANSFER [dbo].[QFO4_REZKISI]
------------------------------------------------------------------------------------------------------------------



--ALTER TABLE MISAFIR_ONLINE
--ALTER COLUMN REZKISIID VARCHAR(50) COLLATE Latin1_General_100_CI_AI_SC--COLUMN COLLATE

--ALTER TABLE MISAFIR_ONLINE ALTER COLUMN FILCE nvarchar COLLATE Albanian_CS_AI_KS

--select * from INFORMATION_SCHEMA.COLUMNS

--ALTER TABLE MISAFIR_ONLINE ALTER COLUMN AD nvarchar(100) COLLATE Albanian_CS_AI_KS






--alter proc degisim (@yecollation nvarchar(max)='')
--AS
--BEGIN
--ALTER TABLE @table_name ALTER COLUMN FILCE nvarchar COLLATE Albanian_CS_AI_KS

--END

 --DBCC FREEPROCCACHE



-- IF EXISTS (
--SELECT 1 FROM sys.indexes I
--JOIN sys.tables T ON I.object_id=T.object_id
--JOIN sys.schemas S ON S.schema_id=T.schema_id
--WHERE I.Name='PK_Product_ProductID' --Ýndex Adý
--AND T.Name='ACENTA' -- Tablo Adý
--AND S.Name='ACENTAID' -- Þema Adý
--)
--BEGIN
--PRINT 'Index Mevcut'
--END
--ELSE
--BEGIN
--PRINT 'Index Mevcut Deðil'
--END
