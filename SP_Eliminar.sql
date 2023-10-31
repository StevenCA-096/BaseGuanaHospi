--Procedimientos para eliminar archivos.
use Guana_HospiDB
go
--Eliminar un doctor
drop procedure if exists SP_EliminarDoctor
go
create procedure SP_EliminarDoctor
@IdDoctor varchar(25) 
as

 if (@IdDoctor is null or @IdDoctor ='')
    begin
        print 'Por favor ingrese el identificador del Doctor'
    end

    else if (PATINDEX('%[a-zA-Z]%', @IdDoctor) > 0)

    begin
        print 'El identificador del Doctor contiene caracteres inválidos'
    end


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
go

-- Eliminar una Especialidad
drop procedure if exists SP_EliminarEspecialidad
go
create procedure SP_EliminarEspecialidad
@IdEspecialidad int
as
begin
    if (@IdEspecialidad is null or @IdEspecialidad = '')
    begin
        print 'Por favor ingrese el identificador de la Especialidad'
    end

    else if (PATINDEX('%[a-zA-Z]%', CAST(@IdEspecialidad AS varchar(25))) > 0)
    begin
        print 'El identificador de la Especialidad contiene caracteres inválidos'
    end

    if exists(select ID_Especialidad from Especialidad where ID_Especialidad = @IdEspecialidad)
    begin
        begin tran
        delete from Especialidad where ID_Especialidad = @IdEspecialidad;
        commit tran
        print 'Se eliminó la Especialidad con el ID indicado'
    end
    else
    begin
        print 'No existe una Especialidad con el ID ingresado'
    end
end
go

-- Eliminar un paciente
drop procedure if exists SP_EliminarPaciente
go
create procedure SP_EliminarPaciente
@IdPaciente int
as
begin
    if (@IdPaciente is null or @IdPaciente = '')
    begin
        print 'Por favor ingrese el identificador del Paciente'
    end

    else if (PATINDEX('%[a-zA-Z]%', CAST(@IdPaciente AS varchar(25))) > 0)
    begin
        print 'El identificador del Paciente contiene caracteres inválidos'
    end

    if exists(select ID_Paciente from Paciente where ID_Paciente = @IdPaciente)
    begin
        begin tran
        delete from Paciente where ID_Paciente = @IdPaciente;
        commit tran
        print 'Se eliminó el Paciente con el ID indicado'
    end
    else
    begin
        print 'No existe un Paciente con el ID ingresado'
    end
end
go

-- Eliminar un Síntoma
drop procedure if exists SP_EliminarSintoma
go
create procedure SP_EliminarSintoma
@IdSintoma int
as
begin
    if (@IdSintoma is null or @IdSintoma = '')
    begin
        print 'Por favor ingrese el identificador del Síntoma'
    end

    else if (PATINDEX('%[a-zA-Z]%', CAST(@IdSintoma AS varchar(25))) > 0)
    begin
        print 'El identificador del Síntoma contiene caracteres inválidos'
    end

    if exists(select ID_Sintoma from Sintoma where ID_Sintoma = @IdSintoma)
    begin
        begin tran
        delete from Sintoma where ID_Sintoma = @IdSintoma;
        commit tran
        print 'Se eliminó el Síntoma con el ID indicado'
    end
    else
    begin
        print 'No existe un Síntoma con el ID ingresado'
    end
end
go

-- Eliminar una Enfermedad
drop procedure if exists SP_EliminarEnfermedad
go
create procedure SP_EliminarEnfermedad
@IdEnfermedad int
as
begin
    if (@IdEnfermedad is null or @IdEnfermedad = '')
    begin
        print 'Por favor ingrese el identificador de la Enfermedad'
    end

    else if (PATINDEX('%[a-zA-Z]%', CAST(@IdEnfermedad AS varchar(25))) > 0)
    begin
        print 'El identificador de la Enfermedad contiene caracteres inválidos'
    end

    if exists(select ID_Enfermedad from Enfermedad where ID_Enfermedad = @IdEnfermedad)
    begin
        begin tran
        delete from Enfermedad where ID_Enfermedad = @IdEnfermedad;
        commit tran
        print 'Se eliminó la Enfermedad con el ID indicado'
    end
    else
    begin
        print 'No existe una Enfermedad con el ID ingresado'
    end
end
go

-- Eliminar una relación Enfermedad-Síntoma
drop procedure if exists SP_EliminaEnfermedadSintoma
go
create procedure SP_EliminaEnfermedadSintoma
@IdEnfermedadSintoma int
as
begin
    if (@IdEnfermedadSintoma is null or @IdEnfermedadSintoma = '')
    begin
        print 'Por favor ingrese el identificador del registro'
    end

    else if (PATINDEX('%[a-zA-Z]%', CAST(@IdEnfermedadSintoma AS varchar(25))) > 0)
    begin
        print 'El identificador del registro contiene caracteres inválidos'
    end

    if exists(select ID_Enfermedad_Sintoma from Enfermedad_Sintoma where ID_Enfermedad_Sintoma = @IdEnfermedadSintoma)
    begin
        begin tran
        delete from Enfermedad_Sintoma where ID_Enfermedad_Sintoma = @IdEnfermedadSintoma;
        commit tran
        print 'Se eliminó el registro con el ID indicado'
    end
    else
    begin
        print 'El registro no existe'
    end
end
go

