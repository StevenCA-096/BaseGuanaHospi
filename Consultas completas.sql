--Consultas por todos los datos.
use Guana_HospiDB
go
--Obtener las especialidades
drop procedure if exists Sp_ObtenerEspecialidades
go
create procedure Sp_ObtenerEspecialidades
as
begin
select * from Especialidad
end
go
--
--Obtener los sintomas
drop procedure if exists Sp_ObtenerSintomas
go
create procedure Sp_ObtenerSintomas
as
begin
select * from Sintoma
end
go
--
--Obtener las enfermedades
drop procedure if exists Sp_ObtenerEnfermedades
go
create procedure Sp_ObtenerEnfermedades
as
begin
select * from Enfermedad
end
go
--
--Obtener las enfermedades
drop procedure if exists Sp_ObtenerEnfermedadSintoma
go
create procedure Sp_ObtenerEnfermedadSintoma
as
begin
select * from Enfermedad_Sintoma
end
go
--
--Obtener los pacientes
drop procedure if exists Sp_ObtenerPacientes
go
create procedure Sp_ObtenerPacientes
as
begin
select * from Paciente
end
go
--
--Obtener los doctores
drop procedure if exists Sp_ObtenerDoctores
go
create procedure Sp_ObtenerDoctores
as
begin
select * from Doctor
end
go
--
--Obtener los pacientes
drop procedure if exists Sp_ObtenerUnidad
go
create procedure Sp_ObtenerUnidad
as
begin
select * from Unidad
end
go
--
--Obtener PacienteUnidad
drop procedure if exists Sp_ObtenerPacienteUnidad
go
create procedure Sp_ObtenerPacienteUnidad
as
begin
select * from Paciente_Unidad
end
go
--
--Obtener las intervenciones
drop procedure if exists Sp_ObtenerIntervenciones
go
create procedure Sp_ObtenerIntervenciones
as
begin
select * from Intervencion
end
go
--
--Obtener los tipos de intervencion
drop procedure if exists Sp_ObtenerTipoIntervencion
go
create procedure Sp_ObtenerTipoIntervencion
as
begin
select * from TipoIntervencion
end
go
--
--Obtener los roles
drop procedure if exists Sp_ObtenerRoles
go
create procedure Sp_ObtenerRoles
as
begin
select * from Rol
end
go
--
--Obtener los usuarios
drop procedure if exists Sp_ObtenerUsuarios
go
create procedure Sp_ObtenerUsuarios
as
begin
select * from Enfermedad
end
go
--
