--Drop table

DROP TABLE PUESTO CASCADE CONSTRAINTS; DROP TABLE EMPLEADOS CASCADE CONSTRAINTS; DROP TABLE CLIENTE CASCADE CONSTRAINTS; DROP TABLE PRODUCTO CASCADE CONSTRAINTS;
DROP TABLE PRODUCTO_VENTA CASCADE CONSTRAINTS; DROP TABLE PROVEEDOR CASCADE CONSTRAINTS;
DROP TABLE VENTA CASCADE CONSTRAINTS; DROP TABLE MARCA CASCADE CONSTRAINTS; DROP TABLE GERENTES CASCADE CONSTRAINTS;

CREATE TABLE cliente (
cedula	NUMBER(15) NOT NULL, nombre			VARCHAR2(30) NOT NULL, apellido1		VARCHAR2(30) NOT NULL,
apellido2	VARCHAR2(30),
telefono	NUMBER(20) NOT NULL, Correo_E VARCHAR2(35) NOT NULL,
direccion	VARCHAR2(15) NOT NULL

);
 
CREATE TABLE empleados (
cedula	NUMBER(15) NOT NULL, nombre			VARCHAR2(30) NOT NULL, apellido1		VARCHAR2(30) NOT NULL,
apellido2		VARCHAR2(30), Correo_E	VARCHAR2(35),
puesto_codigo	NUMBER(15) NOT NULL, gerentes_cedula NUMBER(15) NOT NULL
);

CREATE TABLE gerentes (
cedula	NUMBER(15) NOT NULL, nombre			VARCHAR2(30) NOT NULL, apellido1		VARCHAR2(30) NOT NULL,
apellido2	VARCHAR2(30),
telefono	 NUMBER(20) NOT NULL, Correo_E	VARCHAR2(35) NOT NULL,
puesto_codigo NUMBER(15) NOT NULL

);

CREATE TABLE marca (
id	NUMBER(15) NOT NULL, nombre VARCHAR2(35) NOT NULL
);

CREATE TABLE producto (
codigo	NUMBER(15) NOT NULL,
descripcion			VARCHAR2(50) NOT NULL, cantidad		NUMBER(15) NOT NULL, precio	NUMBER(15) NOT NULL,
proveedor_cedula NUMBER(15) NOT NULL, marca_id	NUMBER(15) NOT NULL
);
 
CREATE TABLE producto_venta ( producto_codigo NUMBER(15) NOT NULL, venta_id_cmp	NUMBER(15) NOT NULL
);

CREATE TABLE proveedor (
cedula	NUMBER(15) NOT NULL, nombre		VARCHAR2(30) NOT NULL,
apellido1	VARCHAR2(30), apellido2	VARCHAR2(30),
telefono	 NUMBER(20) NOT NULL, Correo_E	VARCHAR2(35) NOT NULL, direccion		VARCHAR2(100) NOT NULL, gerentes_cedula NUMBER(15) NOT NULL
);

CREATE TABLE puesto (
codigo	NUMBER(15) NOT NULL,
descripcion VARCHAR2(35),
nombre	VARCHAR2(30) NOT NULL

);

CREATE TABLE venta (
id_cmp		NUMBER(15) NOT NULL, fecha	DATE NOT NULL,
empleados_cedula NUMBER(15) NOT NULL, cliente_cedula	NUMBER(15) NOT NULL
);
--PRIMARY KEY
--Cliente
ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( cedula );
--Empleados
ALTER TABLE empleados ADD CONSTRAINT empleados_pk PRIMARY KEY ( cedula );
--Gerentes
ALTER TABLE gerentes ADD CONSTRAINT gerentes_pk PRIMARY KEY ( cedula );
--Producto_Venta
ALTER TABLE producto_venta ADD CONSTRAINT producto_venta_pk PRIMARY KEY ( producto_codigo, venta_id_cmp );
--Marca
ALTER TABLE marca ADD CONSTRAINT marca_pk PRIMARY KEY ( id );
--Venta
ALTER TABLE venta ADD CONSTRAINT venta_pk PRIMARY KEY ( id_cmp );
--Producto
ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( codigo );
--Proveedor
ALTER TABLE proveedor ADD CONSTRAINT proveedor_pk PRIMARY KEY ( cedula );
--Puesto
ALTER TABLE puesto ADD CONSTRAINT puesto_pk PRIMARY KEY ( codigo );

