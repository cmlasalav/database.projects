/*TABLA DICCIONARIO DE TIPO DE EMPLEADO*/
CREATE TABLE TipoEmpleado (
    id_Tipo VARCHAR (1),
    nombre_Tipo VARCHAR (20) NOT NULL,
    CONSTRAINT PK_tipoEmpleado PRIMARY KEY (id_Tipo)
);

/*TABLA CON LOS DATOS DE LOS EMPLEADOS*/
CREATE TABLE Empleado (
    cedula_Empleado VARCHAR (9),
    nombre_Empleado VARCHAR (20) NOT NULL,
    apellido1_Empleado VARCHAR (20) NOT NULL,
    apellido2_Empleado VARCHAR (20) NOT NULL,
    correo VARCHAR (50) NOT NULL,
    contraseÃƒÂ±a VARCHAR (12) NOT NULL,
    id_Tipo VARCHAR (1) NOT NULL,
    CONSTRAINT PK_empleado PRIMARY KEY (cedula_Empleado),
    CONSTRAINT FK_tipoEmpleado FOREIGN KEY (id_Tipo)
    REFERENCES TipoEmpleado (id_Tipo)
);

/*TABLA CON LOS DATOS DE LOS CLIENTES*/
CREATE TABLE Cliente (
    cedula_Cliente VARCHAR (9),
    nombre_Cliente VARCHAR (20) NOT NULL,
    apellido1_Cliente VARCHAR (20) NOT NULL,
    apellido2_Cliente VARCHAR (20) NOT NULL,
    direccion VARCHAR (100) NOT NULL,
    telefono VARCHAR (8) NOT NULL,
    correo VARCHAR (50) NOT NULL,
    contrasena VARCHAR (12) NOT NULL,
    CONSTRAINT PK_cliente PRIMARY KEY (cedula_Cliente)
);

/*TABLA DE LAS CATEGORIAS DE LOS PRODUCTOS*/
CREATE TABLE CategoriaProductos (
    id_Categoria VARCHAR (2),
    nombre_Categoria VARCHAR (50) NOT NULL,
    CONSTRAINT PK_categoriaProductos PRIMARY KEY (id_Categoria)
);

/*TABLA QUE ALMACENA LOS DATOS DE LOS PRODUCTOS*/
CREATE TABLE Producto (
    id_Producto VARCHAR (10),
    nombre_Producto VARCHAR (20) NOT NULL,
    precio_Producto INTEGER NOT NULL CHECK (precio_Producto>0),
    inventario INTEGER NOT NULL CHECK (inventario>=0),
    id_Categoria VARCHAR (2) NOT NULL,
    imagen VARCHAR (200) NOT NULL,
    CONSTRAINT PK_productos PRIMARY KEY (id_Producto),
    CONSTRAINT FK_categoria FOREIGN KEY (id_Categoria) 
    REFERENCES CategoriaProductos (id_Categoria)
);

/*ALMACENA LOS PRODUCTOS QUE EL CLIENTE AGREGA AL CARRITO*/
CREATE TABLE  Carrito (
	id_Carrito VARCHAR (10),
	cantidad_Producto INTEGER (3) NOT NULL,
	cedula_Cliente VARCHAR (9) NOT NULL,
	id_Producto VARCHAR (10) NOT NULL,
	CONSTRAINT PK_carrito PRIMARY KEY (id_Carrito),
   CONSTRAINT FK_cedulaCliente FOREIGN KEY (cedula_Cliente) 
   REFERENCES Cliente (cedula_Cliente),
   CONSTRAINT FK_idProducto FOREIGN KEY (id_Producto) 
   REFERENCES Producto (id_Producto)
);

/*ALMACENA EL ESTADO EN QUE PUEDE ESTAR UNA FACTURA*/
CREATE TABLE EstadoFactura (
	id_Estado VARCHAR (1),
	descripcion_Estado VARCHAR (20) NOT NULL,
	CONSTRAINT PK_estadoFactura PRIMARY KEY (id_Estado)
);

/*ALMACENA LOS DATOS DE LA COMPRA DE FORMA GENERAL*/
CREATE TABLE Factura (
    id_Factura VARCHAR (10),
    fecha_Compra DATE NOT NULL,
    total_Compra DECIMAL (7,2) NOT NULL CHECK (total_Compra>0),
    cedula_Cliente VARCHAR (9) NOT NULL,
    id_Estado VARCHAR (1) NOT NULL,
    CONSTRAINT PK_factura PRIMARY KEY (id_Factura),
    CONSTRAINT FK_cedula_Cliente FOREIGN KEY (cedula_Cliente)
    REFERENCES Cliente (cedula_Cliente),
    CONSTRAINT FK_estado FOREIGN KEY (id_Estado)
    REFERENCES EstadoFactura (id_Estado)
);

