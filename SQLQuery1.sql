create database agencia_db;
use agencia_db;


CREATE TABLE Destino(
    id_destino int identity(1,1) primary key,
    nombre varchar(50) not null,
    descripcion varchar(500) not null,
    actividades varchar(200) not null,
	costo float,
    );


CREATE TABLE Cliente(
	id_cliente int identity(1,1) primary key,
	nombre varchar(500) not null,
	usuario varchar(100) not null unique,
	correo varchar(400) not null,
	contrasenia varchar(300) not null
);

CREATE TABLE PaqueteTuristico(
    id_paquete_turistico int identity(1,1) primary key,
    nombre_destino varchar(500) not null,
    fecha_inicio date not null,
    fecha_termino date not null,
    precio_final int not null
	id_destino INT REFERENCES Destino(id_destino)
	id_cliente INT REFERENCES Cliente(id_cliente)
);



insert into PaqueteTuristico(id_paquete_turistico, nombre_destino, fecha_inicio, fecha_termino, precio_final)
values(0, "Paquete ", )---- REVISAR



create table Reserva (
	id_reserva int identity(1,1) primary key,
	id_cliente int REFERENCES Cliente(id_cliente),
	id_paquete_turistico int REFERENCES PaqueteTuristico(id_paquete_turistico),
	fecha_reserva date
);


create table DetallePaquete (
	id_detalle_paquete int primary key identity(1,1),
	id_destino int REFERENCES Destino(id_destino),
	id_paquete_turistico int REFERENCES PaqueteTuristico(id_paquete_turistico)
);


--FALTA PONER PRECIO SE MODIFICO LA TABLA DESTINO Y PAQUETE EN LAS FK
insert into Destino(id_destino, nombre, descripcion, actividades,costo)
values(0,'San Pedro de Atacama', 'Con paisajes como el Valle de la Luna, los géiseres del Tatio y salares impresionantes.','Excursiones al Valle de la Luna y Valle de la Muerte, Visitar los géiseres del Tatio al amanecer.',300000)

insert into Destino(id_destino, nombre, descripcion, actividades,costo)
values(1, 'Iquique', 'Famoso por sus playas, el casco histórico y el desierto de Pica y Humberstone (sitio declarado Patrimonio de la Humanidad).','Practicar parapente desde las dunas cercanas')

insert into Destino(id_destino, nombre, descripcion, actividades,costo)
values(2, 'Antofagasta', 'Hogar del Monumento Natural La Portada y acceso al desierto más árido del mundo', 'Excursiones al Salar de Atacama o al Observatorio ALMA')

insert into Destino(id_destino, nombre, descripcion, actividades,costo)
Values(3, 'Santiago', 'La capital, con lugares como el Cerro San Cristóbal, el Palacio de La Moneda y los museos nacionales.','Visitar museos como el Museo de Arte Precolombino y el Museo Nacional de Historia.',)

