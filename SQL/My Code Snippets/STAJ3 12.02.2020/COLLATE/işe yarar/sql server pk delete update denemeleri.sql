SELECT * FROM   sys.key_constraints CONS
WHERE  [type] = 'PK' 


SELECT * FROM sys.key_constraints
SELECT * FROM sys.column_

	
ALTER TABLE Table_1
ADD PRIMARY KEY(event_id);
select * from ACENTA_FIYAT
SELECT * FROM   sys.key_constraints
--SELECT OBJS.name AS TABLENAME, COLS.NAME AS COLUMNNAME,TYPS.NAME AS COLTYPE,COLS.max_length AS MAX_LENGTH, * FROM SYS.objects OBJS
--INNER JOIN SYS.COLUMNS COLS ON OBJS.object_id = COLS.object_id
--INNER JOIN SYS.TYPES TYPS ON COLS.system_type_id = TYPS.system_type_id
--WHERE OBJS.[TYPE] = 'U' --and TYPS.[name] not like '%t%'
--ORDER BY OBJS.name, COLS.name


alter table CUSTOMER drop CONSTRAINT ID--primary key drop etme 

alter table CUSTOMER add primary key (PK_CUSTOMER)
ALTER TABLE CUSTOMER 
ADD CONSTRAINT PK_CUSTOMER PRIMARY KEY NONCLUSTERED (ID)
GO


ALTER TABLE CUSTOMER
ALTER COLUMN CUSTOMERNAME primary key not null;


ALTER TABLE t1  
DROP CONSTRAINT PK__t1__3213E83F88CF144D;   
GO  

alter table CUSTOMER
alter column ID varchar(10) not null




ALTER TABLE CUSTOMER ADD CONSTRAINT CT_ID PRIMARY KEY (ID)

ALTER TABLE CUSTOMER
  DROP PRIMARY KEY,ADD PRIMARY KEY (ID);





















  ----------------------------------------------------------------------------------------------------------------
  SELECT * FROM   sys.key_constraints CONS
WHERE  [type] = 'PK' 


SELECT * FROM sys.key_constraints
SELECT * FROM sys.column_

	
ALTER TABLE Table_1
ADD PRIMARY KEY(event_id);
select * from ACENTA_FIYAT
SELECT * FROM   sys.key_constraints
--SELECT OBJS.name AS TABLENAME, COLS.NAME AS COLUMNNAME,TYPS.NAME AS COLTYPE,COLS.max_length AS MAX_LENGTH, * FROM SYS.objects OBJS
--INNER JOIN SYS.COLUMNS COLS ON OBJS.object_id = COLS.object_id
--INNER JOIN SYS.TYPES TYPS ON COLS.system_type_id = TYPS.system_type_id
--WHERE OBJS.[TYPE] = 'U' --and TYPS.[name] not like '%t%'
--ORDER BY OBJS.name, COLS.name


alter table CUSTOMER drop CONSTRAINT ID--primary key drop etme 

alter table CUSTOMER add primary key (ID)


SELECT * FROM sysobjects WHERE name = 'ID'
  -----------------------------------------------------------------------------------------------------------------