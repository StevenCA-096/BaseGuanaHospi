--Procedimientos para actualizar la informacion
use Guana_HospiDB
go

--Actualizar una enfermedad
drop procedure if exists SP_ActualizarEnfermedad
go
create procedure SP_ActualizarEnfermedad
@IdEnfermedad int,
@Nombre varchar(25)
as
begin
	begin tran
	update Enfermedad
	set Nombre = @Nombre 
	where ID_Enfermedad = @IdEnfermedad
	commit tran
end
go

--Actualizar EnfermedadSintoma
drop procedure if exists SP_ActualizarEnfermedadSintoma
go
create procedure SP_ActualizarEnfermedadSintoma
@IdEnfermedadSintoma int,
@IdEnfermedad int,
@IdSintoma int
as
begin
	begin tran
	update Enfermedad_Sintoma
	set ID_Enfermedad = @IdEnfermedad, ID_Sintoma = @IdSintoma
	where ID_Enfermedad_Sintoma = @IdEnfermedadSintoma
	commit tran
end
go

--Actualizar un sintoma
drop procedure if exists SP_ActualizarSintoma
go
create procedure SP_ActualizarSintoma
@IdSintoma int,
@Nombre varchar(25)
as
begin
	begin tran
	update Sintoma
	set Nombre = @Nombre 
	where ID_Sintoma = @IdSintoma
	commit tran
end
go

--Actualizar un sintoma
drop procedure if exists SP_ActualizarIntervencion
go
create procedure SP_ActualizarIntervencion
@IdIntervencion int,
@FechaIntervencion datetime,
@prescripcion varchar(50),
@IdTipoIntervencion int,
@IdEnfermedad int,
@IdPaciente int,
@Id_Doctor int
as
begin
	begin tran
	update Intervencion
	set 
		Fecha_Intervencion = @FechaIntervencion,
		prescripcion = @prescripcion,
		Id_TipoIntervencion = @IdTipoIntervencion,
		Id_Enfermedad = @IdEnfermedad,
		Id_Paciente = @IdPaciente,
		Id_Doctor = @Id_Doctor
	where  ID_Intervencion = @IdIntervencion
	commit tran
end
go

--Actualizar TipoIntervencion
drop procedure if exists SP_ActualizarTipoIntervencion
go
create procedure SP_ActualizarTipoIntervencion
@IdTipoIntervencion int,
@Nombre varchar(25)
as
begin
	begin tran
	update TipoIntervencion
	set Nombre = @Nombre 
	where ID_TipoIntervencion = @IdTipoIntervencion
	commit tran
end
go

--Actualizar TipoRol
drop procedure if exists SP_ActualizarRol
go
create procedure SP_ActualizarRol
@IdRol int,
@Nombre varchar(25)
as
begin
	begin tran
	update Rol
	set Nombre = @Nombre 
	where ID_Rol = @IdRol
	commit tran
end
go

--Actualizar Especialidad
drop procedure if exists SP_ActualizarEspecialidad
go
create procedure SP_ActualizarEspecialidad
@IdEspecialidad int,
@Nombre varchar(30)
as
begin
	begin tran
	update Especialidad
	set Nombre = @Nombre 
	where ID_Especialidad = @IdEspecialidad
	commit tran
end
go

--Actualizar unidad
drop procedure if exists SP_ActualizarUnidad
go
create procedure SP_ActualizarUnidad
@IdUnidad int,
@codigo int,
@nombre varchar(25),
@Planta int,
@IdDoctor int
as
begin
	begin tran
	update Unidad
	set 
	Codigo = @codigo, 
	Nombre = @nombre, 
	Planta = @Planta,
	Id_Doctor =@IdDoctor
	where @IdUnidad = @IdUnidad
	commit tran
end
go

--Actualizar paciente
drop procedure if exists SP_ActualizarPaciente
go
create procedure SP_ActualizarPaciente
@IdPaciente int,
@NumSeguro int,
@Nombre varchar (25),
@Apellido1 varchar(25),
@Apellido2 varchar (25),
@Edad int,
@FechaIngreso datetime
as
begin
	begin tran
	update Paciente
	set 
	NumSeguro = @NumSeguro,
	Nombre = @Nombre,
	Apellido1 = @Apellido1,
	Apellido2 = @Apellido2,
	Edad = @Edad,
	Fecha_Ingreso = @FechaIngreso
	where ID_Paciente = @IdPaciente
	commit tran
end
go

--Actualizar Doctor
drop procedure if exists SP_ActualizarDoctor
go
create procedure SP_ActualizarDoctor
@IdDoctor int,
@Codigo int,
@Nombre varchar(25),
@Apellido1 varchar(25),
@Apellido2 varchar (25),
@IdEspecialidad int
as
begin
	begin tran
	update Doctor
	set 
	Codigo = @Codigo,
	Nombre = @Nombre ,
	Apellido1 = @Apellido1,
	Apellido2 = @Apellido2,
	ID_Especialidad = @IdEspecialidad
	where ID_Doctor = @IdDoctor
	commit tran
end
go
--Actualizar PacienteUnidad
drop procedure if exists SP_ActualizarPacienteUnidad
go
create procedure SP_ActualizarPacienteUnidad
@IdPacienteUnidad int,
@IdPaciente int,
@IdUnidad int,
@FechaIngreso datetime,
@FechaSalida datetime
as
begin
	begin tran
	update Paciente_Unidad
	set 
	Id_Paciente = @IdPaciente,
	Id_Unidad = @IdUnidad,
	Fecha_Ingreso = @FechaIngreso,
	Fecha_Salida = @FechaSalida
	where ID_Paciente_Unidad = @IdPacienteUnidad
	commit tran
end
go
