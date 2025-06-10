
CREATE TABLE user_role  -- Se crea la tabla
( 
 id_role INT AUTO_INCREMENT NOT NULL, -- Definición de la columna id_role como clave primaria autoincremental
 role_description VARCHAR(200) NOT NULL,  -- Descripción del rol con un límite de 500 caracteres
 
 CONSTRAINT PK_user_role PRIMARY KEY (id_role) -- Se define la clave primaria de la tabla
); 

CREATE TABLE users -- Se crea la tabla para almacenar los datos de los usuarios
( 
 id INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
 id_user VARCHAR(150) UNIQUE NOT NULL, -- Columna id_user como clave primaria (identificador único)
 user_name VARCHAR(200) NOT NULL,  -- Nombre del usuario
 user_phone VARCHAR(100) NOT NULL, -- Teléfono del usuario
 user_email VARCHAR(250) NOT NULL, -- Correo electrónico del usuario
 user_password VARCHAR(250) NOT NULL, -- Contraseña del usuario
 membership_date DATE NOT NULL, -- Fecha de membresia
 id_role INT NOT NULL -- Relación con el id_role para determinar el rol del usuario
); 

-- Foreign Keys
ALTER TABLE users 
ADD CONSTRAINT FK_user_role_users_id_role FOREIGN KEY (id_role) REFERENCES user_role(id_role);
-- Crea una clave foránea entre 'users' y 'user_role' utilizando 'id_role'.

CREATE TABLE extra_services -- Se crea la tabla para almacenar los servicios adicionales
( 
 id_services INT AUTO_INCREMENT NOT NULL, -- Columna id_services como clave primaria (autoincremental)
 services_name VARCHAR(250) NOT NULL,  -- Nombre del servicio
 services_description VARCHAR(400) NOT NULL,  -- Descripción del servicio
 services_price INT NOT NULL, -- Precio del servicio
 
 CONSTRAINT PK_services PRIMARY KEY (id_services)  -- Definición de la clave primaria para la tabla
); 

CREATE TABLE room_services -- Se crea la tabla que vincula habitaciones con servicios
( 
 id_booking INT, -- ID de la habitación
 id_services INT, -- ID del servicio
 PRIMARY KEY (id_booking, id_services) -- Clave primaria compuesta por id_room y id_services
); 

CREATE TABLE room_type -- Se crea la tabla para los tipos de habitaciones
( 
 id_typeRoom INT AUTO_INCREMENT NOT NULL, -- ID único del tipo de habitación
 type_description VARCHAR(500) NOT NULL, -- Descripción del tipo de habitación
 guest_number INT NOT NULL,  -- Número de huéspedes permitidos
 
 CONSTRAINT PK_room_type PRIMARY KEY (id_typeRoom) -- Clave primaria en id_typeRoom
);


CREATE TABLE rooms -- Se crea la tabla para las habitaciones
(
 id_room INT AUTO_INCREMENT NOT NULL, -- ID único de la habitación
 room_name VARCHAR(250) NOT NULL, -- Nombre de la habitación
 room_description VARCHAR(500) NOT NULL, -- Descripción de la habitación
 room_price INT NOT NULL, -- Precio de la habitación
 id_roomType INT NOT NULL, -- Tipo de habitación (relacionado con room_type)
 room_image VARCHAR(500) NOT NULL, -- Ruta o nombre de la imagen de la habitación
 room_status BOOLEAN NOT NULL, -- Estado de la habitación (disponible/no disponible)
 
 CONSTRAINT PK_rooms PRIMARY KEY (id_room) -- Clave primaria en id_room
);

CREATE TABLE booking_status -- Se crea la tabla para el estado de las reservas
(
	id_status INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    status_description VARCHAR (250) NOT NULL
);

CREATE TABLE booking -- Se crea la tabla para las reservas
( 
 id_booking INT AUTO_INCREMENT NOT NULL, -- ID único de la reserva
 booking_date DATE NOT NULL,  -- Fecha de la reserva
 id_user VARCHAR(150) NOT NULL,  -- ID del usuario que realiza la reserva
 id_room INT NOT NULL, -- ID de la habitación reservada
 checkIn_date DATE NOT NULL, -- Fecha de entrada
 checkOut_date DATE NOT NULL, -- Fecha de salida
 guest INT NOT NULL,  -- Cantidad huéspedes
 id_status INT NOT NULL, -- Estado del Booking (False cancelado y True activo)
 
 CONSTRAINT PK_booking PRIMARY KEY (id_booking) -- Clave primaria en id_booking
);