-- Eliminar una Intervencion
drop procedure if exists SP_EliminaIntervencion
go
create procedure SP_EliminaIntervencion
@IdIntervencion int 
as
begin
    if (@IdIntervencion is null or @IdIntervencion = '')
    begin
        print 'Por favor ingrese el identificador de la Intervencion'
    end

    else if (PATINDEX('%[a-zA-Z]%', CAST(@IdIntervencion AS varchar(25))) > 0)
    begin
        print 'El identificador de la Intervencion contiene caracteres inválidos'
    end

    if exists(select ID_Intervencion from Intervencion where ID_Intervencion = @IdIntervencion)
    begin
        begin tran
        delete from Intervencion where ID_Intervencion = @IdIntervencion;
        commit tran
        print 'Se eliminó la Intervencion con el ID indicado'
    end
    else
    begin
        print 'No existe una Intervencion con el ID ingresado'
    end
end
go

-- Eliminar una relación Paciente_Unidad
drop procedure if exists SP_EliminarPacienteUnidad
go
create procedure SP_EliminarPacienteUnidad
@IdPacienteUnidad int 
as
begin
    if (@IdPacienteUnidad is null or @IdPacienteUnidad = '')
    begin
        print 'Por favor ingrese el identificador del registro'
    end

    else if (PATINDEX('%[a-zA-Z]%', CAST(@IdPacienteUnidad AS varchar(25))) > 0)
    begin
        print 'El identificador del registro contiene caracteres inválidos'
    end

    if exists(select ID_Paciente_Unidad from Paciente_Unidad where ID_Paciente_Unidad = @IdPacienteUnidad)
    begin
        begin tran
        delete from Paciente_Unidad where ID_Paciente_Unidad = @IdPacienteUnidad;
        commit tran
        print 'Se eliminó el registro con el ID indicado'
    end
    else
    begin
        print 'No existe un registro con el ID ingresado'
    end
end
go

-- Eliminar un Rol
drop procedure if exists SP_EliminarRol
go
create procedure SP_EliminarRol
@IdRol int 
as
begin
    if (@IdRol is null or @IdRol = '')
    begin
        print 'Por favor ingrese el identificador del Rol'
    end

    else if (PATINDEX('%[a-zA-Z]%', CAST(@IdRol AS varchar(25))) > 0)
    begin
        print 'El identificador del Rol contiene caracteres inválidos'
    end

    if exists(select ID_Rol from Rol where ID_Rol = @IdRol)
    begin
        begin tran
        delete from Rol where ID_Rol = @IdRol;
        commit tran
        print 'Se eliminó el Rol con el ID indicado'
    end
    else
    begin
        print 'No existe un Rol con el ID ingresado'
    end
end
go

-- Eliminar un Tipo de Intervencion
drop procedure if exists SP_EliminarTipoIntervencion
go
create procedure SP_EliminarTipoIntervencion
@IdTipoIntervencion int 
as
begin
    if (@IdTipoIntervencion is null or @IdTipoIntervencion = '')
    begin
        print 'Por favor ingrese el identificador del Tipo de Intervencion'
    end

    else if (PATINDEX('%[a-zA-Z]%', CAST(@IdTipoIntervencion AS varchar(25))) > 0)
    begin
        print 'El identificador del Tipo de Intervencion contiene caracteres inválidos'
    end

    if exists(select ID_TipoIntervencion from TipoIntervencion where ID_TipoIntervencion = @IdTipoIntervencion)
    begin
        begin tran
        delete from TipoIntervencion where ID_TipoIntervencion = @IdTipoIntervencion;
        commit tran
        print 'Se eliminó el Tipo de Intervencion con el ID indicado'
    end
    else
    begin
        print 'No existe un Tipo de Intervencion con el ID ingresado'
    end
end
go

-- Eliminar una Unidad
drop procedure if exists SP_EliminarUnidad
go
create procedure SP_EliminarUnidad
@IdUnidad int 
as
begin
    if (@IdUnidad is null or @IdUnidad = '')
    begin
        print 'Por favor ingrese el identificador de la Unidad'
    end

    else if (PATINDEX('%[a-zA-Z]%', CAST(@IdUnidad AS varchar(25))) > 0)
    begin
        print 'El identificador de la Unidad contiene caracteres inválidos'
    end

    if exists(select ID_Unidad from Unidad where ID_Unidad = @IdUnidad)
    begin
        begin tran
        delete from Unidad where ID_Unidad = @IdUnidad;
        commit tran
        print 'Se eliminó la Unidad con el ID indicado'
    end
    else
    begin
        print 'No existe una Unidad con el ID ingresado'
    end
end
go

-- Eliminar un Usuario
drop procedure if exists SP_EliminarUsuario
go
create procedure SP_EliminarUsuario
@IdUsuario int 
as
begin
    if (@IdUsuario is null or @IdUsuario = '')
    begin
        print 'Por favor ingrese el identificador del Usuario'
    end

    else if (PATINDEX('%[a-zA-Z]%', CAST(@IdUsuario AS varchar(25))) > 0)
    begin
        print 'El identificador del Usuario contiene caracteres inválidos'
    end

    if exists(select ID_Usuario from Usuario where ID_Usuario = @IdUsuario)
    begin
        begin tran
        delete from Usuario where ID_Usuario = @IdUsuario;
        commit tran
        print 'Se eliminó el Usuario con el ID indicado'
    end
    else
    begin
        print 'No existe un Usuario con el ID ingresado'
    end
end
go
