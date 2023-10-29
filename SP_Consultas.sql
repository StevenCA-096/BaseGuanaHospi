--Consultas completas
use Guana_HospiDB
go

--Consultar doctores
drop procedure if exists SP_ConsultarDoctores
go
create procedure SP_ConsultarDoctores
as
begin
	select * from Doctor,Especialidad where Doctor.ID_Especialidad = Especialidad.ID_Especialidad
end
go