--Foreign key
--Gerente
ALTER TABLE gerentes ADD CONSTRAINT gerentes_puesto_fk FOREIGN KEY (puesto_codigo) REFERENCES puesto (codigo);
ALTER TABLE gerentes ADD CONSTRAINT ck_gerente_correo CHECK (correo_e like '%@%ulatech.com%');
--Empleados
ALTER TABLE empleados ADD CONSTRAINT empleados_gerentes_fk FOREIGN KEY ( gerentes_cedula ) REFERENCES gerentes ( cedula );
ALTER TABLE empleados ADD CONSTRAINT empleados_puesto_fk FOREIGN KEY (puesto_codigo) REFERENCES puesto (codigo);
ALTER TABLE empleados ADD CONSTRAINT ck_empleado_correo CHECK (correo_e like '%@%ulatech.com%');
--Proveedor
ALTER TABLE proveedor ADD CONSTRAINT proveedor_gerentes_fk FOREIGN KEY ( gerentes_cedula ) REFERENCES gerentes ( cedula );
ALTER TABLE proveedor ADD CONSTRAINT ck_proveedor_correo CHECK (correo_e like '%@%.com%');
--Producto
ALTER TABLE producto ADD CONSTRAINT producto_proveedor_fk FOREIGN KEY ( proveedor_cedula ) REFERENCES proveedor ( cedula );
ALTER TABLE producto ADD CONSTRAINT producto_marca_fk FOREIGN KEY (marca_id) REFERENCES marca (id);
--Venta
ALTER TABLE venta ADD CONSTRAINT venta_empleados_fk FOREIGN KEY ( empleados_cedula ) REFERENCES empleados ( cedula );
ALTER TABLE venta ADD CONSTRAINT venta_cliente_fk FOREIGN KEY ( cliente_cedula ) REFERENCES cliente ( cedula );
--Producto_Venta
ALTER TABLE producto_venta ADD CONSTRAINT producto_venta_producto_fk FOREIGN KEY ( producto_codigo )REFERENCES producto ( codigo );
ALTER TABLE producto_venta ADD CONSTRAINT producto_venta_venta_fk FOREIGN KEY ( venta_id_cmp ) REFERENCES venta ( id_cmp );
--Cliente
ALTER TABLE cliente ADD CONSTRAINT ck_cliente_correo CHECK (correo_e like '%@%.com%');

--INSERT
--Puesto: Codigo, Descripion, Nombre
INSERT INTO PUESTO (Codigo, Nombre) VALUES(1, 'Gerente');
INSERT INTO PUESTO (Codigo, Nombre) VALUES(2, 'Vendedor');
INSERT INTO puesto (codigo, nombre) VALUES (3, 'Cajero');
INSERT INTO puesto (codigo, nombre) VALUES (4, 'Ensamblador');
INSERT INTO puesto (codigo, nombre) VALUES (5, 'Disenador');
INSERT INTO puesto (codigo, nombre) VALUES (6, 'RH');
INSERT INTO puesto (codigo, nombre) VALUES (7, 'Programador');

--Gerente: Cedula, Nombre, Apellido1, Apellido2, Telefono, Correo_E, Puesto_codigo --> El campo Puesto_Codigo tiene que existir en la tabla de "Puesto"
INSERT INTO GERENTES VALUES(252331663, 'Michael', 'Castro', 'Perez', 67890123,
'michael@ulatech.com', 1);
INSERT INTO gerentes VALUES (404394599, 'Julia', 'Gomez', 'Lopez', 71234567,'julia@ulatech.com', 1);
INSERT INTO gerentes VALUES (708919563, 'Roberto', 'Martinez', 'Sanchez', 80123456, 'roberto@ulatech.com', 1);
INSERT INTO gerentes VALUES (507418538, 'Martha', 'Sanchez', 'Gonzalez', 78901234, 'martha@ulatech.com', 1);
INSERT INTO gerentes VALUES (488213533, 'Jorge', 'Lopez', 'Vargas', 61234567, 'jorge@ulatech.com', 1);
INSERT INTO gerentes VALUES (229055945, 'Laura', 'Gonzalez', 'Fernandez', 82345678, 'laura@ulatech.com', 1);