/*DEFINE LOS TIPOS DE ENTREGA*/
CREATE TABLE Entrega (
    id_Entrega VARCHAR (1),
    descripcion_Entrega VARCHAR (20) NOT NULL,
    CONSTRAINT PK_Entrega PRIMARY KEY (id_Entrega)
);

/*ALMACENA LOS DATOS DE LA COMPRA DE FORMA MAS ESPECIFICA*/
CREATE TABLE DetalleFactura (
    id_Detalle VARCHAR (10),
    id_Factura VARCHAR (10) NOT NULL,
    id_Producto VARCHAR (5) NOT NULL,
    cantidad_Producto INTEGER NOT NULL,
    id_Entrega VARCHAR (1),
    CONSTRAINT PK_detalle PRIMARY KEY (id_Detalle),
    CONSTRAINT FK_idFactura FOREIGN KEY (id_Factura)
    REFERENCES Factura (id_Factura),
    CONSTRAINT FK_id_Producto FOREIGN KEY (id_Producto)
    REFERENCES Producto (id_Producto),
    CONSTRAINT FK_idEntrega FOREIGN KEY (id_Entrega)
    REFERENCES Entrega (id_Entrega)
);

DROP TABLE TipoEmpleado;
DROP TABLE Empleado;
DROP TABLE Cliente;
DROP TABLE CategoriaProductos;
DROP TABLE Producto;
DROP TABLE Carrito;
DROP TABLE EstadoFactura;
DROP TABLE Factura;
DROP TABLE Entrega
DROP TABLE DetalleFactura;


/*INSERTS*/

INSERT INTO cliente (cedula_Cliente, nombre_Cliente, apellido1_Cliente,apellido2_Cliente, direccion, telefono, correo, contrasena) VALUES ('109870645','Pedro','Matinez','Pereira','Alajuela','81326523','pedro@gmail.com', 'qwer'),
('208670345','Emmanuel','Cordero','Cordero','San Jose', '73446323','emma@gmail.com', 'qwer');

INSERT INTO tipoempleado (id_Tipo, nombre_Tipo) VALUES ('1', 'Empleado'), ('2', 'Administrador');

INSERT INTO empleado (cedula_Empleado,nombre_Empleado,apellido1_Empleado,apellido2_Empleado,id_Tipo,correo,contrasena) VALUES ('209870345','Juan','Perez','Rojas','1','juan@adis.com','adis'), ('109250342','Carlos','Solis','Chaves','2','carlos@adis.com','adis');

INSERT INTO categoriaproductos (id_Categoria, nombre_Categoria) VALUES ('01', 'Frutas y Verduras'), ('02', 'Carnes'), ('03', 'Lacteos'), ('04', 'Pescaderia'), ('05', 'Reposteria y Panaderia'), ('06', 'Congelados'), ('07', 'Mariscos y vegetales en lata'), ('08', 'Salsas y aderezos'), ('09', 'Pastas alimenticias'), ('10', 'Aceites y grases vegetales'), ('11', 'Granos basicos'), ('12', 'Galletas y Cereales'), ('13', 'Cafe y te'), ('14', 'Jaleas y mermeladas'), ('15', 'Confites y chocolates'), ('16', 'Snacks'), ('17', 'Hidratantes'), ('18', 'Refrescos'), ('19', 'Helados'), ('20', 'Bebidas alcoholicas'), ('21', 'Gaseosas');

INSERT INTO entrega (id_Entrega, descripcion_Entrega) VALUES ('1','Entrega a domicilio'), ('2', 'Retiro en supermercado');

INSERT INTO estadofactura (id_Estado,descripcion_Estado) VALUES ('1', 'Cancelado'), ('2','Pendiente'), ('3','Anulado');

--Categorias

