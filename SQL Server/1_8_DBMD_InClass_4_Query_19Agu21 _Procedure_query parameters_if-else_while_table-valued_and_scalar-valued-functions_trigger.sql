----------------------------DBMD 19-08-2021 -----------------------------------


---------------------------- PROCEDURE------------------------
CREATE PROC sp_sampleproc_1
AS
BEGIN
	SELECT 'HELLO WORLD'

END;

EXECUTE sp_sampleproc_1   -- PROCEDURE'� �ALI�TIRMAK ���N.

EXEC sp_sampleproc_1  -- BU �EK�LDE DE �ALI�IR.

sp_sampleproc_1  -- VE BU �EK�LDE DE �ALI�IR.


-- PROCEDURE'� DE���T�REL�M.
ALTER PROC sp_sampleproc_1
AS
BEGIN
	SELECT 'QUERY COMPLETED' RESULT

END;

sp_sampleproc_1





--- BBUNDAN SONRAK� ��LEMLER ���N �RNEK TABLO OLU�TURUYORUZ

CREATE TABLE ORDER_TBL
(
ORDER_ID TINYINT NOT NULL,
CUSTOMER_ID TINYINT NOT NULL,
CUSTOMER_NAME VARCHAR(50),
ORDER_DATE DATE,
EST_DELIVERY_DATE DATE--estimated delivery date
);
INSERT ORDER_TBL VALUES (1, 1, 'Adam', GETDATE()-10, GETDATE()-5 ),
						(2, 2, 'Smith',GETDATE()-8, GETDATE()-4 ),
						(3, 3, 'John',GETDATE()-5, GETDATE()-2 ),
						(4, 4, 'Jack',GETDATE()-3, GETDATE()+1 ),
						(5, 5, 'Owen',GETDATE()-2, GETDATE()+3 ),
						(6, 6, 'Mike',GETDATE(), GETDATE()+5 ),
						(7, 6, 'Rafael',GETDATE(), GETDATE()+5 ),
						(8, 7, 'Johnson',GETDATE(), GETDATE()+5 )


-- BU TABLO TESL�MATIN GER�EKLE�T�R�LME ZAMANINI B�ZE SERG�L�YOR
CREATE TABLE ORDER_DELIVERY
(
ORDER_ID TINYINT NOT NULL,
DELIVERY_DATE DATE -- tamamlanan delivery date
);
SET NOCOUNT ON
INSERT ORDER_DELIVERY VALUES (1, GETDATE()-6 ),
						(2, GETDATE()-2 ),
						(3, GETDATE()-2 ),
						(4, GETDATE() ),
						(5, GETDATE()+2 ),
						(6, GETDATE()+3 ),
						(7, GETDATE()+5 ),
						(8, GETDATE()+5 )


SELECT * FROM ORDER_DELIVERY

--ORDER LARI SAYDIRAN B�R PROC YAZALIM:
CREATE PROC sp_sumorder
AS
BEGIN
		SELECT COUNT(ORDER_ID) FROM Order_tbl

END;
-- BUNU ARTIK �STED���M HER YERE �A�IRIP �ALI�TIRALB�L�R�M.
	--VE ORDER TABLOSUNDAK� S�PAR�� SAYISINI GET�REB�L�R�M.
	--ORDER TABLOSU G�NCELLEND�K�E BU PROCEDURE'�N SONUCU DA ONA BA�LI OLARAK DE���ECEKT�R.
	-- VE HER DEFASINDA G�NCEL B�LG�Y� GET�RECEKT�R.
sp_sumorder


------------------

CREATE PROC sp_wanted_dayorder (@DAY DATE)
AS
BEGIN

	SELECT COUNT (ORDER_ID)
	FROM ORDER_TBL
	WHERE ORDER_DATE = @DAY

END;

SELECT * FROM ORDER_TBL

EXEC sp_wanted_dayorder '2021-08-12' -- buraya bir tarih girece�im ve procedure bana o g�ne ait order_id leri say�s�n� getirecek




--------------------------- SORGU PARAMETRELER�---------------

/* select ve set ile variable tan�mlayabiliyoruz. Ayr�ca select ile tan�mlad���m�z variable � �a��rabiliyoruz. 
set ya da select ile variable tan�mlarken "=" atama operat�r�n� kullan�yoruz.
@ ile de�i�ken sql de yer alan terim olarak parametre tan�mlayaca��m�z� deklare ediyoruz. 
De�i�keni tan�mlarken de�i�kenin veri tipini de belirtmemiz gerekiyor.
*/
	-- PARAMETRELERE DE�ER ATAMAK ���N SET VEYEA SELECT D�YORUZ
DECLARE @P1 INT, @P2 INT, @SUM INT

SET @P1 = 6

SELECT @P2  =4

SELECT @SUM = @P1 + @P2

SELECT @SUM  -- SELECT �LE YAZDIRDI�INDA SONU� RESULT KISMINDA �IKAR.

PRINT @SUM  -- PRINT �LE YAZDIRDI�INDA SONU� MESSSAGE KISMINDA �IKAR.
-- DE�ER ATAMAK ���N SET VEYA SELECT, 
-- PARAMETREY� �A�IRMAK ���N SELECT




DECLARE @CUST_ID INT

SET @CUST_ID = 5  -- CUST parametresine 5 de�erini at�yorum. a�a��da sorguda bunu kullanaca��m.

