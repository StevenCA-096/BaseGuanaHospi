--Creacion de los procedimientos para cargar información en las tablas de dimensión
use Guana_HospiDB_DW
go

--Habilitar opciones avanzadas
exec sp_configure 'show advanced options', 1;
reconfigure;
go

--Procedimiento para habilitar xp_cmdshell
drop procedure if exists SP_Habilitar_Xpcmdshell
go
create procedure SP_Habilitar_Xpcmdshell as
begin
	exec sp_configure 'xp_cmdshell', 1;
	reconfigure;
end
go

--Procedimiento para deshabilitar xp_cmdshell
drop procedure if exists SP_Deshabilitar_Xpcmdshell
go
create procedure SP_Deshabilitar_Xpcmdshell as
begin
	exec sp_configure 'xp_cmdshell', 0;
	reconfigure;
end
go

--Procedimiento para habilitar las restricciones de las tablas de hechos
drop procedure if exists SP_Habilitar_FK
go
create procedure SP_Habilitar_FK as
begin
	alter table Guana_HospiDB_DW.dbo.Fact_UnidadesPacientes with check check constraint all;
	alter table Guana_HospiDB_DW.dbo.Fact_EnfermedadesIntervenciones with check check constraint all;
	alter table Guana_HospiDB_DW.dbo.Fact_DoctoresIntervenciones with check check constraint all;
	alter table Guana_HospiDB_DW.dbo.Fact_TiposIntervencion with check check constraint all;
	alter table Guana_HospiDB_DW.dbo.Fact_PacientesIntervenciones with check check constraint all;
	alter table Guana_HospiDB_DW.dbo.Fact_SintomasEnfermedades with check check constraint all;
	alter table Guana_HospiDB_DW.dbo.Fact_SintomasAtendidos with check check constraint all;
end
go

--Procedimiento para deshabilitar las restricciones de las tablas de hechos
drop procedure if exists SP_Deshabilitar_FK
go
create procedure SP_Deshabilitar_FK as
begin
	alter table Guana_HospiDB_DW.dbo.Fact_UnidadesPacientes nocheck constraint all;
	alter table Guana_HospiDB_DW.dbo.Fact_EnfermedadesIntervenciones nocheck constraint all;
	alter table Guana_HospiDB_DW.dbo.Fact_DoctoresIntervenciones nocheck constraint all;
	alter table Guana_HospiDB_DW.dbo.Fact_TiposIntervencion nocheck constraint all;
	alter table Guana_HospiDB_DW.dbo.Fact_PacientesIntervenciones nocheck constraint all;
	alter table Guana_HospiDB_DW.dbo.Fact_SintomasEnfermedades nocheck constraint all;
	alter table Guana_HospiDB_DW.dbo.Fact_SintomasAtendidos nocheck constraint all;
end
go

