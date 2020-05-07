SELECT * from INFORMATION_SCHEMA.COLUMNS 

ALTER PROC collation_get(@tabloadi nvarchar(255)='',@column_name nvarchar(255)='',@ecollation nvarchar(255)='',@ycollation nvarchar(255)='')
AS
BEGIN
		DECLARE @collation_name nvarchar(100)
		DECLARE crs_get_collation CURSOR FOR
		SELECT 'ALTER TABLE ' + TABLE_NAME +
' ALTER COLUMN ' + COLUMN_NAME + ' ' + DATA_TYPE +
CASE WHEN CHARACTER_MAXIMUM_LENGTH = -1 THEN '(max)'
WHEN DATA_TYPE in ('text','ntext') THEN ''
WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL
THEN '('+(CONVERT(VARCHAR,CHARACTER_MAXIMUM_LENGTH)+')' )
ELSE
ISNULL(CONVERT(VARCHAR,CHARACTER_MAXIMUM_LENGTH),' ')
END
+' ESKÝ COLLATE: '+@ecollation+' YENÝ COLLATE: '+@ycollation +
CASE IS_NULLABLE WHEN 'YES' THEN ' NULL' WHEN 'No' THEN 'NOT NULL'
END
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME=@tabloadi --and COLUMN_NAME=@column_name
		OPEN crs_get_collation
		FETCH NEXT FROM crs_get_collation
		INTO @collation_name
		WHILE @@FETCH_STATUS=0
		BEGIN 
		PRINT @collation_name 
		FETCH NEXT FROM crs_get_collation
		END
		CLOSE crs_get_collation
		DEALLOCATE crs_get_collation
END


exec collation_get 'MISAFIR_ONLINE', 'BARKODID','Turkish_CI_AS','Latin1_General_CI_AS_KS_WS'