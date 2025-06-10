---------------------------------PRESENTACION GRUPO 4-----------------------------------------------------------------------------

--Tablas
SELECT * FROM Categoria; 
SELECT * FROM Canton; 
SELECT * FROM Factores; 

SELECT * FROM Huella_Carbono;

SELECT * FROM Proveedor_Bienes ORDER BY Proveedor_Bienes.ID_PROVEEDORB ASC;
SELECT * FROM Productos_Bienes ORDER BY Productos_Bienes.ID_PRODUCTOB ASC;
SELECT * FROM Factura_Bienes ORDER BY Factura_Bienes.N_FACTURAB ASC;

SELECT * FROM Proveedor_Comida ORDER BY Proveedor_Comida.ID_PROVEEDORA ASC;
SELECT * FROM Compras_Comida;
SELECT * FROM Factura_Comida ORDER BY Factura_Comida.N_FACTURAA ASC;

SELECT * FROM Expositor ORDER BY Expositor.ID_EXPOSITOR ASC;
SELECT * FROM Eventos ORDER BY Eventos.ID_EVENTO ASC;
SELECT * FROM Registro_Eventos ORDER BY Registro_Eventos.N_REGISTROE DESC;
SELECT * FROM Estudiantes ORDER BY Estudiantes.ID_ESTUDIANTESE ASC;

SELECT * FROM Organizacion_TCU ORDER BY Organizacion_TCU.ID_ORGANIZACION ASC;
SELECT * FROM Registro_TCU ORDER BY Registro_TCU.N_REGISTROTCU ASC;

SELECT * FROM LogIn;


--Joins por consulta 
-- 1. inner join
SELECT Expositor.Nombre_Expositor, Eventos.Id_Evento, Eventos.Nombre_Evento FROM Expositor
INNER JOIN Eventos ON Expositor.Id_Expositor=Eventos.Id_Expositor
-- 2. Left join
SELECT Factura_Bienes.N_FacturaB, Proveedor_Bienes.Id_ProveedorB, Proveedor_Bienes.Nombre_ProvB  FROM Factura_Bienes
Left JOIN Proveedor_Bienes ON Factura_Bienes.Id_ProveedorB=Proveedor_Bienes.Id_ProveedorB
-- 3. Right Join
SELECT Factura_Comida.N_FacturaA, Compras_Comida.Id_ProductoA, Compras_Comida.Nombre_ProductoA FROM Factura_Comida
Right JOIN Compras_Comida ON Factura_Comida.Id_ProductoA=Compras_Comida.Id_ProductoA
-- 4. Full join
SELECT Expositor.Nombre_Expositor, Eventos.Id_Evento FROM Expositor
Left JOIN Eventos ON Expositor.Id_Expositor=Eventos.Id_Expositor
UNION
SELECT Expositor.Nombre_Expositor, Eventos.Id_Evento FROM Expositor
Right JOIN Eventos ON Expositor.Id_Expositor=Eventos.Id_Expositor--

SELECT Estudiantes.Id_EstudiantesE, Estudiantes.NombreE, Organizacion_TCU.NombreOrg_TCU FROM Estudiantes
FULL OUTER Join Registro_TCU 
ON Estudiantes.Id_EstudiantesE = Registro_TCU.Id_EstudiantesE
INNER JOIN Organizacion_TCU
ON Registro_TCU.Id_Organizacion = Organizacion_TCU.Id_Organizacion;

--Vistas 
SELECT * from SellosVerdes;
SELECT *FROM CierreDeCaja;
--Index
SELECT *
FROM ALL_INDEXES		
WHERE OWNER = 'ADMIN';









----------------------------------------------------------------------------------------------------------------------------------

--Categoria
--check
CREATE TABLE Categoria (Id_Categoria NUMBER(1) NOT NULL,  Descripcion_Categoria VARCHAR2 (80) NOT NULL, 
CONSTRAINT idcateg PRIMARY KEY (Id_Categoria), 
CONSTRAINT min_cat CHECK(Id_Categoria<6));
 
--Canton
CREATE TABLE Canton (Id_Canton NUMBER(5) NOT NULL, Provincia VARCHAR2 (80) NOT NULL, Canton_Descripcion VARCHAR2(80) NOT NULL, Kilometros NUMBER(4) NOT NULL,
CONSTRAINT idcanton PRIMARY KEY (Id_Canton));
 

