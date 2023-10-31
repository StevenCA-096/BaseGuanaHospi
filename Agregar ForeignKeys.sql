--Asignacion de llaves foraneas
use Guana_HospiDB
go

--Agregar llaves foraneas a tabla Paciente_Unidad

--Llave foranea con paciente
alter table Paciente_Unidad
Add constraint FK_PacienteUnidad_Paciente
FOREIGN KEY (Id_Paciente)
references Paciente (ID_Paciente)
go
--Llave foranea con Unidad
alter table Paciente_Unidad
Add constraint FK_PacienteUnidad_Unidad
FOREIGN KEY (Id_Unidad)
references Unidad (ID_Unidad)
go

--Agregar llaves foraneas a tabla Unidad
alter table Unidad
Add constraint FK_Unidad_Doctor
FOREIGN KEY (Id_Doctor)
references Doctor (ID_Doctor)
go
--Agregar llaves foreaneas a tabla Doctor
alter table Doctor 
Add constraint FK_Doctor_Especialidad
FOREIGN KEY (Id_Especialidad)
references Especialidad (ID_Especialidad)
go

--Agregar llaves foraneas a tabla Intervencion--

--Agregar llave foranea de paciente con intervencion
alter table Intervencion
add constraint FK_Intervencion_Paciente
foreign key (Id_Paciente)
references Paciente (ID_Paciente)
go
--Agregar lave foranea de doctor con intervencion
alter table Intervencion
add constraint FK_Intervencion_Doctor
foreign key (Id_Doctor)
references Doctor (ID_Doctor)
go
--Agregar llave foranea de enfermedad con intervencion
alter table Intervencion
add constraint FK_Intervencion_Enfermedad
foreign key (Id_Enfermedad)
references Enfermedad (ID_Enfermedad)
go
--Agregar llave foranea de TipoIntevencion con intervencion
alter table Intervencion
add constraint FK_Intervencion_TipoIntervencion
foreign key (Id_TipoIntervencion)
references TipoIntervencion (ID_TipoIntervencion)
go
---
--Agregar llaves foraneas a Enfermedad_Sintoma

--agregar llave foranea de enfermedad_Sintoma con enfermedad
alter table Enfermedad_Sintoma
add constraint FK_EnfermedadSintoma_Enfermedad
foreign key (Id_Enfermedad)
references Enfermedad (ID_Enfermedad)
go
--agregar llave foranea de enfermedad_Sintoma con sintoma
alter table Enfermedad_Sintoma
add constraint FK_EnfermedadSintoma_Sintoma
foreign key (Id_Sintoma)
references Sintoma (ID_Sintoma)
go
--
--Agregar llave foranea a Usuario
alter table Usuario
add constraint FK_Usuario_Rol
foreign key (Id_Rol)
references Rol (ID_Rol)
go