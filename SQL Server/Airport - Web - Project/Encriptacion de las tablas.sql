USE ServiciosWeb 
GO
----------------------------------------------------------------
--Using a Function to Encrypt By Passphrase
-----------------------------------------------------------------
CREATE TABLE #SecretInfo
(Secret1 varbinary(8000) NOT NULL PRIMARY KEY,
 Secret2 varchar(8000) null,
 Secret3_int varbinary(8000) null)
 
GO

INSERT #SecretInfo
(Secret1,
	Secret2,
	Secret3_int)
VALUES (
EncryptByPassPhrase('ServiciosWeb2023.','1200'),
EncryptByPassPhrase('ServiciosWeb2023.','AE'),
EncryptByPassPhrase('ServiciosWeb2023.', '1')
);

Select * from #SecretInfo
DROP TABLE #SecretInfo

SELECT 
CAST(CAST(DecryptByPassPhrase('ServiciosWeb2023.', Secret1) as varchar(max)) as int) as Panocho,
CAST(DecryptByPassPhrase('ServiciosWeb2023.', Secret2) as varchar(max)) as Panocho,
CAST(CAST(DecryptByPassPhrase('ServiciosWeb2023.', Secret3_int) as varchar(max)) as int) as Panocho
FROM #SecretInfo;

CREATE TABLE Pivote(
	ID int,
	Descripcion nvarchar(max) NOT NULL,
	Consecutivo varbinary(max) NOT NULL,
	Prefijo nvarchar(max) NOT NULL,
	RangoInicial varbinary(max) NOT NULL,
	RangoFinal varbinary(max) NOT NULL,
	CONSTRAINT PivotePK PRIMARY KEY (ID)
);
GO
-- USAMOS LA FUNCION EncryptByPassPhrase PARA INSERTAR VALORES CIFRADOS
INSERT INTO Pivote VALUES (1, 'Aerolinea', 1, 'AE', 1, 5);
INSERT Pivote
(ID,
	Descripcion,
	Consecutivo,
	Prefijo,
	RangoInicial,
	RangoFinal) 
VALUES (
1,
EncryptByPassPhrase('ServiciosWeb2023.','Aerolinea'),
EncryptByPassPhrase('ServiciosWeb2023.', '1'),
EncryptByPassPhrase('ServiciosWeb2023.','AE'),
EncryptByPassPhrase('ServiciosWeb2023.', '1'),
EncryptByPassPhrase('ServiciosWeb2023.', '5')
);
-- HACEMOS UN SELECT COMUN Y VEMOS QUE EL VALOR QUEDO CIFRADO
SELECT *
FROM Pivote;
-- HACEMOS UN SELECT USANDO DecryptByPassPhrase PARA MOSTRAR LA INFORMACION DESCIFRADA
SELECT ID, 
	CAST(DecryptByPassPhrase('ServiciosWeb2023.', Descripcion) as varchar(50)) as Descripcion,
	CAST(DecryptByPassPhrase('ServiciosWeb2023.', Prefijo) as varchar(50)) as Prefijo,
	CAST(CAST(DecryptByPassPhrase('ServiciosWeb2023.',Consecutivo) as varchar(50)) as int) as Consecutivo,
	CAST(CAST(DecryptByPassPhrase('ServiciosWeb2023.',RangoInicial) as varchar(50)) as int) as RangoInicial,
	CAST(CAST(DecryptByPassPhrase('ServiciosWeb2023.',RangoFinal) as varchar(50)) as int) as RangoFinal
FROM Pivote;

drop table Pivote;
-------------------------------------------------------------------------------------
-------------------------------  CERTIFICADOS ---------------------------------------
-------------------------------------------------------------------------------------
--Creating a Database Certificate
CREATE CERTIFICATE Tablas_Certificado
ENCRYPTION BY PASSWORD = 'Ulacit2023.'
WITH SUBJECT = 'Certificado Tablas',
START_DATE = '11/12/2023', EXPIRY_DATE = '12/24/2023'

--Viewing Certificates in the Database
SELECT name, pvt_key_encryption_type_desc, issuer_name
FROM sys.certificates

--Backing Up and Restoring a Certificate
BACKUP CERTIFICATE Tablas_Certificado
TO FILE = 'C:\Cetificados_Tablas\Certificado Tablas.BAK'
WITH PRIVATE KEY ( FILE = 'C:\Cetificados_Tablas\Certificado Tablas.BAK' ,
ENCRYPTION BY PASSWORD = 'ServiciosWeb123.',
DECRYPTION BY PASSWORD = 'Ulacit2023.')

--Managing a Certificate’s Private Key

CREATE TABLE Pivote(
	ID int,
	Descripcion varbinary(max) NOT NULL,
	Consecutivo varbinary(max) NOT NULL,
	Prefijo varbinary(max) NOT NULL,
	RangoInicial varbinary(max) NOT NULL,
	RangoFinal varbinary(max) NOT NULL,
	CONSTRAINT PivotePK PRIMARY KEY (ID)
);
GO
--Using Certificate Encryption and Decryption
INSERT INTO Pivote VALUES (1, 'Aerolinea', 1, 'AE', 1, 5);
--Encryptar
INSERT Pivote
(ID, Descripcion, Consecutivo, Prefijo, RangoInicial, RangoFinal)
VALUES(
1,
EncryptByCert(Cert_ID('Tablas_Certificado'), 'Aerolinea'),
EncryptByCert(Cert_ID('Tablas_Certificado'), '1'),
EncryptByCert(Cert_ID('Tablas_Certificado'), 'AE'),
EncryptByCert(Cert_ID('Tablas_Certificado'), '1'),
EncryptByCert(Cert_ID('Tablas_Certificado'),  '5')
);

