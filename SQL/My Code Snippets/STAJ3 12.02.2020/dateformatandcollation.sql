EXEC sp_helplanguage turkish

SELECT * FROM sys.syslanguages WHERE alias='turkish'

--sp_configure 'default language',22--yani türkçe yapmak için
--Reconfigure with override--aksi durumda sql restart olduktan sonra aktifleþir sunucu hemen yeniden yapýlandýrýlýr

SELECT @@LANGUAGE--baðlý olunan kullanýcýnýn dilini döndürecek
--geçici olarak dili deðiþtirmek istersek
--SET  LANGUAGE turkish--bu kýsým da türkçe döndürecek
--tarih formatýný deðiþtirmek için 
--SET DateFormat dmy
--Declare @Tarih DateTime
--Set @Tarih='13.02.2020'
--Select @Tarih as Tarih

--EXEC sp_defaultlanguage 'sa','Turkish'
--ALTER LOGIN sa WITH DEFAULT_LANGUAGE=Turkish kullanýcýnýn kalýcý olarak dil ayarlarý deðiþtirilir.

--//////////////////////////////////////////////////////////////////////////////////////////////////////
--COLLATÝON KAVRAMI dil veya alfabenin karakter kurallarý anlamýna gelir türkçede i veya I nýn ayný olmamasý dilin collationu ile ilgilidir
--WÝNDOWS dilleri ve lehçeleri birer 32 bitlik Language ID Reference Number(LCID) koduyla saklar bu numaralandýrma ayný dilleri veya harfleri ayný çatý altýnda toplar
--COLLATÝONLAR karakterlerin doðru yazýlýp okunmasý ve karþýlaþtýrýlmasýndan sorumludur.
--SQL SERVER iki tür collation yapýsý sunar Windows collation ve SQL collation
--SQL SERVER COLLATÝON unicode ve nonUnicode veri türlerinin sýralanmasý ve karþýlaþtýrýlmasýnda önemli rol oynar
--4 BÖLÜMDEN OLUÞUR SIRALAMA KURALLARI- DÝL VEYA ALFABE ADI
--ÜSTÜNLÜK- BÜYÜK KÜÇÜK HARF ÖNCELÝÐÝ
--CODEPAGE - ASCII CODE PAGE
--CI; CASE INSENSITIVE(BÜYÜK KÜÇÜK HARF AYRIMI OLMASIN) CS(BÜYÜK KÜÇÜK HARF AYRIMI OLSUN)AI(AKSAN DUYARLI OLMASIN)AS(AKSAN DUYARLI)BIN(BINARY DUZEN)
SELECT * FROM fn_helpcollations() WHERE name like ('%Turkish%')
--SQL SERVERDA COLLATÝON AYARLARI SERVER DATABASE COLUMN EXPRESSÝON BAZINDA GERÇEKLEÞEBÝLÝR
--SERVER BAZINDAN OLAN OLUÞTURULACAK DATABASELERÝ DATABASELERÝ ETKÝLER VE ONLARIN DEFAULT COLLATÝON DEÐERÝ OLMUÞ OLUR
--SELECT SERVERPROPERTY('COLLATÝON')
--SQL SERVER ÝLK KURULDUÐUNDA WÝNDOWSUN YEREL AYARLARINA(REGÝONALANDLANGUAGE OPTÝONS)UYGUN COLLATÝON DEÐERÝNÝ SET EDER.
--SERVERÝN COLLATÝON BÝLGÝSÝ MANAGEMENT STUDÝO'DA OBJECT EXPLORER PENCERESÝNDE ÝLGÝLÝ SERVERÝN DATABASE ENGÝNE'NÝNE SAÐ TIKLAYIP PROPERTÝES BÖLÜMÜNDEN GENERAL SEKMESÝNDEKÝ SERVER COLALTÝON BÖLÜMÜNDEN GÖRÜLEBÝLÝR.
--AYRICA SERVERPROPERTY FONKSÝYONUNA COLLATÝON GÖNDERÝLEREK DE ÖÐRENÝLEBÝLÝR.
--MAKÝNEMÝZÝN HANGÝ KARAKTER INSTANCE'IN HANGÝ KARAKTER SIRALAMASI(SORT ORDER) VE (KARAKTER SETÝ CHARACTER SET)kullandýðýný öðrenmenin yolu sp_helpsort procedureni kullanmaktýr.
EXEC sp_helpsort
--SERVERÝN COLLATÝON BÝLGÝSÝ TOOLS//BINN KLASÖRÜ ALTINDA RebuildM.exe aracýyla deðiþtirilebilir.
--Database seviyesinde collation tanýmlamasý yapabilir.
--Bütün databaseler default olarak server collation olmak üzere bir collation deðerine sahiptir.
--Management Studio ortamýnda yeni bir database oluþturduðumuzda Options sekmesinde Collaction bölümünden seçim yapýlabilir veya býrakýlýr.
--veya t-sql yardýmý ile database oluþturulurken collate sözcüðü ile collaction deðeri girilebilir.

--aþþaðýdaki kod ile fransýzcayý kullanacak bir fransýzca database oluþturuypruz
--CREATE DATABASE FrDatabase COLLATE French_CI_AI
--ALTER DATABASE TestVI 
	--COLLATE Turkish_CI_AS
	--sistemdeki databaselerin collation bilgilerini inceleyelim
	--SELECT name , collation_name FROM sys.databases

	--***********************--i yerine I YAZABÝLMEK ÝÇÝN  COLLATÝON TÝPÝNÝN ÝNGÝLÝZCE(SQL_Latin1_General_CP1_CI_AS)olmasý gerekir
	--collation ifadesinin deðiþmesi için dbyi single user moda getirip alter database ifadesi kullanýlýr.
	--veritabaný üzerinde oluþturulmuþ tablo kolonlarý seviyesinde	 de collation tanýmlamasý yapýlýr.
	--tablodaki kolonun collation  deðerini deðiþtirmek için ALTER TABLE ifadesi kullanýlýr
	--ALTER TABLE SELECT*FROMUYE WHERE USERMNAMETR=USERNAMEENG
	
	--FARKLI COLLATÝON TÜRÜNDEKÝ KOLONLARI BÝRBÝRÝ ÝLE KARIÞILAÞTIRAMAYIZ.