use ELEKTRA
go
ALTER proc cget�r
@kriter nvarchar(30)
as
BEGIN
SELECT  * FROM SYSCOLUMNS where collation Like   '%'+@kriter+'%'
UNION ALL
SELECT  * FROM SYSCOLUMNS where collation NOT Like   '%'+@kriter+'%'
ORDER BY collation asc

END


EXEC cget�r 'Albanian_CS_AI_KS'