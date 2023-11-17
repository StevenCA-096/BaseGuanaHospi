--Procedimientos para actualizar la informacion
use Guana_HospiDB
go

--Actualizar una enfermedad
drop procedure if exists SP_ActualizarEnfermedad
go
create procedure SP_ActualizarEnfermedad
@IdEnfermedad varchar(25),
@Nombre varchar(25)
as

if(@IdEnfermedad = '' or @IdEnfermedad is null or 
   @Nombre = '' or @Nombre is null )
begin
	print 'Por favor ingrese todos los datos requeridos para actualizar la enfermedad'
end

else if (PATINDEX('%[a-zA-Z]%' , @IdEnfermedad) > 0 or
		 PATINDEX('%[^a-zA-Z]%', @Nombre) > 0)

begin
	print 'Los datos a ingresar contienen carácteres inválidos'
end

else if exists (select ID_Enfermedad from Enfermedad where ID_Enfermedad = @IdEnfermedad)
begin
	begin tran
	update Enfermedad
	set Nombre = @Nombre 
	where ID_Enfermedad = @IdEnfermedad
	commit tran
end

else

begin
	print 'La enfermedad no existe'
end
go

-- Actualizar EnfermedadSintoma
drop procedure if exists SP_ActualizarEnfermedadSintoma
go
create procedure SP_ActualizarEnfermedadSintoma
@IdEnfermedadSintoma int,
@IdEnfermedad int,
@IdSintoma int
as
begin
    if(@IdEnfermedadSintoma is null or @IdEnfermedadSintoma = '' or @IdEnfermedad is null or @IdEnfermedad ='' or @IdSintoma is null or @IdSintoma='')
    begin
        print 'Por favor ingrese todos los datos requeridos para actualizar el registro'
    end

    else if (PATINDEX('%[a-zA-Z]%', CAST(@IdEnfermedadSintoma AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@IdEnfermedad AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@IdSintoma AS varchar(25))) > 0)
    begin
        print 'Los datos a ingresar contienen carácteres inválidos'
    end

    else if exists (select ID_Enfermedad_Sintoma from Enfermedad_Sintoma where ID_Enfermedad_Sintoma = @IdEnfermedadSintoma)
    begin
        begin tran
        update Enfermedad_Sintoma
        set ID_Enfermedad = @IdEnfermedad, ID_Sintoma = @IdSintoma
        where ID_Enfermedad_Sintoma = @IdEnfermedadSintoma
        commit tran
        print 'Se actualizó el registro'
    end
    else
    begin
        print 'El registro no existe'
    end
end
go

-- Actualizar Sintoma
drop procedure if exists SP_ActualizarSintoma
go
create procedure SP_ActualizarSintoma
@IdSintoma int,
@Nombre varchar(25)
as
begin
    if(@IdSintoma is null or @IdSintoma = '' or @Nombre is null or @Nombre='')
    begin
        print 'Por favor ingrese todos los datos requeridos para actualizar el Sintoma'
    end

    else if (PATINDEX('%[^a-zA-Z]%', @Nombre) > 0 or 
			 PATINDEX('%[a-zA-Z]%', CAST(@IdSintoma as varchar(25))) > 0)
    begin
        print 'Los datos a ingresar contienen carácteres inválidos'
    end

    else if exists (select ID_Sintoma from Sintoma where ID_Sintoma = @IdSintoma)
    begin
        begin tran
        update Sintoma
        set Nombre = @Nombre 
        where ID_Sintoma = @IdSintoma
        commit tran
        print 'Se actualizó el Sintoma con el ID indicado'
    end
    else
    begin
        print 'El Sintoma no existe'
    end
end
go

-- Actualizar Intervencion
drop procedure if exists SP_ActualizarIntervencion
go
create procedure SP_ActualizarIntervencion
@IdIntervencion int,
@FechaIntervencion datetime,
@Prescripcion varchar(50),
@IdTipoIntervencion int,
@IdEnfermedad int,
@IdPaciente int,
@Id_Doctor int
as
begin
    if(@IdIntervencion is null or @IdIntervencion ='' or @FechaIntervencion is null or @FechaIntervencion ='' or
	@Prescripcion is null or @Prescripcion ='' or @IdTipoIntervencion is null or @IdTipoIntervencion=''or @IdEnfermedad is null or @IdEnfermedad='' or 
	@IdPaciente is null or @IdPaciente ='' or @Id_Doctor is null or @Id_Doctor='')

    begin
        print 'Por favor ingrese todos los datos requeridos para actualizar la Intervencion'
    end

    else if (
			 PATINDEX('%[a-zA-Z]%', CAST(@IdIntervencion AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@IdTipoIntervencion AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@IdEnfermedad AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@IdPaciente AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@Id_Doctor AS varchar(25))) > 0)
    begin
        print 'Los datos a ingresar contienen carácteres inválidos'
    end

    else if exists (select ID_Intervencion from Intervencion where ID_Intervencion = @IdIntervencion)
    begin
        begin tran
        update Intervencion
        set 
        Fecha_Intervencion = @FechaIntervencion,
        prescripcion = @Prescripcion,
        Id_TipoIntervencion = @IdTipoIntervencion,
        Id_Enfermedad = @IdEnfermedad,
        Id_Paciente = @IdPaciente,
        Id_Doctor = @Id_Doctor
        where ID_Intervencion = @IdIntervencion
        commit tran
        print 'Se actualizó la Intervencion con el ID indicado'
    end
    else
    begin
        print 'La Intervencion no existe'
    end
end
go

-- Actualizar TipoIntervencion
drop procedure if exists SP_ActualizarTipoIntervencion
go
create procedure SP_ActualizarTipoIntervencion
@IdTipoIntervencion int,
@Nombre varchar(25)
as
begin
    if(@IdTipoIntervencion is null or @IdTipoIntervencion ='' or @Nombre is null or @Nombre='')
    begin
        print 'Por favor ingrese todos los datos requeridos para actualizar el Tipo de Intervencion'
    end

    else if (
			 PATINDEX('%[a-zA-Z]%', CAST(@IdTipoIntervencion AS varchar(25))) > 0 or
			 PATINDEX('%[^a-zA-Z]%', @Nombre) > 0 )	
    begin
        print 'Los datos a ingresar contienen carácteres inválidos'
    end

    else if exists (select ID_TipoIntervencion from TipoIntervencion where ID_TipoIntervencion = @IdTipoIntervencion)
    begin
        begin tran
        update TipoIntervencion
        set Nombre = @Nombre 
        where ID_TipoIntervencion = @IdTipoIntervencion
        commit tran
        print 'Se actualizó el Tipo de Intervencion con el ID indicado'
    end
    else
    begin
        print 'El Tipo de Intervencion no existe'
    end
end
go

-- Actualizar Rol
drop procedure if exists SP_ActualizarRol
go
create procedure SP_ActualizarRol
@IdRol int,
@Nombre varchar(25)
as
begin
    if(@IdRol is null or @IdRol='' or @Nombre is null or @Nombre='')
    begin
        print 'Por favor ingrese todos los datos requeridos para actualizar el Rol'
    end

     else if (
			 PATINDEX('%[a-zA-Z]%', CAST(@IdRol AS varchar(25))) > 0 or
			 PATINDEX('%[^a-zA-Z]%', @Nombre) > 0 )	
    begin
        print 'Los datos a ingresar contienen carácteres inválidos'
    end

    else if exists (select ID_Rol from Rol where ID_Rol = @IdRol)
    begin
        begin tran
        update Rol
        set NombreR = @Nombre 
        where ID_Rol = @IdRol
        commit tran
        print 'Se actualizó el Rol con el ID indicado'
    end
    else
    begin
        print 'El Rol no existe'
    end
end
go

-- Actualizar Especialidad
drop procedure if exists SP_ActualizarEspecialidad
go
create procedure SP_ActualizarEspecialidad
@IdEspecialidad int,
@Nombre varchar(30)
as
begin
    if(@IdEspecialidad is null or @IdEspecialidad='' or @Nombre is null or @Nombre='')
    begin
        print 'Por favor ingrese todos los datos requeridos para actualizar la Especialidad'
    end

    else if (
			 PATINDEX('%[a-zA-Z]%', CAST(@IdEspecialidad AS varchar(25))) > 0 or
			 PATINDEX('%[^a-zA-Z]%', @Nombre) > 0 )	
    begin
        print 'Los datos a ingresar contienen carácteres inválidos'
    end

    else if exists (select ID_Especialidad from Especialidad where ID_Especialidad = @IdEspecialidad)
    begin
        begin tran
        update Especialidad
        set Nombre = @Nombre 
        where ID_Especialidad = @IdEspecialidad
        commit tran
        print 'Se actualizó la Especialidad con el ID indicado'
    end
    else
    begin
        print 'La Especialidad no existe'
    end
end
go

-- Actualizar Unidad
drop procedure if exists SP_ActualizarUnidad
go
create procedure SP_ActualizarUnidad
@IdUnidad int,
@Codigo int,
@Nombre varchar(25),
@Planta int,
@IdDoctor int
as
begin
    if(@IdUnidad is null or @IdUnidad='' or @Codigo is null or @Codigo='' or @Nombre is null or @Nombre='' 
	or @Planta is null or @Planta ='' or @IdDoctor is null or @IdDoctor ='')
    begin
        print 'Por favor ingrese todos los datos requeridos para actualizar la Unidad'
    end

   else if (
			 PATINDEX('%[a-zA-Z]%', CAST(@IdUnidad AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@IdDoctor AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@Codigo AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@Planta AS varchar(25))) > 0)
    begin
        print 'Los datos a ingresar contienen carácteres inválidos'
    end

    else if exists (select ID_Unidad from Unidad where ID_Unidad = @IdUnidad)
    begin
        begin tran
        update Unidad
        set 
        Codigo = @Codigo, 
        Nombre = @Nombre, 
        Planta = @Planta,
        Id_Doctor = @IdDoctor
        where ID_Unidad = @IdUnidad
        commit tran
        print 'Se actualizó la Unidad con el ID indicado'
    end
    else
    begin
        print 'La Unidad no existe'
    end
end
go
EXEC sp_set_session_context 'user_id', 2
exec sp_ActualizarUnidad 11,2121,'Unidad as',2,2
-- Actualizar Paciente
drop procedure if exists SP_ActualizarPaciente
go
create procedure SP_ActualizarPaciente
@IdPaciente int,
@NumSeguro int,
@Nombre varchar (25),
@Apellido1 varchar(25),
@Apellido2 varchar (25),
@Edad int
as
begin
    if(@IdPaciente is null or @IdPaciente='' or @NumSeguro is null or @NumSeguro ='' 
	or @Nombre is null or @Nombre='' or @Apellido1 is null or @Apellido1='' or @Apellido2 is null or @Apellido2='' or @Edad is null or @Edad='')
    begin
        print 'Por favor ingrese todos los datos requeridos para actualizar el Paciente'
    end

   else if (
			 PATINDEX('%[a-zA-Z]%', CAST(@IdPaciente AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@Edad AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@NumSeguro AS varchar(25))) > 0 or
			 PATINDEX('%[^a-zA-Z]%', @Nombre) > 0 or
			 PATINDEX('%[^a-zA-Z]%', @Apellido1) > 0 or
			 PATINDEX('%[^a-zA-Z]%', @Apellido2) > 0 )	
    begin
        print 'Los datos a ingresar contienen carácteres inválidos'
    end

    else if exists (select ID_Paciente from Paciente where ID_Paciente = @IdPaciente)
    begin
        begin tran
        update Paciente
        set 
        NumSeguro = @NumSeguro,
        Nombre = @Nombre,
        Apellido1 = @Apellido1,
        Apellido2 = @Apellido2,
        Edad = @Edad
        where ID_Paciente = @IdPaciente
        commit tran
        print 'Se actualizó el Paciente con el ID indicado'
    end
    else
    begin
        print 'El Paciente no existe'
    end
end
go

-- Actualizar Doctor
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
    if(@IdDoctor is null or @IdDoctor='' or @Codigo is null or @Codigo='' or 
	@Nombre is null or @Nombre ='' or @Apellido1 is null or @Apellido1 ='' or @Apellido2 is null or @Apellido2 ='' or 
	@IdEspecialidad is null or @IdEspecialidad='')
    begin
        print 'Por favor ingrese todos los datos requeridos para actualizar el Doctor'
    end

    else if (
			 PATINDEX('%[a-zA-Z]%', CAST(@IdDoctor AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@Codigo AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@IdEspecialidad AS varchar(25))) > 0 or
			 PATINDEX('%[^a-zA-Z]%', @Nombre) > 0 or
			 PATINDEX('%[^a-zA-Z]%', @Apellido1) > 0 or
			 PATINDEX('%[^a-zA-Z]%', @Apellido2) > 0 )	
    begin
        print 'Los datos a ingresar contienen carácteres inválidos'
    end

    else if exists (select ID_Doctor from Doctor where ID_Doctor = @IdDoctor)
    begin
        begin tran
        update Doctor
        set 
        Codigo = @Codigo,
        Nombre = @Nombre,
        Apellido1 = @Apellido1,
        Apellido2 = @Apellido2,
        ID_Especialidad = @IdEspecialidad
        where ID_Doctor = @IdDoctor
        commit tran
        print 'Se actualizó el Doctor con el ID indicado'
    end
    else
    begin
        print 'El Doctor no existe'
    end
end
go

-- Actualizar PacienteUnidad
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

    if (@IdPacienteUnidad is null or @IdPacienteUnidad = '' or
        @IdPaciente is null or @IdPaciente='' or
        @IdUnidad is null or @IdUnidad='' or
        @FechaIngreso is null or @FechaIngreso='' or
        @FechaSalida is null or @FechaSalida='' )
    begin
        print 'Por favor ingrese todos los datos requeridos para actualizar el registro'
    end
   
   else if (
			 PATINDEX('%[a-zA-Z]%', CAST(@IdPacienteUnidad AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@IdPaciente AS varchar(25))) > 0 or
			 PATINDEX('%[a-zA-Z]%', CAST(@IdUnidad AS varchar(25))) > 0)

    begin
        print 'Los datos a ingresar contienen carácteres inválidos'
    end

	else if exists (select ID_Paciente_Unidad from Paciente_Unidad where ID_Paciente_Unidad = @IdPacienteUnidad)
	begin
	begin tran
	update Paciente_Unidad set
	Id_Paciente = @IdPaciente,
	Id_Unidad = @IdUnidad,
	Fecha_Ingreso = @FechaIngreso,
	Fecha_Salida = @FechaSalida
	where ID_Paciente_Unidad = @IdPacienteUnidad
	commit tran
	print 'Se actualizó el registro con el ID indicado'
	end

	else
    begin
        print 'El registro no existe'
    end
end
go