insert into Destino(id_destino, nombre, descripcion, actividades,costo)
values(4, 'Viña del Mar','Valparaíso es famosa por sus cerros, arte callejero y ascensores históricos, mientras que Viña del Mar tiene playas y festivales.','Relajarte en las playas de Viña del Mar,
visitar el jardín botánico y el famoso reloj de flores.')

insert into Destino(id_destino, nombre, descripcion, actividades,costo)
values(5,'Isla de Pascua','Con sus icónicos moáis, volcanes y cultura única.','Practicar buceo o snorkel en las aguas cristalinas.')

insert into Destino(id_destino, nombre, descripcion, actividades,costo)
values(6,'Valle del Elqui','Ideal para observar las estrellas, disfrutar del pisco chileno y relajarse.','Practicar trekking o relajarte en termas.')


insert into Destino(id_destino, nombre, descripcion, actividades,costo)
values(7, 'Pucón', 'Perfecto para deportes acuáticos, senderismo y disfrutar de termas.','Deportes acuáticos como kayak o paddle en el lago.')

insert into Destino(id_destino, nombre, descripcion, actividades,costo)
values(8,'Valdivia','Con su fuerte historia colonial, cervecerías artesanales y ríos navegables.','Navegar por los ríos Calle-Calle y Valdivia.
Visitar los fuertes históricos en Corral y Niebla.');


insert into Destino(id_destino, nombre, descripcion, actividades,costo)
values(9, 'Chiloé', 'Con su arquitectura tradicional, iglesias Patrimonio de la Humanidad y mitología rica. ','Visitar las iglesias Patrimonio de la Humanidad.
Explorar el Parque Nacional Chiloé y avistar fauna.')

insert into Destino(id_destino, nombre, descripcion, actividades,costo)
values(10, 'Torres del Paine', 'Un paraíso para senderistas con montañas, glaciares y lagos de colores vibrantes.','Navegar por el lago Grey para ver el glaciar.
Avistamiento de guanacos, cóndores y otros animales.')




-- VISTAS --------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW vista_detalle_paquete AS
    SELECT PaqueteTuristico.id_paquete_turistico, 
            PaqueteTuristico.nombre_destino, 
            PaqueteTuristico.fecha_inicio, 
            PaqueteTuristico.fecha_termino, 
            PaqueteTuristico.precio_final, 
            Destino.id_destino, 
            Destino.descripcion, Destino.actividades,
            count(Destino.id_destino) AS cantidadDestinos
    FROM PaqueteTuristico
    JOIN Destino 
    ON PaqueteTuristico.id_paquete_turistico = Destino.id_paquete_turistico
    GROUP BY PaqueteTuristico.id_paquete_turistico, 
                PaqueteTuristico.nombre_destino,
                PaqueteTuristico.fecha_inicio, 
                PaqueteTuristico.fecha_termino, 
                PaqueteTuristico.precio_final, 
                Destino.id_destino, 
                Destino.descripcion, 
                Destino.actividades
;

CREATE VIEW vista_reserva AS
    SELECT Cliente.id_cliente, 
            PaqueteTuristico.id_paquete_turistico,
            count(Cliente.id_cliente) AS CantidadReservas
    FROM Cliente
    JOIN PaqueteTuristico 
    ON Cliente.id_cliente = PaqueteTuristico.id_paquete_turistico
    GROUP BY Cliente.id_cliente, 
    PaqueteTuristico.id_paquete_turistico
;



-- Triggers ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Paquete Turistico - con auditoria
---- EXEC IsertarPaqueteTuristico nombre_pq, CAST('fecha_inicio' AS DATETIME), CAST('fecha_final' AS DATETIME), precio_final;
---- EXEC ActualizaFechasPT id_pt, nueva_fecha_inicio,  CAST('nueva_fecha_termino' AS DATETIME)
---- EXEC ActualizarNombrePT id_pt, nuevo_nombre 
---- EXEC ActualizarPrecioFinalPT id_pt, nuevo_nombre
--
-- Destino
---- EXEC ActualizarNombre id_destino, nuevo_nombre
---- EXEC ActualizarDescripcion id_destino, nueva_descripcion
---- EXEC ActualizarActividades id_destino, nueva_actividad
---- EXEC ActualizarIdPaqueteTuristico id_destino, nuevo_id_pt
--
-- Cliente
---- EXEC CrearCliente
---- EXEC ActualizarNombre
---- EXEC ActualizarCorreo
---- EXEC ActualizarContrasenia
---- EXEC ActualizarNombreUsuario
---- EXEC EliminarCliente
--
-- Hay que hacer una nueva tabla entre destinos y paquetes turisticos, una vista para esto y lograr extraer información sin los id



-- Paquete Turistico -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
---- Procedimiento para insertar un paquete turístico
CREATE PROCEDURE InsertarPaqueteTuristico
    @nombre_pq VARCHAR(255),
    @fecha_inicio DATE,
    @fecha_termino DATE,
    @precio_final INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO PaqueteTuristico (
            nombre,
            fecha_inicio,
            fecha_termino,
            precio_final
        )
        VALUES (
            @nombre_pq,
            @fecha_inicio,
            @fecha_termino,
            @precio_final
        );

        PRINT 'Paquete turístico ' + @nombre_pq + ' insertado correctamente';
    END TRY
    BEGIN CATCH
        PRINT 'Error al insertar: ' + ERROR_MESSAGE();
    END CATCH
END;

---- Procedimiento para actualizar fechas de un paquete turístico
CREATE PROCEDURE ActualizarFechasPT
    @id_pt INT,
    @nueva_fecha_inicio DATE,
    @nueva_fecha_termino DATE
AS
BEGIN
    BEGIN TRY
        UPDATE PaqueteTuristico
        SET fecha_inicio = @nueva_fecha_inicio,
            fecha_termino = @nueva_fecha_termino
        WHERE id_paquete_turistico = @id_pt;

        PRINT 'Fechas del paquete actualizadas exitosamente';
    END TRY
    BEGIN CATCH
        PRINT 'Error al actualizar: ' + ERROR_MESSAGE();
    END CATCH
END;

---- Procedimiento para actualizar nombre
CREATE PROCEDURE ActualizarNombrePT
    @id_pt INT,
    @nuevo_nombre varchar
AS
BEGIN
    BEGIN TRY
        UPDATE PaqueteTuristico
        SET nombre = @nuevo_nombre
        WHERE id_paquete_turistico = @id_pt;

        PRINT 'Nombre del paquete actualizado exitosamente';
    END TRY
    BEGIN CATCH
        PRINT 'Error al actualizar: ' + ERROR_MESSAGE();
    END CATCH
END;

---- Procedimiento para actualizar precio final
CREATE PROCEDURE ActualizarPrecioFinalPT
    @id_pt INT,
    @nuevo_precio_final INT
AS
BEGIN
    BEGIN TRY
        UPDATE PaqueteTuristico
        SET precio_final = @nuevo_precio_final
        WHERE id_paquete_turistico = @id_pt;
        PRINT 'Nombre del paquete actualizado exitosamente';
    END TRY
    BEGIN CATCH
        PRINT 'Error al actualizar: ' + ERROR_MESSAGE();
    END CATCH
END;




-- Destino -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
---- Procedimiento para actualizar nombre del destino
CREATE PROCEDURE ActualizarNombreDestino
    @id_des INT,
    @nuevo_nombre varchar
AS
BEGIN
    BEGIN TRY
        UPDATE Destino
        SET nombre = @nuevo_nombre
        WHERE id_destino = @id_des;

        PRINT 'Nombre del destino actualizado exitosamente';
    END TRY
    BEGIN CATCH
        PRINT 'Error al actualizar: ' + ERROR_MESSAGE();
    END CATCH
END;




-- Cliente -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
---- Procedimiento para insertar un cliente
CREATE OR ALTER PROCEDURE InsertarCliente
    @nombre VARCHAR,
    @correo VARCHAR,
    @contrasenia VARCHAR
AS
BEGIN
    BEGIN TRY
        INSERT INTO cliente (nombre, correo, contrasenia)
        VALUES (@nombre, @correo, @contrasenia);

        PRINT 'CLIENTE: ' + @nombre + ' INSERTADO CORRECTAMENTE';
    END TRY
    BEGIN CATCH
        PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH
END;

---- Procedimiento para actualizar correo
CREATE OR ALTER PROCEDURE ActualizarCorreo
    @correo_nuevo VARCHAR,
    @id INT
AS
BEGIN
    BEGIN TRY
        -- Actualizar el correo del usuario
        UPDATE USUARIO
        SET correo = @correo_nuevo
        WHERE id_cliente = @id;

        -- Mensaje de éxito
        PRINT 'CORREO ACTUALIZADO';
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH
END;

---- Procedimiento para borrar cliente
CREATE OR ALTER PROCEDURE BorrarCliente
    @nombre_usuario VARCHAR
AS
BEGIN
    BEGIN TRY
        -- Elimina al cliente con el nombre especificado
        DELETE FROM cliente
        WHERE usuario = @nombre_usuario;

        -- Mensaje de confirmación
        PRINT 'CLIENTE CON USUARIO ' + @nombre_usuario + ' ELIMINADO CORRECTAMENTE';
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH
END;

---- Procedimiento para cambiarContrasenia
CREATE OR ALTER PROCEDURE CambiarContrasenia
    @usuario VARCHAR,
    @nueva_contrasenia VARCHAR
AS
BEGIN
    BEGIN TRY
        UPDATE Cliente
        SET contrasenia = @nueva_contrasenia
        WHERE usuario = @usuario;
        PRINT 'CONTRASEÑA ACTUALIZADA CORRECTAMENTE PARA EL USUARIO ' + @usuario;
    END TRY
    BEGIN CATCH
        PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH
END;





-- TRIGGERS DE AUDITORIA ----------------------------------------------------------------------------------------------------------------------------------------------------
---- Trigger de auditoria para paquete turistico
CREATE TABLE SesionPaqueteTuristico (
    os_user VARCHAR(100),
    ip_user VARCHAR(100),
    sesion_usuario VARCHAR(100),
    fecha DATE,
    a_nombre VARCHAR(100),
    a_fecha_inicio DATE,
    a_fecha_termino DATE,
    a_precio_final INT,
    n_nombre VARCHAR(100),
    n_fecha_inicio DATE,
    n_fecha_termino DATE,
    n_precio_final INT
);

CREATE TRIGGER AuditoriaPaqueteTuristico
ON PaqueteTuristico
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO SesionPaqueteTuristico (
        os_user,
        ip_user,
        sesion_usuario,
        fecha,
        a_nombre,
        a_fecha_inicio,
        a_fecha_termino,
        a_precio_final,
        n_nombre,
        n_fecha_inicio,
        n_fecha_termino,
        n_precio_final
    )
    SELECT 
        SYSTEM_USER AS os_user,
        CAST(CONNECTIONPROPERTY('client_net_address') AS VARCHAR(100)) AS ip_user,
        SESSION_USER AS sesion_usuario, 
        GETDATE() AS fecha, 
        d.nombre AS a_nombre, 
        d.fecha_inicio AS a_fecha_inicio,
        d.fecha_termino AS a_fecha_termino,
        d.precio_final AS a_precio_final,
        i.nombre AS n_nombre,
        i.fecha_inicio AS n_fecha_inicio,
        i.fecha_termino AS n_fecha_termino,
        i.precio_final AS n_precio_final
    FROM 
        Inserted i
    INNER JOIN 
        Deleted d ON i.id_paquete_turistico = d.id_paquete_turistico
    WHERE 
        d.nombre != i.nombre 
        OR d.fecha_inicio != i.fecha_inicio
        OR d.fecha_termino != i.fecha_termino
        OR d.precio_final != i.precio_final;
END;


---- Trigger de auditoria para destino
-- Crear tabla para auditoría de cambios en Destino
CREATE TABLE SesionDestino (
    os_user VARCHAR(100),
    ip_user VARCHAR(100),
    sesion_usuario VARCHAR(100),
    fecha DATETIME,
    a_nombre VARCHAR(50),
    a_descripcion VARCHAR(500),
    a_actividades VARCHAR(200),
    n_nombre VARCHAR(50),
    n_descripcion VARCHAR(500),
    n_actividades VARCHAR(200)
);

-- Trigger para registrar actualizaciones en Destino
CREATE TRIGGER AuditoriaDestino
ON Destino
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO SesionDestino (
        os_user,
        ip_user,
        sesion_usuario,
        fecha,
        a_nombre,
        a_descripcion,
        a_actividades,
        n_nombre,
        n_descripcion,
        n_actividades
    )
    SELECT 
        SYSTEM_USER AS os_user,
        CAST(CONNECTIONPROPERTY('client_net_address') AS VARCHAR(100)) AS ip_user,
        SESSION_USER AS sesion_usuario,
        GETDATE() AS fecha,
        d.nombre AS a_nombre,
        d.descripcion AS a_descripcion,
        d.actividades AS a_actividades,
        i.nombre AS n_nombre,
        i.descripcion AS n_descripcion,
        i.actividades AS n_actividades
    FROM 
        Inserted i
    INNER JOIN 
        Deleted d ON i.id_destino = d.id_destino
    WHERE 
        d.nombre != i.nombre 
        OR d.descripcion != i.descripcion
        OR d.actividades != i.actividades;
END;

