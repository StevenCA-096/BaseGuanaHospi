--Consultas por todos los datos.
use Guana_HospiDB
go

-- Obtener Especialidades
drop procedure if exists SP_ObtenerEspecialidades;
go
create procedure SP_ObtenerEspecialidades
as
begin
    select
        E.ID_Especialidad AS 'ID_ESPECIALIDAD',
        E.Nombre AS 'NOMBREE'
    from Especialidad E;
end
go

-- Obtener Síntomas
drop procedure if exists SP_ObtenerSintomas;
go
create procedure SP_ObtenerSintomas
as
begin
    select
        S.ID_Sintoma AS 'ID_SINTOMA',
        S.Nombre AS 'NOMBRE'
    from Sintoma S;
end
go

-- Obtener Enfermedades
drop procedure if exists SP_ObtenerEnfermedades;
go
create procedure SP_ObtenerEnfermedades
as
begin
    select
        E.ID_Enfermedad AS 'ID_ENFERMEDAD',
        E.Nombre AS 'NOMBRE'
    from Enfermedad E;
end
go

-- Obtener Enfermedades-Síntomas
drop procedure if exists SP_ObtenerEnfermedadSintoma;
go
create procedure SP_ObtenerEnfermedadSintoma
as
begin
    select
        ES.ID_Enfermedad_Sintoma AS 'ID_ENFERMEDAD_SÍNTOMA',
        E.Nombre AS 'ENFERMEDAD',
        S.Nombre AS 'SÍNTOMA'
    from Enfermedad_Sintoma ES
    inner join Enfermedad E on ES.ID_Enfermedad = E.ID_Enfermedad
    inner join Sintoma S on ES.ID_Sintoma = S.ID_Sintoma;
end
go

-- Obtener Pacientes
drop procedure if exists SP_ObtenerPacientes;
go
create procedure SP_ObtenerPacientes
as
begin
    select
        P.ID_Paciente AS 'ID_PACIENTE',
        P.NumSeguro AS 'NumSeguro',
        P.Nombre AS 'NOMBRE',
        P.Apellido1 AS 'APELLIDO1',
        P.Apellido2 AS 'APELLIDO2',
        P.Edad AS 'EDAD'
    from Paciente P;
end
go

-- Obtener Doctores 
drop procedure if exists SP_ObtenerDoctores;
go
create procedure SP_ObtenerDoctores
as
begin
    select
        D.ID_Doctor AS 'ID_DOCTOR',
        D.Codigo AS 'CODIGO',
        D.Nombre AS 'NOMBRED',
        D.Apellido1 AS 'APELLIDO1',
        D.Apellido2 AS 'APELLIDO2',
		
		e.ID_Especialidad as 'ID_Especialidad',
        E.Nombre AS 'Nombre'
    from Doctor D
    inner join Especialidad E on D.ID_Especialidad = E.ID_Especialidad;
end
go

exec SP_ObtenerDoctores
-- Obtener Unidades
drop procedure if exists SP_ObtenerUnidad;
go
create procedure SP_ObtenerUnidad
as
begin
    select
        U.ID_Unidad AS 'ID_UNIDAD',
        U.Codigo AS 'CodigoU',
        U.Nombre AS 'NombreU',
        U.Planta AS 'PLANTA',
		u.Id_Doctor as 'doctor_id'	
		
    from Unidad U 
end
go

-- Obtener Pacientes-Unidades
drop procedure if exists SP_ObtenerPacienteUnidad;
go
create procedure SP_ObtenerPacienteUnidad
as
begin
    select
        PU.ID_Paciente_Unidad AS 'ID_PACIENTE_UNIDAD',
		p.ID_Paciente AS 'Id_Paciente',
        P.NumSeguro AS 'NUMSEGURO',
        concat(P.Nombre,' ',P.Apellido1) AS 'NOMBRE_PACIENTE',
		U.ID_Unidad AS 'Id_Unidad',
        U.Nombre AS 'NOMBRE_UNIDAD',
        PU.Fecha_Ingreso AS 'FECHA_INGRESO',
        PU.Fecha_Salida AS 'FECHA_SALIDA'
    from Paciente_Unidad PU
    inner join Paciente P on PU.Id_Paciente = P.ID_Paciente
    inner join Unidad U on PU.Id_Unidad = U.ID_Unidad;
end
go

-- Obtener Intervenciones
drop procedure if exists SP_ObtenerIntervenciones;
go
create procedure SP_ObtenerIntervenciones
as
begin
    select
        I.ID_Intervencion AS 'ID_INTERVENCION',
        I.Fecha_Intervencion,
        I.prescripcion AS 'PRESCRIPCION',
        TI.Nombre AS 'NombreTI',
        E.Nombre AS 'NombreE',
        concat(P.Nombre,' ',P.Apellido1) AS 'NombreP',
        concat(D.Nombre,' ',D.Apellido1) AS 'NombreD'
    from Intervencion I
    inner join TipoIntervencion TI on I.Id_TipoIntervencion = TI.ID_TipoIntervencion
    inner join Enfermedad E on I.Id_Enfermedad = E.ID_Enfermedad
    inner join Paciente P on I.Id_Paciente = P.ID_Paciente
    inner join Doctor D on I.Id_Doctor = D.ID_Doctor;
end
go

-- Obtener Tipos de Intervencion
drop procedure if exists SP_ObtenerTipoIntervencion;
go
create procedure SP_ObtenerTipoIntervencion
as
begin
    select
        TI.ID_TipoIntervencion AS 'ID_TIPOINTERVENCION',
        TI.Nombre AS 'NOMBRE'
    from TipoIntervencion TI;
end
go

-- Obtener Roles
drop procedure if exists SP_ObtenerRoles;
go
create procedure SP_ObtenerRoles
as
begin
    select
        R.ID_Rol AS 'ID_ROL',
        R.NombreR AS 'NombreR'
    from Rol R;
end
go

-- Obtener Usuarios con Roles
drop procedure if exists SP_ObtenerUsuarios;
go
create procedure SP_ObtenerUsuarios
as
begin
    select
        U.ID_Usuario AS 'ID_USUARIO',
        U.Correo AS 'CORREO',
        U.Contra AS 'CONTRA',
		R.ID_Rol,
		R.NombreR
    from Usuario U
    inner join Rol R on U.ID_Rol = R.ID_Rol;
end
go
