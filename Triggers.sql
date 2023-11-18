--Triggers para registro de acciones

use Guana_HospiDB
go

--Creacion de tabla para guardar datos de triggers
drop table if exists HistorialAcciones
go
CREATE TABLE HistorialAcciones (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME,
	IdUsuario INT,
    CorreoUsuario VARCHAR(50),
    Accion VARCHAR(50),
    IdRegistroModificado INT,
);

--Llave foranea con usuario
alter table HistorialAcciones
Add constraint FK_HistorialAcciones_Usuario
FOREIGN KEY (IdUsuario)
references Usuario (ID_Usuario)
go

--Triggers de Doctor

--Trigger al insertar un doctor
DROP TRIGGER IF EXISTS TR_InsertarDoctor;
GO
CREATE TRIGGER TR_InsertarDoctor 
ON Doctor AFTER INSERT
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Doctor INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Doctor = ID_Doctor FROM inserted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'INSERCIÓN EN DOCTOR', @ID_Doctor);
END;
GO

-- Trigger al actualizar un Doctor
DROP TRIGGER IF EXISTS TR_ActualizarDoctor;
GO
CREATE TRIGGER TR_ActualizarDoctor 
ON Doctor AFTER UPDATE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Doctor INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Doctor = ID_Doctor FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ACTUALIZACIÓN EN DOCTOR', @ID_Doctor);
END;
GO

-- Trigger al eliminar un Doctor
DROP TRIGGER IF EXISTS TR_EliminarDoctor;
GO
CREATE TRIGGER TR_EliminarDoctor 
ON Doctor AFTER DELETE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Doctor INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Doctor = ID_Doctor FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ELIMINACIÓN EN DOCTOR', @ID_Doctor);
END;
GO

-- Triggers de Enfermedad

-- Trigger al insertar una Enfermedad
DROP TRIGGER IF EXISTS TR_InsertarEnfermedad;
GO
CREATE TRIGGER TR_InsertarEnfermedad
ON Enfermedad AFTER INSERT
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Enfermedad INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Enfermedad = ID_Enfermedad FROM inserted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'INSERCIÓN EN ENFERMEDAD', @ID_Enfermedad);
END;
GO

-- Trigger al actualizar una Enfermedad
DROP TRIGGER IF EXISTS TR_ActualizarEnfermedad;
GO
CREATE TRIGGER TR_ActualizarEnfermedad 
ON Enfermedad AFTER UPDATE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Enfermedad INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Enfermedad = ID_Enfermedad FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ACTUALIZACIÓN EN ENFERMEDAD', @ID_Enfermedad);
END;
GO

-- Trigger al eliminar una Enfermedad
DROP TRIGGER IF EXISTS TR_EliminarEnfermedad;
GO
CREATE TRIGGER TR_EliminarEnfermedad 
ON Enfermedad AFTER DELETE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Enfermedad INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Enfermedad = ID_Enfermedad FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ELIMINACIÓN EN ENFERMEDAD', @ID_Enfermedad);
END;
GO

-- Triggers de Sintoma

-- Trigger al insertar un Síntoma
DROP TRIGGER IF EXISTS TR_InsertarSintoma;
GO
CREATE TRIGGER TR_InsertarSintoma
ON Sintoma AFTER INSERT
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Sintoma INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Sintoma = ID_Sintoma FROM inserted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'INSERCIÓN EN SÍNTOMA', @ID_Sintoma);
END;
GO

-- Trigger al actualizar un Sintoma
DROP TRIGGER IF EXISTS TR_ActualizarSintoma;
GO
CREATE TRIGGER TR_ActualizarSintoma 
ON Sintoma AFTER UPDATE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Sintoma INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Sintoma = ID_Sintoma FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ACTUALIZACIÓN EN SÍNTOMA', @ID_Sintoma);
END;
GO

