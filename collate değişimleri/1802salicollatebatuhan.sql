alter PROCEDURE sp_collate_degisimi
AS 
BEGIN

DECLARE @collate nvarchar(100);
DECLARE @table nvarchar(255);
DECLARE @column_name nvarchar(255);
DECLARE @column_id int;
DECLARE @data_type nvarchar(255);
DECLARE @max_length int;
DECLARE @row_id int;
DECLARE @sql nvarchar(max);
DECLARE @sql_column nvarchar(max);
SET @collate = 'Albanian_CS_AI_KS';

DECLARE crs_tablo CURSOR FOR
 
SELECT [name]
FROM sysobjects
WHERE OBJECTPROPERTY(id, N'IsUserTable') = 1
 
OPEN crs_tablo
FETCH NEXT FROM crs_tablo
INTO @table
 
WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE crs_degisim CURSOR FOR

SELECT ROW_NUMBER() OVER (ORDER BY c.column_id) AS row_id
, c.name column_name
, t.Name data_type
, c.max_length
, c.column_id
FROM sys.columns c
JOIN sys.types t ON c.system_type_id = t.system_type_id
LEFT OUTER JOIN sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
LEFT OUTER JOIN sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
WHERE c.object_id = OBJECT_ID(@table)
ORDER BY c.column_id

OPEN crs_degisim
FETCH NEXT FROM crs_degisim
INTO @row_id, @column_name, @data_type, @max_length, @column_id

WHILE @@FETCH_STATUS = 0
BEGIN

IF (@max_length = -1) SET @max_length = 4000;

IF (@data_type LIKE '%char%')

BEGIN TRY
SET @sql = 'ALTER TABLE ' + @table + ' ALTER COLUMN ' + @column_name + ' ' + @data_type + '(' + CAST(@max_length AS nvarchar(100)) + ') COLLATE ' + @collate
PRINT @sql

EXEC sp_executesql @sql
END TRY
BEGIN CATCH
PRINT 'ERROR: Some index or contraint rely on the column' + @column_name + '. No conversion possible.'
PRINT @sql

END CATCH
 
FETCH NEXT FROM crs_degisim
INTO @row_id, @column_name, @data_type, @max_length, @column_id
 
END
 
CLOSE crs_degisim
DEALLOCATE crs_degisim
 
FETCH NEXT FROM crs_tablo
INTO @table
 
END
 
CLOSE crs_tablo
DEALLOCATE crs_tablo
 end
GO

EXEC sp_collate_degisimi 

--@eskicollation='aa', @yenicollation='bb', @tabloadi=''
-- procedurde parametre nasýl kullanýlýr 
-- gelen parametrenin içeride where kýsmýnda nasýl kullanýýrým  
-- gelen parametre dolu ise kullan boþ ise kullanma
-- gelen parametre sp içerisinde SQL hazýrlarken nasýl kullanýlýr (Alter table komutu içerisinde)
