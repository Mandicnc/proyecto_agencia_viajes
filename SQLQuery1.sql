CREATE TABLE PaqueteTuristico(
    id_paquete_turistico int identity(1,1) primary key,
    nombre varchar(500),
    fecha_inicio date,
    fecha_termino date,
    precio_final int
);

CREATE TABLE Destino(
    id_destino int identity(1,1) primary key,
    nombre varchar(50),
    descripcion varchar(500),
    actividades varchar(200),
    id_paquete_turistico INT REFERENCES PaqueteTuristico(id_paquete_turistico)

);
CREATE TABLE Cliente(
	id_cliente int identity(1,1) primary key,
	nombre varchar(500),
	correo varchar(400),
	contrasenia varchar(300)
);

-- VISTAS --------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW DetallePaquete AS
    SELECT PaqueteTuristico.id_paquete_turistico, 
            PaqueteTuristico.nombre, 
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
                PaqueteTuristico.nombre,
                PaqueteTuristico.fecha_inicio, 
                PaqueteTuristico.fecha_termino, 
                PaqueteTuristico.precio_final, 
                Destino.id_destino, 
                Destino.descripcion, 
                Destino.actividades
;

CREATE VIEW Reserva AS
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
---- InsertarPaqueteTuristico(nombre_pq, fecha_inicio, fecha_termino, precio_final);
---- ActualizaFechasPT(id_pt, nueva_fecha_inicio, nueva_fecha_termino)
---- ActualizarNombrePT(id_pt, nuevo_nombre)
---- ActualizarPrecioFinalPT(id_pt, nuevo_nombre)
--
-- Destino
---- ActualizarNombre()
---- ActualizarDescripcion()
---- ActualizarActividades()
---- ActualizarIdPaqueteTuristico()
--
-- Cliente
---- CrearCliente()
---- ActualizarNombre()
---- ActualizarCorreo()
---- ActualizarContrasenia()
---- EliminarCliente()
--



-- Paquete Turistico -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
---- Procedimiento para insertar un paquete turístico
CREATE PROCEDURE InsertarPaqueteTuristico
    @nombre_pq NVARCHAR(255),
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
        WHERE id = @id_pt;

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
        WHERE id = @id_pt;

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
        WHERE id = @id_pt;
        PRINT 'Nombre del paquete actualizado exitosamente';
    END TRY
    BEGIN CATCH
        PRINT 'Error al actualizar: ' + ERROR_MESSAGE();
    END CATCH
END;

-- Destino -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
---- Procedimiento para actualizar nombre del destino
CREATE PROCEDURE ActualizarNombreDes
    @id_des INT,
    @nuevo_nombre varchar
AS
BEGIN
    BEGIN TRY
        UPDATE Destino
        SET nombre = @nuevo_nombre
        WHERE id = @id_des;

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
        WHERE id = @id;

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
    @nombre_cliente VARCHAR
AS
BEGIN
    BEGIN TRY
        -- Elimina al cliente con el nombre especificado
        DELETE FROM cliente
        WHERE nombre = @nombre_cliente;

        -- Mensaje de confirmación
        PRINT 'CLIENTE CON NOMBRE ' + @nombre_cliente + ' ELIMINADO CORRECTAMENTE';
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH
END;

---- Procedimiento para cambiarContrasenia
CREATE OR ALTER PROCEDURE CambiarContrasenia
    @id INT,
    @nueva_contrasenia VARCHAR
AS
BEGIN
    BEGIN TRY
        -- Actualiza la contraseña del usuario con el ID especificado
        UPDATE USUARIO
        SET contrasenia = @nueva_contrasenia
        WHERE id = @id;

        -- Mensaje de confirmación
        PRINT 'CONTRASEÑA ACTUALIZADA CORRECTAMENTE PARA EL USUARIO CON ID ' + CAST(@id AS VARCHAR);
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH
END;


-- Usuario -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
---- Procedimiento para cambiar nombre de usuario
CREATE OR ALTER PROCEDURE cambiar_nombre_usuario
    @nombre_usuario VARCHAR,
    @nuevo_nombre VARCHAR
AS
BEGIN
    BEGIN TRY
        -- Actualiza el nombre del usuario utilizando el nombre de usuario
        UPDATE USUARIO
        SET nombre = @nuevo_nombre
        WHERE nombre = @nombre_usuario;

        -- Mensaje de confirmación
        PRINT 'NOMBRE DEL USUARIO CON NOMBRE ' + @nombre_usuario + ' ACTUALIZADO A ' + @nuevo_nombre;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH
END;

-- TRIGGERS DE AUDITORIA ----------------------------------------------------------------------------------------------------------------------------------------------------
---- Trigger de auditoria para paquete turistico
CREATE TABLE SesionPaqueteTuristico (
    os_user VARCHAR(100),
    ip_user VARCHAR(100),
    sesion_usuario VARCHAR(100),
    fecha DATETIME,
    a_nombre VARCHAR(100),
    a_fecha_inicio DATE,
    a_fecha_termino DATE,
    a_precio_final INT,
    n_nombre VARCHAR(100),
    n_fecha_inicio DATE,
    n_fecha_termino DATE,
    n_precio_final INT
);

CREATE TRIGGER ActualizarPaqueteTuristico
ON PaqueteTuristico
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Insertar en la tabla SesionPaqueteTuristico si hay cambios en los campos específicos
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
        SYSTEM_USER AS os_user,                      -- Usuario del sistema
        CONNECTIONPROPERTY('client_net_address') AS ip_user, -- Dirección IP del cliente
        SESSION_USER AS sesion_usuario,              -- Usuario de la sesión
        GETDATE() AS fecha,                          -- Fecha actual
        d.nombre AS a_nombre,                        -- Valores antiguos
        d.fecha_inicio AS a_fecha_inicio,
        d.fecha_termino AS a_fecha_termino,
        d.precio_final AS a_precio_final,
        i.nombre AS n_nombre,                        -- Valores nuevos
        i.fecha_inicio AS n_fecha_inicio,
        i.fecha_termino AS n_fecha_termino,
        i.precio_final AS n_precio_final
    FROM 
        Inserted i
    INNER JOIN 
        Deleted d ON i.id = d.id                     -- Relacionar filas antiguas y nuevas
    WHERE 
        d.nombre != i.nombre 
        OR d.fecha_inicio != i.fecha_inicio
        OR d.fecha_termino != i.fecha_termino
        OR d.precio_final != i.precio_final;
END;


---- Trigger de auditoria para destino
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

CREATE TRIGGER ActualizarDestino
ON Destino
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Insertar en la tabla SesionDestino si hay cambios en los campos específicos
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
        SYSTEM_USER AS os_user,                      -- Usuario del sistema
        CONNECTIONPROPERTY('client_net_address') AS ip_user, -- Dirección IP del cliente
        SESSION_USER AS sesion_usuario,              -- Usuario de la sesión
        GETDATE() AS fecha,                          -- Fecha actual
        d.nombre AS a_nombre,                        -- Valores antiguos
        d.descripcion AS a_descripcion,
        d.actividades AS a_actividades,
        i.nombre AS n_nombre,                        -- Valores nuevos
        i.descripcion AS n_descripcion,
        i.actividades AS n_actividades
    FROM 
        Inserted i
    INNER JOIN 
        Deleted d ON i.id = d.id                     -- Relacionar filas antiguas y nuevas
    WHERE 
        d.nombre != i.nombre 
        OR d.descripcion != i.descripcion
        OR d.actividades != i.actividades;
END;


















