--Creacion de procedimientos almacenados para insertar informacion
use Guana_HospiDB
go

--Procedimiento para insertar un paciente
drop procedure if exists SP_InsertarPaciente
go
create procedure SP_InsertarPaciente
@NumSeguro varchar(25),
@Nombre varchar (25),
@Apellido1 varchar (25) ,
@Apellido2 varchar (25) ,
@Edad varchar (2)

as

if(@NumSeguro = '' or @NumSeguro is null or 
   @Nombre = '' or @Nombre is null or
   @Apellido1 = '' or @Apellido1 is null or
   @Apellido2 = '' or @Apellido2 is null or
   @Edad = '' or @Edad is null 
)

begin
	print 'Por favor ingrese todos los datos requeridos para registrar el paciente'
end

else if (PATINDEX('%[a-zA-Z]%' , @NumSeguro) > 0 or
		 PATINDEX('%[^a-zA-Z]%', @Nombre) > 0 or
		 PATINDEX('%[^a-zA-Z]%', @Apellido1) > 0 or
	     PATINDEX('%[^a-zA-Z]%', @Apellido2) > 0 or
		 PATINDEX('%[a-zA-Z]%', @Edad) > 0 )

begin
	print 'Los datos a ingresar contienen carácteres inválidos'
end

else if not exists (select ID_Paciente from Paciente where NumSeguro = @NumSeguro)
begin
	begin tran
		insert into Paciente values(@NumSeguro,@Nombre,@Apellido1,@Apellido2,@Edad)
	commit tran
end

else

begin
	print 'El paciente ya existe'
end
go

--Procedimiento para insertar Unidad
drop procedure if exists SP_InsertarUnidad
go
create procedure SP_InsertarUnidad
@Codigo varchar (25),
@Nombre varchar (30),
@Planta varchar (25),
@Id_Doctor varchar (25)
as
begin
    if (@Codigo is null or @Codigo = '' or @Nombre is null or @Nombre = '' or @Planta is null or @Planta  = '' or @Id_Doctor is null or @Id_Doctor  = '')
    begin
        print 'Por favor ingrese todos los datos requeridos para registrar la unidad'
    end
 
    else if (PATINDEX('%[a-zA-Z]%', @Codigo) > 0 or
             PATINDEX('%[a-zA-Z]%', @Planta) > 0 or
             PATINDEX('%[a-zA-Z]%', @Id_Doctor) > 0)
    begin
        print 'Los datos a ingresar contienen caracteres inválidos'
    end
    else if not exists (select Codigo from Unidad where Codigo = @Codigo)
    begin
        begin tran
        insert into Unidad values(@Codigo, @Nombre, @Planta, @Id_Doctor)
        commit tran
    end
    else
    begin
        print 'La unidad con el código especificado ya existe'
    end
end
go

--Procedimiento para insertar Paciente_Unidad
drop procedure if exists SP_InsertarPaciente_Unidad
go
create procedure SP_InsertarPaciente_Unidad
@IdPaciente int,
@Id_Unidad int,
@Fecha_Ingreso datetime,
@Fecha_Salida datetime
as
begin
    if (@IdPaciente is null or @IdPaciente  = '' or @Id_Unidad is null or @Id_Unidad ='' or @Fecha_Ingreso is null or @Fecha_Ingreso = '')
    begin
        print 'Por favor ingrese todos los datos requeridos'
    end

	--else if (PATINDEX('%[a-zA-Z]%' , @Id_Unidad) > 0 or
		-- PATINDEX('%[a-zA-Z]%', @IdPaciente) > 0 )

		   else if (PATINDEX('%[a-zA-Z]%', CONVERT(varchar, @IdPaciente)) > 0 or
					PATINDEX('%[a-zA-Z]%', CONVERT(varchar, @Id_Unidad)) > 0 )


begin
	print 'Los datos a ingresar contienen carácteres inválidos'
end

    else if not exists (select ID_Paciente_Unidad from Paciente_Unidad where ID_Paciente = @IdPaciente and Id_Unidad = @Id_Unidad)
    begin
        begin tran
        insert into Paciente_Unidad values(@IdPaciente, @Id_Unidad, @Fecha_Ingreso, '')
        commit tran
    end
    else
    begin
        print 'El registro ya existe'
    end
end
go

