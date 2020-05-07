EXEC sp_helplanguage turkish

SELECT * FROM sys.syslanguages WHERE alias='turkish'

--sp_configure 'default language',22--yani t�rk�e yapmak i�in
--Reconfigure with override--aksi durumda sql restart olduktan sonra aktifle�ir sunucu hemen yeniden yap�land�r�l�r

SELECT @@LANGUAGE--ba�l� olunan kullan�c�n�n dilini d�nd�recek
--ge�ici olarak dili de�i�tirmek istersek
--SET  LANGUAGE turkish--bu k�s�m da t�rk�e d�nd�recek
--tarih format�n� de�i�tirmek i�in 
--SET DateFormat dmy
--Declare @Tarih DateTime
--Set @Tarih='13.02.2020'
--Select @Tarih as Tarih

--EXEC sp_defaultlanguage 'sa','Turkish'
--ALTER LOGIN sa WITH DEFAULT_LANGUAGE=Turkish kullan�c�n�n kal�c� olarak dil ayarlar� de�i�tirilir.

--//////////////////////////////////////////////////////////////////////////////////////////////////////
--COLLAT�ON KAVRAMI dil veya alfabenin karakter kurallar� anlam�na gelir t�rk�ede i veya I n�n ayn� olmamas� dilin collationu ile ilgilidir
--W�NDOWS dilleri ve leh�eleri birer 32 bitlik Language ID Reference Number(LCID) koduyla saklar bu numaraland�rma ayn� dilleri veya harfleri ayn� �at� alt�nda toplar
--COLLAT�ONLAR karakterlerin do�ru yaz�l�p okunmas� ve kar��la�t�r�lmas�ndan sorumludur.
--SQL SERVER iki t�r collation yap�s� sunar Windows collation ve SQL collation
--SQL SERVER COLLAT�ON unicode ve nonUnicode veri t�rlerinin s�ralanmas� ve kar��la�t�r�lmas�nda �nemli rol oynar
--4 B�L�MDEN OLU�UR SIRALAMA KURALLARI- D�L VEYA ALFABE ADI
--�ST�NL�K- B�Y�K K���K HARF �NCEL���
--CODEPAGE - ASCII CODE PAGE
--CI; CASE INSENSITIVE(B�Y�K K���K HARF AYRIMI OLMASIN) CS(B�Y�K K���K HARF AYRIMI OLSUN)AI(AKSAN DUYARLI OLMASIN)AS(AKSAN DUYARLI)BIN(BINARY DUZEN)
SELECT * FROM fn_helpcollations() WHERE name like ('%Turkish%')
--SQL SERVERDA COLLAT�ON AYARLARI SERVER DATABASE COLUMN EXPRESS�ON BAZINDA GER�EKLE�EB�L�R
--SERVER BAZINDAN OLAN OLU�TURULACAK DATABASELER� DATABASELER� ETK�LER VE ONLARIN DEFAULT COLLAT�ON DE�ER� OLMU� OLUR
--SELECT SERVERPROPERTY('COLLAT�ON')
--SQL SERVER �LK KURULDU�UNDA W�NDOWSUN YEREL AYARLARINA(REG�ONALANDLANGUAGE OPT�ONS)UYGUN COLLAT�ON DE�ER�N� SET EDER.
--SERVER�N COLLAT�ON B�LG�S� MANAGEMENT STUD�O'DA OBJECT EXPLORER PENCERES�NDE �LG�L� SERVER�N DATABASE ENG�NE'N�NE SA� TIKLAYIP PROPERT�ES B�L�M�NDEN GENERAL SEKMES�NDEK� SERVER COLALT�ON B�L�M�NDEN G�R�LEB�L�R.
--AYRICA SERVERPROPERTY FONKS�YONUNA COLLAT�ON G�NDER�LEREK DE ��REN�LEB�L�R.
--MAK�NEM�Z�N HANG� KARAKTER INSTANCE'IN HANG� KARAKTER SIRALAMASI(SORT ORDER) VE (KARAKTER SET� CHARACTER SET)kulland���n� ��renmenin yolu sp_helpsort procedureni kullanmakt�r.
EXEC sp_helpsort
--SERVER�N COLLAT�ON B�LG�S� TOOLS//BINN KLAS�R� ALTINDA RebuildM.exe arac�yla de�i�tirilebilir.
--Database seviyesinde collation tan�mlamas� yapabilir.
--B�t�n databaseler default olarak server collation olmak �zere bir collation de�erine sahiptir.
--Management Studio ortam�nda yeni bir database olu�turdu�umuzda Options sekmesinde Collaction b�l�m�nden se�im yap�labilir veya b�rak�l�r.
--veya t-sql yard�m� ile database olu�turulurken collate s�zc��� ile collaction de�eri girilebilir.

--a��a��daki kod ile frans�zcay� kullanacak bir frans�zca database olu�turuypruz
--CREATE DATABASE FrDatabase COLLATE French_CI_AI
--ALTER DATABASE TestVI 
	--COLLATE Turkish_CI_AS
	--sistemdeki databaselerin collation bilgilerini inceleyelim
	--SELECT name , collation_name FROM sys.databases

	--***********************--i yerine I YAZAB�LMEK ���N  COLLAT�ON T�P�N�N �NG�L�ZCE(SQL_Latin1_General_CP1_CI_AS)olmas� gerekir
	--collation ifadesinin de�i�mesi i�in dbyi single user moda getirip alter database ifadesi kullan�l�r.
	--veritaban� �zerinde olu�turulmu� tablo kolonlar� seviyesinde	 de collation tan�mlamas� yap�l�r.
	--tablodaki kolonun collation  de�erini de�i�tirmek i�in ALTER TABLE ifadesi kullan�l�r
	--ALTER TABLE SELECT*FROMUYE WHERE USERMNAMETR=USERNAMEENG
	
	--FARKLI COLLAT�ON T�R�NDEK� KOLONLARI B�RB�R� �LE KARI�ILA�TIRAMAYIZ.