-- Creacion de procedimiento almacenado para exportar todos los datos
drop procedure if exists SP_LoadDimension;
go
create procedure SP_LoadDimension
as
begin
	exec SP_Habilitar_Xpcmdshell
    declare @cmd nvarchar(1000);

    set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Paciente" queryout "C:\SQLSERVER\SqlCSV\Paciente.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Unidad" queryout "C:\SQLSERVER\SqlCSV\Unidad.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Paciente_Unidad" queryout "C:\SQLSERVER\SqlCSV\Paciente_Unidad.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Doctor" queryout "C:\SQLSERVER\SqlCSV\Doctor.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Especialidad" queryout "C:\SQLSERVER\SqlCSV\Especialidad.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Enfermedad" queryout "C:\SQLSERVER\SqlCSV\Enfermedad.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Sintoma" queryout "C:\SQLSERVER\SqlCSV\Sintoma.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Enfermedad_Sintoma" queryout "C:\SQLSERVER\SqlCSV\Enfermedad_Sintoma.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.TipoIntervencion" queryout "C:\SQLSERVER\SqlCSV\TipoIntervencion.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Intervencion" queryout "C:\SQLSERVER\SqlCSV\Intervencion.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;

	exec SP_Deshabilitar_Xpcmdshell

	exec SP_Deshabilitar_FK

	begin tran
	delete from Guana_HospiDB_DW.dbo.Dim_Intervencion;
	delete from Guana_HospiDB_DW.dbo.Dim_TipoIntervencion;
	delete from Guana_HospiDB_DW.dbo.Dim_Enfermedad_Sintoma;
	delete from Guana_HospiDB_DW.dbo.Dim_Sintoma;
	delete from Guana_HospiDB_DW.dbo.Dim_Enfermedad;
	delete from Guana_HospiDB_DW.dbo.Dim_Paciente_Unidad;
	delete from Guana_HospiDB_DW.dbo.Dim_Unidad;
	delete from Guana_HospiDB_DW.dbo.Dim_Paciente;
	delete from Guana_HospiDB_DW.dbo.Dim_Doctor;
    delete from Guana_HospiDB_DW.dbo.Dim_Especialidad;

    bulk insert Guana_HospiDB_DW.dbo.Dim_Paciente
    from 'C:\SQLSERVER\SqlCSV\Paciente.csv'
   	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Especialidad
    from 'C:\SQLSERVER\SqlCSV\Especialidad.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Doctor
    from 'C:\SQLSERVER\SqlCSV\Doctor.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Unidad
    from 'C:\SQLSERVER\SqlCSV\Unidad.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Paciente_Unidad
    from 'C:\SQLSERVER\SqlCSV\Paciente_Unidad.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Enfermedad
    from 'C:\SQLSERVER\SqlCSV\Enfermedad.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Sintoma
    from 'C:\SQLSERVER\SqlCSV\Sintoma.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Enfermedad_Sintoma
    from 'C:\SQLSERVER\SqlCSV\Enfermedad_Sintoma.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_TipoIntervencion
    from 'C:\SQLSERVER\SqlCSV\TipoIntervencion.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Intervencion
    from 'C:\SQLSERVER\SqlCSV\Intervencion.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	exec SP_Habilitar_FK

	commit tran
end;
go

-- Creacion de procedimiento almacenado para exportar datos de Pacientes y Unidades
drop procedure if exists SP_LoadPacientesUnidades
go
create procedure SP_LoadPacientesUnidades
as
begin
	exec SP_Habilitar_Xpcmdshell
    declare @cmd nvarchar(1000);
    set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Paciente" queryout "C:\SQLSERVER\SqlCSV\Paciente.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Unidad" queryout "C:\SQLSERVER\SqlCSV\Unidad.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Paciente_Unidad" queryout "C:\SQLSERVER\SqlCSV\Paciente_Unidad.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Intervencion" queryout "C:\SQLSERVER\SqlCSV\Intervencion.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	exec SP_Deshabilitar_Xpcmdshell
	exec SP_Deshabilitar_FK

	begin tran

	delete from Guana_HospiDB_DW.dbo.Dim_Paciente_Unidad;
    
	delete from Guana_HospiDB_DW.dbo.Dim_Unidad;
    bulk insert Guana_HospiDB_DW.dbo.Dim_Unidad
    from 'C:\SQLSERVER\SqlCSV\Unidad.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	delete from Guana_HospiDB_DW.dbo.Dim_Intervencion;

	delete from Guana_HospiDB_DW.dbo.Dim_Paciente;
	bulk insert Guana_HospiDB_DW.dbo.Dim_Paciente
	from 'C:\SQLSERVER\SqlCSV\Paciente.csv'  
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Intervencion
    from 'C:\SQLSERVER\SqlCSV\Intervencion.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Paciente_Unidad
    from 'C:\SQLSERVER\SqlCSV\Paciente_Unidad.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	exec SP_Habilitar_FK

	commit tran
end;
go