-- Adquisicion de bienes
--check
CREATE TABLE Proveedor_Bienes (Id_ProveedorB NUMBER(5)NOT NULL, Nombre_ProvB VARCHAR2(50)NOT NULL, Id_Canton NUMBER (5) NOT NULL, Id_Categoria NUMBER(1) NOT NULL,
CONSTRAINT provB PRIMARY KEY (Id_ProveedorB),
CONSTRAINT  fk_categB FOREIGN KEY (Id_Categoria) REFERENCES Categoria(Id_Categoria),
CONSTRAINT fk_cantonPB FOREIGN KEY (Id_Canton) REFERENCES Canton (Id_Canton));

CREATE TABLE Productos_Bienes (Id_ProductoB NUMBER (5) NOT NULL, Nombre_ProductoB VARCHAR2(40) NOT NULL, Fecha_EntradaB DATE NOT NULL, 
CONSTRAINT productB PRIMARY KEY (Id_ProductoB), 
CONSTRAINT min_provB CHECK(Id_ProductoB>0));

CREATE TABLE Factura_Bienes (N_FacturaB NUMBER(14) NOT NULL, Fecha_SolicitudB DATE NOT NULL, Cantidad_RequeridaB NUMBER (3) NOT NULL, Fecha_EntregaB DATE NOT NULL, 
Id_ProductoB NUMBER (5) NOT NULL, Id_ProveedorB NUMBER(5)NOT NULL, Precio_FinalB NUMBER (10,2) NOT NULL, 
CONSTRAINT factB PRIMARY KEY (N_FacturaB), 
CONSTRAINT fk_produB FOREIGN KEY (Id_ProductoB) REFERENCES Productos_Bienes(Id_ProductoB),
CONSTRAINT fk_proveeB FOREIGN KEY (Id_ProveedorB) REFERENCES Proveedor_Bienes(Id_ProveedorB));  

-- Servicios de alimentacion 
CREATE TABLE Proveedor_Comida (Id_ProveedorA NUMBER (5) NOT NULL, Nombre_ProvA VARCHAR2(50)NOT NULL, Id_Canton NUMBER (5) NOT NULL, Id_Categoria NUMBER(1) NOT NULL, 
CONSTRAINT provA PRIMARY KEY (Id_ProveedorA),
CONSTRAINT  fk_categA FOREIGN KEY (Id_Categoria) REFERENCES Categoria(Id_Categoria),
CONSTRAINT fk_canton FOREIGN KEY (Id_Canton) REFERENCES Canton (Id_Canton));

CREATE TABLE Compras_Comida (Id_ProductoA NUMBER(5) NOT NULL, Nombre_ProductoA VARCHAR2 (84) NOT NULL,
CONSTRAINT productA PRIMARY KEY (Id_ProductoA)); 

CREATE TABLE Factura_Comida (N_FacturaA NUMBER (15) NOT NULL, Fecha_SolicitudA DATE NOT NULL, Cantidad_RequeridaA NUMBER (3) NOT NULL, Fecha_EntregaA DATE NOT NULL, 
Id_ProductoA NUMBER (5) NOT NULL, Id_ProveedorA NUMBER(5)NOT NULL, Precio_FinalA NUMBER (12,2) NOT NULL, 
CONSTRAINT factA PRIMARY KEY (N_FacturaA), 
CONSTRAINT fk_proveA FOREIGN KEY (Id_ProveedorA) REFERENCES Proveedor_Comida (Id_ProveedorA),
CONSTRAINT fk_productA FOREIGN KEY (Id_ProductoA) REFERENCES Compras_Comida (Id_ProductoA));