--Empleado: Cedula, Nombre, Apellido1, Apellido2 , Correo_E, Puesto_codigo, Gerentes_cedula--> El campo Gerente_cedula tiene que existir en la tabla de "Gerentes". El campo Puesto_Codigo tiene que existir en la tabla de "Puesto"
INSERT INTO EMPLEADOS VALUES (424563971, 'Carlos', 'Solis', 'Diaz','carlos@ulatech.com', 2, 404394599);
INSERT INTO empleados VALUES (615892347, 'Andres', 'Ramirez', 'Gonzalez', 'andres@ulatech.com', 2, 488213533);
INSERT INTO empleados VALUES (309487216, 'Sofia', 'Gomez', 'Martinez', 'sofia@ulatech.com', 3, 229055945);
INSERT INTO empleados VALUES (732109584, 'Diego', 'Martinez', 'Sanchez', 'diego@ulatech.com', 4, 507418538);
INSERT INTO empleados VALUES (458621703, 'Elena', 'Sanchez', 'Lopez', 'elena@ulatech.com', 5, 252331663);
INSERT INTO empleados VALUES (296837450, 'Miguel', 'Vargas', 'Gonzalez', 'miguel@ulatech.com', 6, 708919563);
INSERT INTO EMPLEADOS VALUES (712345678, 'Ana', 'Pérez', 'Gómez', 'ana@ulatech.com', 1, 229055945);
INSERT INTO empleados VALUES (321456789, 'Luis', 'Ramírez', 'Fernández', 'luis@ulatech.com', 2, 404394599);
INSERT INTO empleados VALUES (658901247, 'María', 'Martínez', 'González', 'maria@ulatech.com', 3, 708919563);
INSERT INTO empleados VALUES (873210945, 'Javier', 'García', 'Rodríguez', 'javier@ulatech.com', 4, 507418538);
INSERT INTO empleados VALUES (187654320, 'Sofía', 'Sánchez', 'Pérez', 'sofia@ulatech.com', 5, 708919563);
INSERT INTO empleados VALUES (346789012, 'Andrés', 'Fernández', 'López', 'andres@ulatech.com', 6, 488213533);
INSERT INTO EMPLEADOS VALUES (725809314, 'Diego', 'Martinez', 'Sanchez','diego@ulatech.com', 2, 404394599);
INSERT INTO empleados VALUES (465890123, 'Laura', 'Gomez', 'Perez', 'laura@ulatech.com', 2, 507418538);
INSERT INTO empleados VALUES (765432198, 'Bryan', 'Hernandez', 'Hernandez', 'miguelh@ulatech.com', 3, 252331663);
INSERT INTO empleados VALUES (278039514, 'Elena', 'Rodriguez', 'Jimenez', 'elenaS@ulatech.com', 2, 708919563);
INSERT INTO empleados VALUES (426780139, 'Carlos', 'Lopez', 'Fernandez', 'carlosl@ulatech.com', 5, 229055945);
INSERT INTO empleados VALUES (281934567, 'Luisa', 'Gomez', 'Gonzalez', 'luisa@ulatech.com', 2, 488213533);
INSERT INTO EMPLEADOS VALUES (518270394, 'David', 'Martinez', 'Gonzalez','david@ulatech.com', 2, 507418538);
INSERT INTO empleados VALUES (349812765, 'Isabel', 'Gomez', 'Rodriguez', 'isabel@ulatech.com', 2, 507418538);
INSERT INTO empleados VALUES (634182759, 'Jorge', 'Garcia', 'Sanchez', 'jorge@ulatech.com', 3, 488213533);
INSERT INTO empleados VALUES (634567890, 'Carmen', 'Rodriguez', 'Perez', 'carmen@ulatech.com', 4, 252331663);
INSERT INTO EMPLEADOS VALUES (524673082, 'Andrea', 'Fernandez', 'Brenes','andrea@ulatech.com', 3, 252331663);
INSERT INTO EMPLEADOS VALUES (624783193, 'Pedro', 'Montenegro', 'Ureña','pedro@ulatech.com', 4, 708919563);
INSERT INTO EMPLEADOS VALUES (724893204, 'Mariana', 'Rodriguez', 'Campos','mariana@ulatech.com', 5, 488213533);
INSERT INTO EMPLEADOS VALUES (824903315, 'Jose', 'Vargas', 'Arroyo','jose@ulatech.com', 1, 507418538);
INSERT INTO EMPLEADOS VALUES (924913426, 'Isabel', 'Gutierrez', 'Alfaro','isabel@ulatech.com', 3, 252331663);

--Cliente: Cedula, Nombre, Apellido1, Apellido2, Telefono (10), Correo_E, Direccion
INSERT INTO Cliente VALUES(678901234, 'Luis', 'Morillo', 'Castro', 67590321,'luis@gmail.com', 'Calle Las Rosas');
INSERT INTO cliente VALUES(743218956, 'Ana', 'Garcia', 'Lopez', 85421890,'ana@gmail.com', 'Avenida 456');
INSERT INTO cliente VALUES(212356789, 'Pedro', 'Rojas', 'Sanchez', 82335678, 'pedro@yahoo.com', 'Calle 789');
INSERT INTO cliente VALUES(697804321, 'Luisa', 'Martinez', 'Gomez', 60080743, 'luisa@outlook.com', 'Plaza 123');
INSERT INTO cliente VALUES(367509214, 'Laura', 'Fernandez', 'Vargas', 66751209, 'laura@hotmail.com', 'Carrera 987');
INSERT INTO cliente VALUES(731254867, 'Daniel', 'Lopez', 'Gonzalez', 83125648, 'daniel@gmail.com', 'Callejon 654');
INSERT INTO Cliente VALUES(821076534, 'Juan', 'Pérez', 'Gómez', 724568901,'juan@gmail.com', 'Avenida Central');
INSERT INTO cliente VALUES(684527913, 'María', 'Rodríguez', 'Fernández', 658240937, 'maria@hotmail.com', 'Calle 123');
INSERT INTO cliente VALUES(481695723, 'Andrés', 'Martínez', 'González', 753089461, 'andres@yahoo.com', 'Calle Principal');
INSERT INTO cliente VALUES(513890246, 'Sofía', 'López', 'Sánchez', 863092471, 'sofia@yahoo.com', 'Avenida del Sol');
INSERT INTO cliente VALUES(587629134, 'Diego', 'García', 'Pérez', 813476592,'diego@gmail.com', 'Calle Los Pinos');
INSERT INTO cliente VALUES(658721903, 'Laura', 'Hernández', 'Vargas', 826753104, 'laura@yahoo.com', 'Avenida Luna');
INSERT INTO Cliente VALUES(276398145, 'Ana', 'Fernández', 'Gómez', 687914302,'ana@gmail.com', 'Calle Flores');
INSERT INTO cliente VALUES(374912568, 'Carlos', 'Sánchez', 'López', 789124356, 'carlos@hotmail.com', 'Calle Almendro');
INSERT INTO cliente VALUES(279815306, 'Luisa', 'Ramírez', 'Mora', 674512890,'luisa@gmail.com', 'Calle El Bosque');
INSERT INTO cliente VALUES(736405821, 'David', 'Gómez', 'Jiménez', 742903815, 'david@gmail.com', 'Avenida del Mar');
INSERT INTO cliente VALUES(412835679, 'Isabel', 'Pérez', 'Castro', 635890214, 'isabel@yahoo.com', 'Calle El Sueño');
INSERT INTO cliente VALUES(753109482, 'Jorge', 'Martínez', 'Soto', 714298635, 'jorge@hotmail.com', 'Calle Esperanza');
INSERT INTO Cliente VALUES(518937260, 'Mónica', 'Fernández', 'Alvarado', 812356479, 'monica@gmail.com', 'Calle Palmas');
INSERT INTO cliente VALUES(634187529, 'Pedro', 'Gutiérrez', 'Solís', 751928346, 'pedro@yahoo.com', 'Calle Cerezos');
INSERT INTO cliente VALUES(126384795, 'Carmen', 'Hernández', 'Mora', 726304159, 'carmen@outlook.com', 'Calle Montaña');
INSERT INTO Cliente VALUES(578902345, 'Andrea', 'Gutierrez', 'Alvarez', 67590322, 'andrea@yahoo.com', 'Avenida 234');
INSERT INTO Cliente VALUES(478903456, 'Carlos', 'Valencia', 'Bravo', 67590323, 'carlos@gmail.com', 'Calle 121');
INSERT INTO Cliente VALUES(378904567, 'Daniela', 'Soto', 'Crespo', 67590324,'daniela@outlook.com', 'Plaza 119');
INSERT INTO Cliente VALUES(278905678, 'Ricardo', 'Ortega', 'Duarte', 67590325, 'ricardo@gmail.com', 'Boulevard 405');
INSERT INTO Cliente VALUES(178906789, 'Mariana', 'Perez', 'Estrada', 67590326, 'mariana@gmail.com', 'Callejón 87');

