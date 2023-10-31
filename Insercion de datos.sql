use Guana_HospiDB
go

-- Insertar pacientes 
--exec SP_InsertarPaciente 'NumeroSeguroSocial(int)','Nombre(varchar)','Apellido1(varchar)','Apellido2(varchar)','Edad(Int)'
EXEC SP_InsertarPaciente '123456789', 'Juan', 'Perez', 'Gomez', 30;
EXEC SP_InsertarPaciente '987654321', 'Maria', 'Lopez', 'Rodriguez', 25;
EXEC SP_InsertarPaciente '112233445', 'Carlos', 'Gonzalez', 'Martinez', 40;
EXEC SP_InsertarPaciente '135790245', 'Laura', 'Torres', 'Ramirez', 35;
EXEC SP_InsertarPaciente '154204844', 'Pedro', 'Diaz', 'Santos', 28;
EXEC SP_InsertarPaciente '999988887', 'Alejandra', 'Fern�ndez', 'L�pez', 9;
EXEC SP_InsertarPaciente '876543210', 'Fernando', 'Hern�ndez', 'Garc�a', 45;
EXEC SP_InsertarPaciente '567890123', 'Ana', 'G�mez', 'S�nchez', 15;
EXEC SP_InsertarPaciente '345678912', 'Luis', 'Torres', 'Rodr�guez', 55;
EXEC SP_InsertarPaciente '432109876', 'Mar�a', 'Gonz�lez', 'Mart�nez', 38;


-- Insertar especialidades 
--exec SP_InsertarEspecialidad 'Nombre(varchar)'
EXEC SP_InsertarEspecialidad 'Cardiolog�a';
EXEC SP_InsertarEspecialidad 'Dermatolog�a';
EXEC SP_InsertarEspecialidad 'Neurolog�a';
EXEC SP_InsertarEspecialidad 'Ginecolog�a';
EXEC SP_InsertarEspecialidad 'Ortopedia';
EXEC SP_InsertarEspecialidad 'Pediatr�a';
EXEC SP_InsertarEspecialidad 'Oftalmolog�a';
EXEC SP_InsertarEspecialidad 'Urolog�a';
EXEC SP_InsertarEspecialidad 'Oncolog�a';
EXEC SP_InsertarEspecialidad 'Psiquiatr�a';


-- Insertar doctores 
--exec SP_InsertarDoctor 'Codigo(Int)','Nombre(varchar)','Apellido1(varchar)','Apellido2(varchar)','IdEspecialidad(int)'
EXEC SP_InsertarDoctor 01, 'Juan', 'Gonzalez', 'Lopez', 1; 
EXEC SP_InsertarDoctor 02, 'Maria', 'Rodriguez', 'Perez', 2; 
EXEC SP_InsertarDoctor 03, 'Roberto', 'Hernandez', 'Martinez', 3; 
EXEC SP_InsertarDoctor 04, 'Sofia', 'Gomez', 'Fernandez', 4; 
EXEC SP_InsertarDoctor 05, 'Daniel', 'Perez', 'Ramirez', 5;
EXEC SP_InsertarDoctor 06, 'Laura', 'D�az', 'Garc�a', 6;
EXEC SP_InsertarDoctor 07, 'Carlos', 'Torres', 'S�nchez', 7;
EXEC SP_InsertarDoctor 08, 'Ana', 'Fern�ndez', 'Rodr�guez', 8;
EXEC SP_InsertarDoctor 09, 'Luis', 'Gonz�lez', 'Mart�nez', 9;
EXEC SP_InsertarDoctor 10, 'Mar�a', 'L�pez', 'Hern�ndez', 10;