--Eventos
CREATE TABLE Estudiantes (Id_EstudiantesE NUMBER (5) NOT NULL, NombreE VARCHAR2 (40) NOT NULL, ApellidoE VARCHAR2(60) NOT NULL, 
Id_Canton NUMBER (5) NOT NULL, Id_Categoria NUMBER(1) NOT NULL, 
CONSTRAINT idEstuE PRIMARY KEY (Id_EstudiantesE),
CONSTRAINT fk_cateE FOREIGN KEY (Id_Categoria) REFERENCES Categoria(Id_Categoria),
CONSTRAINT fk_cantonES FOREIGN KEY (Id_Canton) REFERENCES Canton (Id_Canton));
--check
CREATE TABLE Expositor (Id_Expositor NUMBER (5) NOT NULL, Nombre_Expositor VARCHAR2 (40) NOT NULL, Apellido_Expositor VARCHAR2(60) NOT NULL, 
Id_Canton NUMBER (5) NOT NULL, Id_Categoria NUMBER(1) NOT NULL, 
CONSTRAINT idExpo PRIMARY KEY(Id_Expositor), CONSTRAINT min_expo CHECK(Id_Expositor>0),
CONSTRAINT fk_cantonE FOREIGN KEY (Id_Canton) REFERENCES Canton (Id_Canton));

CREATE TABLE Eventos (Id_Evento NUMBER (15)NOT NULL, Fecha_Evento DATE NOT NULL, Duracion_Evento VARCHAR2(40), Nombre_Evento VARCHAR2(88) NOT NULL, 
Tipo_Evento VARCHAR2(96) NOT NULL, Id_Expositor NUMBER (5) NOT NULL,
CONSTRAINT idEvent PRIMARY KEY (Id_Evento), CONSTRAINT fk_expoE FOREIGN KEY (Id_Expositor) REFERENCES Expositor(Id_Expositor));

CREATE TABLE Registro_Eventos (N_RegistroE NUMBER (18) NOT NULL, 
Id_Evento NUMBER (15) NOT NULL, Id_EstudiantesE NUMBER (5) NOT NULL, Id_Expositor NUMBER (5) NOT NULL,
CONSTRAINT regE PRIMARY KEY(N_RegistroE),
CONSTRAINT fk_exposE FOREIGN KEY (Id_Expositor) REFERENCES Expositor(Id_Expositor), 
CONSTRAINT fk_estuE FOREIGN KEY (Id_EstudiantesE) REFERENCES Estudiantes(Id_EstudiantesE),
CONSTRAINT fk_eventE FOREIGN KEY (Id_Evento) REFERENCES Eventos(Id_Evento));

--TCU

CREATE TABLE Organizacion_TCU (Id_Organizacion NUMBER(5) NOT NULL, Cant_Visitas NUMBER(4) NOT NULL, NombreOrg_TCU VARCHAR2(68) NOT NULL, 
Id_Canton NUMBER (5) NOT NULL, Id_Categoria NUMBER(1) NOT NULL,
CONSTRAINT idOrg PRIMARY KEY (Id_Organizacion),
CONSTRAINT fk_cantonO FOREIGN KEY (Id_Canton) REFERENCES Canton (Id_Canton));

CREATE TABLE Registro_TCU (N_RegistroTCU NUMBER(16) NOT NULL, Id_Organizacion NUMBER(5) NOT NULL, Id_EstudiantesE NUMBER(5) NOT NULL,
CONSTRAINT regTCU PRIMARY KEY (N_RegistroTCU),
CONSTRAINT fk_orgaTCU FOREIGN KEY (Id_Organizacion) REFERENCES Organizacion_TCU(Id_Organizacion), 
CONSTRAINT fk_EstuTCU FOREIGN KEY (Id_EstudiantesE) REFERENCES Estudiantes(Id_EstudiantesE));

--Login

CREATE TABLE LogIn (Clave NUMBER(5) NOT NULL, Usuario VARCHAR2(20) NOT NULL, Acceso VARCHAR2(60) NOT NULL, Fecha_Venc DATE NOT NULL, CONSTRAINT usuar PRIMARY KEY (Usuario));

--Factores
CREATE TABLE Factores (Id_Factor NUMBER(5) NOT NULL, Factor_Descripcon VARCHAR2(20) NOT NULL, Factor_Valor NUMBER(4,2) NOT NULL, Fecha_Vigencia DATE NOT NULL,
CONSTRAINT idfactor PRIMARY KEY(Factor_Valor));

--Huella_Carbono 
CREATE TABLE Huella_Carbono (Id_Huella NUMBER(5) NOT NULL, Id_Categoria NUMBER(1) NOT NULL, ID NUMBER(5) NOT NULL, Dato_Actividad NUMBER(4,2) NOT NULL, Factor_Emision NUMBER (4,2) NOT NULL, 
Huella NUMBER(10,2), CONSTRAINT idhuella PRIMARY KEY (Id_Huella), 
CONSTRAINT fk_idcategH FOREIGN KEY (Id_Categoria) REFERENCES Categoria (Id_Categoria),
CONSTRAINT fk_Factor FOREIGN KEY (Factor_Emision) REFERENCES Factores (Factor_Valor));


