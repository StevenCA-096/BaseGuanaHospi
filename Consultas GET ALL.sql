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
        E.ID_Especialidad AS 'ID ESPECIALIDAD',
        E.Nombre AS 'NOMBRE'
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
        S.ID_Sintoma AS 'ID SÍNTOMA',
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
        E.ID_Enfermedad AS 'ID ENFERMEDAD',
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
        ES.ID_Enfermedad_Sintoma AS 'ID ENFERMEDAD-SÍNTOMA',
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
        P.ID_Paciente AS 'ID PACIENTE',
        P.NumSeguro AS 'NUMERO DE SEGURO',
        P.Nombre AS 'NOMBRE',
        P.Apellido1 AS 'PRIMER APELLIDO',
        P.Apellido2 AS 'SEGUNDO APELLIDO',
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
        D.ID_Doctor AS 'ID DOCTOR',
        D.Codigo AS 'CODIGO',
        D.Nombre AS 'NOMBRE',
        D.Apellido1 AS 'PRIMER APELLIDO',
        D.Apellido2 AS 'SEGUNDO APELLIDO',
        E.Nombre AS 'ESPECIALIDAD'
    from Doctor D
    inner join Especialidad E on D.ID_Especialidad = E.ID_Especialidad;
end
go


-- Obtener Unidades
drop procedure if exists SP_ObtenerUnidad;
go
create procedure SP_ObtenerUnidad
as
begin
    select
        U.ID_Unidad AS 'ID UNIDAD',
        U.Codigo AS 'CODIGO',
        U.Nombre AS 'NOMBRE',
        U.Planta AS 'PLANTA'
    from Unidad U;
end
go

-- Obtener Pacientes-Unidades
drop procedure if exists SP_ObtenerPacienteUnidad;
go
create procedure SP_ObtenerPacienteUnidad
as
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
        I.ID_Intervencion AS 'ID INTERVENCION',
        I.Fecha_Intervencion AS 'FECHA DE INTERVENCION',
        I.prescripcion AS 'PRESCRIPCION',
        TI.Nombre AS 'TIPO DE INTERVENCION',
        E.Nombre AS 'ENFERMEDAD',
        P.Nombre AS 'NOMBRE DEL PACIENTE',
        D.Nombre AS 'NOMBRE DEL DOCTOR'
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
        TI.ID_TipoIntervencion AS 'ID TIPO DE INTERVENCION',
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
        R.ID_Rol AS 'ID ROL',
        R.Nombre AS 'NOMBRE'
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
        U.ID_Usuario AS 'ID USUARIO',
        U.Correo AS 'CORREO',
        U.Contra AS 'CONTRASEÑA',
        R.Nombre AS 'ROL'
    from Usuario U
    inner join Rol R on U.ID_Rol = R.ID_Rol;
end
go
