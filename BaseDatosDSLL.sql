create database Escuela;
use Escuela;

-- TABLAS
-- DIRECCIONES
CREATE TABLE Departamentos (
    ID_Departamento CHAR(2) PRIMARY KEY,
    Departamento VARCHAR(60) NOT NULL,
    Pais VARCHAR(60)
);

create table Municipios(
	ID_Municipio char(3) primary key,
	Municipio varchar(60) not null,
	ID_Departamento char(2) not null
);

create table Distritos(
	ID_Distrito varchar(5) primary key,
	Distrito varchar(60) not null,
	ID_Municipio char(3) not null
);

CREATE TABLE Direcciones (
    ID_Direccion INT PRIMARY KEY AUTO_INCREMENT,
    Linea1 VARCHAR(100) NOT NULL,
    Linea2 VARCHAR(100),
    ID_Distrito VARCHAR(5) NOT NULL,
    CodigoPostal CHAR(5)
);

-- EMPLEADOS

create table Cargos(
	ID_Cargo INT PRIMARY KEY AUTO_INCREMENT,
    Cargo varchar(45) NOT NULL
);

create table Empleados(
	ID_Empleado INT PRIMARY KEY AUTO_INCREMENT,
    DUI_Empleado varchar(10) not null,
    ISSS_Empleado int not null,
    NombresEmpleado varchar(60) not null,
    ApellidosEmpleado varchar(60) not null,
    FechaNacEmpleado date not null,
    TelefonoEmpleado varchar(10) not null,
    Correo varchar(100),
    ID_Cargo int not null,
    ID_Direccion int not null   
);

create table Especialidades(
	ID_Especialidad INT PRIMARY KEY AUTO_INCREMENT,
	NombreEspecialidad varchar(100) not null,
	Carrera varchar(60) not null
);

create table Docentes(
	ID_Docente INT PRIMARY KEY AUTO_INCREMENT,	
	ID_Empleado int not null,
	ID_Especialidad int not null,
	Escalafon varchar(20)
);

-- MANEJO DE ROLES

create table Opciones(
	ID_Opcion INT PRIMARY KEY AUTO_INCREMENT,
    NombreOpcion varchar(60) not null
);

create table Roles(
	ID_Rol INT PRIMARY KEY AUTO_INCREMENT,
    NombreRol varchar(60) not null
);

create table AsignacionRolesOpciones(
	ID_AsignacionRol INT PRIMARY KEY AUTO_INCREMENT,
    ID_Rol int not null,
    ID_Opcion int not null
);

create table Usuarios(
	ID_Usuario INT PRIMARY KEY AUTO_INCREMENT,	
    ID_Empleado int not null,
	ID_Rol int not null,
    Usuario varchar(60) not null,
    Clave varchar(60) not null
);

-- GRUPOS
create table Turnos(
	ID_Turno INT PRIMARY KEY AUTO_INCREMENT,	
    Turno varchar(30) not null
);
create table Aulas(
	ID_Aula INT PRIMARY KEY AUTO_INCREMENT,	
    Edificio varchar(20),
    Piso varchar(10),	
    NumeroAula varchar(10)
);

create table Grupos(
	ID_Grupo INT PRIMARY KEY AUTO_INCREMENT,	
    Grado varchar(30) not null,
	Seccion varchar(10) not null,
    Anio int not null,
    ID_Turno int not null,
    ID_Aula int not null,
    ID_Docente int not null
);
-- ESTUDIANTES
create table Encargados(
	ID_Encargado INT PRIMARY KEY AUTO_INCREMENT,
	NombresEncargado varchar(60) not null,
	ApellidosEncargado varchar(60) not null,
	TelefonoEncargado varchar(10),
	DUI_Encargado varchar(10) not null,
	ID_Direccion int not null
);
create table Estudiantes(
	NIE INT PRIMARY KEY AUTO_INCREMENT,
    NombresEstudiante varchar(60) not null,
    ApellidosEstudiante varchar(60) not null,
    FechaNacEstudiante date not null,
    GeneroEstudiante char(1),
	TelefonoEstudiante varchar(10),
    ID_Encargado int not null,
    ID_Direccion int not null
);

