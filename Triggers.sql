--Contexto para conocer a los usuarios
drop procedure if exists SP_Contexto
go
create procedure SP_Contexto (@IdUsuario decimal(18, 0)) as
begin
declare @contextInfo varbinary(128);
set @contextInfo = cast(@IdUsuario AS varbinary(128));
set CONTEXT_INFO @contextInfo;
end
go

--Triggers para registro de acciones

use Guana_HospiDB
go

--Creacion de tabla para guardar datos de triggers
drop table if exists HistorialAcciones
go
create table HistorialAcciones
(
ID_Accion int IDENTITY(1,1) PRIMARY KEY,
ID_Usuario int not null,
ID_Registro int not null,
Fecha datetime not null,
Descripcion varchar(300) not null
)
go

--Llave foranea con usuario
alter table HistorialAcciones
Add constraint FK_HistorialAcciones_Usuario
FOREIGN KEY (ID_Usuario)
references Usuario (ID_Usuario)
go

--Triggers de Doctor

--Trigger al insertar un doctor
drop trigger if exists TR_InsertarDoctor
go
create trigger TR_InsertarDoctor 
on Doctor after insert
as
begin
        declare @ID_Usuario int
        declare @ID_Doctor int
		declare @Correo_Usuario varchar(60)
        select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));  
        select @ID_Doctor = ID_Doctor from inserted
		select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

        insert into HistorialAcciones(ID_Usuario,ID_Registro,Fecha,Descripcion)
        values (@ID_Usuario, @ID_Doctor, getdate(), 
		'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: INSERCIÓN EN DOCTOR.' + ' ID REGISTRO INSERTADO: ' + cast(@ID_Doctor as varchar) + 
		'. FECHA ACCIÓN: ' + Convert(varchar(40),getdate())
        )
end
go

--Trigger al actualizar un doctor
drop trigger if exists TR_ActualizarDoctor
go
create trigger TR_ActualizarDoctor 
on Doctor after update
as
begin
    declare @ID_Usuario int
    declare @ID_Doctor int
    declare @Correo_Usuario varchar(60)
    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Doctor = ID_Doctor from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Doctor, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ACTUALIZACIÓN EN DOCTOR.' + ' ID REGISTRO ACTUALIZADO: ' + cast(@ID_Doctor as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al eliminar un doctor
drop trigger if exists TR_EliminarDoctor
go
create trigger TR_EliminarDoctor 
on Doctor after delete
as
begin
    declare @ID_Usuario int
    declare @ID_Doctor int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Doctor = ID_Doctor from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Doctor, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ELIMINACIÓN EN DOCTOR.' + ' ID REGISTRO ELIMINADO: ' + cast(@ID_Doctor as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Triggers de Enfermedad

--Trigger al insertar una Enfermedad
drop trigger if exists TR_InsertarEnfermedad
go
create trigger TR_InsertarEnfermedad
on Enfermedad after insert
as
begin
        declare @ID_Usuario int
        declare @ID_Enfermedad int
		declare @Correo_Usuario varchar(60)

        select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
        select @ID_Enfermedad = ID_Enfermedad from inserted
		select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

        insert into HistorialAcciones(ID_Usuario,ID_Registro,Fecha,Descripcion)
        values (@ID_Usuario, @ID_Enfermedad, getdate(), 
		'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: INSERCIÓN EN ENFERMEDAD.' + ' ID REGISTRO INSERTADO: ' + cast(@ID_Enfermedad as varchar) + 
		'. FECHA ACCIÓN: ' + Convert(varchar(40),getdate())
        )
end
go

--Trigger al actualizar una Enfermedad
drop trigger if exists TR_ActualizarEnfermedad
go
create trigger TR_ActualizarEnfermedad 
on Enfermedad after update
as
begin
    declare @ID_Usuario int
    declare @ID_Enfermedad int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Enfermedad = ID_Enfermedad from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Enfermedad, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ACTUALIZACIÓN EN ENFERMEDAD.' + ' ID REGISTRO ACTUALIZADO: ' + cast(@ID_Enfermedad as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al eliminar una Enfermedad
