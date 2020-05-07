Use ELEKTRA

GO

create table #CreateScripts (ID INT , Constraint_Type VARCHAR(100), SQL VARCHAR(4000), Column_Name SYSNAME DEFAULT '')

 

declare @TableName sysname

declare curs cursor for

select name from sys.objects where type='U'

open curs

fetch next from curs into @TableName

while (@@fetch_status = 0)

begin

insert #CreateScripts

EXEC usp_Create_Table_DDL @sTable_Name = @TableName, @Create_Table_Ind = 0, @PK_Ind = 1, @FK_Ind = 1, @Check_Ind = 1, @Default_Ind = 1

fetch next from curs into @TableName

end

close curs

deallocate curs

 

declare @sql varchar(max)=''

select @sql+=sql+char(10) from #CreateScripts

print @sql

 

drop table #CreateScripts

--Messages kýsmýndaki sonlara doðru Alter ile baþlayan satýrlarýn tamamýný alýp kaydedin. Daha sonra bu scriptler ile constraint leri tekrar create edeceðiz.

--Evet þimdi constraint leri drop edebiliriz. Bunun için aþaðýdaki script i execute ediniz.

use ELEKTRA

declare @sql varchar(max)=''

select @sql+='ALTER TABLE ['+tab.name+'] DROP CONSTRAINT ['+cons.name+']; '+char(10)

from sys.objects cons,sys.objects tab

where cons.type in ('C', 'F', 'PK', 'UQ', 'D')

and cons.parent_object_id=tab.object_id and tab.type='U'

order by cons.type

exec(@sql)

 

--2.Index Drop

--Constraint te yaptýðýmýz gibi Index te de drop etmeden önce generate scriptleri hazýrlamamýz gerekiyor ki daha sonra create edebilelim. Create script generate için aþaðýdaki script i kullanabilirsiniz.

DECLARE @TabName varchar(100)=NULL

DECLARE @ACENTA varchar(100)

DECLARE TCur CURSOR FOR

SELECT '['+SCHEMA_NAME(t.schema_id)+'].['+t.name+']' FROM sys.tables t WHERE exists(SELECT TOP 1 1 FROM sys.indexes WHERE object_id=t.object_id and index_id>0)

AND (t.object_id=OBJECT_ID(@TabName) OR @TabName is null)

OPEN TCur

FETCH FROM TCur INTO @tableName

WHILE @@FETCH_STATUS=0

BEGIN

DECLARE ICur CURSOR FOR

SELECT name,is_primary_key from sys.indexes i WHERE exists(SELECT TOP 1 1 FROM sys.index_columns ic

WHERE i.object_id=ic.object_id and i.index_id=ic.index_id) and

i.object_id=OBJECT_ID(@tableName)

OPEN ICur

DECLARE @IName VARCHAR(100),@IsPK BIT,@SQL VARCHAR(MAX),@CName varchar(100),@is_descending_key bit

FETCH FROM ICur INTO @IName,@IsPK

WHILE @@FETCH_STATUS=0

BEGIN

IF(@IsPK=1)

BEGIN

SET @SQL='ALTER TABLE '+@tableName+' ADD PRIMARY KEY'+CHAR(10)+'('+CHAR(10)

DECLARE CCur CURSOR FOR

SELECT COL_NAME(i.object_id,ic.column_id),ic.is_descending_key FROM sys.indexes i inner join sys.index_columns ic

ON i.object_id=ic.object_id and i.index_id=ic.index_id

WHERE i.object_id=OBJECT_ID(@tableName) and i.name=@IName

OPEN CCur

FETCH FROM CCur INTO @CName,@is_descending_key

SET @SQL+='['+@CName+'] '+CASE WHEN @is_descending_key=0 THEN 'ASC' ELSE 'DESC' END+CHAR(10)

FETCH NEXT FROM CCur INTO @CName,@is_descending_key

WHILE @@FETCH_STATUS=0

BEGIN

SET @SQL+=',['+@CName+'] '+CASE WHEN @is_descending_key=0 THEN 'ASC' ELSE 'DESC' END+CHAR(10)

FETCH NEXT FROM CCur INTO @CName,@is_descending_key

END

CLOSE CCur

DEALLOCATE CCur

SET @SQL+=');'

PRINT @SQL

END

ELSE

BEGIN

SET @SQL='CREATE '+(SELECT type_desc FROM sys.indexes WHERE object_id=OBJECT_ID(@tableName) and name=@IName)+' INDEX ['+@IName+'] ON '+@tableName+CHAR(10)+'('+CHAR(10)

DECLARE CCur CURSOR FOR

SELECT COL_NAME(i.object_id,ic.column_id),ic.is_descending_key FROM sys.indexes i inner join sys.index_columns ic

ON i.object_id=ic.object_id and i.index_id=ic.index_id

WHERE i.object_id=OBJECT_ID(@tableName) and i.name=@IName

OPEN CCur

FETCH FROM CCur INTO @CName,@is_descending_key

SET @SQL+='['+@CName+'] '+CASE WHEN @is_descending_key=0 THEN 'ASC' ELSE 'DESC' END+CHAR(10)

FETCH NEXT FROM CCur INTO @CName,@is_descending_key

WHILE @@FETCH_STATUS=0

BEGIN

SET @SQL+=',['+@CName+'] '+CASE WHEN @is_descending_key=0 THEN 'ASC' ELSE 'DESC' END+CHAR(10)

FETCH NEXT FROM CCur INTO @CName,@is_descending_key

END

CLOSE CCur

DEALLOCATE CCur

SET @SQL+=');'

PRINT @SQL

END

FETCH NEXT FROM ICur INTO @IName,@IsPK

END

CLOSE ICur

DEALLOCATE ICur

FETCH NEXT FROM TCur INTO @tableName

END

CLOSE TCur

DEALLOCATE TCur

 

--Messages kýsmýndaki yazýlarý kopyalayýp kaydedelim. Daha sonra create index adýmýnda bu create script ini kullanacaðýz.

--Create script i hazýr olduðuna göre artýk index leri drop edebiliriz.

--Bunun için aþaðýdaki script i kullanabilirsiniz.

declare @str varchar(max)=''

select @str += 'DROP INDEX ['+i.name +'] ON ['+schema_name(t.schema_id)+'].['+t.name+']; '+CHAR(10)

from sys.indexes i

left join sys.objects t on t.object_id=i.object_id

where t.type='u' and i.index_id>0

exec(@str)

 

--3.Change DB Collation

--DB nin collation ýný deðiþtirmek için aþaðýdaki script i kullanabilirsiniz.

ALTER DATABASE SampleDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE

ALTER DATABASE SampleDB COLLATE TURKISH_CI_AS

ALTER DATABASE SampleDB SET MULTI_USER

 

--4.Change Columns Collation

--Bu adýmda DB de default collation kullanmayan column larýn collation ýný deðiþtireceðiz. Hangi column larý deðiþtireceðimizi bulmak için aþaðýdaki script i kullanabilirsiniz.

-------------------------------------------------------------

--- LM_ChangeCollation - Change collation in all tables

--- made by Luis Monteiro - ljmonteiro@eurociber.pt

--- modified by wilfred van dijk - wvand@wilfredvandijk.nl

-------------------------------------------------------------

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

set @new_collation = convert(sysname, databasepropertyex(DB_NAME(), 'collation'))

--- set @new_collation = convert(sysname, serverproperty('collation'))

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

join sysobjects b on a.object_id = b.id

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