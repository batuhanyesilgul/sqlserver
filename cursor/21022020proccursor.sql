--DECLARE @madi nvarchar(100);
--DECLARE @sehir nvarchar(50);
--DECLARE @sql nvarchar(max);
--DECLARE cursor_yapisi CURSOR FOR 
--SELECT CUSTOMERNAME,CITY FROM CUSTOMER
--OPEN cursor_yapisi
--FETCH NEXT FROM cursor_yapisi INTO @madi,@sehir
--WHILE @@FETCH_STATUS=0
--BEGIN
--UPDATE CUSTOMER SET @madi='BATUHAN' WHERE @madi='Irmak TAHSÝNOÐLU'
--print @madi+@sehir
--FETCH NEXT FROM cursor_yapisi INTO @madi,@sehir
--END
--CLOSE cursor_yapisi
--DEALLOCATE cursor_yapisi

select * from SALES 


SELECT ITEMNAME,COUNT(*)AS sayi FROM SALES  WHERE ITEMCODE=00000005863 group by ITEMNAME

alter PROC SalesGetir
@item_code int
AS
BEGIN
	DECLARE @urunadi nvarchar(100)
	DECLARE cursor_yapisi CURSOR for SELECT ITEMNAME FROM SALES WHERE ITEMCODE=@item_code
	OPEN cursor_yapisi 
	FETCH NEXT FROM cursor_yapisi INTO @urunadi
		WHILE @@FETCH_STATUS=0
		BEGIN
		--UPDATE SALES SET ITEMCODE='1903' WHERE ITEMCODE='00000005863'
		print @urunadi
		FETCH NEXT FROM cursor_yapisi INTO @urunadi
		END;
		CLOSE cursor_yapisi
		DEALLOCATE cursor_yapisi


END;

 