CREATE TABLE receipt -- Se crea la tabla para los recibos
( 
 id_receipt INT AUTO_INCREMENT NOT NULL,  -- ID único del recibo
 id_booking INT NOT NULL, -- ID de la reserva asociada al recibo
 total INT NOT NULL,  -- Total del recibo
 
 CONSTRAINT PK_receipt PRIMARY KEY (id_receipt) -- Clave primaria en id_receipt
);

CREATE TABLE reviews -- Se crea la tabla para las reseñas
( 
 id_review INT AUTO_INCREMENT NOT NULL, -- ID único de la reseña
 review_body VARCHAR(500) NOT NULL, -- Cuerpo de la reseña
 review_date DATE NOT NULL, -- Fecha de la reseña
 califactions INT NOT NULL, -- Calificación otorgada
 id_user VARCHAR(150) NOT NULL,  -- ID del usuario que hace la reseña
 id_room INT NOT NULL, -- ID de la habitación asociada a la reseña
 
 CONSTRAINT PK_reviews PRIMARY KEY (id_review) -- Clave primaria en id_review
);



---------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE reviews 
ADD CONSTRAINT FK_users_reviews_id_user FOREIGN KEY (id_user) REFERENCES users(id_user);
-- Crea una clave foránea entre 'reviews' y 'users' utilizando 'id_user'.

---------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE booking 
ADD CONSTRAINT FK_users_booking_id_user FOREIGN KEY (id_user) REFERENCES users(id_user);
-- Crea una clave foránea entre 'booking' y 'users' utilizando 'id_user'.

---------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE reviews 
ADD CONSTRAINT FK_rooms_reviews_id_room FOREIGN KEY (id_room) REFERENCES rooms(id_room);
-- Crea una clave foránea entre 'reviews' y 'rooms' utilizando 'id_room'.

---------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE booking 
ADD CONSTRAINT FK_rooms_booking_id_room FOREIGN KEY (id_room) REFERENCES rooms(id_room);
-- Crea una clave foránea entre 'booking' y 'rooms' utilizando 'id_room'.
ALTER TABLE booking
ADD CONSTRAINT fk_booking_status FOREIGN KEY (id_status) REFERENCES booking_status(id_status);
-- Crea una clave foránea entre 'booking' y 'status_booking' utilizando 'id_status'.

---------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE receipt 
ADD CONSTRAINT FK_booking_receipt_id_booking FOREIGN KEY (id_booking) REFERENCES booking(id_booking);
-- Crea una clave foránea entre 'receipt' y 'booking' utilizando 'id_booking'.

---------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE rooms 
ADD CONSTRAINT FK_room_type_rooms_id_typeRoom FOREIGN KEY (id_roomType) REFERENCES room_type(id_typeRoom);
-- Crea una clave foránea entre 'rooms' y 'room_type' utilizando 'id_roomType'.

---------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE room_services 
ADD CONSTRAINT FK_extra_services_room_services_id_services FOREIGN KEY (id_services) REFERENCES extra_services(id_services);
-- Crea una clave foránea entre 'room_services' y 'extra_services' utilizando 'id_services'.

---------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE room_services 
ADD CONSTRAINT FK_room_services_id_booking FOREIGN KEY (id_booking ) REFERENCES booking(id_booking );
-- Crea una clave foránea entre 'room_services' y 'rooms' utilizando 'id_room'.


-- Selects
SELECT * FROM user_role;
SELECT * FROM booking_status;
SELECT * FROM booking;
SELECT * FROM receipt;
SELECT * FROM reviews;
SELECT * FROM room_type;
SELECT * FROM room_services;
SELECT * FROM rooms;
SELECT * FROM users;
SELECT * FROM extra_services;

SELECT * FROM receipt ORDER BY id_receipt DESC LIMIT 1;

-- Select Join
-- Room Services
SELECT 
    S.services_price,
    S.services_name
FROM booking B
JOIN room_services RS ON B.id_booking = RS.id_booking
JOIN extra_services S ON RS.id_services = S.id_services
WHERE B.id_booking = 4;

-- Booking By User
SELECT 
B.booking_date AS Fecha_Reserva,
B.checkIn_date AS CheckIn,
B.checkOut_date AS CheckOut,
-- ES.services_name AS Services,
R.room_name AS Room
FROM booking B 
JOIN rooms R ON B.id_room = R.id_room
JOIN room_services RS ON B.id_room = RS.id_room
-- JOIN extra_services ES ON RS.id_services = ES.id_services
WHERE id_user = '186201148610';