--Marca: Id, Nombre
INSERT INTO Marca VALUES (1, 'Kingstone');
INSERT INTO marca VALUES (2, 'Lenovo');
INSERT INTO marca VALUES (3, 'Microsoft');
INSERT INTO marca VALUES (4, 'HP');
INSERT INTO marca VALUES (5, 'Dell');
INSERT INTO marca VALUES (6, 'Logitec');
INSERT INTO Marca VALUES (7, 'ASUS');
INSERT INTO Marca VALUES (8, 'Acer');
INSERT INTO Marca VALUES (9, 'Corsair');
INSERT INTO Marca VALUES (10, 'Razer');
INSERT INTO Marca VALUES (11, 'Western Digital');
 
--Proveedor Cedula, Nombre, Apellido1, Apellido2, Telefono, Correo_E, Direccion ,Gerentes_cedula --> Pueden poner apellidos, si es una "persona". El campo Gerente_cedula tiene que existir en la tabla de "Gerentes";
INSERT INTO Proveedor VALUES(678914320, 'Gash', null, null, 81234567, 'gash@gmail.com','La Uruca', 404394599);
INSERT INTO proveedor VALUES (764218530, 'Cargas Jimenez', null, null, 83219876, 'cargarjimenez@gmail.com', 'Calle San Martin', 507418538);
INSERT INTO proveedor VALUES (835372146, 'Yuba', null, null, 85432198, 'yuba@yahoo.com', 'Calle Vargas', 229055945);
INSERT INTO proveedor VALUES (698704312, 'Mayquer', null, null, 87654321, 'mayquer@hotmail.com', 'Calle Vieja', 252331663);
INSERT INTO proveedor VALUES (879512430, 'IRR Logistics', null, null, 82107654, 'irrlogistics@yahoo.com', 'Calle Victoria', 708919563);
INSERT INTO proveedor VALUES (741256809, 'Delgado S.A.', null, null, 89012345, 'delgado@outlook.com', 'Calle Castilla', 488213533);
INSERT INTO Proveedor VALUES(284753619, 'ElectroTech', null, null, 89023456, 'info@electrotech.com','Avenida Central', 404394599);
INSERT INTO Proveedor VALUES(635819472, 'Carlos', 'Mendez', 'Rojas', 89023457, 'carlos@mendeztech.com', 'Calle de Oro', 708919563);
INSERT INTO Proveedor VALUES(745812936, 'Lorena', 'Vargas', 'Solano', 89023458, 'lorena@vargastech.com', 'Calle Lluvia', 252331663);
INSERT INTO Proveedor VALUES(482679153, 'AutoParts', null, null, 89023459, 'contact@autoparts.com', 'Bulevar del Sur', 229055945);
INSERT INTO Proveedor VALUES(718263594, 'Diana', 'Fernandez', 'Castillo', 89023460, 'diana@ferntech.com', 'Calle del Mar', 229055945);

