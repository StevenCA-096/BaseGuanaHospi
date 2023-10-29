--Procedimientos para eliminar archivos.
use Guana_HospiDB
go
--Eliminar un doctor
drop procedure if exists SP_EliminarDoctor
go
create procedure SP_EliminarDoctor
@IdDoctor int 
as
begin
	if exists(select ID_Doctor from Doctor where ID_Doctor = @IdDoctor)
	begin
		begin tran
		delete from Doctor where ID_Doctor =  @IdDoctor;
		commit tran
		print 'Se elimino el doctor con el id indicado'
	end
	else
		begin
		print 'No existe un doctor con el id ingresado'
	end
end
exec SP_EliminarDoctor 1
go
--Eliminar un especialidad
drop procedure if exists SP_EliminarEspecialidad
go
create procedure SP_EliminarEspecialidad
@IdEspecialidad int 
as
begin
	begin tran
	delete from Especialidad where ID_Especialidad =  @IdEspecialidad;
	commit tran
end
go

--Eliminar un paciente
drop procedure if exists SP_EliminarPaciente
go
create procedure SP_EliminarPaciente
@IdPaciente int 
as
begin
	begin tran
	delete from Paciente where ID_Paciente =  @IdPaciente;
	commit tran
end
go

--Eliminar un Sintoma
drop procedure if exists SP_EliminarSintoma
go
create procedure SP_EliminarSintoma
@IdSintoma int 
as
begin
	begin tran
	delete from Sintoma where ID_Sintoma =  @IdSintoma;
	commit tran
end
go

--Eliminar una enfermedad
drop procedure if exists SP_EliminarEnfermedad
go
create procedure SP_EliminarEnfermedad
@IdEnfermedad int 
as
begin
	begin tran
	delete from Enfermedad where ID_Enfermedad =  @IdEnfermedad;
	commit tran
end
go

--Eliminar Enfermedad_Sintoma
drop procedure if exists SP_EliminaEnfermedadSintoma
go
create procedure SP_EliminaEnfermedadSintoma
@IdEnfermedadSintoma int 
as
begin
	begin tran
	delete from Enfermedad_Sintoma where ID_Enfermedad_Sintoma =  @IdEnfermedadSintoma;
	commit tran
end
go

--Eliminar una Intervencion
drop procedure if exists SP_EliminaIntervencion
go
create procedure SP_EliminaIntervencion
@IdIntervencion int 
as
begin
	begin tran
	delete from Intervencion where ID_Intervencion =  @IdIntervencion;
	commit tran
end
go

--Eliminar Paciente_Unidad
drop procedure if exists SP_EliminarPacienteUnidad
go
create procedure SP_EliminarPacienteUnidad
@IdPacienteUnidad int 
as
begin
	begin tran
	delete from Paciente_Unidad where ID_Paciente_Unidad=  @IdPacienteUnidad;
	commit tran
end
go

--Eliminar rol
drop procedure if exists SP_EliminarRol
go
create procedure SP_EliminarRol
@IdRol int 
as
begin
	begin tran
	delete from Rol where ID_Rol=  @IdRol;
	commit tran
end
go
--Eliminar tipo intervencion
drop procedure if exists SP_EliminarTipoIntervencion
go
create procedure SP_EliminarTipoIntervencion
@IdTipoIntervencion int 
as
begin
	begin tran
	delete from TipoIntervencion where ID_TipoIntervencion = @IdTipoIntervencion;
	commit tran
end
go
--Eliminar tipo intervencion
drop procedure if exists SP_EliminarUnidad
go
create procedure SP_EliminarUnidad
@IdUnidad int 
as
begin
	begin tran
	delete from Unidad where ID_Unidad = @IdUnidad;
	commit tran
end
go
--Eliminar tipo intervencion
drop procedure if exists SP_EliminarUsuario
go
create procedure SP_EliminarUsuario
@IdUsuario int 
as
begin
	begin tran
	delete from Usuario where ID_Usuario = @IdUsuario;
	commit tran
end
go