-- Trigger al eliminar un Sintoma
DROP TRIGGER IF EXISTS TR_EliminarSintoma;
GO
CREATE TRIGGER TR_EliminarSintoma
ON Sintoma AFTER DELETE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Sintoma INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Sintoma = ID_Sintoma FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ELIMINACIÓN EN SÍNTOMA', @ID_Sintoma);
END;
GO

-- Triggers de Especialidad

-- Trigger al insertar una Especialidad
DROP TRIGGER IF EXISTS TR_InsertarEspecialidad;
GO
CREATE TRIGGER TR_InsertarEspecialidad
ON Especialidad AFTER INSERT
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Especialidad INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Especialidad = ID_Especialidad FROM inserted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'INSERCIÓN EN ESPECIALIDAD', @ID_Especialidad);
END;
GO

-- Trigger al actualizar una Especialidad
DROP TRIGGER IF EXISTS TR_ActualizarEspecialidad;
GO
CREATE TRIGGER TR_ActualizarEspecialidad 
ON Especialidad AFTER UPDATE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Especialidad INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Especialidad = ID_Especialidad FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ACTUALIZACIÓN EN ESPECIALIDAD', @ID_Especialidad);
END;
GO

-- Trigger al eliminar una Especialidad
DROP TRIGGER IF EXISTS TR_EliminarEspecialidad;
GO
CREATE TRIGGER TR_EliminarEspecialidad
ON Especialidad AFTER DELETE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Especialidad INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Especialidad = ID_Especialidad FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
	VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ELIMINACION EN ESPECIALIDAD', @ID_Especialidad);
END;
GO
-- Triggers de	Paciente


-- Trigger al insertar un Paciente
DROP TRIGGER IF EXISTS TR_InsertarPaciente;
GO
CREATE TRIGGER TR_InsertarPaciente
ON Paciente AFTER INSERT
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Paciente INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Paciente = ID_Paciente FROM inserted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'INSERCIÓN EN PACIENTE', @ID_Paciente);
END;
GO

-- Trigger al actualizar un Paciente
DROP TRIGGER IF EXISTS TR_ActualizarPaciente;
GO
CREATE TRIGGER TR_ActualizarPaciente
ON Paciente AFTER UPDATE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Paciente INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Paciente = ID_Paciente FROM inserted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ACTUALIZACIÓN EN PACIENTE', @ID_Paciente);
END;
GO

-- Trigger al eliminar un Paciente
DROP TRIGGER IF EXISTS TR_EliminarPaciente;
GO
CREATE TRIGGER TR_EliminarPaciente
ON Paciente AFTER DELETE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Paciente INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Paciente = ID_Paciente FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ELIMINACIÓN EN PACIENTE', @ID_Paciente);
END;
GO

--Triggers de Rol

-- Trigger al insertar un Rol
DROP TRIGGER IF EXISTS TR_InsertarRol;
GO
CREATE TRIGGER TR_InsertarRol
ON Rol AFTER INSERT
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Rol INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Rol = ID_Rol FROM inserted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'INSERCIÓN EN ROL', @ID_Rol);
END;
GO

-- Trigger al actualizar un Rol
DROP TRIGGER IF EXISTS TR_ActualizarRol;
GO
CREATE TRIGGER TR_ActualizarRol
ON Rol AFTER UPDATE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Rol INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Rol = ID_Rol FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ACTUALIZACIÓN EN ROL', @ID_Rol);
END;
GO

-- Trigger al eliminar un Rol
DROP TRIGGER IF EXISTS TR_EliminarRol;
GO
CREATE TRIGGER TR_EliminarRol
ON Rol AFTER DELETE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Rol INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Rol = ID_Rol FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ELIMINACIÓN EN ROL', @ID_Rol);
END;
GO

--Triggers de TipoIntervencion


-- Trigger al insertar un TipoIntervencion
DROP TRIGGER IF EXISTS TR_InsertarTipoIntervencion;
GO
CREATE TRIGGER TR_InsertarTipoIntervencion
ON TipoIntervencion AFTER INSERT
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_TipoIntervencion INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_TipoIntervencion = ID_TipoIntervencion FROM inserted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'INSERCIÓN EN TIPO INTERVENCIÓN', @ID_TipoIntervencion);
END;
GO

