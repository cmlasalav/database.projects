-- Inserciones para user_role
INSERT INTO user_role (role_description) VALUES ('Administrador');
INSERT INTO user_role (role_description) VALUES ('Recepcionista');
INSERT INTO user_role (role_description) VALUES ('Huesped');

-- Inserciones para users 
INSERT INTO users (id_user, user_name, user_phone, user_email, user_password, membership_date, id_role) 
VALUES ('186201148610', 'Carlos Lasala Villegas', '70341035', 'carlos.miguel.lv@gmail.com', '$2b$10$LBylJ/bxU6FoP39lxBOf3ew2YxQ1itF8k7c6t.69aY5CtCgWb157S', '2025-03-27', 1);

-- Inserciones para extra_services
INSERT INTO extra_services (services_name, services_description, services_price) VALUES ('Desayuno', 'Desayuno continental incluido', 10);
INSERT INTO extra_services (services_name, services_description, services_price) VALUES ('Transporte', 'Traslado desde y hacia el aeropuerto', 25);
INSERT INTO extra_services (services_name, services_description, services_price) VALUES ('Spa', 'Sesion de relajacion en el spa', 40);
INSERT INTO extra_services (services_name, services_description, services_price) VALUES ('Alquiler de Bicicletas', 'Bicicletas disponibles para explorar la ciudad', 10);
INSERT INTO extra_services (services_name, services_description, services_price) VALUES ('Cama Adicional', 'Cama extra para huéspedes adicionales', 15);
INSERT INTO extra_services (services_name, services_description, services_price) VALUES ('Cuna para Bebés', 'Cuna cómoda para bebés', 5);
INSERT INTO extra_services (services_name, services_description, services_price) VALUES ('Clases de Yoga', 'Sesión privada de yoga con instructor certificado', 20);

-- Inserciones para room_type
INSERT INTO room_type (type_description, guest_number) VALUES ('Habitacion Sencilla', 1);
INSERT INTO room_type (type_description, guest_number) VALUES ('Habitacion Doble', 2);
INSERT INTO room_type (type_description, guest_number) VALUES ('Suite', 4);
INSERT INTO room_type (type_description, guest_number) VALUES ('Habitacion Familiar', 6);

-- Inserciones para rooms
INSERT INTO rooms (room_name, room_description, room_price, id_roomType, room_image, room_status) VALUES ('Oceano Azul', 'Habitación con vista al mar y decoración costera', 100, 1, 'https://surl.li/tboecq', 1);
INSERT INTO rooms (room_name, room_description, room_price, id_roomType, room_image, room_status) VALUES ('Brisa Marina', 'Habitación con balcón y vista panorámica', 150, 2, 'https://surl.li/wsftpv', 1);
INSERT INTO rooms (room_name, room_description, room_price, id_roomType, room_image, room_status) VALUES ('Suite Real', 'Suite de lujo con jacuzzi privado y sala de estar', 300, 3, 'https://surl.li/qcszmt', 1);
INSERT INTO rooms (room_name, room_description, room_price, id_roomType, room_image, room_status) VALUES ('Jardín Escondido', 'Habitación con terraza privada rodeada de naturaleza', 180, 2, 'https://surl.li/rmlubs', 1);
INSERT INTO rooms (room_name, room_description, room_price, id_roomType, room_image, room_status) VALUES ('Cielo Estrellado', 'Habitación con techo panorámico de cristal para ver las estrellas', 200, 2, 'https://surl.li/whjpbe', 1);
INSERT INTO rooms (room_name, room_description, room_price, id_roomType, room_image, room_status) VALUES ('Aurora Boreal', 'Habitación temática con iluminación inspirada en la aurora boreal', 220, 3, 'https://surl.li/ywscea', 1);
INSERT INTO rooms (room_name, room_description, room_price, id_roomType, room_image, room_status) VALUES ('Refugio Alpino', 'Cabaña de montaña con chimenea y vista a los Alpes', 250, 3, 'https://surl.li/idqsap', 1);
INSERT INTO rooms (room_name, room_description, room_price, id_roomType, room_image, room_status) VALUES ('Paraíso Tropical', 'Bungalow privado con acceso directo a la playa', 280, 3, 'https://surl.li/jqdiwz', 1);
INSERT INTO rooms (room_name, room_description, room_price, id_roomType, room_image, room_status) VALUES ('Santuario Zen', 'Habitación minimalista con tatamis y jardín japonés', 190, 2, 'https://surl.lu/cclvgi', 1);
INSERT INTO rooms (room_name, room_description, room_price, id_roomType, room_image, room_status) VALUES ('Oasis del Desierto', 'Habitación temática inspirada en un oasis, con decoración árabe y piscina privada', 260, 4, 'https://surl.li/fhjkvf', 1);

DELETE FROM rooms  WHERE id_room = 10;


-- Inserciones para Booking_ Status
INSERT INTO booking_status (status_description) VALUES ("Activa");
INSERT INTO booking_status (status_description) VALUES ("Completada");
INSERT INTO booking_status (status_description) VALUES ("Cancelada");

-- Inserciones para booking
INSERT INTO booking (booking_date, id_user, id_room, checkIn_date, checkOut_date, guest, id_status) VALUES ('2025-03-15', '186201148610', 1, '2025-03-25', '2025-03-27', 1, 2);
INSERT INTO booking (booking_date, id_user, id_room, checkIn_date, checkOut_date, guest, id_status) VALUES ('2025-03-16', '186201148610', 2, '2025-04-02', '2025-04-06', 2, 3);
INSERT INTO booking (booking_date, id_user, id_room, checkIn_date, checkOut_date, guest, id_status) VALUES ('2025-03-17', '186201148610', 3, '2025-04-07', '2025-04-09', 4, 3);
INSERT INTO booking (booking_date, id_user, id_room, checkIn_date, checkOut_date, guest, id_status) VALUES ('2025-04-18', '186201148610', 4, '2025-04-25', '2025-04-26', 6, 1);
INSERT INTO booking (booking_date, id_user, id_room, checkIn_date, checkOut_date, guest, id_status) VALUES ('2025-03-18', '186201148610', 4, '2025-03-27', '2025-03-29', 2, 1);

-- Inserciones para room_services
INSERT INTO room_services (id_booking, id_services) VALUES (1, 1);
INSERT INTO room_services (id_booking, id_services) VALUES (2, 3);
INSERT INTO room_services (id_booking, id_services) VALUES (3, 2);
INSERT INTO room_services (id_booking, id_services) VALUES (4, 1);
INSERT INTO room_services (id_booking, id_services) VALUES (4, 2);
INSERT INTO room_services (id_booking, id_services) VALUES (4, 3);

-- Inserciones para receipt
INSERT INTO receipt (id_booking, total) VALUES (1, 500);
INSERT INTO receipt (id_booking, total) VALUES (2, 600);
INSERT INTO receipt (id_booking, total) VALUES (3, 1200);
INSERT INTO receipt (id_booking, total) VALUES (4, 1500);
INSERT INTO receipt (id_booking, total) VALUES (5, 1000);


-- Inserciones para reviews
INSERT INTO reviews (review_body, review_date, califactions, id_user, id_room) VALUES ('Excelente servicio', '2025-04-06', 5, '186201148610', 1);
INSERT INTO reviews (review_body, review_date, califactions, id_user, id_room) VALUES ('Muy buena atencion', '2025-04-07', 4, '186201148610', 2);
INSERT INTO reviews (review_body, review_date, califactions, id_user, id_room) VALUES ('Habitacion comoda y limpia', '2025-04-08', 5, '186201148610', 3);