--Producto: Codigo, Descripcion, Cantidad, Precio, Proveedor_cedula, Marca_id -->El campo Proveedor_Cedula tiene que existir en la tabla de "Proveedor". El campo Marca_Id tiene que existir en la tabla de "Marca";
INSERT INTO Producto VALUES(1, 'A400 240GB', 20, 1200, 678914320, 1);
INSERT INTO producto VALUES (2, 'Estuche para Iphone 13 de Silicon', 5, 20.05, 835372146,2);
INSERT INTO producto VALUES (3, 'Teclado Hyperx Alloy Core RGB', 20, 60.75, 879512430,3);
INSERT INTO producto VALUES (4, 'UPS APC BVX900L-LM', 15, 50.00, 764218530, 4);
INSERT INTO producto VALUES (5, 'Mouse Orochi V2', 8, 45.80, 698704312, 5);
INSERT INTO producto VALUES (6, 'Cargador AON Wireless V-100', 12, 30.25, 741256809, 6);
INSERT INTO Producto VALUES (7, 'Teclado G915 TKL RGB', 18, 75.50, 764218530, 6);
INSERT INTO Producto VALUES (8, 'Redragon P012 Capricorn', 3, 15.30, 835372146, 3);
INSERT INTO Producto VALUES (9, 'Laptop hinkpad t480', 25, 200.00, 698704312, 2);
INSERT INTO Producto VALUES (10, 'Teclado G PRO', 10, 80.45, 698704312, 6);
INSERT INTO Producto VALUES (11, 'Cables APEVIA Audio-USB', 6, 12.75, 741256809, 5);
INSERT INTO Producto VALUES (12, 'Teclado Ratri K595 RGB', 14, 40.20, 764218530, 4);
INSERT INTO Producto VALUES (13, 'Seiren X - Microfono', 22, 90.00, 879512430, 1);
INSERT INTO Producto VALUES (14, 'Headset XPG PRECOG S', 7, 35.10, 879512430, 4);
INSERT INTO Producto VALUES (15, 'Fury S-L', 30, 150.50, 741256809, 2);
INSERT INTO Producto VALUES (16, 'Extensor Señal RE305 AC1200', 25, 35.50, 764218530,3);
INSERT INTO Producto VALUES (17, 'Enfriamiento 17 CO', 10, 15.25, 764218530, 4);
INSERT INTO Producto VALUES (18, 'Bombilla Inteligente pack', 18, 25.00, 741256809, 1);
INSERT INTO Producto VALUES (19, 'M.2 Adata SX8100 1TB', 12, 50.75, 698704312, 1);
INSERT INTO Producto VALUES (20, 'XPGS40G 1TB RGB', 7, 80.20, 879512430, 5);
INSERT INTO Producto VALUES (21, 'Router Tri-Band Archer AX75', 15, 95.00, 764218530,4);
INSERT INTO Producto VALUES (22, 'MicroSD Purple – 256gb', 22, 40.50, 698704312, 4);
INSERT INTO Producto VALUES (23, 'WifiAC1200 Whole Home Mesh', 9, 70.30, 764218530,2);
INSERT INTO Producto VALUES (24, 'Producto 24', 14, 55.60, 764218530, 6);
INSERT INTO Producto VALUES (25, 'Chromecast (3ª generación)', 6, 25.80, 764218530, 2);
INSERT INTO Producto VALUES (26, 'Parlante Cyclone Portable Rojo', 11, 10.75, 879512430,2);
INSERT INTO Producto VALUES (27, 'Lentes VR Oculus', 28, 100.00, 698704312, 6);
INSERT INTO Producto VALUES (28, 'Fuente de Poder C650 Bronze', 13, 45.00, 698704312,2);
INSERT INTO Producto VALUES (29, 'Memoria RAM Laptop 32 GB', 20, 60.35, 764218530, 2);
INSERT INTO Producto VALUES (30, 'M.2 Adata SX8100 256GB', 8, 35.70, 835372146, 3);
INSERT INTO Producto VALUES(31, 'Laptop ASUS ROG Strix G15', 10, 1500.50, 879512430, 4);
INSERT INTO Producto VALUES(32, 'Audífonos Sony WH-1000XM4', 25, 299.99, 764218530, 2);
INSERT INTO Producto VALUES(33, 'Monitor LG UltraGear 27"', 15, 480.75, 698704312, 3);
INSERT INTO Producto VALUES(34, 'Webcam Logitech C920 HD Pro', 30, 89.90, 879512430, 1);
INSERT INTO Producto VALUES(35, 'SSD Evo 1TB', 22, 210.65, 698704312, 6);
 
