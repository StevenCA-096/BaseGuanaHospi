use Guana_HospiDB
go
--Creacion de procedimientos almacenados para insertar informacion
--Procedimiento para insertar un paciente
drop procedure if exists SP_InsertarPaciente
go
create procedure SP_InsertarPaciente
@NumSeguro int,
@Nombre varchar (25),
@Apellido1 varchar (25) ,
@Apellido2 varchar (25) ,
@Edad int ,
@Fecha_Ingreso datetime
as
begin
	begin tran
		insert into Paciente values(@NumSeguro,@Nombre,@Apellido1,@Apellido2,@Edad,@Fecha_Ingreso)
	commit tran
end
go
--Procedimiento para insertar Unidad
drop procedure if exists SP_InsertarUnidad
go
create procedure SP_InsertarUnidad
@Codigo int,
@Nombre varchar (30),
@Planta int,
@Id_Doctor int
as
begin
	begin tran
	insert into Unidad values(@Codigo,@Nombre,@Planta,@Id_Doctor)
	commit tran
end
go
--Procedimiento para insertar Paciente_Unidad
drop procedure if exists SP_InsertarPaciente_Unidad
go
create procedure SP_InsertarPaciente_Unidad
@IdPaciente int,
@Id_Unidad int,
@Fecha_Ingreso datetime,
@Fecha_Salida datetime
as
begin 
	begin tran
	insert into Paciente_Unidad values(@IdPaciente,@Id_Unidad,@Fecha_Ingreso,@Fecha_Salida)
	commit tran
end
go
--Crear procedimiento para insertar en tabla doctor
drop procedure if exists SP_InsertarDoctor
go
create procedure SP_InsertarDoctor
@Codigo int,
@Nombre varchar(25),
@Apellido1 varchar(25),
@Apellido2 varchar(25),
@Id_Especialidad int
as
begin 
	begin tran
	insert into Doctor values(@Codigo,@Nombre,@Apellido1,@Apellido2,@Id_Especialidad)
	commit tran
end
go
--Crear procedimiento para insertar en tabla especialidad
drop procedure if exists SP_InsertarEspecialidad
go
create procedure SP_InsertarEspecialidad
@Nombre varchar(30)
as
begin
	begin tran
	insert into Especialidad values(@Nombre)
	commit tran
end
go
--Crear procedimiento para insertar en tabla Intervencion
drop procedure if exists SP_InsertarIntervencion
go
create procedure SP_InsertarIntervencion
@FechaIntervencion datetime,
@Prescripcion varchar (50),
@ID_TipoIntervencion int,
@ID_Enfermedad int,
@ID_Paciente int,
@ID_Doctor int
as
begin
	begin tran
	insert into Intervencion 
	values(@FechaIntervencion,@Prescripcion,@ID_TipoIntervencion,@ID_Enfermedad,@ID_Paciente,@ID_Doctor)
	commit tran
end
go
--Crear procedimiento para insertar en tabla tipo Intervencion
drop procedure if exists SP_InsertarTipoIntervencion
go
create procedure SP_InsertarTipoIntervencion
@Nombre varchar(25)
as
begin
	begin tran
	insert into TipoIntervencion values(@Nombre)
	commit tran
end
go
--Crear procedimiento para insertar en tabla Enfermedad
drop procedure if exists SP_InsertarEnfermedad
go
create procedure SP_InsertarEnfermedad
@Nombre varchar(25)
as
begin
	begin tran
	insert into Enfermedad values(@Nombre)
	commit tran
end
go
--Insertar en tabla enfermedad sintoma
drop procedure if exists SP_InsertarEnfermedad_Sintoma
go
create procedure SP_InsertarEnfermedad_Sintoma
@Id_Enfermedad int,
@Id_Sintoma int
as
begin
	begin tran
	insert into Enfermedad_Sintoma values(@Id_Enfermedad,@Id_Sintoma)
	commit tran
end
go
--Crear procedimiento para insertar en tabla Sintoma
drop procedure if exists SP_InsertarSintoma
go
create procedure SP_InsertarSintoma
@Nombre varchar(25)
as
begin
	begin tran
	insert into Sintoma values(@Nombre)
	commit tran
end
go
--Crear procedimiento para insertar en tabla usuario
drop procedure if exists SP_InsertarUsuario
go
create procedure SP_InsertarUsuario
@Correo varchar(60),
@Contra varchar(16),
@Id_Rol int
as
begin
	begin tran
	insert into Usuario values(@Correo,@Contra,@Id_Rol)
	commit tran
end
go
--Crear procedimiento para insertar en tabla rol
drop procedure if exists SP_InsertarRol
go
create procedure SP_InsertarRol
@Nombre varchar(25)
as
begin
	begin tran
	insert into Rol values(@Nombre)
	commit tran
end
go

--Fin