--Desencryptar
SELECT
    ID,
    DecryptByCert(Cert_ID('Tablas_Certificado'), Descripcion),
    Consecutivo,
    CONVERT(NVARCHAR(MAX), DecryptByCert(Cert_ID('Tablas_Certificado'), Prefijo)),
    RangoInicial,
    CONVERT(INT, DecryptByCert(Cert_ID('Tablas_Certificado'), RangoFinal))
FROM Pivote;


Select * from Pivote;
Drop TABLE Pivote;

SELECT 
	ID, 
	CAST (DecryptByCert(Cert_ID('Tablas_Certificado'), Descripcion, N'Ulacit2023.') as varchar(max)) Descripcion,
	CAST (DecryptByCert(Cert_ID('Tablas_Certificado'), Prefijo, N'Ulacit2023.') as varchar(max)) Prefijo,
	CAST (CAST (DecryptByCert(Cert_ID('Tablas_Certificado'), Consecutivo) as varchar(50)) AS INT) as Consecutivo,
	CAST (DecryptByCert(Cert_ID('Tablas_Certificado'), RangoInicial, N'Ulacit2023.') as varchar(max)) RangoInicial,
	CAST (DecryptByCert(Cert_ID('Tablas_Certificado'), RangoFinal, N'Ulacit2023.') as varchar(max)) RangoFinal
FROM Pivote;

SELECT
    CAST (DecryptByCert(Cert_ID('Tablas_Certificado'), ID) AS INT) AS ID,
    CAST (DecryptByCert(Cert_ID('Tablas_Certificado'), Descripcion, N'Ulacit2023.')) AS Descripcion,
    CAST (DecryptByCert(Cert_ID('Tablas_Certificado'), Consecutivo) AS INT) AS  Consecutivo,
    CAST (DecryptByCert(Cert_ID('Tablas_Certificado'), Prefijo, N'Ulacit2023.')) AS Prefijo,
    CAST (DecryptByCert(Cert_ID('Tablas_Certificado'), RangoInicial) AS INT) AS RangoInicial,
    CAST (DecryptByCert(Cert_ID('Tablas_Certificado'), RangoFinal) AS INT) AS RangoFinal  
FROM Pivote;


SELECT
    CONVERT(INT, DecryptByCert(Cert_ID('Tablas_Certificado'), ID)) AS ID,
    CONVERT(NVARCHAR(MAX), DecryptByCert(Cert_ID('Tablas_Certificado'), Descripcion)) AS Descripcion,
    CONVERT(INT, DecryptByCert(Cert_ID('Tablas_Certificado'), Consecutivo)) AS Consecutivo,
    CONVERT(NVARCHAR(MAX), DecryptByCert(Cert_ID('Tablas_Certificado'), Prefijo)) AS Prefijo,
    CONVERT(INT, DecryptByCert(Cert_ID('Tablas_Certificado'), RangoInicial)) AS RangoInicial,
    CONVERT(INT, DecryptByCert(Cert_ID('Tablas_Certificado'), RangoFinal)) AS RangoFinal  
FROM Pivote;




-- BORRAMOS CERTIFICADO
DROP CERTIFICATE cert_triggerdb
GO

-- CREAMOS CERTIFICADO POR MEDIO DE BACKUP
CREATE CERTIFICATE cert_triggerdb
FROM FILE = 'c:\temp\cert_triggerdb.BAK'
WITH PRIVATE KEY (FILE = 'c:\temp\certtriggerdbPK.BAK',
DECRYPTION BY PASSWORD = '3439F6A',
ENCRYPTION BY PASSWORD = 'AA5FA6AC')
GO

Select * from #PasswordHint

SELECT CAST(DecryptByCert(Cert_ID('cert_triggerdb'),
userpassword, N'AA5FA6AC') 
as varchar(200)) Password
FROM #PasswordHint
WHERE CustomerID = 1

DROP CERTIFICATE cert_triggerdb
GO

----------------------------------------------------------------------------------------
------------------------------- CLAVES ASIMETRICAS -------------------------------------
----------------------------------------------------------------------------------------
--Creating an Asymmetric Key
DROP ASYMMETRIC KEY asy_TRIGGERDB

CREATE ASYMMETRIC KEY asy_TRIGGERDB
WITH ALGORITHM = RSA_2048
ENCRYPTION BY PASSWORD = 'EEB0B4DD'
--Viewing Asymmetric Keys in the Current Database
SELECT name, algorithm_desc, pvt_key_encryption_type_desc
FROM sys.asymmetric_keys
--Encrypting and Decrypting Data using an Asymmetric Key
drop table IF EXISTS #PasswordHint

CREATE TABLE #PasswordHint
(CustomerID int NOT NULL PRIMARY KEY,
 Username varchar(300) NOT NULL,
 userPassword   varbinary(1000) NOT NULL)
GO

INSERT #PasswordHint
(CustomerID, Username, userPassword)
VALUES
(1, 'Triggerdb',
 EncryptByAsymKey(AsymKey_ID('asy_TRIGGERDB'),
'Clave del usuario'))

SELECT * FROM #PasswordHint

-- 

SELECT CAST(DecryptByAsymKey
( AsymKey_ID('asy_triggerdb'),

userPassword,
N'EEB0B4DD') as varchar(100)) BankRoutingNBR
FROM #PasswordHint