--Venta: Id_cmp, Fecha, Empleados_cedula, Cliente_cedula. -->El campo Empleados_Cedula tiene que existir en la tabla de "Empleados". El campo Cliente_Cedula tiene que existir en la tabla de "Clientes";
INSERT INTO Venta VALUES(1, TO_DATE('2023/04/28', 'YYYY/MM/DD'), 424563971, 678901234);
INSERT INTO venta VALUES (2, TO_DATE('2023/08/05', 'YYYY/MM/DD'), 309487216, 212356789);
INSERT INTO venta VALUES (3, TO_DATE('2023/02/14', 'YYYY/MM/DD'), 458621703, 367509214);
INSERT INTO venta VALUES (4, TO_DATE('2023/03/18', 'YYYY/MM/DD'), 615892347, 743218956);
INSERT INTO venta VALUES (5, TO_DATE('2023/04/14', 'YYYY/MM/DD'), 732109584, 697804321);
INSERT INTO venta VALUES (6, TO_DATE('2023/02/16', 'YYYY/MM/DD'), 296837450, 731254867);
INSERT INTO Venta VALUES (7, TO_DATE('2023/05/10', 'YYYY/MM/DD'), 426780139, 212356789);
INSERT INTO Venta VALUES (8, TO_DATE('2023/06/21', 'YYYY/MM/DD'), 424563971, 678901234);
INSERT INTO Venta VALUES (9, TO_DATE('2023/07/03', 'YYYY/MM/DD'), 296837450, 279815306);
INSERT INTO Venta VALUES (10, TO_DATE('2022/08/12', 'YYYY/MM/DD'), 725809314, 821076534);
INSERT INTO Venta VALUES (11, TO_DATE('2022/09/28', 'YYYY/MM/DD'), 309487216, 412835679);
INSERT INTO Venta VALUES (12, TO_DATE('2022/10/15', 'YYYY/MM/DD'), 712345678, 743218956);
INSERT INTO Venta VALUES (13, TO_DATE('2022/11/08', 'YYYY/MM/DD'), 187654320, 587629134);
INSERT INTO Venta VALUES (14, TO_DATE('2023/1/02', 'YYYY/MM/DD'), 465890123, 412835679);
INSERT INTO Venta VALUES (15, TO_DATE('2023/01/23', 'YYYY/MM/DD'), 321456789, 753109482);
INSERT INTO Venta VALUES (16, TO_DATE('2023/03/09', 'YYYY/MM/DD'), 296837450, 736405821);
INSERT INTO Venta VALUES (17, TO_DATE('2023/04/17', 'YYYY/MM/DD'), 658901247, 697804321);
INSERT INTO Venta VALUES (18, TO_DATE('2023/06/05', 'YYYY/MM/DD'), 732109584, 276398145);
INSERT INTO Venta VALUES (19, TO_DATE('2023/07/29', 'YYYY/MM/DD'), 615892347, 684527913);
INSERT INTO Venta VALUES (20, TO_DATE('2022/09/14', 'YYYY/MM/DD'), 873210945, 367509214);
INSERT INTO Venta VALUES (21, TO_DATE('2022/11/01', 'YYYY/MM/DD'), 634567890, 731254867);
INSERT INTO venta VALUES (22, TO_DATE('2023/01/05', 'YYYY/MM/DD'), 321456789, 587629134);
INSERT INTO venta VALUES (23, TO_DATE('2023/06/15', 'YYYY/MM/DD'), 321456789, 736405821);
INSERT INTO venta VALUES (24, TO_DATE('2022/09/09', 'YYYY/MM/DD'), 615892347, 367509214);
INSERT INTO venta VALUES (25, TO_DATE('2023/05/21', 'YYYY/MM/DD'), 634567890, 587629134);
INSERT INTO venta VALUES (26, TO_DATE('2023/07/12', 'YYYY/MM/DD'), 296837450, 697804321);

--Producto_Venta: Producto_codigo, Venta_id_cmp -->El campo Producto_codigo tiene que existir en la tabla de "Productos". El campo Venta_id_cmp tiene que existir en la tabla de "Venta";
INSERT INTO Producto_Venta VALUES(1, 1);
INSERT INTO producto_venta VALUES (2, 6);
INSERT INTO producto_venta VALUES (5, 3);
INSERT INTO producto_venta VALUES (4, 1);
INSERT INTO producto_venta VALUES (6, 2);
INSERT INTO producto_venta VALUES (3, 5);
INSERT INTO producto_venta VALUES (1,3);
INSERT INTO producto_venta VALUES (7, 20);
INSERT INTO producto_venta VALUES (10, 8);
INSERT INTO producto_venta VALUES (22, 3);
INSERT INTO producto_venta VALUES (23, 2);
INSERT INTO producto_venta VALUES (21, 26);
---QUERYs
/*

1.	Obtenga una consulta donde se refleje la compra de los productos. En la proyección se debe mostrar el nombre del cliente,
 
la descripcion del producto, la fecha de compra, y el nombre del empleado. Al nombre del cliente etiquetelo 'Cliente', a la descripción
etiquetelo 'Producto' y al nombre de empleado etiquetelo 'Empleado'.
Esto va a ayudar al negocio a tener control sobre la información de las ventas y clientes.

*/
SELECT c.nombre AS Cliente, p.descripcion AS Producto, v.fecha, e.nombre AS Empleado FROM venta v
JOIN cliente c

ON c.cedula = v.cliente_cedula JOIN empleados e
ON e.cedula = v.empleados_cedula JOIN producto_venta pv
ON v.id_cmp = pv.venta_id_cmp JOIN producto p
ON p.codigo = pv.producto_codigo;
/*
 
2.	Obtenga una consulta de los negocios elaborados por cualquier de los gerentes. Esta se debe imprimir de la siguente manera:
[Nombre gerente] negocio con el proveedor de nombre [nombre proveedor] por el producto [descripcion producto]
Etiquete esta consulta como 'Informacion_negociacion'
Esto va a permitir al negocio a saber la relación existente entre gerentes y proveedores y sus negociaciones.
*/

SELECT g.nombre, concat(' negocio con el proveedor de nombre ', concat(p.nombre,concat(' por el producto ',pr.descripcion))) AS Informacion_negociacion
FROM gerentes g
JOIN proveedor p ON p.gerentes_cedula = g.cedula JOIN producto pr ON pr.proveedor_cedula = p.cedula WHERE g.cedula = 252331663;