INSERT INTO CategoriaProductos VALUES ('01', 'Frutas y Verduras');
INSERT INTO CategoriaProductos VALUES ('02', 'Carnes');
INSERT INTO CategoriaProductos VALUES ('03', 'Lacteos');
INSERT INTO CategoriaProductos VALUES ('04', 'Pescaderia');
INSERT INTO CategoriaProductos VALUES ('05', 'Reposteria y Panaderia');
INSERT INTO CategoriaProductos VALUES ('06', 'Congelados');
INSERT INTO CategoriaProductos VALUES ('07', 'Mariscos y vegetales en lata');
INSERT INTO CategoriaProductos VALUES ('08', 'Salsas y aderezos');
INSERT INTO CategoriaProductos VALUES ('09', 'Pastas alimenticias');
INSERT INTO CategoriaProductos VALUES ('10', 'Aceites y grases vegetales');
INSERT INTO CategoriaProductos VALUES ('11', 'Granos basicos');
INSERT INTO CategoriaProductos VALUES ('12', 'Galletas y Cereales');
INSERT INTO CategoriaProductos VALUES ('13', 'Cafe y te');
INSERT INTO CategoriaProductos VALUES ('14', 'Jaleas y mermeladas');
INSERT INTO CategoriaProductos VALUES ('15', 'Confites y chocolates');
INSERT INTO CategoriaProductos VALUES ('16', 'Snacks');
INSERT INTO CategoriaProductos VALUES ('17', 'Hidratantes');
INSERT INTO CategoriaProductos VALUES ('18', 'Refrescos');
INSERT INTO CategoriaProductos VALUES ('19', 'Helados');
INSERT INTO CategoriaProductos VALUES ('20', 'Bebidas alcoholicas');
INSERT INTO CategoriaProductos VALUES ('21', 'Gaseosas');