drop trigger if exists TR_EliminarEnfermedad
go
create trigger TR_EliminarEnfermedad 
on Enfermedad after delete
as
begin
    declare @ID_Usuario int
    declare @ID_Enfermedad int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Enfermedad = ID_Enfermedad from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Enfermedad, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ELIMINACIÓN EN ENFERMEDAD.' + ' ID REGISTRO ELIMINADO: ' + cast(@ID_Enfermedad as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Triggers de Sintoma

--Trigger al insertar un Sintoma
drop trigger if exists TR_InsertarSintoma
go
create trigger TR_InsertarSintoma
on Sintoma after insert
as
begin
        declare @ID_Usuario int
        declare @ID_Sintoma int
		declare @Correo_Usuario varchar(60)

        select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
        select @ID_Sintoma = ID_Sintoma from inserted
		select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

        insert into HistorialAcciones(ID_Usuario,ID_Registro,Fecha,Descripcion)
        values (@ID_Usuario, @ID_Sintoma, getdate(), 
		'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: INSERCIÓN EN SÍNTOMA.' + ' ID REGISTRO INSERTADO: ' + cast(@ID_Sintoma as varchar) + 
		'. FECHA ACCIÓN: ' + Convert(varchar(40),getdate())
        )
end
go

--Trigger al actualizar una Sintoma
drop trigger if exists TR_ActualizarSintoma
go
create trigger TR_ActualizarSintoma 
on Sintoma after update
as
begin
    declare @ID_Usuario int
    declare @ID_Sintoma int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Sintoma = ID_Sintoma from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Sintoma, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ACTUALIZACIÓN EN SÍNTOMA.' + ' ID REGISTRO ACTUALIZADO: ' + cast(@ID_Sintoma as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al eliminar una Sintoma
drop trigger if exists TR_EliminarSintoma
go
create trigger TR_EliminarSintoma
on Sintoma after delete
as
begin
    declare @ID_Usuario int
    declare @ID_Sintoma int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Sintoma = ID_Sintoma from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Sintoma, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ELIMINACIÓN EN SÍNTOMA.' + ' ID REGISTRO ELIMINADO: ' + cast(@ID_Sintoma as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Triggers de Especialidad

--Trigger al insertar una Especialidad
drop trigger if exists TR_InsertarEspecialidad
go
create trigger TR_InsertarEspecialidad
on Especialidad after insert
as
begin
    declare @ID_Usuario int
    declare @ID_Especialidad int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Especialidad = ID_Especialidad from inserted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Especialidad, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: INSERCIÓN EN ESPECIALIDAD.' + ' ID REGISTRO INSERTADO: ' + cast(@ID_Especialidad as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al actualizar una Especialidad
drop trigger if exists TR_ActualizarEspecialidad
go
create trigger TR_ActualizarEspecialidad
on Especialidad after update
as
begin
    declare @ID_Usuario int
    declare @ID_Especialidad int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Especialidad = ID_Especialidad from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Especialidad, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ACTUALIZACIÓN EN ESPECIALIDAD.' + ' ID REGISTRO ACTUALIZADO: ' + cast(@ID_Especialidad as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al eliminar una Especialidad
drop trigger if exists TR_EliminarEspecialidad
go
create trigger TR_EliminarEspecialidad
on Especialidad after delete
as
begin
    declare @ID_Usuario int
    declare @ID_Especialidad int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Especialidad = ID_Especialidad from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Especialidad, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ELIMINACIÓN EN ESPECIALIDAD.' + ' ID REGISTRO ELIMINADO: ' + cast(@ID_Especialidad as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Triggers de Intervencion

--Trigger al insertar una Intervencion
drop trigger if exists TR_InsertarIntervencion
go
create trigger TR_InsertarIntervencion
on Intervencion after insert
as
begin
    declare @ID_Usuario int
    declare @ID_Intervencion int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Intervencion = ID_Intervencion from inserted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Intervencion, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: INSERCIÓN EN INTERVENCIÓN.' + ' ID REGISTRO INSERTADO: ' + cast(@ID_Intervencion as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go	

