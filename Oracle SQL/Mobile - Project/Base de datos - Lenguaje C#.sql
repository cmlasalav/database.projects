--CREATE TABLE PARA SQL DEVELOPER
--1. Tabla de Estado Usuario

CREATE TABLE Estado_Usuarios (
	Id_Estado NUMBER NOT NULL,
	Descripcion_Estado VARCHAR(99) NOT NULL,
    CONSTRAINT Estado_UsuariosPK PRIMARY KEY (Id_Estado)
    );

--2. Tabla de la Prioridad de eventos

CREATE TABLE Prioridad_Eventos(
	Id_Prioridad NUMBER (1) NOT NULL,
	Descripcion_Prioridad VARCHAR(99) NOT NULL,
	CONSTRAINT PrioridadPK PRIMARY KEY (Id_Prioridad)
    );

--3. Tabla de Usuarios

CREATE TABLE Usuarios(
	Id_Usuario NUMBER(3,0) NOT NULL,
	Nombre_Usuario VARCHAR(30) NOT NULL,
	Apellido_Usuario VARCHAR(30) NOT NULL, 
	Usuario VARCHAR (20) NOT NULL,
	Password_Usuario VARCHAR (25) NOT NULL, 
	Palabra_Emergencia VARCHAR(20) NOT NULL,
	Id_Estado NUMBER(1) NOT NULL,
	CONSTRAINT UsuarioPK PRIMARY KEY (Id_Usuario),
	FOREIGN KEY (Id_Estado) REFERENCES Estado_Usuarios (Id_Estado)
);

--4. Tabla de Eventos

CREATE TABLE Eventos(
	Id_Evento NUMBER(3,0) NOT NULL,
	Id_Usuario NUMBER(3,0) NOT NULL,
	Nombre_Evento VARCHAR(40) NOT NULL,
	Descripcion_Evento VARCHAR2(99), --Este campo es Nulleable. 
	Id_Prioridad NUMBER(1) NOT NULL,
	Fecha_Evento DATE NOT NULL,
	Hora_Inicial VARCHAR(20) NULL,
	Hora_Final VARCHAR(20) NOT NULL,
	CONSTRAINT EventoPK PRIMARY KEY (Id_Evento),
	FOREIGN KEY (Id_Usuario) REFERENCES Usuarios (Id_Usuario),
	FOREIGN KEY (Id_Prioridad) REFERENCES Prioridad_Eventos (Id_Prioridad)
);

--INSERTS
--Estado_Usuario
INSERT INTO Estado_Usuarios VALUES(
	1, 'Activo'
);

INSERT INTO Estado_Usuarios VALUES(
	2, 'Inactivo'
);

--Prioridad_Evento
INSERT INTO Prioridad_Eventos VALUES(
	1, 'Alta'
);

INSERT INTO Prioridad_Eventos VALUES(
	2, 'Media'
);

INSERT INTO Prioridad_Eventos VALUES(
	3, 'Baja'
);

--Usuarios
INSERT INTO Usuarios VALUES(
	0, 'Admin', 'Admin', 'admin123', 'Cosas123', 'Admin', 1
);
INSERT INTO Usuarios VALUES(
	1, 'Aisha', 'Gregory', 'AGregory123', 'Danza123/.', 'Danza', 1
);

INSERT INTO Usuarios VALUES(
	2, 'Caroline', 'Chaves', 'CChaves456.', 'Isaac123.', 'Dise�o', 2
);

INSERT INTO Usuarios VALUES(
	3, 'Ximena', 'Perez', 'XPerez789.', 'NoSe456.', 'Trabajo', 1
);

INSERT INTO Usuarios VALUES(
	4, 'Carlos', 'Lasala', 'CLasala011.', 'Fuvol2208.', 'Bellacoso', 1
);

--Eventos (CAMBIAR EL FORMATO DE LA FECHA A ORACLE SQL: 1. dd/mm/yyy � 2. 'mm/dd/yyy)
INSERT INTO Eventos VALUES(
	1, 1, 'Presentacion', 'Presentacion en San Jose', 1, TO_DATE('12/11/2023', 'DD/MM/YYYY'), '14:00', '16:00'
);

INSERT INTO Eventos VALUES(
	2, 2, 'Almuerzo', 'Almuero en Multi', 2, TO_DATE('16/12/2023','DD/MM/YYYY'), '13:00', '15:00'
);

INSERT INTO Eventos VALUES(
	3, 3, 'Reunion', 'Reunion con el equipo', 1, TO_DATE('23/11/2023','DD/MM/YYYY'), '14:00', '15:30'
);

INSERT INTO Eventos VALUES(
	4, 4, 'Fuvol', 'Real Madrid', 3, TO_DATE('12/12/2023','DD/MM/YYYY'), '10:45', '12:30'
);

INSERT INTO Eventos VALUES(
	5, '4', 'Viaje', 'Vacaciones', 1, TO_DATE('23/12/2023','DD/MM/YYYY'), '06:30', '18:30'
);

--SELECTS CON JOINS
--1. Select para ver los eventos de cada usuario
SELECT
    U.Nombre_Usuario AS Nombre,
    E.Nombre_Evento AS Evento,
    E.Descripcion_Evento AS Descripcion,
    PE.Descripcion_Prioridad AS Prioridad,
    E.Fecha_Evento AS Fecha,
    E.Hora_Inicial AS Inicio,
    E.Hora_Final AS Final
FROM
    Usuarios U
JOIN
    Eventos E ON U.Id_Usuario = E.Id_Usuario
JOIN 
	Prioridad_Eventos PE ON PE.Id_Prioridad= E.Id_Prioridad
WHERE U.Id_Usuario = 4; --En el codigo se cambia el valor por un parametro


--2. Select para ver que usarios estan activos
SELECT
	U.Nombre_Usuario AS Nombre, 
	U.Apellido_Usuario AS Apellido, 
	EU.Descripcion_Estado AS Estado
FROM 
	Usuarios U
JOIN
	Estado_Usuarios EU ON U.Id_Estado = EU.Id_Estado
WHERE EU.Id_Estado = 1; --En el codigo se cambia el valor por un parametro

--3. Select para ver que usuarios estan inactivos
SELECT
	U.Nombre_Usuario AS Nombre, 
	U.Apellido_Usuario AS Apellido, 
	EU.Descripcion_Estado AS Estado
FROM 
	Usuarios U
JOIN
	Estado_Usuarios EU ON U.Id_Estado = EU.Id_Estado
WHERE EU.Id_Estado = 2; --En el codigo se cambia el valor por un parametro



--SELECTS INDIVIDUALES
SELECT * FROM Prioridad_Eventos;
SELECT * FROM Estado_Usuarios;
SELECT * FROM Usuarios;
SELECT * FROM Eventos;


--DROPS
DROP TABLE Usuarios;
DROP TABLE Estado_Usuarios;
DROP TABLE Eventos;
DROP TABLE Prioridad_Eventos;


