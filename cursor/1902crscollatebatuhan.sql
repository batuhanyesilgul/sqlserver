

--alter proc sp_collate_degisimison(@tabloadi nvarchar(255)='',@ecollation nvarchar(255)='',@ycollation nvarchar(255)='')
--AS
--BEGIN
--DECLARE 
--SELECT 'ALTER TABLE ' + TABLE_NAME +
--' ALTER COLUMN ' + COLUMN_NAME + ' ' + DATA_TYPE +
--CASE WHEN CHARACTER_MAXIMUM_LENGTH = -1 THEN '(max)'
--WHEN DATA_TYPE in ('text','ntext') THEN ''
--WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL
--THEN '('+(CONVERT(VARCHAR,CHARACTER_MAXIMUM_LENGTH)+')' )
--ELSE
--ISNULL(CONVERT(VARCHAR,CHARACTER_MAXIMUM_LENGTH),' ')
--END
--+' ESK� COLLATE: '+@ecollation+' YEN� COLLATE: '+@ycollation +
--CASE IS_NULLABLE WHEN 'YES' THEN ' NULL' WHEN 'No' THEN 'NOT NULL'
--END
--FROM INFORMATION_SCHEMA.COLUMNS
--WHERE DATA_TYPE IN ('varchar' ,'char','nvarchar','nchar','text','ntext')
--AND COLLATION_NAME = @ecollation AND TABLE_NAME=@tabloadi --AND TABLE_NAME IS NOT NULL AND COLLATION_NAME IS NOT NULL

--END

--exec sp_collate_degisimison 'MISAFIR_ONLINE', 'Turkish_CI_AS','Latin1_General_CI_AS_KS_WS'


SELECT * from INFORMATION_SCHEMA.COLUMNS 

alter PROC collation_get(@tabloadi nvarchar(255)='',@ecollation nvarchar(255)='',@ycollation nvarchar(255)='')
AS
BEGIN
		DECLARE @collation_name nvarchar(100)
		DECLARE @str nvarchar(max)
		DECLARE crs_get_collation CURSOR FOR
		
		SELECT 'ALTER TABLE ' + TABLE_NAME +
' ALTER COLUMN ' + COLUMN_NAME + ' ' +
CASE WHEN CHARACTER_MAXIMUM_LENGTH = -1 THEN '(max)'
WHEN DATA_TYPE in ('text','ntext') THEN ''
WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL
THEN '('+(CONVERT(VARCHAR,CHARACTER_MAXIMUM_LENGTH)+')' )
ELSE
ISNULL(CONVERT(VARCHAR,CHARACTER_MAXIMUM_LENGTH),' ')
END
+' ESK� COLLATE: '+@ecollation+' YEN� COLLATE: '+@ycollation +
CASE IS_NULLABLE WHEN 'YES' THEN ' NULL' WHEN 'No' THEN 'NOT NULL'
END

		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME=@tabloadi --and COLUMN_NAME=@column_name
		OPEN crs_get_collation
		FETCH NEXT FROM crs_get_collation
		INTO @collation_name
		WHILE @@FETCH_STATUS=0
		BEGIN
		--UPDATE SALES SET ITEMCODE='1903' WHERE ITEMCODE='00000000008'
		--UPDATE INFORMATION_SCHEMA.COLUMNS SET COLLATION_NAME=@ycollation WHERE COLLATION_NAME=@ecollation
		 SET @str ='ALTER DATABASE '+@tabloadi+' SET SINGLE_USER WITH ROLLBAC IMMEDIATE '++' ALTER DATABASE '+@tabloadi+' COLLATE '+@ycollation+
					' ALTER DATABASE '+@tabloadi+' SET MULTI_USER '
		PRINT @str

		FETCH NEXT FROM crs_get_collation
		END
		CLOSE crs_get_collation
		DEALLOCATE crs_get_collation
END
--ALTER DATABASE SampleDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE
--ALTER DATABASE SampleDB COLLATE TURKISH_CI_AS
--ALTER DATABASE SampleDB SET MULTI_USER

exec collation_get 'MISAFIR_ONLINE', 'Turkish_CI_AS','Latin1_General_CI_AS_KS_WS'
 
--select * from SALES 


--SELECT ITEMNAME,COUNT(*)AS sayi FROM SALES  WHERE ITEMCODE=00000005863 group by ITEMNAME

--alter PROC SalesGetir
--@item_code int
--AS
--BEGIN
--	DECLARE @urunadi nvarchar(100)
--	DECLARE cursor_yapisi CURSOR for SELECT ITEMNAME FROM SALES WHERE ITEMCODE=@item_code
--	OPEN cursor_yapisi 
--	FETCH NEXT FROM cursor_yapisi INTO @urunadi
--		WHILE @@FETCH_STATUS=0
--		BEGIN
--		--UPDATE SALES SET ITEMCODE='1903' WHERE ITEMCODE='00000005863'
--		print @urunadi
--		FETCH NEXT FROM cursor_yapisi INTO @urunadi
--		END;
--		CLOSE cursor_yapisi
--		DEALLOCATE cursor_yapisi


--END;

 



 ALTER DATABASE MISAFIR_ONLINE SET SINGLE_USER WITH ROLLBACK IMMEDIATE  ALTER DATABASE MISAFIR_ONLINE COLLATE Latin1_General_CI_AS_KS_WS ALTER DATABASE MISAFIR_ONLINE SET MULTI_USER 