/*
 
3.	Obtenga una consulta de los productos con descuento. Esta debe imprimir la descripcion de los productos y el descuento de 5% que se amplica solo
para productos Lenovo. Esta etiquetelo 'Descuento'.
Esto va ayuda a tener una vista o una lista de inventario de los productos que tienen descuento. En esta caso, son los elementos de marca Lenovo.
*/
SELECT p. descripcion, CASE p.marca_id
WHEN 2 THEN p.precio - (p.precio*0.05) ELSE 0 END Descuento
FROM producto p WHERE p.marca_id = 2 ORDER BY Descuento;

/*

4.	Obtengan una lista que muestre la descripción, precio y cantidad de productos de la empresa.
 
Calcula la ganancia esperada para cada producto si se venden por completo. Luego, ordene los resultados en orden descendente según la cantidad.
Esto proporcionará los detalles de los 5 productos con la mayor cantidad y la correspondiente ganancia esperada para cada uno,
dándole una proyección futura a la organización de sus ingresos.

*/

SELECT descripcion AS Producto, precio AS Precio_del_producto, cantidad AS Cantidad_de_producto,
(precio * cantidad) AS Ganancia_Esperada FROM producto p
WHERE p.marca_id = 4 ORDER BY cantidad DESC;

/*

5.	Obtenga una proyección que recopile la información sobre los empleados que únicamente hayan realizado alguna venta y sus ventas totales.
Debe mostrar la cédula, el nombre y el primer apellido de cada empleado que haya realizado alguna venta,
 
junto con el número total de ventas hechas por cada uno de ellos. La columna de cédula debe etiquetarse como "cédula_del_empleado",
la columna de nombre debe nombrarse como "nombre_del_empleado" y por último la columna de primer apellido debe etiquetarse como
"primer_apellido_del_empleado" y el resultado del total de ventas por empleado debe llamarse "ventas_realizadas". Los resultados se agrupan por la cédula,
el nombre y el primer apellido del empleado, y se ordenan en orden descendente según el total de ventas hechas por los empleados.

Esto proporcionará los detalles del rendimiento de las ventas de los empleado y además medir de manera tangible la cantidad de ventas realizadas por cada uno de ellos.

*/

SELECT e.cedula AS cedula_del_empleado, e.nombre AS nombre_del_empleado, e.apellido1 AS primer_apellido_del_empleado,
COUNT(v.id_cmp) AS ventas_realizadas FROM empleados e
JOIN venta v ON e.cedula = v.empleados_cedula GROUP BY e.cedula, e.nombre, e.apellido1 ORDER BY COUNT(v.id_cmp) DESC;
 
--PL/SQL

/*

1.	Realice una función que obtenga la información sobre un empleado en específico y

los productos que ha vendido. La función debe solicitar el número de cédula del empleado que se desea consultar.
Posteriormente la función debe recopilar los nombres de los productos que el empleado ha vendido y mostrarlos junto con el nombre del empleado.

Esta función proporciona un control de las ventas al empleado al demostrar el empleado que ejecuto la venta y los productos que vendio.
*/

SET SERVEROUTPUT ON DECLARE
CURSOR CedulaEmpleado (cedEmpleado NUMBER) IS SELECT e.nombre Empleado, p.descripcion Producto FROM empleados e
JOIN venta v ON e.cedula = v.empleados_cedula
JOIN producto_venta pv ON v.id_cmp = pv.venta_id_cmp JOIN producto p ON pv.producto_codigo = p.codigo WHERE e.cedula = cedEmpleado;
cedula NUMBER := &empleadocedula; BEGIN
FOR prueba IN CedulaEmpleado(cedula) LOOP
DBMS_OUTPUT.PUT_LINE('Empleado: ' || prueba.Empleado || ' Productos vendidos: ' || prueba.Producto);
END LOOP; EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('No se encontraron registros para el empleado con cédula ' || cedula);
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Ocurrió un error: ' || SQLERRM); END;
/

/*
 
2.	Realice una función que ingrese un nuevo puesto en su tabla correspondiente.
La función debe solicitar el codigo del puesto y el nombre del puesto para ser añadido a la tabla de Puesto.
Esta función proporciona al administrador una manera de ingresar un nuevo puesto.

*/

SET SERVEROUTPUT ON; DECLARE
codigo_puesto NUMBER(15); nombre_puesto VARCHAR2(30); contador NUMBER;
BEGIN
codigo_puesto := &Codigo_Puesto;
SELECT COUNT(*) INTO contador FROM PUESTO WHERE codigo = codigo_puesto; --
Contador para revisar si el codigo del puesto ya existe if (contador > 0)
THEN DBMS_OUTPUT.PUT_LINE('El codigo ' || codigo_puesto || ' ya existe en la tabla'); else
nombre_puesto := '&Nombre_Puesto';
INSERT INTO PUESTO(codigo, nombre) VALUES(codigo_puesto, nombre_puesto); end if;
COMMIT; EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Ocurrió un error: ' || SQLERRM); END;
/

/*

3.	Realice una función que ingrese un nuevo cliente en su tabla correspondiente.
La función debe solicitar la cedula, el nombre, el primer apellido, el segundo apellido, el teléfono, el correo, y la dirección para poder ser añadido a la tabla de Cliente.
Esta función proporciona al administrador una manera de ingresar un nuevo cliente.

*/