-- Creacion de procedimiento almacenado para exportar datos de Enfermedades y Sintomas
drop procedure if exists SP_LoadEnfermedadesSintomas;
go
create procedure SP_LoadEnfermedadesSintomas
as
begin
	exec SP_Habilitar_Xpcmdshell
    declare @cmd nvarchar(1000);
    set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Enfermedad_Sintoma" queryout "C:\SQLSERVER\SqlCSV\Enfermedad_Sintoma.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Enfermedad" queryout "C:\SQLSERVER\SqlCSV\Enfermedad.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Sintoma" queryout "C:\SQLSERVER\SqlCSV\Sintoma.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Intervencion" queryout "C:\SQLSERVER\SqlCSV\Intervencion.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	exec SP_Deshabilitar_Xpcmdshell
	exec SP_Deshabilitar_FK

	begin tran
    delete from Guana_HospiDB_DW.dbo.Dim_Enfermedad_Sintoma;
	delete from Guana_HospiDB_DW.dbo.Dim_Intervencion;

	delete from Guana_HospiDB_DW.dbo.Dim_Enfermedad;
    bulk insert Guana_HospiDB_DW.dbo.Dim_Enfermedad
    from 'C:\SQLSERVER\SqlCSV\Enfermedad.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Intervencion
    from 'C:\SQLSERVER\SqlCSV\Intervencion.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	delete from Guana_HospiDB_DW.dbo.Dim_Sintoma;
    bulk insert Guana_HospiDB_DW.dbo.Dim_Sintoma
    from 'C:\SQLSERVER\SqlCSV\Sintoma.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Enfermedad_Sintoma
    from 'C:\SQLSERVER\SqlCSV\Enfermedad_Sintoma.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	exec SP_Habilitar_FK

	commit tran
end;
go

-- Creacion de procedimiento almacenado para exportar datos de Doctores y Especialidades
drop procedure if exists SP_LoadDoctoresEspecialidades;
go
create procedure SP_LoadDoctoresEspecialidades
as
begin
	exec SP_Habilitar_Xpcmdshell
    declare @cmd nvarchar(1000);
    set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Doctor" queryout "C:\SQLSERVER\SqlCSV\Doctor.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Especialidad" queryout "C:\SQLSERVER\SqlCSV\Especialidad.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Intervencion" queryout "C:\SQLSERVER\SqlCSV\Intervencion.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Unidad" queryout "C:\SQLSERVER\SqlCSV\Unidad.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Paciente_Unidad" queryout "C:\SQLSERVER\SqlCSV\Paciente_Unidad.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	exec SP_Deshabilitar_Xpcmdshell
	exec SP_Deshabilitar_FK

	begin tran
	delete from Guana_HospiDB_DW.dbo.Dim_Intervencion;
	delete from Guana_HospiDB_DW.dbo.Dim_Paciente_Unidad;
	delete from Guana_HospiDB_DW.dbo.Dim_Unidad;
    delete from Guana_HospiDB_DW.dbo.Dim_Doctor;
   
	delete from Guana_HospiDB_DW.dbo.Dim_Especialidad;
    bulk insert Guana_HospiDB_DW.dbo.Dim_Especialidad
    from 'C:\SQLSERVER\SqlCSV\Especialidad.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Doctor
    from 'C:\SQLSERVER\SqlCSV\Doctor.csv'
    with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Unidad
    from 'C:\SQLSERVER\SqlCSV\Unidad.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Paciente_Unidad
    from 'C:\SQLSERVER\SqlCSV\Paciente_Unidad.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Intervencion
    from 'C:\SQLSERVER\SqlCSV\Intervencion.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	exec SP_Habilitar_FK

	commit tran
end;
go

-- Creacion de procedimiento almacenado para exportar datos de Intervenciones y sus Tipos
drop procedure if exists SP_LoadIntervencionesTipos;
go
create procedure SP_LoadIntervencionesTipos
as
begin
	exec SP_Habilitar_Xpcmdshell
    declare @cmd nvarchar(1000);
    set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.TipoIntervencion" queryout "C:\SQLSERVER\SqlCSV\TipoIntervencion.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	set @cmd = 'bcp "SELECT * FROM Guana_HospiDB.dbo.Intervencion" queryout "C:\SQLSERVER\SqlCSV\Intervencion.csv" -c -t, -T -S' + @@SERVERNAME;
    exec xp_cmdshell @cmd;
	exec SP_Deshabilitar_Xpcmdshell
	exec SP_Deshabilitar_FK

	begin tran
	delete from Guana_HospiDB_DW.dbo.Dim_Intervencion;
    delete from Guana_HospiDB_DW.dbo.Dim_TipoIntervencion;

    bulk insert Guana_HospiDB_DW.dbo.Dim_TipoIntervencion
    from 'C:\SQLSERVER\SqlCSV\TipoIntervencion.csv'
   	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	bulk insert Guana_HospiDB_DW.dbo.Dim_Intervencion
    from 'C:\SQLSERVER\SqlCSV\Intervencion.csv'
	with ( fieldterminator = ',', rowterminator = '\n', tablock, batchsize = 100);

	exec SP_Habilitar_FK

	commit tran
end;
go