-- Insertar unidades m�dicas
--exec SP_InsertarUnidad 'Codigo(Int)','Nombre(varchar)','PlantaUnidad(int)','IdDoctor(int)'
EXEC SP_InsertarUnidad 101, 'Unidad A', 1, 1; 
EXEC SP_InsertarUnidad 102, 'Unidad B', 2, 2; 
EXEC SP_InsertarUnidad 103, 'Unidad C', 3, 3; 
EXEC SP_InsertarUnidad 104, 'Unidad D', 1, 4; 
EXEC SP_InsertarUnidad 105, 'Unidad E', 2, 5; 
EXEC SP_InsertarUnidad 106, 'Unidad F', 3, 6; 
EXEC SP_InsertarUnidad 107, 'Unidad G', 1, 7; 
EXEC SP_InsertarUnidad 108, 'Unidad H', 2, 8; 
EXEC SP_InsertarUnidad 109, 'Unidad I', 3, 9; 
EXEC SP_InsertarUnidad 110, 'Unidad J', 3, 10; 


-- Asociar pacientes a unidades m�dicas 
--exec SP_InsertarPaciente_Unidad 'IdPaciente(Int)','IdUnidad(Int)','Fechaingreso(datetime)','FechaSalida(datetime)'
EXEC SP_InsertarPaciente_Unidad 1, 1, '2023-10-11', '2023-11-10';
EXEC SP_InsertarPaciente_Unidad 2, 2, '2023-09-15', '2023-10-30';
EXEC SP_InsertarPaciente_Unidad 3, 3, '2023-08-05', '2023-09-15';
EXEC SP_InsertarPaciente_Unidad 4, 4, '2023-07-20', '2023-08-28';
EXEC SP_InsertarPaciente_Unidad 5, 5, '2023-06-10', '2023-07-20';
EXEC SP_InsertarPaciente_Unidad 6, 6, '2023-05-25', '2023-06-05';
EXEC SP_InsertarPaciente_Unidad 7, 7, '2023-04-04', '2023-05-25';
EXEC SP_InsertarPaciente_Unidad 8, 8, '2023-03-09', '2023-04-20';
EXEC SP_InsertarPaciente_Unidad 9, 9, '2023-02-01', '2023-03-08';
EXEC SP_InsertarPaciente_Unidad 10, 10, '2023-01-30', '2023-02-10';


-- Insertar tipos de intervenci�n 
--exec SP_InsertarTipoIntervencion 'Nombre(varchar)'
EXEC SP_InsertarTipoIntervencion 'Cirug�a';
EXEC SP_InsertarTipoIntervencion 'Tratamiento';
EXEC SP_InsertarTipoIntervencion 'Radioterapia';
EXEC SP_InsertarTipoIntervencion 'Fisioterapia';
EXEC SP_InsertarTipoIntervencion 'Psicoterapia';
EXEC SP_InsertarTipoIntervencion 'Anestesia';
EXEC SP_InsertarTipoIntervencion 'Rehabilitaci�n';
EXEC SP_InsertarTipoIntervencion 'Endoscopia';
EXEC SP_InsertarTipoIntervencion 'Terapia ocupacional';
EXEC SP_InsertarTipoIntervencion 'Cirug�a laparosc�pica';


-- Insertar enfermedades 
--exec SP_InsertarEnfermedad 'Nombre(varchar)'
EXEC SP_InsertarEnfermedad 'Fimosis';
EXEC SP_InsertarEnfermedad 'Hipertensi�n';
EXEC SP_InsertarEnfermedad 'Asma';
EXEC SP_InsertarEnfermedad 'Diabetes';
EXEC SP_InsertarEnfermedad 'Artritis';
EXEC SP_InsertarEnfermedad 'C�ncer de pulm�n';
EXEC SP_InsertarEnfermedad 'Gripe';
EXEC SP_InsertarEnfermedad 'Alergia';
EXEC SP_InsertarEnfermedad 'Esquizofrenia';
EXEC SP_InsertarEnfermedad 'Hipotiroidismo';


-- Insertar s�ntomas
--exec SP_InsertarSintoma 'Nombre(varchar)'
EXEC SP_InsertarSintoma 'Dolor de cabeza';
EXEC SP_InsertarSintoma 'Picaz�n';
EXEC SP_InsertarSintoma 'N�useas';
EXEC SP_InsertarSintoma 'Fatiga';
EXEC SP_InsertarSintoma 'Mareos';
EXEC SP_InsertarSintoma 'Dolor de espalda';
EXEC SP_InsertarSintoma 'Insomnio';
EXEC SP_InsertarSintoma 'Palpitaciones';
EXEC SP_InsertarSintoma 'Tos';
EXEC SP_InsertarSintoma 'Ansiedad';


