--Creacion de la data warehouse
use master
go

CREATE DATABASE Guana_HospiDB_DW ON
(
	NAME = 'Guana_HospiDB_DW_data',
    FILENAME = 'C:\SQLSERVER\SqlDATA\Guana_HospiDB_DW_data.mdf',
    SIZE = 10Mb,
    MAXSIZE = 500Mb,
    FILEGROWTH = 5Mb
)
LOG ON
(
	NAME = 'Guana_HospiDB_DW_log',
    FILENAME = 'C:\SQLSERVER\SqlLOG\Guana_HospiDB_DW_log.ldf',
    SIZE = 5 MB,
    MAXSIZE = 30MB,
    FILEGROWTH = 5 MB
)
GO

--Creacion de las tablas de dimensión
use Guana_HospiDB_DW
go

--Creacion de la tabla dimensión paciente 
create table Dim_Paciente(
ID_Paciente int not null PRIMARY KEY,
NumSeguro int not null,
Nombre varchar (25) not null,
Apellido1 varchar (25) not null,
Apellido2 varchar (25) not null,
Edad int not null,
)
go

--Creacion de la tabla dimensión especialidad
create table Dim_Especialidad(
ID_Especialidad int not null PRIMARY KEY,
Nombre varchar(30) not null
)
go

--Creacion de la tabla dimensión doctor
create table Dim_Doctor(
ID_Doctor int not null PRIMARY KEY,
Codigo int not null,
Nombre varchar(25) not null,
Apellido1 varchar (25) not null,
Apellido2 varchar (25) not null,
ID_Especialidad int not null,
FOREIGN KEY (Id_Especialidad) references Dim_Especialidad (ID_Especialidad)
)
go

--Creacion de la tabla dimensión Unidad
create table Dim_Unidad(
ID_Unidad int not null PRIMARY KEY,
Codigo int not null,
Nombre varchar (25) not null,
Planta int not null,
Id_Doctor int not null,
FOREIGN KEY (Id_Doctor) references Dim_Doctor (ID_Doctor)
)
go

--Creacion de tabla dimensión PacienteUnidad
create table Dim_Paciente_Unidad(
ID_Paciente_Unidad int not null PRIMARY KEY,
Id_Paciente int not null,
Id_Unidad int not null,
Fecha_Ingreso DateTime not null,
Fecha_Salida DateTime not null,
FOREIGN KEY (Id_Paciente) references Dim_Paciente (ID_Paciente),
FOREIGN KEY (Id_Unidad) references Dim_Unidad (ID_Unidad)
)
go


--Creacion de tabla dimensión Tipo Intervencion
create table Dim_TipoIntervencion(
ID_TipoIntervencion int not null PRIMARY KEY,
Nombre varchar (25) not null
)
go

--Creacion de la tabla dimensión Enfermedad
create table Dim_Enfermedad(
ID_Enfermedad int not null PRIMARY KEY,
Nombre varchar(25) not null
)
go

--creacion de la tabla dimensión Sintoma
create table Dim_Sintoma(
ID_Sintoma int not null PRIMARY KEY,
Nombre varchar (25) not null
)
go

--Creacion de la tabla dimensión EnfermedadSintoma
create table Dim_Enfermedad_Sintoma(
ID_Enfermedad_Sintoma int not null PRIMARY KEY,
ID_Enfermedad int not null,
ID_Sintoma int not null
foreign key (ID_Enfermedad) references Dim_Enfermedad (ID_Enfermedad),
foreign key (ID_Sintoma) references Dim_Sintoma (ID_Sintoma)
)
go

--Creacion de la tabla dimensión intervencion
create table Dim_Intervencion(
ID_Intervencion int not null PRIMARY KEY,
Fecha_Intervencion DateTime not null,
prescripcion varchar (50) not null,
Id_TipoIntervencion int not null,
Id_Enfermedad int not null,
Id_Paciente int not null,
Id_Doctor int not null,
foreign key (Id_Paciente) references Dim_Paciente (ID_Paciente),
foreign key (Id_Doctor) references Dim_Doctor (ID_Doctor),
foreign key (Id_Enfermedad) references Dim_Enfermedad (ID_Enfermedad),
foreign key (Id_TipoIntervencion) references Dim_TipoIntervencion (ID_TipoIntervencion)
)
go

--Creacion de las tablas de hechos
use Guana_HospiDB_DW
go

--Creacion de la tabla hecho UnidadesPacientes
CREATE TABLE Fact_UnidadesPacientes (
    ID_Fact_UnidadesPacientes INT IDENTITY(1,1) PRIMARY KEY,
    ID_Unidad INT,
    Fecha DATE,
    Cantidad_Pacientes INT,
    FOREIGN KEY (ID_Unidad) REFERENCES Dim_Unidad (ID_Unidad)
);

--Creacion de la tabla hecho EnfermedadesIntervenciones
CREATE TABLE Fact_EnfermedadesIntervenciones (
    ID_Fact_EnfermedadesIntervenciones INT IDENTITY(1,1) PRIMARY KEY,
    ID_Enfermedad INT,
    Fecha DATE,
    Cantidad_Intervenciones INT,
    FOREIGN KEY (ID_Enfermedad) REFERENCES Dim_Enfermedad (ID_Enfermedad)
);

--Creacion de la tabla hecho DoctoresIntervenciones
CREATE TABLE Fact_DoctoresIntervenciones (
    ID_Fact_DoctoresIntervenciones INT IDENTITY(1,1) PRIMARY KEY,
    ID_Doctor INT,
    Fecha DATE,
    Cantidad_Intervenciones INT,
    FOREIGN KEY (ID_Doctor) REFERENCES  Dim_Doctor (ID_Doctor)
);

--Creacion de la tabla hecho TiposIntervencion
CREATE TABLE Fact_TiposIntervencion (
    ID_Fact_TiposIntervencion INT IDENTITY(1,1) PRIMARY KEY,
    ID_TipoIntervencion INT,
    Fecha DATE,
    Cantidad_Intervenciones INT,
    FOREIGN KEY (ID_TipoIntervencion) REFERENCES Dim_TipoIntervencion (ID_TipoIntervencion)
);

--Creacion de la tabla hecho PacientesIntervenciones
CREATE TABLE Fact_PacientesIntervenciones (
    ID_Fact_PacientesIntervenciones INT IDENTITY(1,1) PRIMARY KEY,
    ID_Paciente INT,
    Fecha DATE,
    Cantidad_Intervenciones INT,
    FOREIGN KEY (ID_Paciente) REFERENCES Dim_Paciente (ID_Paciente)
);

--Creacion de la tabla hecho SintomasEnfermedades
CREATE TABLE Fact_SintomasEnfermedades (
    ID_Fact_SintomasEnfermedades INT IDENTITY(1,1) PRIMARY KEY,
    ID_Enfermedad INT,
    ID_Sintoma INT,
    Fecha DATE,
    Frecuencia INT,
    FOREIGN KEY (ID_Enfermedad) REFERENCES Dim_Enfermedad (ID_Enfermedad),
    FOREIGN KEY (ID_Sintoma) REFERENCES Dim_Sintoma (ID_Sintoma)
);

--Creacion de la tabla hecho SintomasAtendidos
CREATE TABLE Fact_SintomasAtendidos (
    ID_Fact_SintomasAtendidos INT IDENTITY(1,1) PRIMARY KEY,
    ID_Sintoma INT,
    Fecha DATE,
    Frecuencia INT,
    FOREIGN KEY (ID_Sintoma) REFERENCES Dim_Sintoma (ID_Sintoma)
);