SELECT *
FROM ORDER_TBL
WHERE CUSTOMER_ID = @CUST_ID



----------------- IF-ELSE YAPILARINI KULLANMA--------------

-- A�a��daki 3 �arta g�re i�lem yap�p bize sonu� d�nd�recek bir sorgu yazaca��z.

-- 3 TEN K���KSE
-- 3'E E��TSE
-- 3'TEN B�Y�KSE

DECLARE @CUST_ID INT  -- CUST_ID �SM�NDE INT T�P�NDE B�R OBJECT OLU�TURDUM

SET @CUST_ID = 4  -- BA�TA CUST_ID'YE B�R DE�ER ATADIM. A�A�IDA BUNU CONDITION'A SOKUP SONU� YAZDIRACA�IM

IF @CUST_ID < 3

BEGIN   --- BEGIN KOYARSAN HEMEN ALTINDA END YAZ K� UNUTMA. 
	SELECT *
	FROM ORDER_TBL
	WHERE CUSTOMER_ID = @CUST_ID
END

-- IF YAPISINDA BEGIN ���NE B�R SATIR YAZACAKSAN END'E GEREK YOK AMA B�RDEN FAZLA SATIR YAZACAKSAN END �LE KAPATMALISIN.

ELSE IF @CUST_ID > 3
BEGIN
	SELECT *
	FROM ORDER_TBL
	WHERE CUSTOMER_ID = @CUST_ID
END

ELSE
	PRINT 'CUSTOMER ID EQUAL TO 3'



-------------------------WHILE------------------------


-- BEL�RT�LEN �ART SA�LANDI�I S�RECE ��LEME DEVAM EDER.

-- D�KKAT ED�LMES� GEREKEN NOKTA: (���NDE PARAMETRE VAR �SE) BEL�RTT���N�Z PARAMETREN�N B�TECE�� YER� S�YLEMEN�Z GEREK�YOR
	-- YOKSA SONSUZ D�NG�YE G�RECEKT�R.

DECLARE @NUM_OF_ITER INT = 50, @COUNTER INT = 0

WHILE @NUM_OF_ITER > @COUNTER --COUNTER 50'YE GELENE KADAR BEGIN-END KODUNU �ALI�TIRACAK.

BEGIN  -- WHILE �LE DE BEGIN KULLANIYORUM.
	SELECT @COUNTER
	SET @COUNTER += 1 --- D�NG�Y� BU �EK�LDE KONTROL ED�YORUM. �TERASYONU SA�LAYAN SATIR BU SATIR.

END 


------------------------ FUNCTION-----------------------
/* 
A function is a database object in SQL Server.
The function is a set of SQL statements that accept only input parameters,
perform actions and return the result. A function can return only a scalar value or a table.


-----TABLE-VALUED FUNCTIONS:

--Table-Valued Function is a function that returns a table, 
thus it can be used as a table in a query
BEL�RL� �ARTA BA�LI OLARAK �ALI�AN TABLO G�B� D���NEB�L�RS�N.

---- SCALAR-VALUED FUNCTIONS:

It returns a single value or scalar value. 
In the following screenshot, the function is created.
*/


CREATE FUNCTION fn_uppertext  -- fn_uppertext ad�nda fonksiyon olu�turduk. yaz�lan ifadeleri b�y�k harfe �evirmesini istiyoruz.
(
	@inputtext VARCHAR(MAX)  -- bir parametre tan�mlad�m. inputtext i�ine bir text koyaca��m ve fonksiyon bana b�y�k harfe �evirecek
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN UPPER(@inputtext) -- EN SON D�ND�RMES�N� �STED���M ��LEM� BURAYA YAZIYORUM. BUNU, EN SON �RETECEK DE�ER� D�ND�RMEK ���N KULLANIYORUM

END

SELECT dbo.fn_uppertext('whatsapp')

SELECT dbo.fn_uppertext(customer_name) FROM ORDER_TBL 
-- ORDER_TBL TABLOSUNDAK� customer_name s�tunundaki isimleri uppertext fonksiyonuna soktuk


-------TABLE VALUED FUNCTIONS-----------

CREATE FUNCTION fn_order_detail (@DATE DATE)
RETURNS TABLE
AS 
	RETURN SELECT * FROM ORDER_TBL WHERE ORDER_DATE = @DATE  --BURADA B�R TABLO �RET�L�YOR.

-- !! TABLE VALUED FUNCTIONDA BEGIN-END KULLANILMIYOR !!

SELECT * FROM dbo.fn_order_detail('2021-08-17') 
-- TABLE-VALUED FUNCTION B�R TABLO OLU�TURDU�U ���N ,
	--�A�IRIRKEN DE B�R TABLO �A�IRIR G�B� "FROM" KULLANIYORUZ!!




------------ TRIGGER

/* INSERTED AND DELETED TABLES

After each DML operation, related records are temporarily kept in the following three tables.
These tables are used in trigger operations

DML event		INSERTED table holds		DELETED table holds
---------		---------------------		-------------------
INSERT			rows to be inserted			empty

UPDATE			new rows modified by		existing rows modified by

				the update					the update

DELETE			empty						rows to be deleted 
*/



------------- DDL TRIGGERS--------

CREATE TRIGGER  [schema_name.] trigger_name
ON DATABASE
FOR
{[drop_table],  [alter_table], [create_function], [create_procedure], ...}

AS
{sql_statements}