--Inserts 

--1. Cantones: ID, Provincia, Canton, Kilometros
INSERT INTO CANTON VALUES (00001, 'San Jose', 'Santa Ana', 20);
INSERT INTO CANTON VALUES (00002, 'San Jose', 'San Isidro de Coronado', 7);
INSERT INTO CANTON VALUES (00003, 'Alajuela', 'San Pedro de Poas', 36);
INSERT INTO CANTON VALUES (00004, 'Alajuela', 'Sarchi Norte', 55);
INSERT INTO CANTON VALUES (00005, 'Cartago', 'Tres Rios', 11);
INSERT INTO CANTON VALUES (00006, 'Cartago', 'San Rafael de Oreamuno', 24);
INSERT INTO CANTON VALUES (00007, 'Heredia', 'Barva', 13);
INSERT INTO CANTON VALUES (00008, 'Heredia', 'San Isidro', 19);

--2. Categorias (Utilizarlas para los datos de las tablas de Proveedor_Bienes, Proveedor_Comida, Estudiantes, Expositor y Organizacion_TCU)
INSERT INTO Categoria VALUES (00001, 'Proveedor de Bienes');
INSERT INTO Categoria VALUES (00002, 'Proveedor de comida');
INSERT INTO Categoria VALUES (00003, 'Estudiantes');
INSERT INTO Categoria VALUES (00004, 'Expositor');
INSERT INTO Categoria VALUES (00005, 'Organizacion del TCU');

--3. Proveedor Bienes (Categoria: 1) -->ID, Nombre, Provincia, Categoria
INSERT INTO Proveedor_Bienes VALUES (00001, 'Lenovo', 00002, 1);
INSERT INTO Proveedor_Bienes VALUES (00002, 'DeepTek', 00003, 1);
INSERT INTO Proveedor_Bienes VALUES (00003, 'Intel', 00004, 1);
INSERT INTO Proveedor_Bienes VALUES (00004, 'Teltron', 00007, 1);
INSERT INTO Proveedor_Bienes VALUES (00005, 'Ofigen', 00006, 1);


--4.Productos Bienes: ID, Nombre, Fecha de Entrada
INSERT INTO Productos_Bienes VALUES (00001, 'Computadoras', '22/January/2023');
INSERT INTO Productos_Bienes VALUES (00002, 'Telefonos IP', '15/January/2023');
INSERT INTO Productos_Bienes VALUES (00003, 'Touch Panel', '2/February/2023');
INSERT INTO Productos_Bienes VALUES (00004, 'Procesador', '1/March/2023');
INSERT INTO Productos_Bienes VALUES (00005, 'Servidor', '5/April/2023');

--5. Factura Bienes: ID, Fecha de Consulta, Cantidad, Fecha de llegada, ID Proveedor, ID Producto, Precio
INSERT INTO Factura_Bienes VALUES (00000001, '28/January/2023', '20', SYSDATE, 00002, 00003, 500000.00);
INSERT INTO Factura_Bienes VALUES (00000002, '30/January/2023', '15', SYSDATE, 00001, 00001, 150000.00);
INSERT INTO Factura_Bienes VALUES (00000003, '13/February/2023', '5', SYSDATE, 00004, 00002, 75000.00);
INSERT INTO Factura_Bienes VALUES (00000004, '5/March/2023', '8', SYSDATE, 00004, 00005, 250000.00);
INSERT INTO Factura_Bienes VALUES (00000005, '18/March/2023', '3', SYSDATE, 00005, 00004, 150000.00)

--6. Proveedor de Comida (Categoria: 2)-->ID, Nombre, Provincia, Categoria
INSERT INTO Proveedor_Comida VALUES (00001, 'Alimentos Polar', 00001, 2);
INSERT INTO Proveedor_Comida VALUES (00002, 'Pozuelo', 00002, 2);
INSERT INTO Proveedor_Comida VALUES (00003, 'Tropical', 00007, 2);
INSERT INTO Proveedor_Comida VALUES (00004, 'Cristal', 00004, 2);
INSERT INTO Proveedor_Comida VALUES (00005, 'Empaques Belen', 00003, 2);
INSERT INTO Proveedor_Comida VALUES (00006, 'Roma', 00005, 2);

