alter proc sp_collate_degistirme
as
begin

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
 
DECLARE local_table_cursor CURSOR FOR
 
SELECT [name]
FROM sysobjects
WHERE OBJECTPROPERTY(id, N'IsUserTable') = 1
 
OPEN local_table_cursor
FETCH NEXT FROM local_table_cursor
INTO @table
 
WHILE @@FETCH_STATUS = 0
BEGIN


 
DECLARE local_change_cursor CURSOR FOR
 
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
 
OPEN local_change_cursor
FETCH NEXT FROM local_change_cursor
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
 
FETCH NEXT FROM local_change_cursor
INTO @row_id, @column_name, @data_type, @max_length, @column_id
 
END
 
CLOSE local_change_cursor
DEALLOCATE local_change_cursor
 
FETCH NEXT FROM local_table_cursor
INTO @table
 
END
 
CLOSE local_table_cursor
DEALLOCATE local_table_cursor
 end
GO

exec sp_collate_degistirme