-- Asociar enfermedades con s�ntomas 
--exec SP_InsertarEnfermedad_Sintoma'IdEnfermedad(int)','IdSintoma(int)'
EXEC SP_InsertarEnfermedad_Sintoma 1, 5; 
EXEC SP_InsertarEnfermedad_Sintoma 1, 4; 
EXEC SP_InsertarEnfermedad_Sintoma 1, 3; 
EXEC SP_InsertarEnfermedad_Sintoma 2, 2; 
EXEC SP_InsertarEnfermedad_Sintoma 2, 9; 
EXEC SP_InsertarEnfermedad_Sintoma 2, 10; 
EXEC SP_InsertarEnfermedad_Sintoma 3, 7; 
EXEC SP_InsertarEnfermedad_Sintoma 3, 5; 
EXEC SP_InsertarEnfermedad_Sintoma 3, 1; 
EXEC SP_InsertarEnfermedad_Sintoma 4, 3;
EXEC SP_InsertarEnfermedad_Sintoma 4, 9;
EXEC SP_InsertarEnfermedad_Sintoma 4, 1;
EXEC SP_InsertarEnfermedad_Sintoma 5, 7; 
EXEC SP_InsertarEnfermedad_Sintoma 5, 6; 
EXEC SP_InsertarEnfermedad_Sintoma 5, 1; 
EXEC SP_InsertarEnfermedad_Sintoma 6, 2;
EXEC SP_InsertarEnfermedad_Sintoma 6, 3;
EXEC SP_InsertarEnfermedad_Sintoma 6, 8;
EXEC SP_InsertarEnfermedad_Sintoma 7, 4;
EXEC SP_InsertarEnfermedad_Sintoma 7, 5;
EXEC SP_InsertarEnfermedad_Sintoma 7, 1;
EXEC SP_InsertarEnfermedad_Sintoma 8, 2;
EXEC SP_InsertarEnfermedad_Sintoma 8, 5;
EXEC SP_InsertarEnfermedad_Sintoma 8, 7;
EXEC SP_InsertarEnfermedad_Sintoma 9, 9;
EXEC SP_InsertarEnfermedad_Sintoma 9, 3;
EXEC SP_InsertarEnfermedad_Sintoma 9, 2;
EXEC SP_InsertarEnfermedad_Sintoma 10, 10;
EXEC SP_InsertarEnfermedad_Sintoma 10, 6;
EXEC SP_InsertarEnfermedad_Sintoma 10, 5;


-- Registrar intervenciones m�dicas de prueba
--exec SP_InsertarIntervencion 'FechaIntervencion(datetime)','Prescripcion(varchar)','IdTipoIntervencion(int)','IdEnfermedad(int)','IdPaciente(Int)','IdDoctor(int)'
EXEC SP_InsertarIntervencion '2023-02-01', 'Receta de medicamentos', 1, 1, 1, 1; 
EXEC SP_InsertarIntervencion '2023-03-04', 'Terapia f�sica', 2, 2, 2, 2;
EXEC SP_InsertarIntervencion '2023-04-07', 'Control de presi�n arterial', 3, 3, 3, 3;
EXEC SP_InsertarIntervencion '2023-05-11', 'Examen de piel', 4, 4, 4, 4;
EXEC SP_InsertarIntervencion '2023-06-15', 'Cirug�a de rodilla', 5, 5, 5, 5;
EXEC SP_InsertarIntervencion '2023-07-19', 'Terapia de rehabilitaci�n', 6, 6, 6, 6;
EXEC SP_InsertarIntervencion '2023-08-21', 'Radioterapia contra el c�ncer', 7, 7, 7, 7;
EXEC SP_InsertarIntervencion '2023-09-25', 'Cirug�a de ap�ndice', 8, 8, 8, 8;
EXEC SP_InsertarIntervencion '2023-01-31', 'Receta de medicamentos', 9, 9, 9, 9;
EXEC SP_InsertarIntervencion '2023-11-10', 'Reposo', 10, 10, 10, 10;