-- Crear procedimiento para insertar en tabla Doctor
drop procedure if exists SP_InsertarDoctor
go
create procedure SP_InsertarDoctor
@Codigo varchar (25),
@Nombre varchar(25),
@Apellido1 varchar(25),
@Apellido2 varchar(25),
@Id_Especialidad varchar (25)
as
begin
    if (@Codigo is null or @Codigo ='' or @Nombre is null or @Nombre = '' or @Apellido1 is null  or @Apellido1='' or @Apellido2 is null or @Apellido2='' or @Id_Especialidad is null or @Id_Especialidad='')
    begin
        print 'Por favor ingrese todos los datos requeridos para registrar al doctor'
    end
    
    else if (PATINDEX('%[a-zA-Z]%', CONVERT(varchar, @Codigo)) > 0 or
             PATINDEX('%[^a-zA-Z]%', @Nombre) > 0 or
             PATINDEX('%[^a-zA-Z]%', @Apellido1) > 0 or
             PATINDEX('%[^a-zA-Z]%', @Apellido2) > 0 or
             PATINDEX('%[a-zA-Z]%', CONVERT(varchar, @Id_Especialidad)) > 0)
    begin
        print 'Los datos a ingresar contienen caracteres inválidos'
    end
    else if not exists (select Codigo from Doctor where Codigo = @Codigo)
    begin
        begin tran
        insert into Doctor values(@Codigo, @Nombre, @Apellido1, @Apellido2, @Id_Especialidad)
        commit tran
    end
    else
    begin
        print 'El doctor ya existe'
    end
end
go

-- Crear procedimiento para insertar en tabla Especialidad
drop procedure if exists SP_InsertarEspecialidad
go
create procedure SP_InsertarEspecialidad
@Nombre varchar(30)
as
begin
    if (@Nombre is null or @Nombre ='')
    begin
        print 'Por favor ingrese el nombre de la especialidad'
    end
    else if (PATINDEX('%[^a-zA-Z ]%', @Nombre) > 0)
    begin
        print 'El nombre de la especialidad contiene caracteres inválidos'
    end
    else if not exists (select Nombre from Especialidad where Nombre = @Nombre)
    begin
        begin tran
        insert into Especialidad values(@Nombre)
        commit tran
    end
    else
    begin
        print 'La especialidad ya existe'
    end
end
go

-- Crear procedimiento para insertar en tabla Intervencion
drop procedure if exists SP_InsertarIntervencion
go
create procedure SP_InsertarIntervencion
@FechaIntervencion datetime,
@Prescripcion varchar(50),
@ID_TipoIntervencion varchar (25),
@ID_Enfermedad varchar (25),
@ID_Paciente varchar (25),
@ID_Doctor varchar (25)
as
begin
    if (@FechaIntervencion is null or @FechaIntervencion='' or @Prescripcion is null or @Prescripcion ='' or 
	@ID_TipoIntervencion is null or @ID_TipoIntervencion ='' or
        @ID_Enfermedad is null or @ID_Enfermedad ='' or @ID_Paciente is null or @ID_Paciente ='' or
		@ID_Doctor is null or @ID_Doctor ='')
    begin
        print 'Por favor ingrese todos los datos requeridos para registrar la intervención'
    end
  
  	else if (PATINDEX('%[a-zA-Z]%' , @ID_TipoIntervencion) > 0 or
	PATINDEX('%[a-zA-Z]%' , @ID_Enfermedad) > 0 or
	PATINDEX('%[a-zA-Z]%' , @ID_Paciente) > 0 or
	PATINDEX('%[a-zA-Z]%' , @ID_Doctor) > 0 )

begin
	print 'Los datos a ingresar contienen carácteres inválidos'
end

    else if not exists (select ID_Intervencion from Intervencion where Fecha_Intervencion = @FechaIntervencion and
                     ID_Paciente = @ID_Paciente and ID_Doctor = @ID_Doctor)
    begin
        begin tran
        insert into Intervencion
        values(@FechaIntervencion, @Prescripcion, @ID_TipoIntervencion, @ID_Enfermedad, @ID_Paciente, @ID_Doctor)
        commit tran
    end
    else
    begin
        print 'La intervención ya existe para el paciente y el doctor en la misma fecha'
    end
end
go

-- Crear procedimiento para insertar en tabla TipoIntervencion
drop procedure if exists SP_InsertarTipoIntervencion
go
create procedure SP_InsertarTipoIntervencion
@Nombre varchar(25)
as
begin
    if (@Nombre is null or @Nombre='')
    begin
        print 'Por favor ingrese el nombre del tipo de intervención'
    end
    
    else if (PATINDEX('%[^a-zA-Z ]%', @Nombre) > 0)
    begin
        print 'El nombre del tipo de intervención contiene caracteres inválidos'
    end
    else if not exists (select Nombre from TipoIntervencion where Nombre = @Nombre)
    begin
        begin tran
        insert into TipoIntervencion values(@Nombre)
        commit tran
    end
    else
    begin
        print 'El tipo de intervención ya existe'
    end
