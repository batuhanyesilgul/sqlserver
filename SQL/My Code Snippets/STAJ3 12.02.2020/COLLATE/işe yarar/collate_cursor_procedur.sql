--select * from syscolumns


alter proc cdegistirme
@collate_id int

AS
BEGIN
			DECLARE @collatinoadi nvarchar(100);
			DECLARE @kolon_adi Nvarchar(max);
			DECLARE @collation_id nvarchar(max);
			DECLARE @yeni_collate nvarchar(100);
			DECLARE @sql nvarchar(max);

			SET @yeni_collate='Albanian_CS_AI_KS';

			DECLARE cursoryapisi CURSOR FOR 
			
			--SELECT [collation],[name],[collationid] FROM syscolumns WHERE collationid=@collate_id
			select T.name AS TABLENAME,C.name AS COLUMNNAME from sys.tables T
			INNER JOIN sys.columns C ON T.object_id = C.object_id 
			

			OPEN cursoryapisi 
			FETCH NEXT FROM cursoryapisi INTO T,C--,--@collation_id
			
			WHILE @@FETCH_STATUS=0
			BEGIN
			SET @sql= ' kolon adi '+@kolon_adi+'collate adi '+@collatinoadi+' COLLATÝON ID '+@collation_id+' YENÝ COLLATÝON '+@yeni_collate
	
			print @sql
		

			FETCH NEXT FROM cursoryapisi INTO @collatinoadi ,@kolon_adi,@collation_id


			END
			close cursoryapisi
			deallocate cursoryapisi

END

exec cdegistirme 53274

SELECT * FROM syscolumns WHERE collationid=0