-- Receipt
SELECT 
    R.id_receipt,
    B.booking_date,
    B.checkIn_date,
    B.checkOut_date,
    B.id_booking,
    RO.room_price,
    RO.room_name,
    RT.type_description,
    COALESCE(SUM(ES.services_price),0) AS Extra_Services, 
    (RO.room_price + SUM(ES.services_price)) AS Total_services,
    R.total,
    U.user_name
FROM receipt R
LEFT JOIN booking B ON R.id_booking = B.id_booking 
LEFT JOIN users U ON B.id_user = U.id_user
LEFT JOIN rooms RO ON B.id_room = RO.id_room
LEFT JOIN room_services RS ON B.id_booking = RS.id_booking
LEFT JOIN room_type RT ON RO.id_roomType = RT.id_typeRoom
LEFT JOIN extra_services ES ON RS.id_services = ES.id_services
WHERE B.id_user = '186201148610' AND R.id_booking = 8
GROUP BY R.id_receipt, B.id_booking, B.booking_date, B.checkIn_date, B.checkOut_date, RO.room_price, U.user_name;

-- Room Description
SELECT 
R.id_Room,
R.room_name,
RT.type_description,
R.room_description,
R.room_image,
R.room_price
FROM rooms R
JOIN room_type RT ON R.id_roomType = RT.id_typeRoom;

-- CheckIn y Check Out Dates
SELECT 
    R.id_Room, 
    R.room_name, 
    RT.type_description, 
    R.id_roomType, 
    R.room_description, 
    R.room_image, 
    R.room_price, 
    RT.guest_number, 
    GROUP_CONCAT(DISTINCT B.checkIn_date ORDER BY B.checkIn_date) AS checkIn_dates,
    GROUP_CONCAT(DISTINCT B.checkOut_date ORDER BY B.checkOut_date) AS checkOut_dates
FROM rooms R
JOIN room_type RT ON R.id_roomType = RT.id_typeRoom
JOIN booking B ON R.id_room = B.id_room
WHERE R.id_room = 1
GROUP BY 
    R.id_Room, 
    R.room_name, 
    RT.type_description, 
    R.id_roomType, 
    R.room_description, 
    R.room_image, 
    R.room_price, 
    RT.guest_number;

-- Users By email
SELECT U.id_user, U.user_name, U.user_email, U.user_password FROM users U WHERE U.user_email= "carlos@gmail.com";

UPDATE booking SET id_room = 1 WHERE id_booking = 8;
UPDATE booking SET checkIn_date = '2025-03-30' WHERE id_booking = 4;
UPDATE users SET id_role = "1" WHERE id_user = '186201148610';
UPDATE rooms SET room_status = 0 WHERE id_room = 1;
UPDATE rooms SET room_price= 120, room_status= 1 WHERE id_Room = 1;
UPDATE users SET user_email = 'pedro@gmail.com' WHERE id_user = '111111111111';

DELETE FROM receipt WHERE id_receipt = 7;
DELETE FROM room_services WHERE id_booking = 7;
DELETE FROM booking WHERE id_booking = 7;

SELECT 
	B.id_booking,
    B.booking_date, 
    B.checkIn_date, 
    B.checkOut_date, 
    B.guest, 
    U.user_name, 
    R.room_name, 
    BS.status_description, 
    GROUP_CONCAT(ES.services_name) AS services_name,
    RT.total,
    SUM(ES.services_price) AS total_services,     
    RT.total + SUM(ES.services_price) AS total_reserva    
FROM booking B
JOIN 
receipt RT ON B.id_booking = RT.id_booking
LEFT JOIN rooms R ON B.id_room = R.id_Room
LEFT JOIN users U ON B.id_user = U.id_user
LEFT JOIN booking_status BS ON B.id_status = BS.id_status
LEFT JOIN room_services RS ON B.id_booking = RS.id_booking
LEFT JOIN extra_services ES ON RS.id_services = ES.id_services
GROUP BY 
    B.id_booking, B.booking_date, B.checkIn_date, B.checkOut_date, B.guest, 
    U.user_name, R.room_name, BS.status_description, RT.total;


DROP TABLE reviews;
DROP TABLE receipt;
DROP TABLE room_services;
DROP TABLE booking;
DROP TABLE booking_status;
DROP TABLE users;
DROP TABLE user_role;
DROP TABLE extra_services;
DROP TABLE rooms;
DROP TABLE room_type;