create table Matriculas(
	ID_Matricula INT PRIMARY KEY AUTO_INCREMENT,
	NIE int not null,
	ID_Grupo int not null
);

create table Materias(
	ID_Materia INT PRIMARY KEY AUTO_INCREMENT,
	NombreMateria varchar(60)
);

create table Calificaciones(
	ID_Calificacion INT PRIMARY KEY AUTO_INCREMENT,
	ID_Materia int not null,
	NIE int not null,
	ID_Docente int not null,
	Examen1 decimal(3, 1),
	Examen2 decimal(3, 1),
	Examen3 decimal(3, 1),
	ExamenFinal decimal(3, 1),
	Tareas decimal(3, 1),
	Promedio decimal(3, 1),
	Estado char(1)
);

-- CONEXIONES CON LLAVES FOREANEAS

ALTER TABLE Municipios ADD FOREIGN KEY (ID_Departamento) REFERENCES Departamentos(ID_Departamento);
ALTER TABLE Distritos ADD FOREIGN KEY (ID_Municipio) REFERENCES Municipios(ID_Municipio);
ALTER TABLE Direcciones ADD FOREIGN KEY (ID_Distrito) REFERENCES Distritos(ID_Distrito);
ALTER TABLE Empleados ADD FOREIGN KEY (ID_Cargo) REFERENCES Cargos(ID_Cargo);
ALTER TABLE Empleados ADD FOREIGN KEY (ID_Direccion) REFERENCES Direcciones(ID_Direccion);
ALTER TABLE Docentes ADD FOREIGN KEY (ID_Empleado) REFERENCES Empleados(ID_Empleado);
ALTER TABLE Docentes ADD FOREIGN KEY (ID_Especialidad) REFERENCES Especialidades(ID_Especialidad);
ALTER TABLE Encargados ADD FOREIGN KEY (ID_Direccion) REFERENCES Direcciones(ID_Direccion);
ALTER TABLE Grupos ADD FOREIGN KEY (ID_Turno) REFERENCES Turnos(ID_Turno);
ALTER TABLE Grupos ADD FOREIGN KEY (ID_Aula) REFERENCES Aulas(ID_Aula);
ALTER TABLE Grupos ADD FOREIGN KEY (ID_Docente) REFERENCES Docentes(ID_Docente);
ALTER TABLE Estudiantes ADD FOREIGN KEY (ID_Direccion) REFERENCES Direcciones(ID_Direccion);
ALTER TABLE Estudiantes ADD FOREIGN KEY (ID_Encargado) REFERENCES Encargados(ID_Encargado);
ALTER TABLE Usuarios ADD FOREIGN KEY (ID_Empleado) REFERENCES Empleados(ID_Empleado);
ALTER TABLE Usuarios ADD FOREIGN KEY (ID_Rol) REFERENCES Roles(ID_Rol);
ALTER TABLE AsignacionRolesOpciones ADD FOREIGN KEY (ID_Rol) REFERENCES Roles(ID_Rol);
ALTER TABLE AsignacionRolesOpciones ADD FOREIGN KEY (ID_Opcion) REFERENCES Opciones(ID_Opcion);
ALTER TABLE Matriculas ADD FOREIGN KEY (NIE) REFERENCES Estudiantes(NIE);
ALTER TABLE Matriculas ADD FOREIGN KEY (ID_Grupo) REFERENCES Grupos(ID_Grupo);
ALTER TABLE Calificaciones ADD FOREIGN KEY (ID_Materia) REFERENCES Materias(ID_Materia);
ALTER TABLE Calificaciones ADD FOREIGN KEY (NIE) REFERENCES Estudiantes(NIE);
ALTER TABLE Calificaciones ADD FOREIGN KEY (ID_Docente) REFERENCES Docentes(ID_Docente);