--Productos INSERT INTO productos (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES 

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES 

INSERT INTO producto VALUES ('1', 'Aceite Clover',2300, 100, '10', 'https://drive.google.com/uc?export=download&id=1IGbXG56mfoegRGylugdPt1N_WYYlMY-l');
INSERT INTO producto VALUES('2', 'Fresas Bandeja',1000,340,'01','https://drive.google.com/uc?export=download&id=1b4-8rg8WSSCbyyGd7NRS9c3hX0yX_TBc');
INSERT INTO producto VALUES('3','Frijol Ducal Molido',1500,200,'11','https://drive.google.com/uc?export=download&id=1a2_7C9z8tjTz1StT9r-Z1tphhmG00I7X');
INSERT INTO producto VALUES('4','Harina Nacarina',1000 ,45 ,'05','https://drive.google.com/uc?export=download&id=1BTm2tjFDdFkMx_sZT0V5kvnzTl0VsHSU');
INSERT INTO producto VALUES('5','Limon Mandarino',1000 ,876 ,'01','https://drive.google.com/uc?export=download&id=1YDQraLmpRFuvWtDQ6De0odNMJMEmv6Or');
INSERT INTO producto VALUES('6','Mayonesa HellMans',1100 ,96 ,'08','https://drive.google.com/uc?export=download&id=1ra-Mn2lvXvQQJ69ZBwVJ4dl3pUdIjMlL');
INSERT INTO producto VALUES('7','Palomitas Act II',200 ,700 ,'16','https://drive.google.com/uc?export=download&id=1ahyF7V5pfo_Fr0hLU7kYWFozuiuGgYFz');
INSERT INTO producto VALUES('8','Torta Pollo',4000 ,99 ,'02','https://drive.google.com/uc?export=download&id=1npRxh3V-umwfcRhTaskenBNR0_C1bJHY');

INSERT INTO producto VALUES('8','Torta Pollo Don Cristobal',4000 ,99 ,'02','https://drive.google.com/uc?export=download&id=1npRxh3V-umwfcRhTaskenBNR0_C1bJHY'); -->Muy largo el nombre



--Frutas y verduras = 01

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES 

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES ('9', 'Banano Especial', 450, 150 ,'01','https://drive.google.com/uc?export=download&id=1Vkn07B299q7_lHUEvoiva0Qc7FTL5O38 ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES ('10', 'Aguacate Empacado',2400 ,100 ,'01','https://drive.google.com/uc?export=download&id=15M-VDYva5kEsRVLS8PONo-lc3LHuqcdp ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES ('11', 'Tomate Cherry',750 , 40,'01','https://drive.google.com/uc?export=download&id=1eLrN9_Jx_R91OlGbR8mPncF5B77kCD4J ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES ('12', 'Papa MarcaHortifruti', 2370 , 100 ,'01','https://drive.google.com/uc?export=download&id=1KI9qQel-GRgs5VidV4Ez0UkWE9RX9heR ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES ('13', 'Culantro En Rollo',370,300,'01','https://drive.google.com/uc?export=download&id=19atFOP8OTotInvmWIWwALXAK2MaivA8_ ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES ('14', 'Uva Globo Empacado ',2150,200,'01','https://drive.google.com/uc?export=download&id=192Yij1qfe5SoxD0WKi4ISRa1LlTRchrE');

--Carnes = 02

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES  ('15', 'Carne Molida Magra', 6500, 100 ,'02',' https://drive.google.com/uc?export=download&id=1pGIozOvCgh717q9SBdGPoxBOTJXiqs2M');


INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES ('16', 'Salmón Congelado ', 4640 ,100 ,'02','https://drive.google.com/uc?export=download&id=1SoNRjExrHraYIdwHjmZtfJAcfrfYQxSM ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES ('17', 'Muslo De Pollo',3410, 200,'02',' https://drive.google.com/uc?export=download&id=1FRoby6Px79_2Gab4iJ6zhwI4bb2t6x2X ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES ('18', 'Tocino Great Value ',4500 ,80 ,'02','https://drive.google.com/uc?export=download&id=1y3SdngRX-BctAQADs_KUqTsNL-iNfhTX');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES ('19', 'Bistec Lomo De Res ', 4800, 100 ,'02','https://drive.google.com/uc?export=download&id=1MzQpMqPUj9daNyp-hQ8hJZWSyQdJ0cer ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES ('20','Chuleta De Cerdo ', 4320, 40 ,'02',' https://drive.google.com/uc?export=download&id=1Z9VYm6joi9IM1z0CWxMmtsJbCrvvd3xm');


--Lacteos = 03

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('21', 'Queso Cottage ', 3700 , 30 ,'03','https://drive.google.com/uc?export=download&id=1gO3ss1Dv4czYicuLkyLaq-Sb9XE8oCdY');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('22', 'Leche Condensada',1170 ,60 ,'03','https://drive.google.com/uc?export=download&id=1biatZnBs4UaN8U5fjIDetXszqXo0u3en ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('23', 'LecheSemidescremada ',1190 , 120 ,'03','https://drive.google.com/uc?export=download&id=1sb5WjhLkLPaHc8-a6HvTO-QFGXXRZ5x_');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('24', 'Queso Turrialba',2330 ,300 ,'03','https://drive.google.com/uc?export=download&id=1mywqvVIBFwedDMOy2SFp3sr1YyiI0rKN');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('25', 'Natilla LibreLactosa',1590 ,55 ,'03','https://drive.google.com/uc?export=download&id=1LJCfUbHhg3HeXK3BWqeNFgvRTAfionR4 ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('26', 'Leche En Polvo', 6510 ,20 ,'03','https://drive.google.com/uc?export=download&id=1tZSoWqdp2yHoNjyiWevJPZPLX1kEeLON');

--Pescaderia = 04
INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('27', 'Camarón Pelado',6800 ,20 ,'04','https://drive.google.com/uc?export=download&id=1naxDyCqlPbIG3-a0leDLszNIRCOxupr_ ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('28', 'Pulpo Congelado',5278 ,40 ,'04','https://drive.google.com/uc?export=download&id=1TkeP8nPVGaOis5NlHAMEVi5L27QeYZef ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('29', 'Almeja Congelada',2000 ,34 ,'04','https://drive.google.com/uc?export=download&id=1dl3SAq4MO4PoMuPuW77NaqI2E5rJvn8x');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('30', 'Pancitas De Tilapia',3300 ,20 ,'04','https://drive.google.com/uc?export=download&id=198Q9HQJUevtM1Zd3Xg5QESwMDREjYRIB ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('31', 'Filetes Anchoa',6800 ,300 ,'04','https://drive.google.com/uc?export=download&id=1CwHu88jAkKcayouOB2xUkpGhxj4tAI2a ');



--Reposteria y Panaderia = 05 
INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('32', 'Tartara Bandeja',1720 ,100 ,'05','https://drive.google.com/uc?export=download&id=17xsq_yjQnygusvG3GFwG5DqHTp2ZLcK7');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('33', 'Tres Leches',3630 ,5 ,'05','https://drive.google.com/uc?export=download&id=1MZUYMDRpqjDMFRnwux3qkyLPVe3SMJ3e');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('34', 'Torta Selva Negra', 9900 , 6 ,'05','https://drive.google.com/uc?export=download&id=1tULu1wloNtM3BQ3_zQVtHG4mKLYvuM-b');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('35', 'Queque Marmoleado', 3900 ,3 ,'05','https://drive.google.com/uc?export=download&id=1q31NX2deZm1AKnIM6rS2ienPYlBfY9Ne');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('36', 'Porcion Cheese Cake',1900 ,10 ,'05','https://drive.google.com/uc?export=download&id=1Cx15NmYsMCtuf-Z8qcz3Mrx1f3GRFQBW');



--Congelados = 06

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('37', 'Papa FritaCongelada',1320 ,30 ,'06','https://drive.google.com/uc?export=download&id=1YYHnFQGXTkRAGBtBZyDUu5OOW7gaK6FE');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('38', 'Piña PeladaEmpacado',1162 ,30 ,'06','https://drive.google.com/uc?export=download&id=1TbOU49TnoKqTaFCnJFdSyf1V78pSMoGt');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('39', 'Helado Queque ',10500 ,250 ,'06','https://drive.google.com/uc?export=download&id=1uyB5oTxtaa_4RftQWxegc0BJ4EMUW7az');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('40', 'Torta De Carne ',2176 ,20 ,'06','https://drive.google.com/uc?export=download&id=1lCl4sRQyB86jBZDXpmBl_DCSe6H3Mrgb');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('41', 'Vegetales Mixt',1160 ,30 ,'06','https://drive.google.com/uc?export=download&id=1mWhJSSmscqjlDfsCKPzV7OuKKkT8CKUv');



--Mariscos y vegetales en lata = 07
INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('42', 'VegetalesMixtos Lata',510,300 ,'07','https://drive.google.com/uc?export=download&id=1yp3zsdfJsZPmJdMwqs_NFeT_MNlhTPOW ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('43', 'Maiz Dulce Lata',690 ,130 ,'07','https://drive.google.com/uc?export=download&id=1wM_x8cmHV62cp_PrAdK187gnIw9bzka- ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('44', 'EsparragosVerde Lata',3800 ,190 ,'07','https://drive.google.com/uc?export=download&id=1A4lYmkX8EKrof3t0tbRtbhYq6Q36pwZl ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('45', 'Palmito Trozos Lata',1160 ,49 ,'07','https://drive.google.com/uc?export=download&id=1JGZfVGyj60ijXs3D4N2REy44OOp2EXqe ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('46', 'Champinon Escabeche',1500 ,35 ,'07','https://drive.google.com/uc?export=download&id=1i-zOY248jmXyie02_iEfPguJqdZW8nQj ');


--Salas y Aderezos = 08

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('47', 'Ketchup Banquete',1590 ,290 ,'08','https://drive.google.com/uc?export=download&id=1QgCEm3OEzKV_hXTXInDp__IeH8iojRMu');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('48', 'Salsa Jengibre Naranja',1370 ,180,'08','https://drive.google.com/uc?export=download&id=1l0m59ScHbJept3gISTMdVpALRuT4tPou');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('49', 'Salsa Teriyaki Miel',5740, 140 ,'08','https://drive.google.com/uc?export=download&id=1GBMnaaRVMeq6qbX91ZjybYztHPB7eYEv');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('50', 'Salsa Tabasco Picante',1840 ,264 ,'08','https://drive.google.com/uc?export=download&id=1H2axshRL2z6T8vTicJqxXmLn8VXvwKR3');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('51', 'Salsa Caribeña',1150 ,200 ,'08','https://drive.google.com/uc?export=download&id=1_hOExUgC0fMzhMWO4sJBt0ZHPyQYygB1');


--Pastas Alimenticias = 09

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('52', 'Pasta TomateAlbahaca',1180 ,200 ,'09','https://drive.google.com/uc?export=download&id=1WDXVG3YAmt0y6Bs_g4pYLQwYjQBwTuRw ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('53', 'Pasta Gluten Free',1380 , 30 ,'09','https://drive.google.com/uc?export=download&id=1VtNiycaKPNqxZ1rao4pQGVBsbed2aaEM ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('54', 'Pasta Fideo Integral', 2480, 300 ,'09','https://drive.google.com/uc?export=download&id=1hodPz-Z7GP1VDQdVQN7WLtfeU7gaVkQH ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('55', 'PastaTornillo Gluten',1360 ,219 ,'09','https://drive.google.com/uc?export=download&id=1ocHKIIVQ0C6sqgwYwdGMTYYjfxgKa99I ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('56', 'Pasta Ghocchis',1840 ,180 ,'09','https://drive.google.com/uc?export=download&id=1Odov7-i0qtjswcnQCRFiHAEfnN8ueonA ');


--Aceites y grasas vegetales = 10
INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('57', 'Aceite Oliva Spray',2500 ,40 ,'10','https://drive.google.com/uc?export=download&id=1jVYjon0kcH0BF-j3BbRRk-oGcO1B3sCZ ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('58', 'Aceite Extra Oliva',6600 ,300 ,'10','https://drive.google.com/uc?export=download&id=1B9q6QkyDWU3jSf_GFry1tccCrG4VpNeU ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('59', 'Aceite Aguacate',6950,120 ,'10','https://drive.google.com/uc?export=download&id=1BBs-cB7Jf_5NzRGHu6D_pdb9qG3Sl_Jb ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('60', 'Aceite Oliva Ajo', 3620 ,210 ,'10','https://drive.google.com/uc?export=download&id=1UEnMGK9-QwwG1_KSta8_3l51nrop2ink ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('61', 'Aceite con Romero',3410 , 130,'10','https://drive.google.com/uc?export=download&id=1zt8x3jhd9G6ks4cakr7IBMay6ciIabJJ ');


--Granos Basicos = 11
INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('62', 'Arroz Grano Entero',3750 ,200 ,'11','https://drive.google.com/uc?export=download&id=1n7C4zsRppcIH3Nu4z91YVVwcpfp469nX');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('63', 'Frijol Negro',1290 ,240 ,'11','https://drive.google.com/uc?export=download&id=1PUXVb-Es29XbUqd9JPYzIX4PanU9xnsE');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('64', 'Frijol Rojo ',1560 ,222 ,'11','https://drive.google.com/uc?export=download&id=1AY5yIDXCnoFuMnKT8jGFFY1PdGS1X-n4');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('65', 'Lentejas Bolsa',845 ,340 ,'11','https://drive.google.com/uc?export=download&id=18N1uH6dWvj8Kj5XiaI_xIKHrUEb1lxVD');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('66', 'Garbanzos Bolsa',810 , 70 ,'11','https://drive.google.com/uc?export=download&id=1SBblCJh4vWf7FyYcpCGTEgS-cgTm4lXN');


--Galletas y Cereales = 12

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('67', 'Galleta Arándano',2700 ,120 ,'12','https://drive.google.com/uc?export=download&id=1W2_TX-k1UNLhoUGi6TlNaLfmiYv_KmJP');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('68', 'Galletas Soda ',2990 ,100 ,'12','https://drive.google.com/uc?export=download&id=1pmMixXNX2H4OBwMGQEWOkCp4Dw8ARKOa');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('69', 'Galletas Julieta',1340 ,400 ,'12','https://drive.google.com/uc?export=download&id=1ejlb5ldFGl5dWGTHSRkOceTUNEPestf_');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('70', 'Cereal FrootLoops',2000 ,120 ,'12','https://drive.google.com/uc?export=download&id=1QTr4eE-7M8lKaeZVZcOpDZvD87mWtv1J');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('71', 'Cereal Chocozucarita',2320 ,140 ,'12','https://drive.google.com/uc?export=download&id=1nlR-mOgyl5puXezLNavwdtcmRjTyWb-4');


--Cafe y Te = 13
INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('72', 'Café Sánchez',2860 ,39 ,'13','https://drive.google.com/uc?export=download&id=1qb3EV7M4CGCaHV9eE8UY5KDc-8ewS4Fu ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('73', 'Café 1820 Clásico ',1790 , 80,'13','https://drive.google.com/uc?export=download&id=1UYGLVQrGvAx9Yj7H0ho8lMrnS4fbnNNQ ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('74', 'Café Rey Selecto',3000 ,46 ,'13','https://drive.google.com/uc?export=download&id=1KWo6-484XSuAXNHlhxIgxoPHiMvp8IcW ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('75', 'Té Verde Caja',907 ,50 ,'13','https://drive.google.com/uc?export=download&id=1PSmMIeae-9l4SATGU4twbAE-UPYFL_EP ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('76', 'Té Manzanilla Caja',930 ,78 ,'13','https://drive.google.com/uc?export=download&id=1sGhySPSGou7PiaoT9QUU_Woh9AS0Txk_ ');


--Jaleas y Mermeladas = 14
INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('77', 'Jalea Guayaba ',1200 , 59,'14','https://drive.google.com/uc?export=download&id=1oxC0FgTVYxYC7OBuWz7kVT30x2ReoY6-'); 

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('78', 'Jalea Fresa ',1000 ,40 ,'14','https://drive.google.com/uc?export=download&id=1Fbsjp5E_KJ9z0znFDRq6HgpNFSHLzixI');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('79', 'Mermelada Piña ',1150 ,99 ,'14','https://drive.google.com/uc?export=download&id=1zHrF-VGyTc9lMFdTpz8ZPY6aEzIkBxSd');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('80', 'Mermelada Mora ',1100 , 80 ,'14','https://drive.google.com/uc?export=download&id=1gTgeoX7W23L2oE6yaT6abplVYjF0RKi-');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('81', 'Mermelada Arandanos', 3540, 78 ,'14','https://drive.google.com/uc?export=download&id=152KJolcntii-9Qf77NFiVDZYW9-dIWg2');



--Confites y Chocolates  = 15

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('82', 'Morenito Bolsa',820 ,189 ,'15','https://drive.google.com/uc?export=download&id=1We2LHLHKtJuCwoJPVaPwT3DIVaNmPup2 ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('83', 'Bolsa Surtida', 3000 ,40 ,'15','https://drive.google.com/uc?export=download&id=14infSjk9UWL5QjzlA9bToLmmBHPDoFui ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('84', 'Hersheys Dark',2560 ,258 ,'15','https://drive.google.com/uc?export=download&id=1cdLma8k-syCTzSO-ElvEBCPbR7209-yC ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('85', 'Tutto Bombon Relleno',1300 ,34 ,'15','https://drive.google.com/uc?export=download&id=1WcMXF832y6kopvAPfS_2vvxTUtghephy ');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('86', 'Chocolate Kit Kat',2900 ,97 ,'15','https://drive.google.com/uc?export=download&id=1liw9Lyf4U0jcnK0HVOTZvHDA4I1_GaY1 ');


--Snacks = 16
INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('87', 'Meneitos',1400 ,240 ,'16','https://drive.google.com/uc?export=download&id=1Uw8ML-V0awUtFpJNIv5Ew6RTN1uxGZm1');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('88', 'Mejitos Jumbo',1540 ,333 ,'16','https://drive.google.com/uc?export=download&id=1vGeLlHDkw5l7O0f2ev67icmejBEkL6Du');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('89', 'Detodito Fiesta',2200 , 330 ,'16','https://drive.google.com/uc?export=download&id=1qUAVe13OcXYW2nUPK4apT7_DD-othNOi');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('90', 'Takis Xplosión',900 ,30 ,'16','https://drive.google.com/uc?export=download&id=12aHCKLJYyxDrKiKnpmKDN9ZMnmt0PLgz');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('91', 'Tosty Mix ',2100 ,320 ,'16','https://drive.google.com/uc?export=download&id=1ReVPvL3q6VzUcSNhIAZZpQeaY2ukBoSj');


--Hidratantes = 17
INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('92', 'Hidratante Fruit Punch',4794 ,30 ,'17','https://drive.google.com/uc?export=download&id=1XrqI6f-uWjE57EM9kxj4jpv8PmXMjLSz');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('93', 'Hidratante Orange Citrus ',4802 ,25 ,'17','https://drive.google.com/uc?export=download&id=1SSvkW491mLNuwU0-A_TPwwwMQDoNkvXd');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('94', 'Hidratante Cafeína',4675 ,20 ,'17','https://drive.google.com/uc?export=download&id=1lIldpu06BQTcJ2fhX0ULOJRgIfsAtvfH');


--Refrescos = 18

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('95', 'Pepsi 3L',1200 ,20 ,'18','https://drive.google.com/uc?export=download&id=1qY-B-k__v15uM_i5i9Npyequr2O61UF_');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('96', '7Up ',900 ,3 ,'18','https://drive.google.com/uc?export=download&id=18eR1EDSi2u23fJdLfsJD9ImEfA9J3rQB');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('97', 'SQUIRT toronja', 1100 ,32 ,'18','https://drive.google.com/uc?export=download&id=1BLLy3K6Ba2zEFP1JIZve6zHwOCGzzRF7');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('98', 'Mirinda Piña ',1880 , 7 ,'18','https://drive.google.com/uc?export=download&id=1N5vk4GDH3uZ7-N9uVT4RQEJ20VFLINn7');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('99', 'Ginger Evervess',1200 ,60 ,'18','https://drive.google.com/uc?export=download&id=1vw6e4A7O806VIoTwjhBCXrBIj3M7o3Lv');


--Helados = 19

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('100','Helado Coco',2650 ,30 ,'19','https://drive.google.com/uc?export=download&id=13YYGgu58fHyofsfmsYzX44fRKuKKEbP2');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('101', 'Helado Mokka ',3000 , 23 ,'19','https://drive.google.com/uc?export=download&id=1lJLISTNsV2PoGVZij2te5FXctNkcg395');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('102', 'Helado Chips',3100 , 29 ,'19','https://drive.google.com/uc?export=download&id=1b3CRrzSjSAkNCNVp9nyVXplMVY86QLhh');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('103', 'Helado Dinamita',3920 ,40 ,'19','https://drive.google.com/uc?export=download&id=1f2WnM4ec8LMx5u3QjdMSA3NLbFplJ5eW');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('104', 'Helado TortaChilena ',3124 , 50 ,'19','https://drive.google.com/uc?export=download&id=1UL4ZFQRse67d840h5VrvL_-0tiet3yh9');


--Bebidas Alcoholicas = 20

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('105', 'Jagermeister',15160 , 18 ,'20','https://drive.google.com/uc?export=download&id=1QlCl5GdccS2rHGBGSlYR593J_LbaWVJs');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('106', 'Guaro Cacique',4690 , 60 ,'20','https://drive.google.com/uc?export=download&id=1BBpOKOM2egoQf0uP3XTJwIyUZjnUwmp7');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('107', 'Black Label',25500 , 30 ,'20','https://drive.google.com/uc?export=download&id=10NzTdzm3-p4ml7qiTaqLbtdrI7GfDL15');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('108', 'Vino Chileno Blanco', 9170 , 98 ,'20','https://drive.google.com/uc?export=download&id=1vSbPCRc7pane2IQTErpDzv7i9a7XNaEY');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('109', '6 Pack Imperial', 5150 , 300 ,'20','https://drive.google.com/uc?export=download&id=1POQ_0cNa0aE2iJfhqg0LSw6t7D2S6Cqk');



--Gaseosas = 21
INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('110', 'Coca Cola 8pack ', 3420,200 ,'21','https://drive.google.com/uc?export=download&id=1A8EgBkwL42zc1ATafC_5U0tY7m1RFwfY');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('111', '6Pack Pepsi Cola', 3000,176 ,'21','https://drive.google.com/uc?export=download&id=1soaHNGSwfCBFwO1M8z8up9rbbfl78-6x');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('112', 'Coca Cola 2pack 5L',2820 ,39 ,'21','https://drive.google.com/uc?export=download&id=1SHj5brlSQn5SDTGmVzVBzeA0hlo2Mbnc');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('113', 'Coca Cola+Fresca 6L',3835 ,240 ,'21','https://drive.google.com/uc?export=download&id=1E2GRQRjc33m7Nww6iQli6CurbQihL0QN');

INSERT INTO producto (id_Producto, nombre_Producto, precio_Producto, inventario, id_Categoria, imagen)
VALUES('114', 'Canada Dry 3L',2130 ,300 ,'21','https://drive.google.com/uc?export=download&id=1eQ6w4ecv7z6Erh-byqwJDJgqGngV6CtZ');



--Promociones

('COM1', '2 Gaseosas + Ginger Ale',4500 , 30 ,'21','https://drive.google.com/uc?export=download&id=160e4h6UW3uOmWPabBI5evs8lXPOGpFhJ');

('COM2', 'Black Label + Jagermeister',35000 ,15 ,'20','https://drive.google.com/uc?export=download&id=1ANhnIw8rLdd9NlKRJNtAyaMNUKwcVeyO');

('COM3', 'Queque Selva Negra + Helado Torta Chilena',10000 , 23 ,'05','https://drive.google.com/uc?export=download&id=1ThKafcws3AFheN9li9EW9A2vveQTtd9B');

('COM4', 'De Todito + Tosty Mix + Mirinda Piña', 3500 ,6 ,'16','https://drive.google.com/uc?export=download&id=1__LN6qw15xa6U4oeNnh2d9RpGogRgM3s');

('COM5', 'Cereal Chocozucarita + Leche En Polvo ',5000 ,69 ,'12','https://drive.google.com/uc?export=download&id=1jQg7fsgkFPLuvd1o7XcWumUUuSqOBlmX');

('COM6', 'Helado Chips + Galletas Julieta', 3800 , 200 ,'19','https://drive.google.com/uc?export=download&id=1yWtqhpUW_sKwiBHONGhmzyIGuw7PP2TP');

('COM7', 'Café 1820 Clásico + Tartara Bandeja',3000 ,200 ,'13','https://drive.google.com/uc?export=download&id=1iMP-aIB0Tpko-ztXkT33j6DRIA3_ccRs');

('COM8', 'Arroz Grano Entero + Frijol Negro',4000 ,19 ,'11','https://drive.google.com/uc?export=download&id=164QeEGTKxweVVKzVlBTolh-RaRVx_-mE');

('COM9', 'Torta De Carne + Tocino Great Value',5800 ,20 ,'06','https://drive.google.com/uc?export=download&id=1vmr0rv4lIkZ3IteHaW1VIL2s23c-yeRz');

('COM10', 'Helado Coco + Leche Condensada',3800 ,100 ,'19','https://drive.google.com/uc?export=download&id=1O7_4pNbnRP1rv7bxtGdEKfno3yHsUZtf');


SELECT * FROM Producto;
SELECT * FROM CategoriaProductos;


