end
go

-- Crear procedimiento para insertar en tabla Enfermedad
drop procedure if exists SP_InsertarEnfermedad
go
create procedure SP_InsertarEnfermedad
@Nombre varchar(25)
as
begin
    if (@Nombre is null or @Nombre='')
    begin
        print 'Por favor ingrese el nombre de la enfermedad'
    end
  
    else if (PATINDEX('%[^a-zA-Z ]%', @Nombre) > 0)
    begin
        print 'El nombre de la enfermedad contiene caracteres inválidos'
    end
    else if not exists (select Nombre from Enfermedad where Nombre = @Nombre)
    begin
        begin tran
        insert into Enfermedad values(@Nombre)
        commit tran
    end
    else
    begin
        print 'La enfermedad con el nombre especificado ya existe'
    end
end
go

-- Crear procedimiento para insertar en tabla Enfermedad_Sintoma
drop procedure if exists SP_InsertarEnfermedad_Sintoma
go
create procedure SP_InsertarEnfermedad_Sintoma
@Id_Enfermedad varchar (25),
@Id_Sintoma varchar (25)
as
begin
    if (@Id_Enfermedad is null or @Id_Enfermedad ='' or @Id_Sintoma is null or @Id_Sintoma = '')
    begin
        print 'Por favor ingrese ambos IDs de enfermedad y síntoma'
    end

	
  	else if (PATINDEX('%[a-zA-Z]%' , @Id_Enfermedad) > 0 or
	PATINDEX('%[a-zA-Z]%' , @Id_Sintoma) > 0  )
	begin
	print 'Los datos a ingresar contienen carácteres inválidos'
end

    else if not exists (select ID_Enfermedad_Sintoma from Enfermedad_Sintoma where Id_Enfermedad = @Id_Enfermedad and Id_Sintoma = @Id_Sintoma)
    begin
        begin tran
        insert into Enfermedad_Sintoma values(@Id_Enfermedad, @Id_Sintoma)
        commit tran
    end
    else
    begin
        print 'El registro ya existe'
    end
end
go

-- Crear procedimiento para insertar en tabla Sintoma
drop procedure if exists SP_InsertarSintoma
go
create procedure SP_InsertarSintoma
@Nombre varchar(25)
as
begin
    if (@Nombre is null or @Nombre ='')
    begin
        print 'Por favor ingrese el nombre del síntoma'
    end
    else if (PATINDEX('%[^a-zA-Z ]%', @Nombre) > 0)
    begin
        print 'El nombre del síntoma contiene caracteres inválidos'
    end
    else if not exists (select Nombre from Sintoma where Nombre = @Nombre)
    begin
        begin tran
        insert into Sintoma values(@Nombre)
        commit tran
    end
    else
    begin
        print 'El síntoma ya existe'
    end
end
go

-- Crear procedimiento para insertar en tabla Usuario
drop procedure if exists SP_InsertarUsuario
go
create procedure SP_InsertarUsuario
@Correo varchar(60),
@Contra varchar(16),
@Id_Rol varchar (25)
as
begin
    if (@Correo is null or @Correo ='' or @Contra is null or @Contra ='' or @Id_Rol is null or @Id_Rol ='')
    begin
        print 'Por favor ingrese todos los datos requeridos para registrar el usuario'
    end

	else if (PATINDEX('%[a-zA-Z]%' , @Id_Rol) > 0)

	begin
	print 'Los datos a ingresar contienen carácteres inválidos'
	end
    
    else if (LEN(@Contra) < 6)
    begin
        print 'La contraseña debe tener al menos 6 caracteres'
    end
    else if not exists (select Correo from Usuario where Correo = @Correo)
    begin
        begin tran
        insert into Usuario values(@Correo, @Contra, @Id_Rol)
        commit tran
    end
    else
    begin
        print 'El usuario ya existe'
    end
end
go

-- Crear procedimiento para insertar en tabla Rol
drop procedure if exists SP_InsertarRol
go
create procedure SP_InsertarRol
@Nombre varchar(25)
as
begin
    if (@Nombre is null or @Nombre = '')
    begin
        print 'Por favor ingrese el nombre del rol'
    end
    
    else if (PATINDEX('%[^a-zA-Z ]%', @Nombre) > 0)
    begin
        print 'El nombre del rol contiene caracteres inválidos'
    end
    else if not exists (select NombreR from Rol where NombreR = @Nombre)
    begin
        begin tran
        insert into Rol values(@Nombre)
        commit tran
    end
    else
    begin
        print 'El rol ya existe'
    end
end
go

