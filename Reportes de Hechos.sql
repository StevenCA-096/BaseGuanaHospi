--Creacion de reportes
use Guana_HospiDB_DW
go

--Top unidades con más pacientes utilizando la tabla de hecho Fact_UnidadesPacientes
DROP VIEW IF EXISTS VW_TopUnidadesPorPacientes;
GO
CREATE VIEW VW_TopUnidadesPorPacientes AS
SELECT TOP 10
    DU.Nombre AS 'UNIDAD',
    DU.Codigo AS 'CÓDIGO',
    DU.Planta AS 'PLANTA',
    SUM(FUP.Cantidad_Pacientes) AS 'PACIENTES', 
    CONCAT(DD.Nombre, ' ', DD.Apellido1, ' ', DD.Apellido2) AS 'DOCTOR',
    DE.Nombre AS 'ESPECIALIDAD'
FROM
    Dim_Unidad DU
INNER JOIN
    Dim_Doctor DD ON DU.Id_Doctor = DD.ID_Doctor
INNER JOIN
    Dim_Especialidad DE ON DD.ID_Especialidad = DE.ID_Especialidad
INNER JOIN
    Fact_UnidadesPacientes FUP ON DU.ID_Unidad = FUP.ID_Unidad
GROUP BY
    DU.Nombre, DU.Codigo, DU.Planta, DD.Nombre, DD.Apellido1, DD.Apellido2, DE.Nombre
ORDER BY
    'PACIENTES' DESC
WITH CHECK OPTION;
GO

--Top enfermedades más atendidas utilizando la tabla de hecho Fact_EnfermedadesIntervenciones
DROP VIEW IF EXISTS VW_TopEnfermedadesPorIntervenciones;
GO
CREATE VIEW VW_TopEnfermedadesPorIntervenciones AS
SELECT TOP 10
    DE.Nombre AS 'ENFERMEDAD',
    COUNT(FEI.ID_Enfermedad) AS 'INTERVENCIONES'
FROM
    Dim_Enfermedad DE
INNER JOIN
    Fact_EnfermedadesIntervenciones FEI ON DE.ID_Enfermedad = FEI.ID_Enfermedad
GROUP BY
    DE.Nombre
ORDER BY
    'INTERVENCIONES' DESC
WITH CHECK OPTION;
GO

--Top doctores con más intervenciones utilizando la tabla de hecho Fact_DoctoresIntervenciones
DROP VIEW IF EXISTS VW_TopIntervencionesPorDoctor;
GO
CREATE VIEW VW_TopIntervencionesPorDoctor AS
SELECT TOP 10
    CONCAT(DD.Nombre, ' ', DD.Apellido1, ' ', DD.Apellido2) AS 'DOCTOR',
    DD.Codigo AS 'CÓDIGO',
    DE.Nombre AS 'ESPECIALIDAD',
    COUNT(FDI.ID_Doctor) AS 'INTERVENCIONES'
FROM
    Dim_Doctor DD
INNER JOIN
    Dim_Especialidad DE ON DD.ID_Especialidad = DE.ID_Especialidad
INNER JOIN
    Fact_DoctoresIntervenciones FDI ON DD.ID_Doctor = FDI.ID_Doctor
GROUP BY
    DD.Nombre, DD.Apellido1, DD.Apellido2, DD.Codigo, DE.Nombre, FDI.ID_Doctor
ORDER BY
    'INTERVENCIONES' DESC
WITH CHECK OPTION;
GO

--Top tipos de intervención más realizados utilizando la tabla de hecho Fact_TiposIntervencion
DROP VIEW IF EXISTS VW_TopIntervencionesPorTipo;
GO
CREATE VIEW VW_TopIntervencionesPorTipo AS
SELECT TOP 10
    DTI.Nombre AS 'INTERVENCIÓN',
    COUNT(FTI.ID_TipoIntervencion) AS 'CANTIDAD'
FROM
    Dim_TipoIntervencion DTI
INNER JOIN
    Fact_TiposIntervencion FTI ON DTI.ID_TipoIntervencion = FTI.ID_TipoIntervencion
GROUP BY
    DTI.Nombre
ORDER BY
    'CANTIDAD' DESC
WITH CHECK OPTION;
GO

--Top pacientes con más intervenciones utilizando la tabla de hecho Fact_PacientesIntervenciones
DROP VIEW IF EXISTS VW_TopIntervencionesPorPaciente;
GO
CREATE VIEW VW_TopIntervencionesPorPaciente AS
SELECT TOP 10
    DP.NumSeguro AS 'SEGURO',
    CONCAT(DP.Nombre, ' ', DP.Apellido1, ' ', DP.Apellido2) AS 'PACIENTE',
    DP.Edad AS 'EDAD',
    COUNT(FPI.ID_Paciente) AS 'INTERVENCIONES'
FROM
    Dim_Paciente DP
INNER JOIN
    Fact_PacientesIntervenciones FPI ON DP.ID_Paciente = FPI.ID_Paciente
GROUP BY
    DP.NumSeguro, DP.Nombre, DP.Apellido1, DP.Apellido2, DP.Edad
ORDER BY
    'INTERVENCIONES' DESC
WITH CHECK OPTION;
GO

--Frecuencia de síntomas por enfermedad utilizando la tabla de hecho Fact_SintomasEnfermedades
DROP VIEW IF EXISTS VW_TopSintomasPorEnfermedad;
GO
CREATE VIEW VW_TopSintomasPorEnfermedad AS
SELECT TOP 10
    DE.Nombre AS 'ENFERMEDAD',
    DS.Nombre AS 'SÍNTOMA',
    COUNT(FSE.ID_Enfermedad) AS 'FRECUENCIA'
FROM
    Dim_Enfermedad DE
INNER JOIN
    Fact_SintomasEnfermedades FSE ON DE.ID_Enfermedad = FSE.ID_Enfermedad
INNER JOIN
    Dim_Sintoma DS ON FSE.ID_Sintoma = DS.ID_Sintoma
GROUP BY
    DE.Nombre, DS.Nombre
ORDER BY
    DE.Nombre
WITH CHECK OPTION;
GO

--Frecuencia de síntomas atendidos utilizando la tabla de hecho Fact_SintomasAtendidos
DROP VIEW IF EXISTS VW_TopSintomasAtendidos;
GO
CREATE VIEW VW_TopSintomasAtendidos AS
SELECT TOP 10
    DS.Nombre AS 'SÍNTOMA',
    COUNT(FSA.ID_Sintoma) AS 'FRECUENCIA'
FROM
    Dim_Sintoma DS
INNER JOIN
    Fact_SintomasAtendidos FSA ON DS.ID_Sintoma = FSA.ID_Sintoma
GROUP BY
    DS.Nombre
ORDER BY
    'FRECUENCIA' DESC
WITH CHECK OPTION;
GO
