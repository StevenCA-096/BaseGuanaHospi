--Creacion de los procedimientos para cargar información en las tablas de hechos
use Guana_HospiDB_DW
go

-- Procedimiento para cargar información en Fact_UnidadesPacientes
DROP PROCEDURE IF EXISTS SP_LoadFactUnidadesPacientes
GO
CREATE PROCEDURE SP_LoadFactUnidadesPacientes
AS
BEGIN
	BEGIN TRAN
    DELETE FROM Guana_HospiDB_DW.dbo.Fact_UnidadesPacientes;

    INSERT INTO Guana_HospiDB_DW.dbo.Fact_UnidadesPacientes (ID_Unidad, Fecha, Cantidad_Pacientes)
    SELECT
        du.ID_Unidad,
        CONVERT(DATE, GETDATE()) AS Fecha,
        COUNT(pu.ID_Paciente_Unidad) AS Cantidad_Pacientes
    FROM
        Guana_HospiDB_DW.dbo.Dim_Unidad du
    INNER JOIN
        Guana_HospiDB_DW.dbo.Dim_Paciente_Unidad pu ON du.ID_Unidad = pu.ID_Unidad
    GROUP BY
        du.ID_Unidad;
	COMMIT TRAN
END;
GO

-- Procedimiento para cargar información en Fact_EnfermedadesIntervenciones
DROP PROCEDURE IF EXISTS SP_LoadFactEnfermedadesIntervenciones
GO
CREATE PROCEDURE SP_LoadFactEnfermedadesIntervenciones
AS
BEGIN
	BEGIN TRAN
    DELETE FROM Guana_HospiDB_DW.dbo.Fact_EnfermedadesIntervenciones;

    INSERT INTO Guana_HospiDB_DW.dbo.Fact_EnfermedadesIntervenciones (ID_Enfermedad, Fecha, Cantidad_Intervenciones)
    SELECT
        de.ID_Enfermedad,
        CONVERT(DATE, GETDATE()) AS Fecha, 
        COUNT(di.ID_Intervencion) AS Cantidad_Intervenciones
    FROM
        Guana_HospiDB_DW.dbo.Dim_Enfermedad de
    INNER JOIN
        Guana_HospiDB_DW.dbo.Dim_Intervencion di ON de.ID_Enfermedad = di.ID_Enfermedad
    GROUP BY
        de.ID_Enfermedad;
	COMMIT TRAN
	
END;
GO

-- Procedimiento para cargar información en Fact_DoctoresIntervenciones
DROP PROCEDURE IF EXISTS SP_LoadFactDoctoresIntervenciones
GO
CREATE PROCEDURE SP_LoadFactDoctoresIntervenciones
AS
BEGIN
	BEGIN TRAN
    DELETE FROM Guana_HospiDB_DW.dbo.Fact_DoctoresIntervenciones;

    INSERT INTO Guana_HospiDB_DW.dbo.Fact_DoctoresIntervenciones (ID_Doctor, Fecha, Cantidad_Intervenciones)
    SELECT
        dd.ID_Doctor,
        CONVERT(DATE, GETDATE()) AS Fecha,
        COUNT(di.ID_Intervencion) AS Cantidad_Intervenciones
    FROM
        Guana_HospiDB_DW.dbo.Dim_Doctor dd
   INNER JOIN
        Guana_HospiDB_DW.dbo.Dim_Intervencion di ON dd.ID_Doctor = di.ID_Doctor
    GROUP BY
        dd.ID_Doctor;
	COMMIT TRAN
END;
GO

-- Procedimiento para cargar información en Fact_TiposIntervencion
DROP PROCEDURE IF EXISTS SP_LoadFactTiposIntervencion
GO
CREATE PROCEDURE SP_LoadFactTiposIntervencion
AS
BEGIN
	BEGIN TRAN
    DELETE FROM Guana_HospiDB_DW.dbo.Fact_TiposIntervencion;

    INSERT INTO Guana_HospiDB_DW.dbo.Fact_TiposIntervencion (ID_TipoIntervencion, Fecha, Cantidad_Intervenciones)
    SELECT
        dti.ID_TipoIntervencion,
        CONVERT(DATE, GETDATE()) AS Fecha,
        COUNT(di.ID_Intervencion) AS Cantidad_Intervenciones
    FROM
        Guana_HospiDB_DW.dbo.Dim_TipoIntervencion dti
    INNER JOIN
        Guana_HospiDB_DW.dbo.Dim_Intervencion di ON dti.ID_TipoIntervencion = di.ID_TipoIntervencion
    GROUP BY
        dti.ID_TipoIntervencion;
	COMMIT TRAN
END;
GO

-- Procedimiento para cargar información en Fact_PacientesIntervenciones
DROP PROCEDURE IF EXISTS SP_LoadFactPacientesIntervenciones
GO
CREATE PROCEDURE SP_LoadFactPacientesIntervenciones
AS
BEGIN
	BEGIN TRAN
    DELETE FROM Guana_HospiDB_DW.dbo.Fact_PacientesIntervenciones;

    INSERT INTO Guana_HospiDB_DW.dbo.Fact_PacientesIntervenciones (ID_Paciente, Fecha, Cantidad_Intervenciones)
    SELECT
        dp.ID_Paciente,
        CONVERT(DATE, GETDATE()) AS Fecha,
        COUNT(di.ID_Intervencion) AS Cantidad_Intervenciones
    FROM
        Guana_HospiDB_DW.dbo.Dim_Paciente dp
    INNER JOIN
        Guana_HospiDB_DW.dbo.Dim_Intervencion di ON dp.ID_Paciente = di.ID_Paciente
    GROUP BY
        dp.ID_Paciente;
	COMMIT TRAN
END;
GO

-- Procedimiento para cargar información en Fact_SintomasEnfermedades
DROP PROCEDURE IF EXISTS SP_LoadFactSintomasEnfermedades
GO
CREATE PROCEDURE SP_LoadFactSintomasEnfermedades
AS
BEGIN
	BEGIN TRAN
    DELETE FROM Guana_HospiDB_DW.dbo.Fact_SintomasEnfermedades;

    INSERT INTO Guana_HospiDB_DW.dbo.Fact_SintomasEnfermedades (ID_Enfermedad, ID_Sintoma, Fecha, Frecuencia)
    SELECT
        des.ID_Enfermedad,
        dse.ID_Sintoma,
        CONVERT(DATE, GETDATE()) AS Fecha,
        COUNT(dse.ID_Enfermedad_Sintoma) AS Frecuencia
    FROM
        Guana_HospiDB_DW.dbo.Dim_Enfermedad_Sintoma dse
    INNER JOIN
        Guana_HospiDB_DW.dbo.Dim_Enfermedad des ON dse.ID_Enfermedad = des.ID_Enfermedad
    GROUP BY
        des.ID_Enfermedad, dse.ID_Sintoma;
	COMMIT TRAN
END;
GO

-- Procedimiento para cargar información en Fact_SintomasAtendidos
DROP PROCEDURE IF EXISTS SP_LoadFactSintomasAtendidos
GO
CREATE PROCEDURE SP_LoadFactSintomasAtendidos
AS
BEGIN
	BEGIN TRAN
    DELETE FROM Guana_HospiDB_DW.dbo.Fact_SintomasAtendidos;

    INSERT INTO Guana_HospiDB_DW.dbo.Fact_SintomasAtendidos (ID_Sintoma, Fecha, Frecuencia)
    SELECT
        dse.ID_Sintoma,
        CONVERT(DATE, GETDATE()) AS Fecha,
        COUNT(dse.ID_Enfermedad_Sintoma) AS Frecuencia
    FROM
        Guana_HospiDB_DW.dbo.Dim_Enfermedad_Sintoma dse
    GROUP BY
        dse.ID_Sintoma;
	COMMIT TRAN
END;
GO

-- Procedimiento para cargar información en todas las tablas
DROP PROCEDURE IF EXISTS SP_LoadFact
GO
CREATE PROCEDURE SP_LoadFact
AS
BEGIN
	EXEC DBO.SP_LoadFactUnidadesPacientes
	EXEC DBO.SP_LoadFactEnfermedadesIntervenciones
	EXEC DBO.SP_LoadFactDoctoresIntervenciones
	EXEC DBO.SP_LoadFactTiposIntervencion
	EXEC DBO.SP_LoadFactPacientesIntervenciones
	EXEC DBO.SP_LoadFactSintomasEnfermedades
	EXEC DBO.SP_LoadFactSintomasAtendidos
END
GO