--Trigger al actualizar una Intervencion
drop trigger if exists TR_ActualizarIntervencion
go
create trigger TR_ActualizarIntervencion
on Intervencion after update
as
begin
    declare @ID_Usuario int
    declare @ID_Intervencion int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Intervencion = ID_Intervencion from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Intervencion, getdate(),'ACTUALIZACION A INTERVENCION')
end
go

--Trigger al eliminar una Intervencion
drop trigger if exists TR_EliminarIntervencion
go
create trigger TR_EliminarIntervencion
on Intervencion after delete
as
begin
    declare @ID_Usuario int
    declare @ID_Intervencion int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Intervencion = ID_Intervencion from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Intervencion, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ELIMINACIÓN EN INTERVENCIÓN.' + ' ID REGISTRO ELIMINADO: ' + cast(@ID_Intervencion as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Triggers de Paciente

--Trigger al insertar un Paciente
drop trigger if exists TR_InsertarPaciente
go
create trigger TR_InsertarPaciente
on Paciente after insert
as
begin
    declare @ID_Usuario int
    declare @ID_Paciente int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Paciente = ID_Paciente from inserted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Paciente, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: INSERCIÓN EN PACIENTE.' + ' ID REGISTRO INSERTADO: ' + cast(@ID_Paciente as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al actualizar un Paciente
drop trigger if exists TR_ActualizarPaciente
go
create trigger TR_ActualizarPaciente
on Paciente after update
as
begin
    declare @ID_Usuario int
    declare @ID_Paciente int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Paciente = ID_Paciente from inserted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Paciente, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ACTUALIZACIÓN EN PACIENTE.' + ' ID REGISTRO ACTUALIZADO: ' + cast(@ID_Paciente as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al eliminar un Paciente
drop trigger if exists TR_EliminarPaciente
go
create trigger TR_EliminarPaciente
on Paciente after delete
as
begin
    declare @ID_Usuario int
    declare @ID_Paciente int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Paciente = ID_Paciente from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Paciente, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ELIMINACIÓN EN PACIENTE.' + ' ID REGISTRO ELIMINADO: ' + cast(@ID_Paciente as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Triggers de Rol

--Trigger al insertar un Rol
drop trigger if exists TR_InsertarRol
go
create trigger TR_InsertarRol
on Rol after insert
as
begin
    declare @ID_Usuario int
    declare @ID_Rol int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Rol = ID_Rol from inserted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Rol, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: INSERCIÓN EN ROL.' + ' ID REGISTRO INSERTADO: ' + cast(@ID_Rol as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al actualizar un Rol
drop trigger if exists TR_ActualizarRol
go
create trigger TR_ActualizarRol
on Rol after update
as
begin
    declare @ID_Usuario int
    declare @ID_Rol int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Rol = ID_Rol from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Rol, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ACTUALIZACIÓN EN ROL.' + ' ID REGISTRO ACTUALIZADO: ' + cast(@ID_Rol as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al eliminar un Rol
drop trigger if exists TR_EliminarRol
go
create trigger TR_EliminarRol
on Rol after delete
as
begin
    declare @ID_Usuario int
    declare @ID_Rol int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Rol = ID_Rol from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Rol, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ELIMINACIÓN EN ROL.' + ' ID REGISTRO ELIMINADO: ' + cast(@ID_Rol as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Triggers de TipoIntervencion

--Trigger al insertar un TipoIntervencion
drop trigger if exists TR_InsertarTipoIntervencion
go
create trigger TR_InsertarTipoIntervencion
on TipoIntervencion after insert
as
begin
    declare @ID_Usuario int
    declare @ID_TipoIntervencion int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_TipoIntervencion = ID_TipoIntervencion from inserted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_TipoIntervencion, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: INSERCIÓN EN TIPO INTERVENCIÓN.' + ' ID REGISTRO INSERTADO: ' + cast(@ID_TipoIntervencion as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al actualizar un TipoIntervencion
