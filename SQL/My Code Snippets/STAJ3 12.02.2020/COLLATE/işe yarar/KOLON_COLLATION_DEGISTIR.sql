DECLARE @new_collation varchar(100)

DECLARE @debug bit

DECLARE

	@table sysname,

	@previous sysname,

	@column varchar(60),

	@type varchar(20),

	@legth varchar(4),

	@nullable varchar(8),

	@sql varchar(4000),

	@msg varchar(4000),

	@servercollation varchar(120)

/*

uncomment one of the following lines:

*/

set @new_collation = convert(sysname, databasepropertyex(DB_NAME(), 'COLLATION'))

 --set @new_collation = convert(sysname, serverproperty('COLLATION'))

/*

@debug = 0 to execute

*/

set @debug = 1

if @new_collation is null

begin

	print 'which collation?'

	goto einde

end

DECLARE C1 CURSOR FOR

			select 'Table' = b.name,

			'Column' = a.name,

			'Type' = type_name(a.system_type_id),

			'Length' = a.max_length,

			'Nullable' = case when a.is_nullable = 0 then 'NOT NULL' else ' ' end

			from sys.columns a

			join sysobjects b

			on a.object_id = b.id

			where b.xtype = 'U'

			and b.name not like 'dt%'

			and type_name(a.system_type_id) in ('char', 'varchar', 'text', 'nchar', 'nvarchar', 'ntext')

			and a.[collation_name] <> @new_collation

			order by b.name,a.column_id

OPEN C1

	FETCH NEXT

		FROM C1

		INTO @table,@column,@type,@legth,@nullable

		set @previous = @table

	WHILE @@FETCH_STATUS = 0

	BEGIN

		if @table <> @previous print ''

		set @sql = 'ALTER TABLE ' + QUOTENAME(@table) + ' ALTER COLUMN ' + QUOTENAME(@column) + ' '

		set @sql = @sql + @type + '(' + @legth + ')' + ' COLLATE ' + @new_collation + ' ' + @nullable

		print @SQL

		if @debug = 0

		begin

			begin try

				EXEC (@sql)

			end try

			begin catch

				print 'ERROR:' + ERROR_MESSAGE()

				print ''

			end catch

		end

		set @previous = @table

		FETCH NEXT

		FROM C1

		INTO @table,@column,@type,@legth,@nullable

	END

CLOSE C1

DEALLOCATE C1


einde: