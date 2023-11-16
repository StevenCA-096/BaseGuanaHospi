--Consultas por todos los datos.
use Guana_HospiDB
go

-- Obtener Especialidad por ID
drop procedure if exists SP_ObtenerEspecialidadPorID;
go
create procedure SP_ObtenerEspecialidadPorID (@ID_Especialidad varchar(25))
as

if(@ID_Especialidad = '' or @ID_Especialidad is null)

begin
	print 'Por favor ingrese el identificador de la Especialidad a consultar'
end

else if (PATINDEX('%[a-zA-Z]%', @ID_Especialidad) > 0)

begin
	print 'El valor a consultar debe ser numérico'
end

else if exists (select ID_Especialidad from Especialidad where ID_Especialidad = @ID_Especialidad)
begin
    select
        E.ID_Especialidad AS 'ID ESPECIALIDAD',
        E.Nombre AS 'NOMBRE'
    from Especialidad E
    where E.ID_Especialidad = @ID_Especialidad;
end

else

begin
	print 'La Especialidad no existe'
end
go

-- Obtener Síntoma por ID
drop procedure if exists SP_ObtenerSintomaPorID;
go
create procedure SP_ObtenerSintomaPorID (@ID_Sintoma varchar(25))
as

if(@ID_Sintoma = '' or @ID_Sintoma is null)

begin
	print 'Por favor ingrese el identificador del Síntoma a consultar'
end

else if (PATINDEX('%[a-zA-Z]%', @ID_Sintoma) > 0)

begin
	print 'El valor a consultar debe ser numérico'
end

else if exists (select ID_Sintoma from Sintoma where ID_Sintoma = @ID_Sintoma)
begin
    select
        S.ID_Sintoma AS 'ID SÍNTOMA',
        S.Nombre AS 'NOMBRE'
    from Sintoma S
    where S.ID_Sintoma = @ID_Sintoma;
end

else

begin
	print 'El Síntoma no existe'
end
go

-- Obtener Enfermedad por ID
drop procedure if exists SP_ObtenerEnfermedadPorID;
go
create procedure SP_ObtenerEnfermedadPorID (@ID_Enfermedad varchar(25))
as

if(@ID_Enfermedad = '' or @ID_Enfermedad is null)

begin
	print 'Por favor ingrese el identificador de la Enfermedad a consultar'
end

else if (PATINDEX('%[a-zA-Z]%', @ID_Enfermedad) > 0)

begin
	print 'El valor a consultar debe ser numérico'
end

else if exists (select ID_Enfermedad from Enfermedad where ID_Enfermedad = @ID_Enfermedad)
begin
    select
        E.ID_Enfermedad AS 'ID ENFERMEDAD',
        E.Nombre AS 'NOMBRE'
    from Enfermedad E
    where E.ID_Enfermedad = @ID_Enfermedad;
end

else

begin
	print 'La Enfermedad no existe'
end
go

-- Obtener Doctor por ID
drop procedure if exists SP_ObtenerDoctorPorID;
go
create procedure SP_ObtenerDoctorPorID (@ID_Doctor varchar(25))
as

if(@ID_Doctor = '' or @ID_Doctor is null)

begin
	print 'Por favor ingrese el identificador del Doctor a consultar'
end

else if (PATINDEX('%[a-zA-Z]%', @ID_Doctor) > 0)

begin
	print 'El valor a consultar debe ser numérico'
end

else if exists (select ID_Doctor from Doctor where ID_Doctor = @ID_Doctor)
begin
    select
        D.ID_Doctor AS 'ID_DOCTOR',
        D.Codigo AS 'CODIGO',
        D.Nombre AS 'NOMBRED',
        D.Apellido1 AS 'APELLIDO1',
        D.Apellido2 AS 'APELLIDO2',
		E.ID_Especialidad,
        E.Nombre AS 'NOMBREE'
    from Doctor D
    inner join Especialidad E on D.ID_Especialidad = E.ID_Especialidad
    where D.ID_Doctor = @ID_Doctor;
end

else

begin
	select top(0)
        D.ID_Doctor AS 'ID_DOCTOR',
        D.Codigo AS 'CODIGO',
        D.Nombre AS 'NOMBRED',
        D.Apellido1 AS 'APELLIDO1',
        D.Apellido2 AS 'APELLIDO2',
		E.ID_Especialidad,
        E.Nombre AS 'NOMBREE'
    from Doctor D inner join Especialidad E on D.ID_Especialidad = E.ID_Especialidad
    where D.ID_Doctor = @ID_Doctor;
end
go

-- Obtener Paciente por ID
drop procedure if exists SP_ObtenerPacientePorID;
go
create procedure SP_ObtenerPacientePorID (@ID_Paciente varchar(25))
as

if(@ID_Paciente = '' or @ID_Paciente is null)

begin
	print 'Por favor ingrese el identificador del Paciente a consultar'
end

else if (PATINDEX('%[a-zA-Z]%', @ID_Paciente) > 0)

begin
	print 'El valor a consultar debe ser numérico'
end

else if exists (select ID_Paciente from Paciente where ID_Paciente = @ID_Paciente)
begin
    select
        P.ID_Paciente AS 'ID_PACIENTE',
        P.NumSeguro AS 'NUMSEGURO',
        P.Nombre AS 'NOMBRE',
        P.Apellido1 AS 'APELLIDO1',
        P.Apellido2 AS 'APELLIDO2',
        P.Edad AS 'EDAD'
    from Paciente P
    where P.ID_Paciente = @ID_Paciente;
end

else

begin
	print 'El Paciente no existe'
end
go

-- Obtener Unidad por ID
drop procedure if exists SP_ObtenerUnidadPorID;
go
create procedure SP_ObtenerUnidadPorID (@ID_Unidad varchar(25))
as

if(@ID_Unidad = '' or @ID_Unidad is null)

begin
	print 'Por favor ingrese el identificador de la Unidad a consultar'
end

else if (PATINDEX('%[a-zA-Z]%', @ID_Unidad) > 0)

begin
	print 'El valor a consultar debe ser numérico'
end

else if exists (select ID_Unidad from Unidad where ID_Unidad = @ID_Unidad)
begin
    select
        U.ID_Unidad AS 'ID UNIDAD',
        U.Codigo AS 'CODIGO',
        U.Nombre AS 'NOMBRE',
        U.Planta AS 'PLANTA'
    from Unidad U
    where U.ID_Unidad = @ID_Unidad;
end

else

begin
	print 'La Unidad no existe'
end
go

-- Obtener Paciente-Unidad por ID
drop procedure if exists SP_ObtenerPacienteUnidadPorID;
go
create procedure SP_ObtenerPacienteUnidadPorID (@ID_Paciente_Unidad varchar(25))
as

if(@ID_Paciente_Unidad = '' or @ID_Paciente_Unidad is null)

begin
	print 'Por favor ingrese el identificador del registro a consultar'
end

else if (PATINDEX('%[a-zA-Z]%', @ID_Paciente_Unidad) > 0)

begin
	print 'El valor a consultar debe ser numérico'
end

else if exists (select ID_Paciente_Unidad from Paciente_Unidad where ID_Paciente_Unidad = @ID_Paciente_Unidad)
begin
    select
        PU.ID_Paciente_Unidad AS 'ID PACIENTE-UNIDAD',
        P.NumSeguro AS 'NUMERO DE SEGURO',
        P.Nombre AS 'NOMBRE DEL PACIENTE',
        U.Nombre AS 'NOMBRE DE LA UNIDAD',
        PU.Fecha_Ingreso AS 'FECHA DE INGRESO',
        PU.Fecha_Salida AS 'FECHA DE SALIDA'
    from Paciente_Unidad PU
    inner join Paciente P on PU.Id_Paciente = P.ID_Paciente
    inner join Unidad U on PU.Id_Unidad = U.ID_Unidad
    where PU.ID_Paciente_Unidad = @ID_Paciente_Unidad;
end

else

begin
	print 'El registro no existe'
end
go

-- Obtener Intervención por ID
drop procedure if exists SP_ObtenerIntervencionPorID;
go
create procedure SP_ObtenerIntervencionPorID (@ID_Intervencion varchar(25))
as

if(@ID_Intervencion = '' or @ID_Intervencion is null)

begin
	print 'Por favor ingrese el identificador de la intervención a consultar'
end

else if (PATINDEX('%[a-zA-Z]%', @ID_Intervencion) > 0)

begin
	print 'El valor a consultar debe ser numérico'
end

else if exists (select ID_Intervencion from Intervencion where ID_Intervencion = @ID_Intervencion)
begin
    select
        I.ID_Intervencion AS 'ID INTERVENCION',
        I.Fecha_Intervencion AS 'FECHA DE INTERVENCION',
        I.prescripcion AS 'PRESCRIPCION',
        TI.Nombre AS 'TIPO DE INTERVENCIÓN',
        E.Nombre AS 'ENFERMEDAD',
        P.Nombre AS 'NOMBRE DEL PACIENTE',
        D.Nombre AS 'NOMBRE DEL DOCTOR'
    from Intervencion I
    inner join TipoIntervencion TI on I.Id_TipoIntervencion = TI.ID_TipoIntervencion
    inner join Enfermedad E on I.Id_Enfermedad = E.ID_Enfermedad
    inner join Paciente P on I.Id_Paciente = P.ID_Paciente
    inner join Doctor D on I.Id_Doctor = D.ID_Doctor
    where I.ID_Intervencion = @ID_Intervencion;
end

else

begin
	print 'La intervención no existe'
end
go

-- Obtener Tipo de Intervención por ID
drop procedure if exists SP_ObtenerTipoIntervencionPorID;
go
create procedure SP_ObtenerTipoIntervencionPorID (@ID_TipoIntervencion varchar(25))
as

if(@ID_TipoIntervencion = '' or @ID_TipoIntervencion is null)

begin
	print 'Por favor ingrese el identificador del tipo de intervención a consultar'
end

else if (PATINDEX('%[a-zA-Z]%', @ID_TipoIntervencion) > 0)

begin
	print 'El valor a consultar debe ser numérico'
end

else if exists (select ID_TipoIntervencion from TipoIntervencion where ID_TipoIntervencion = @ID_TipoIntervencion)
begin
    select
        TI.ID_TipoIntervencion AS 'ID TIPO DE INTERVENCIÓN',
        TI.Nombre AS 'NOMBRE'
    from TipoIntervencion TI
    where TI.ID_TipoIntervencion = @ID_TipoIntervencion;
end

else

begin
	print 'El tipo de intervención no existe'
end
go

-- Obtener Rol por ID
drop procedure if exists SP_ObtenerRolPorID;
go
create procedure SP_ObtenerRolPorID (@ID_Rol varchar(25))
as

if(@ID_Rol = '' or @ID_Rol is null)

begin
	print 'Por favor ingrese el identificador del Rol a consultar'
end

else if (PATINDEX('%[a-zA-Z]%', @ID_Rol) > 0)

begin
	print 'El valor a consultar debe ser numérico'
end

else if exists (select ID_Rol from Rol where ID_Rol = @ID_Rol)
begin
    select
        R.ID_Rol AS 'ID ROL',
        R.NombreR AS 'NOMBRE'
    from Rol R
    where R.ID_Rol = @ID_Rol;
end

else

begin
	print 'El Rol no existe'
end
go

-- Obtener Usuario por ID
drop procedure if exists SP_ObtenerUsuarioPorID;
go
create procedure SP_ObtenerUsuarioPorID (@ID_Usuario varchar(25))
as

if(@ID_Usuario = '' or @ID_Usuario is null)

begin
	print 'Por favor ingrese el identificador del Usuario a consultar'
end

else if (PATINDEX('%[a-zA-Z]%', @ID_Usuario) > 0)

begin
	print 'El valor a consultar debe ser numérico'
end

else if exists (select @ID_Usuario from Usuario where ID_Usuario = @ID_Usuario)
begin
    select
        U.ID_Usuario AS 'ID USUARIO',
        U.Correo AS 'CORREO',
        U.Contra AS 'CONTRASEÑA',
        R.NombreR AS 'ROL'
    from Usuario U
    inner join Rol R on U.ID_Rol = R.ID_Rol
    where U.ID_Usuario = @ID_Usuario;
end

else

begin
	print 'El Usuario no existe'
end
go

--Ejemplo
--exec SP_ObtenerEspecialidadPorID '1'



