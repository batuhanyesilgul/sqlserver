--SELECT OBJS.name AS TABLENAME, COLS.NAME AS COLUMNNAME,TYPS.NAME AS COLTYPE,COLS.max_length AS MAX_LENGTH, * FROM SYS.objects OBJS
--INNER JOIN SYS.COLUMNS COLS ON OBJS.object_id = COLS.object_id
--INNER JOIN SYS.TYPES TYPS ON COLS.system_type_id = TYPS.system_type_id
--WHERE OBJS.[TYPE] = 'U' --and TYPS.[name] not like '%t%'
--ORDER BY OBJS.name, COLS.name

--SELECT * FROM SYS.columns
--SELECT * FROM SYS.types
--SELECT * FROM SYS.objects

alter proc pr_collated(@table_name nvarchar(max),@ecollation nvarchar(max)='',@ycollation nvarchar(max)='')

AS
BEGIN
DECLARE @column_name nvarchar(100)
DECLARE @data_type nvarchar(50)
DECLARE @uzunluk nvarchar(50)
DECLARE @collate_degistir nvarchar(100)
DECLARE crs_collated CURSOR FOR

SELECT OBJS.name AS TABLENAME, COLS.NAME AS COLUMNNAME,TYPS.NAME AS COLTYPE,CAST(COLS.max_length/2 AS nvarchar(50)) AS MAX_LENGTH FROM SYS.objects OBJS
INNER JOIN SYS.COLUMNS COLS ON OBJS.object_id = COLS.object_id
INNER JOIN SYS.TYPES TYPS ON COLS.system_type_id = TYPS.system_type_id
left JOIN SYS.indexes IND ON OBJS.object_id=IND.object_id

WHERE OBJS.[TYPE] = 'U' and TYPS.[name]  like '%char%' and (@table_name is null or  OBJS.[name]=@table_name) --AND IND.object_id IS NULL
--and COLS.object_id NOT IN(SELECT object_id FROM SYS.indexes)

ORDER BY OBJS.name, COLS.name

OPEN crs_collated
FETCH NEXT FROM crs_collated INTO @table_name,@column_name,@data_type,@uzunluk
WHILE @@FETCH_STATUS=0
BEGIN
SET @collate_degistir='ALTER TABLE '+@table_name+' ALTER COLUMN ['+@column_name+'] '+@data_type+'('+@uzunluk +')'+' COLLATE '+@ycollation
print @table_name
print @collate_degistir
exec (@collate_degistir)
FETCH NEXT FROM crs_collated INTO  @table_name,@column_name,@data_type,@uzunluk
END
CLOSE crs_collated
DEALLOCATE crs_collated
		
END
exec pr_collated NULL,'Turkish_CI_AS','Albanian_CS_AI_KS'





--IF EXISTS (
--SELECT 1 FROM sys.indexes
--WHERE Name='IX_ANKET_ODANO' --Ýndex Adý
--AND object_id=OBJECT_ID('ANKET')         index sorgulama kodu
--)
--BEGIN
--PRINT 'Index Mevcut'
--END
--ELSE
--BEGIN
--PRINT 'Index Mevcut Deðil'
--END

select * from sys.indexes --WHERE --name='IX_ANKET_ODANO'
select * from sys.syscomments where text like '%VIEW%' -- viewlarýn create cümlesi

select ODANO from ANKET 


