--Creacion de tablas--
Use Guana_HospiDB
go
--Creacion de la tabla paciente
create table Paciente(
ID_Paciente int IDENTITY(1,1) PRIMARY KEY,
NumSeguro int not null,
Nombre varchar (25) not null,
Apellido1 varchar (25) not null,
Apellido2 varchar (25) not null,
Edad int not null,
)
go
--Creacion de tabla Paciente_Unidad
create table Paciente_Unidad(
ID_Paciente_Unidad int IDENTITY(1,1) PRIMARY KEY,
Id_Paciente int not null,
Id_Unidad int not null,
Fecha_Ingreso DateTime not null,
Fecha_Salida DateTime not null
)
go
--Creacion de la tabla Unidad
create table Unidad(
ID_Unidad int IDENTITY(1,1) PRIMARY KEY,
Codigo int not null,
Nombre varchar (25) not null,
Planta int not null,
Id_Doctor int not null
)
go
--Creacion de la tabla doctor
create table Doctor(
ID_Doctor int IDENTITY(1,1) PRIMARY KEY,
Codigo int not null,
Nombre varchar(25) not null,
Apellido1 varchar (25) not null,
Apellido2 varchar (25) not null,
ID_Especialidad int not null
)
go
--Creacion de la tabla especialidad
create table Especialidad(
ID_Especialidad int IDENTITY(1,1) PRIMARY KEY,
Nombre varchar(30) not null
)
go
--Creacion de la tabla intervencion
create table Intervencion(
ID_Intervencion int IDENTITY(1,1) PRIMARY KEY,
Fecha_Intervencion DateTime not null,
prescripcion varchar (50) not null,
Id_TipoIntervencion int not null,
Id_Enfermedad int not null,
Id_Paciente int not null,
Id_Doctor int not null
)
go
--Creacion de tabla Tipo Intervencion
create table TipoIntervencion(
ID_TipoIntervencion int IDENTITY(1,1) PRIMARY KEY,
Nombre varchar (25) not null
)
go
--Creacion de la tabla Enfermedad
create table Enfermedad(
ID_Enfermedad int IDENTITY(1,1) PRIMARY KEY,
Nombre varchar(25) not null
)
go
--creacion de la tabla EnfermedadSintoma
create table Enfermedad_Sintoma(
ID_Enfermedad_Sintoma int IDENTITY(1,1) PRIMARY KEY,
ID_Enfermedad int not null,
ID_Sintoma int not null
)
go
--creacion de la tabla Sintoma
create table Sintoma(
ID_Sintoma int IDENTITY(1,1) PRIMARY KEY,
Nombre varchar (25) not null
)
go
--Creacion de la tabla usuario
create table Usuario(
ID_Usuario int IDENTITY(1,1) PRIMARY KEY,
Correo varchar(60) not null,
Contra varchar(16) not null,
ID_Rol int not null
)
go
--Creacion de la tabla Rol
create table Rol(
ID_Rol int IDENTITY(1,1) PRIMARY KEY,
NombreR varchar(25) not null
)
go

exec sp_rename 'dbo.Rol.Nombre', 'NombreR', 'COLUMN';