drop trigger if exists TR_ActualizarTipoIntervencion
go
create trigger TR_ActualizarTipoIntervencion
on TipoIntervencion after update
as
begin
    declare @ID_Usuario int
    declare @ID_TipoIntervencion int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_TipoIntervencion = ID_TipoIntervencion from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_TipoIntervencion, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ACTUALIZACIÓN EN TIPO INTERVENCIÓN.' + ' ID REGISTRO ACTUALIZADO: ' + cast(@ID_TipoIntervencion as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al eliminar un TipoIntervencion
drop trigger if exists TR_EliminarTipoIntervencion
go
create trigger TR_EliminarTipoIntervencion
on TipoIntervencion after delete
as
begin
    declare @ID_Usuario int
    declare @ID_TipoIntervencion int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_TipoIntervencion = ID_TipoIntervencion from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_TipoIntervencion, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ELIMINACIÓN EN TIPO INTERVENCIÓN.' + ' ID REGISTRO ELIMINADO: ' + cast(@ID_TipoIntervencion as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Triggers de Unidad

--Trigger al insertar una Unidad
drop trigger if exists TR_InsertarUnidad
go
create trigger TR_InsertarUnidad
on Unidad after insert
as
begin
    declare @ID_Usuario int
    declare @ID_Unidad int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Unidad = ID_Unidad from inserted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Unidad, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: INSERCIÓN EN UNIDAD.' + ' ID REGISTRO INSERTADO: ' + cast(@ID_Unidad as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al actualizar una Unidad
drop trigger if exists TR_ActualizarUnidad
go
create trigger TR_ActualizarUnidad
on Unidad after update
as
begin
    declare @ID_Usuario int
    declare @ID_Unidad int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Unidad = ID_Unidad from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Unidad, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ACTUALIZACIÓN EN UNIDAD.' + ' ID REGISTRO ACTUALIZADO: ' + cast(@ID_Unidad as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al eliminar una Unidad
drop trigger if exists TR_EliminarUnidad
go
create trigger TR_EliminarUnidad
on Unidad after delete
as
begin
    declare @ID_Usuario int
    declare @ID_Unidad int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_Unidad = ID_Unidad from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_Unidad, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ELIMINACIÓN EN UNIDAD.' + ' ID REGISTRO ELIMINADO: ' + cast(@ID_Unidad as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Triggers de Usuario

--Trigger al insertar un Usuario
drop trigger if exists TR_InsertarUsuario
go
create trigger TR_InsertarUsuario
on Usuario after insert
as
begin
    declare @ID_Usuario int
    declare @ID_UsuarioRegistrado int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_UsuarioRegistrado = ID_Usuario from inserted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_UsuarioRegistrado, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: INSERCIÓN EN USUARIO.' + ' ID REGISTRO INSERTADO: ' + cast(@ID_UsuarioRegistrado as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al actualizar un Usuario
drop trigger if exists TR_ActualizarUsuario
go
create trigger TR_ActualizarUsuario
on Usuario after update
as
begin
    declare @ID_Usuario int
    declare @ID_UsuarioActualizado int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_UsuarioActualizado = ID_Usuario from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_UsuarioActualizado, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ACTUALIZACIÓN EN USUARIO.' + ' ID REGISTRO ACTUALIZADO: ' + cast(@ID_UsuarioActualizado as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al eliminar un Usuario
drop trigger if exists TR_EliminarUsuario
go
create trigger TR_EliminarUsuario
on Usuario after delete
as
begin
    declare @ID_Usuario int
    declare @ID_UsuarioEliminado int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_UsuarioEliminado = ID_Usuario from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_UsuarioEliminado, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ELIMINACIÓN EN USUARIO.' + ' ID REGISTRO ELIMINADO: ' + cast(@ID_UsuarioEliminado as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Triggers de PacienteUnidad