--7. Compras Comida: ID, Nombre, Fecha de Entrada
ALTER TABLE Compras_Comida ADD Fecha_EntradaB DATE NOT NULL; --: Si no se ejecuta esto, va a dar error al hacer el INSERT.
INSERT INTO Compras_Comida VALUES (00001, 'Fiesta Snacks', '4/April/2023');
INSERT INTO Compras_Comida VALUES (00002, 'Tropical Melocoton', '10/March/2023');
INSERT INTO Compras_Comida VALUES (00003, 'Galleta Maria', '1/January/2023');
INSERT INTO Compras_Comida VALUES (00004, 'Enchiladas', '25/January/2023');
INSERT INTO Compras_Comida VALUES (00005, 'Enrollados de canela', '7/February/2023');
INSERT INTO Compras_Comida VALUES (00006, 'Atun de vegetales', '19/March/2023');

--8. Factura Comida: ID, Fecha de Consulta, Cantidad, Fecha de llegada, ID Proveedor, ID Producto, Precio
INSERT INTO Factura_Comida VALUES (000001, '10/April/2023', 100, SYSDATE, 00001, 00004, 300000.00);
INSERT INTO Factura_Comida VALUES (000002, '20/January/2023', 300, '13/April/2023', 00005, 00003, 400000.00);
INSERT INTO Factura_Comida VALUES (000003, '5/March/2023', 150, '20/March/2023', 00002, 00002, 150000.00);
INSERT INTO Factura_Comida VALUES (000004, '8/February/2023', 200, SYSDATE, 00004, 00005, 250000.00);
INSERT INTO Factura_Comida VALUES (000005, '30/January/2023', 200, '22/April/2023', 00003, 00005, 780000.00);
INSERT INTO Factura_Comida VALUES (000006, '8/February/2023', 200, SYSDATE, 00006, 00006, 900000.00);

--9. Estudiantes (Categoría: 3): Codigo, Nombre, Apellido, Canton y Categoria
INSERT INTO Estudiantes VALUES (00001, 'Manuel', 'Solis', 00008, 3);
INSERT INTO Estudiantes VALUES (00002, 'Ana', 'Masis', 00001, 3);
INSERT INTO Estudiantes VALUES (00003, 'Jesica', 'White', 00002, 3);
INSERT INTO Estudiantes VALUES (00004, 'Veronica', 'Lodge', 00006, 3);
INSERT INTO Estudiantes VALUES (00005, 'Raul', 'Rodriguez', 00005, 3);
INSERT INTO Estudiantes VALUES (00006, 'Marco', 'Perez', 00008, 3);

--10. Expositor (Categoría: 4): Codigo, Nombre, Apellido, Canton y Categoria
INSERT INTO Expositor VALUES (00001, 'Leonardo', 'Castillo', 00008, 4);
INSERT INTO Expositor VALUES (00002, 'Victor', 'Segura', 00007, 4);
INSERT INTO Expositor VALUES (00003, 'Marta', 'Young', 00001, 4);
INSERT INTO Expositor VALUES (00004, 'Nirma', 'Juarez', 00005, 4);
INSERT INTO Expositor VALUES (00005, 'Caithlyn', 'Gomez', 00003, 4);
INSERT INTO Expositor VALUES (00006, 'Nina', 'Dobre', 00002, 4);

--11. Eventos: Codigo, Fecha, Tiempo, Nombre, Modalidad, Expositor
INSERT INTO Eventos VALUES (000001, '25/April/2023', '1 hora y media', 'Charla Motivacional', 'Presencial', 00003);
INSERT INTO Eventos VALUES (000002, '27/April/2023', '2 horas', 'Blue Monday', 'Virtual', 00001);
INSERT INTO Eventos VALUES (000003, '31/January/2023', '1 hora y media', ' Alimentacion Sana', 'Presencial', 00004);
INSERT INTO Eventos VALUES (000004, '16/February/2023', '45 minutos', 'Relaciones Sanas', 'Virtual', 00005);
INSERT INTO Eventos VALUES (000005, '21/February/2023', '1 hora y media', 'Prevención del Estrés', 'Virtual', 00005);
INSERT INTO Eventos VALUES (000006, '19/March/2023', '1 hora', 'Clase de Yoga', 'Presencial', 00006);
INSERT INTO Eventos VALUES (000007, '10/March/2023', '1 hora y media', 'Skin Care', 'Virtual', 00002);