-- Trigger al actualizar un TipoIntervencion
DROP TRIGGER IF EXISTS TR_ActualizarTipoIntervencion;
GO
CREATE TRIGGER TR_ActualizarTipoIntervencion
ON TipoIntervencion AFTER UPDATE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_TipoIntervencion INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_TipoIntervencion = ID_TipoIntervencion FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ACTUALIZACIÓN EN TIPO INTERVENCIÓN', @ID_TipoIntervencion);
END;
GO

-- Trigger al eliminar un TipoIntervencion
DROP TRIGGER IF EXISTS TR_EliminarTipoIntervencion;
GO
CREATE TRIGGER TR_EliminarTipoIntervencion
ON TipoIntervencion AFTER DELETE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_TipoIntervencion INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_TipoIntervencion = ID_TipoIntervencion FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ELIMINACIÓN EN TIPO INTERVENCIÓN', @ID_TipoIntervencion);
END;
GO

--Triggers de Unidad


-- Trigger al insertar una Unidad
DROP TRIGGER IF EXISTS TR_InsertarUnidad;
GO
CREATE TRIGGER TR_InsertarUnidad
ON Unidad AFTER INSERT
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Unidad INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Unidad = ID_Unidad FROM inserted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'INSERCIÓN EN UNIDAD', @ID_Unidad);
END;
GO

-- Trigger al actualizar una Unidad
DROP TRIGGER IF EXISTS TR_ActualizarUnidad;
GO
CREATE TRIGGER TR_ActualizarUnidad
ON Unidad AFTER UPDATE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Unidad INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Unidad = ID_Unidad FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ACTUALIZACIÓN EN UNIDAD', @ID_Unidad);
END;
GO

-- Trigger al eliminar una Unidad
DROP TRIGGER IF EXISTS TR_EliminarUnidad;
GO
CREATE TRIGGER TR_EliminarUnidad
ON Unidad AFTER DELETE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Unidad INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Unidad = ID_Unidad FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ELIMINACIÓN EN UNIDAD', @ID_Unidad);
END;
GO

--Triggers de Usuario


-- Trigger al insertar un Usuario
DROP TRIGGER IF EXISTS TR_InsertarUsuario;
GO
CREATE TRIGGER TR_InsertarUsuario
ON Usuario AFTER INSERT
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_UsuarioRegistrado INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_UsuarioRegistrado = ID_Usuario FROM inserted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'INSERCIÓN EN USUARIO', @ID_UsuarioRegistrado);
END;
GO

-- Trigger al actualizar un Usuario
DROP TRIGGER IF EXISTS TR_ActualizarUsuario;
GO
CREATE TRIGGER TR_ActualizarUsuario
ON Usuario AFTER UPDATE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_UsuarioActualizado INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_UsuarioActualizado = ID_Usuario FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ACTUALIZACIÓN EN USUARIO', @ID_UsuarioActualizado);
END
GO

--Triggers de PacienteUnidad


-- Trigger al insertar un PacienteUnidad
DROP TRIGGER IF EXISTS TR_InsertarPacienteUnidad;
GO
CREATE TRIGGER TR_InsertarPacienteUnidad
ON Paciente_Unidad AFTER INSERT
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_PacienteUnidad INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_PacienteUnidad = ID_Paciente_Unidad FROM inserted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'INSERCIÓN EN PACIENTE_UNIDAD', @ID_PacienteUnidad);
END;
GO

-- Trigger al actualizar un PacienteUnidad
DROP TRIGGER IF EXISTS TR_ActualizarPacienteUnidad;
GO
CREATE TRIGGER TR_ActualizarPacienteUnidad
ON Paciente_Unidad AFTER UPDATE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_PacienteUnidad INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_PacienteUnidad = ID_Paciente_Unidad FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ACTUALIZACIÓN EN PACIENTE_UNIDAD', @ID_PacienteUnidad);
END;
GO