--Trigger al insertar un PacienteUnidad
drop trigger if exists TR_InsertarPacienteUnidad
go
create trigger TR_InsertarPacienteUnidad
on Paciente_Unidad after insert
as
begin
    declare @ID_Usuario int
    declare @ID_PacienteUnidad int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_PacienteUnidad = ID_Paciente_Unidad from inserted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_PacienteUnidad, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: INSERCIÓN EN PACIENTE_UNIDAD.' + ' ID REGISTRO INSERTADO: ' + cast(@ID_PacienteUnidad as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al actualizar un PacienteUnidad
drop trigger if exists TR_ActualizarPacienteUnidad
go
create trigger TR_ActualizarPacienteUnidad
on Paciente_Unidad after update
as
begin
    declare @ID_Usuario int
    declare @ID_PacienteUnidad int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_PacienteUnidad = ID_Paciente_Unidad from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_PacienteUnidad, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ACTUALIZACIÓN EN PACIENTE_UNIDAD.' + ' ID REGISTRO ACTUALIZADO: ' + cast(@ID_PacienteUnidad as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al eliminar un PacienteUnidad
drop trigger if exists TR_EliminarPacienteUnidad
go
create trigger TR_EliminarPacienteUnidad
on Paciente_Unidad after delete
as
begin
    declare @ID_Usuario int
    declare @ID_PacienteUnidad int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_PacienteUnidad = ID_Paciente_Unidad from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_PacienteUnidad, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ELIMINACIÓN EN PACIENTE_UNIDAD.' + ' ID REGISTRO ELIMINADO: ' + cast(@ID_PacienteUnidad as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Triggers de EnfermedadSintoma

--Trigger al insertar un EnfermedadSintoma
drop trigger if exists TR_InsertarEnfermedadSintoma
go
create trigger TR_InsertarEnfermedadSintoma
on Enfermedad_Sintoma after insert
as
begin
    declare @ID_Usuario int
    declare @ID_EnfermedadSintoma int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_EnfermedadSintoma = ID_Enfermedad_Sintoma from inserted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_EnfermedadSintoma, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: INSERCIÓN EN ENFERMEDAD_SINTOMA.' + ' ID REGISTRO INSERTADO: ' + cast(@ID_EnfermedadSintoma as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al actualizar un EnfermedadSintoma
drop trigger if exists TR_ActualizarEnfermedadSintoma
go
create trigger TR_ActualizarEnfermedadSintoma
on Enfermedad_Sintoma after update
as
begin
    declare @ID_Usuario int
    declare @ID_EnfermedadSintoma int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_EnfermedadSintoma = ID_Enfermedad_Sintoma from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_EnfermedadSintoma, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ACTUALIZACIÓN EN ENFERMEDAD_SINTOMA.' + ' ID REGISTRO ACTUALIZADO: ' + cast(@ID_EnfermedadSintoma as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

--Trigger al eliminar un EnfermedadSintoma
drop trigger if exists TR_EliminarEnfermedadSintoma
go
create trigger TR_EliminarEnfermedadSintoma
on Enfermedad_Sintoma after delete
as
begin
    declare @ID_Usuario int
    declare @ID_EnfermedadSintoma int
    declare @Correo_Usuario varchar(60)

    select @ID_Usuario = convert(int,SESSION_CONTEXT(N'user_id'));
    select @ID_EnfermedadSintoma = ID_Enfermedad_Sintoma from deleted 
    select @Correo_Usuario = Correo from Usuario where ID_Usuario = @ID_Usuario

    insert into HistorialAcciones(ID_Usuario, ID_Registro, Fecha, Descripcion)
    values (@ID_Usuario, @ID_EnfermedadSintoma, getdate(), 
    'USUARIO: ' + @Correo_Usuario  + '. ACCIÓN: ELIMINACIÓN EN ENFERMEDAD_SINTOMA.' + ' ID REGISTRO ELIMINADO: ' + cast(@ID_EnfermedadSintoma as varchar) + 
    '. FECHA ACCIÓN: ' + Convert(varchar(40), getdate())
    )
end
go