--12. Registro de Evento: (ID, Id_Evento,Id_EstudiantesE, Id_Expositor.
INSERT INTO Registro_Eventos VALUES (0000000001, 000001, 00001, 00004);
INSERT INTO Registro_Eventos VALUES (0000000002, 000002, 00002, 00006);
INSERT INTO Registro_Eventos VALUES (0000000003, 000003, 00001, 00002);
INSERT INTO Registro_Eventos VALUES (0000000004, 000004, 00003, 00002);
INSERT INTO Registro_Eventos VALUES (0000000005, 000005, 00005, 00001);
INSERT INTO Registro_Eventos VALUES (0000000006, 000006, 00006, 00005);
INSERT INTO Registro_Eventos VALUES (0000000007, 000007, 00006, 00004);


--13. Organizacion para el TCU (Categoría: 5): ID, Vistas, Nombre, Canton y Categoria
INSERT INTO Organizacion_TCU VALUES (00001, 3, 'Manos Sin Fronteras', 00002, 5);
INSERT INTO Organizacion_TCU VALUES (00002, 5, 'Greenpeace', 00008, 4);
INSERT INTO Organizacion_TCU VALUES (00003, 4, 'Fundación vida salvaje', 00006, 5);
INSERT INTO Organizacion_TCU VALUES (00004, 6, 'Unicef', 00001, 4);
INSERT INTO Organizacion_TCU VALUES (00005, 10, 'Alzheimer Disease International ', 00004, 5);
INSERT INTO Organizacion_TCU VALUES (00006, 6, 'Asilo de Ansianos', 00001, 5);


--14. Registro del TCU: ID, ID Organizacion, ID Estudiante
INSERT INTO Registro_TCU VALUES (000000001, 00004, 00001);
INSERT INTO Registro_TCU VALUES (000000002, 00003, 00006);
INSERT INTO Registro_TCU VALUES (000000003, 00001, 00002);
INSERT INTO Registro_TCU VALUES (000000004, 00002, 00001);
INSERT INTO Registro_TCU VALUES (000000005, 00004, 00004);
INSERT INTO Registro_TCU VALUES (000000006, 00005, 00005);
INSERT INTO Registro_TCU VALUES (000000007, 00005, 00002);

--15. LogIn: Clave, Usuario, Acceso, Fecha_Venc
INSERT INTO LogIn VALUES (1234,'Administrador', 'All', '31-December-2022');

--16. Factor Emision ID, Factor, Valor y Fecha_Vigencia
INSERT INTO Factores VALUES (00001, 'Factor Combustible', 2.67, '31/December/2023');
INSERT INTO Factores VALUES (00002, 'Factor de Energia', 0.12, '31/December/2023');
INSERT INTO Factores VALUES (00003, 'Factor Agricola', 4.94, '31/December/2023');
INSERT INTO Factores VALUES (00004, 'Factor Ganadero', 55.00, '31/December/2023');

--17. Huella de Carbono: Huella, Categoria , Dato_Actividad, Kilometros, Factor_Emision 
--Scripts necesarios para llenar la tabla de Huellas

--1. Elegir la categoria
SELECT * FROM Categoria;
--2. Buscar el ID de la categoria seleccionada y su canton
SELECT * FROM Proveedor_Bienes; --Categoria: 1
SELECT * FROM Proveedor_Comida; --Categoria: 2
SELECT * FROM Estudiantes; --Categoria: 3
SELECT * FROM Expositor; --Categoria: 4
SELECT * FROM Organizacion_TCU; --Categoria: 5
--3. Identificar el canton y su Dato de Actividad
SELECT Id_Canton, Canton_Descripcion, Kilometros, (Kilometros/10)*2 AS Dato_Actividad FROM Canton;
--4. Ver el Valor del factor emision
SELECT * FROM Factores WHERE Id_Factor = 1;
--5. Insertar y sacar la huella de carbono: ID, Categoria , ID de la categoria, Dato_Actividad, Factor_Emision, Huella 
INSERT INTO Huella_Carbono VALUES (00001, 1, 00003, 11, 2.67, 0);
INSERT INTO Huella_Carbono VALUES (00002, 1, 00002, 7.2, 2.67, 0);
INSERT INTO Huella_Carbono VALUES (00003, 3, 00005, 2.2, 2.67, 0);

UPDATE Huella_Carbono SET Huella = Dato_Actividad * Factor_Emision;

SELECT * FROM Huella_Carbono;

--Vistas 
CREATE VIEW SellosVerdes AS
SELECT Expositor.Nombre_Expositor, Eventos.Id_Evento, Eventos.Nombre_Evento, Estudiante.Id_EstudiantesE, Estudiante.NombreE FROM Expositor
INNER JOIN Eventos ON Expositor.Id_Expositor=Eventos.Id_Expositor

CREATE OR REPLACE VIEW SellosVerdes AS 
SELECT Expositor.Nombre_Expositor, Eventos.Id_Evento FROM Expositor
INNER JOIN Eventos ON Expositor.Id_Expositor=Eventos.Id_Expositor

CREATE VIEW CierreDeCaja AS
SELECT Factura_Comida.N_FacturaA, Compras_Comida.Id_ProductoA, Compras_Comida.Nombre_ProductoA FROM Factura_Comida
INNER JOIN Compras_Comida ON Factura_Comida.Id_ProductoA=Compras_Comida.Id_ProductoA

DROP VIEW SellosVerdes; -- elimina la tabla---
--Indices
CREATE INDEX factor ON Factores(Id_Factor);
CREATE INDEX cant ON Canton(Provincia);
CREATE INDEX dato ON Huella_Carbono(Dato_Actividad);


--Eliminar las tablas

ALTER TABLE Compras_Comida DROP PRIMARY KEY CASCADE;
drop table Compras_Comida;

ALTER TABLE Estudiantes DROP PRIMARY KEY CASCADE;
drop table Estudiantes;

ALTER TABLE Eventos DROP PRIMARY KEY CASCADE;
drop table Eventos;

ALTER TABLE Expositor DROP PRIMARY KEY CASCADE;
drop table Expositor;

ALTER TABLE Factura_Bienes DROP PRIMARY KEY CASCADE;
drop table Factura_Bienes;

ALTER TABLE Factura_Comida DROP PRIMARY KEY CASCADE;
drop table Factura_Comida;

ALTER TABLE Huella_Carbono DROP PRIMARY KEY CASCADE;
drop table Huella_Carbono;

ALTER TABLE LogIn DROP PRIMARY KEY CASCADE;
drop table LogIn;

ALTER TABLE Organizacion_TCU DROP PRIMARY KEY CASCADE;
drop table Organizacion_TCU;

ALTER TABLE Productos_Bienes DROP PRIMARY KEY CASCADE;
drop table Productos_Bienes;

ALTER TABLE Proveedor_Bienes DROP PRIMARY KEY CASCADE;
drop table Proveedor_Bienes;

ALTER TABLE Registro_Eventos DROP PRIMARY KEY CASCADE;
drop table Registro_Eventos;

ALTER TABLE Registro_TCU DROP PRIMARY KEY CASCADE;
drop table Registro_TCU;

ALTER TABLE Proveedor_Comida DROP PRIMARY KEY CASCADE;
drop table Proveedor_Comida;

ALTER TABLE CATEGORIA DROP PRIMARY KEY CASCADE;
drop table Categoria;

ALTER TABLE Canton DROP PRIMARY KEY CASCADE;
drop table Canton;

ALTER TABLE Factores DROP PRIMARY KEY CASCADE;
drop table Factores;

--Eliminar datos
delete from Categoria;
delete from Canton;
delete from Estudiantes;
delete from Proveedor_Bienes;
delete from Proveedor_Comida;
delete from Factura_Bienes;
delete from Factura_Comida;
delete from Productos_Bienes;
delete from Compras_Comida;
delete from LogIn;
delete from Organizacion_TCU;
delete from Registro_TCU;
delete from Eventos;
delete from Registro_Eventos;
delete from Expositor;
delete from Huella_Carbono;
delete from Factores;