-- Trigger al eliminar un PacienteUnidad
DROP TRIGGER IF EXISTS TR_EliminarPacienteUnidad;
GO
CREATE TRIGGER TR_EliminarPacienteUnidad
ON Paciente_Unidad AFTER DELETE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_PacienteUnidad INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_PacienteUnidad = ID_Paciente_Unidad FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ELIMINACIÓN EN PACIENTE_UNIDAD', @ID_PacienteUnidad);
END;
GO

--Triggers de EnfermedadSintoma


-- Trigger al insertar un EnfermedadSintoma
DROP TRIGGER IF EXISTS TR_InsertarEnfermedadSintoma;
GO
CREATE TRIGGER TR_InsertarEnfermedadSintoma
ON Enfermedad_Sintoma AFTER INSERT
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_EnfermedadSintoma INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_EnfermedadSintoma = ID_Enfermedad_Sintoma FROM inserted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'INSERCIÓN EN ENFERMEDAD_SINTOMA', @ID_EnfermedadSintoma);
END;
GO

-- Trigger al actualizar un EnfermedadSintoma
DROP TRIGGER IF EXISTS TR_ActualizarEnfermedadSintoma;
GO
CREATE TRIGGER TR_ActualizarEnfermedadSintoma
ON Enfermedad_Sintoma AFTER UPDATE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_EnfermedadSintoma INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_EnfermedadSintoma = ID_Enfermedad_Sintoma FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ACTUALIZACIÓN EN ENFERMEDAD_SINTOMA', @ID_EnfermedadSintoma);
END;
GO

-- Trigger al eliminar un EnfermedadSintoma
DROP TRIGGER IF EXISTS TR_EliminarEnfermedadSintoma;
GO
CREATE TRIGGER TR_EliminarEnfermedadSintoma
ON Enfermedad_Sintoma AFTER DELETE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_EnfermedadSintoma INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_EnfermedadSintoma = ID_Enfermedad_Sintoma FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ELIMINACIÓN EN ENFERMEDAD_SINTOMA', @ID_EnfermedadSintoma);
END;
GO

-- Triggers de Intervencion

-- Trigger al insertar una Intervencion
DROP TRIGGER IF EXISTS TR_InsertarIntervencion;
GO
CREATE TRIGGER TR_InsertarIntervencion
ON Intervencion AFTER INSERT
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Intervencion INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Intervencion = ID_Intervencion FROM inserted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'INSERCIÓN EN INTERVENCIÓN', @ID_Intervencion);
END;
GO

-- Trigger al actualizar una Intervencion
DROP TRIGGER IF EXISTS TR_ActualizarIntervencion;
GO
CREATE TRIGGER TR_ActualizarIntervencion
ON Intervencion AFTER UPDATE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Intervencion INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Intervencion = ID_Intervencion FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ACTUALIZACIÓN EN INTERVENCIÓN', @ID_Intervencion);
END;
GO

-- Trigger al eliminar una Intervencion
DROP TRIGGER IF EXISTS TR_EliminarIntervencion;
GO
CREATE TRIGGER TR_EliminarIntervencion
ON Intervencion AFTER DELETE
AS
BEGIN
    DECLARE @ID_Usuario INT;
    DECLARE @ID_Intervencion INT;
    DECLARE @Correo_Usuario VARCHAR(60);

    SELECT @ID_Usuario = CONVERT(INT, SESSION_CONTEXT(N'user_id'));
    SELECT @ID_Intervencion = ID_Intervencion FROM deleted;
    SELECT @Correo_Usuario = Correo FROM Usuario WHERE ID_Usuario = @ID_Usuario;

    INSERT INTO HistorialAcciones (Fecha, IdUsuario, CorreoUsuario, Accion, IdRegistroModificado)
    VALUES (GETDATE(), @ID_Usuario, @Correo_Usuario, 'ELIMINACIÓN EN INTERVENCIÓN', @ID_Intervencion);
END;
GO