SET SERVEROUTPUT ON; DECLARE
cedula_cliente NUMBER := &cedula;
nombre_cliente VARCHAR2(30); apellido1_cliente VARCHAR2(30); apellido2_cliente VARCHAR2(30); telefono_cliente NUMBER(20); correo_cliente	VARCHAR2(35); direccion_cliente VARCHAR2(100); contador_cedulas NUMBER;
BEGIN
SELECT COUNT(*) INTO contador_cedulas FROM Cliente C WHERE C.Cedula = cedula_cliente;
if(contador_cedulas > 0)
Then DBMS_OUTPUT.PUT_LINE('El cliente con cedula ' || cedula_cliente || ' ya esta registrado en el sistema');
else
nombre_cliente := '&nombre'; apellido1_cliente := '&apellido1'; apellido2_cliente := '&apellido2'; telefono_cliente := &telefono; correo_cliente := '&correo';
direccion_cliente := '&direccion';
INSERT INTO cliente(cedula, nombre, apellido1, apellido2, telefono, Correo_E, direccion) VALUES (cedula_cliente, nombre_cliente, apellido1_cliente, apellido2_cliente,
telefono_cliente, correo_cliente, direccion_cliente);
end if; COMMIT;
EXCEPTION
WHEN OTHERS THEN ROLLBACK;
DBMS_OUTPUT.PUT_LINE('Error al insertar cliente: ' || SQLERRM); END;
/

/*

4.	Realice una función que ingrese un nuevo empleado en su tabla correspondiente.
La función debe solicitar la cedula, el nombre, el primer apellido, el segundo apellido, el correo, el puesto y el gerente para poder ser añadido a la tabla de Empleado.
Esta función proporciona al administrador una manera de ingresar un nuevo empleado.

*/
CREATE OR REPLACE PROCEDURE Insertar_Empleados( cedula_empleado IN NUMBER,
nombre_empleado IN VARCHAR2, apellido_empleado IN VARCHAR2, apellido2_empleado IN VARCHAR2, correo_empleado IN VARCHAR2, puesto_empleado IN NUMBER, gerente_empleado IN NUMBER
) AS
contador_empleado NUMBER; --> Variable de chequeo BEGIN
SELECT COUNT(*) INTO contador_empleado FROM Empleados E WHERE E.cedula = cedula_empleado;
if(contador_empleado > 0)
Then DBMS_OUTPUT.PUT_LINE('El empleado con cedula ' || cedula_empleado || ' ya esta registrado en el sistema');

else
INSERT INTO Empleados Values(cedula_empleado, nombre_empleado, apellido_empleado, apellido2_empleado,
correo_empleado, puesto_empleado, gerente_empleado);
END IF; EXCEPTION

WHEN OTHERS THEN ROLLBACK;
DBMS_OUTPUT.PUT_LINE('Error al insertar cliente: ' || SQLERRM); END Insertar_Empleados;
/

Execute Insertar_Empleados(&Cedula, '&Nombre', '&Apellido', '&Apellido', '&Correo', &Puesto, &Gerente);

/*

5.	Realice una función que ingrese un nuevo producto en su tabla correspondiente.
La función debe solicitar el codigo, el descripcion, la cantidad, el precio, el proveedor y la marca para poder ser añadido a la tabla de Producto.
Esta función proporciona al administrador una manera de ingresar un nuevo producto.

*/
CREATE OR REPLACE PROCEDURE Insertar_Productos( codigo_producto IN NUMBER,
descripcion_producto IN VARCHAR2, cantidad_producto IN NUMBER, precio_producto IN NUMBER, proveedor_cedula IN NUMBER, marca IN NUMBER
) AS
contador_productos NUMBER; BEGIN
SELECT COUNT(*)INTO contador_productos FROM Producto P WHERE P.Codigo = codigo_producto;
if(contador_productos > 0)
THEN DBMS_OUTPUT.PUT_LINE('El producto con el codigo ' || codigo_producto || ' ya esta registrado en el sistema');

else
INSERT INTO Producto Values(codigo_producto, descripcion_producto, cantidad_producto, precio_producto, proveedor_cedula,
marca); END IF;
EXCEPTION

WHEN OTHERS THEN ROLLBACK;
DBMS_OUTPUT.PUT_LINE('Error al insertar cliente: ' || SQLERRM); END Insertar_Productos;
/

--SELECT
SELECT CODIGO, NOMBRE FROM Puesto;
SELECT * FROM Cliente; SELECT * FROM Proveedor; SELECT * FROM Marca;
SELECT * FROM Empleados; SELECT * FROM Gerentes;
SELECT * FROM Venta;
SELECT * FROM Producto_Venta; SELECT * FROM Producto;


/*Cliente_Cedula
 
678901234

743218956

212356789

697804321

367509214

731254867

821076534

684527913

481695723

513890246

587629134

658721903

276398145

374912568

279815306

736405821

412835679

753109482

518937260

126384795
 
*/

/* Empleado_Cedula 424563971
615892347

309487216

732109584

458621703

296837450

712345678

321456789

658901247

873210945

187654320

346789012

725809314

465890123

765432198

278039514

426780139
 
281934567

518270394

349812765

634182759

634567890

*/