DROP DATABASE IF EXISTS clinica;
CREATE DATABASE IF NOT EXISTS clinica;
USE clinica ;

CREATE TABLE IF NOT EXISTS Departamentos(
  idDepartamento CHAR(2) NOT NULL UNIQUE,
  departamento VARCHAR(25) NOT NULL,
  pais VARCHAR(25) NOT NULL,
  PRIMARY KEY (idDepartamento)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Municipios(
  idMunicipio CHAR(3) NOT NULL UNIQUE,
  Municipio VARCHAR(50) NOT NULL,
  idDepartamento CHAR(2) NOT NULL,
  PRIMARY KEY (idMunicipio),
    FOREIGN KEY (idDepartamento)
    REFERENCES Departamentos (idDepartamento)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Distritos (
  idDistrito CHAR(5) NOT NULL UNIQUE,
  distrito VARCHAR(50) NOT NULL,
  idMunicipio CHAR(3) NOT NULL,
  PRIMARY KEY (idDistrito),
    FOREIGN KEY (idMunicipio)
    REFERENCES Municipios (idMunicipio)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Direcciones (
  idDireccion INT NOT NULL AUTO_INCREMENT,
  Linea1 VARCHAR(100) NULL,
  Linea2 VARCHAR(100) NULL,
  codigoPostal VARCHAR(5) NULL,
  idDistrito CHAR(5) NOT NULL,
  PRIMARY KEY (idDireccion),
    FOREIGN KEY (idDistrito)
    REFERENCES Distritos (idDistrito)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Pacientes (
  idPaciente INT NOT NULL AUTO_INCREMENT,
  nombrePaciente VARCHAR(45) NOT NULL,
  apellidoPaciente VARCHAR(45) NOT NULL,
  generoPaciente VARCHAR(45) NOT NULL,
  fechaNacPaciente VARCHAR(45) NULL,
  emailPaciente VARCHAR(45) NULL,
  duiPaciente VARCHAR(45) NOT NULL,
  ocupacionPaciente VARCHAR(45) NULL,
  estadoCivil VARCHAR(45) NULL,
  idDireccion INT NOT NULL,
  PRIMARY KEY (idPaciente),
    FOREIGN KEY (idDireccion)
    REFERENCES Direcciones (idDireccion)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Cargos (
  idTipoCargo INT NOT NULL AUTO_INCREMENT,
  TipoCargo VARCHAR(45) NOT NULL,
  PRIMARY KEY (idTipoCargo)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Empleados (
  idEmpleado INT NOT NULL AUTO_INCREMENT,
  nombreEmpleado VARCHAR(45) NOT NULL,
  apellidoEmpleado VARCHAR(45) NOT NULL,
  emailEmpleado VARCHAR(90) NOT NULL,
  telefonoEmpleado VARCHAR(45) NOT NULL,
  fechaContratacion VARCHAR(45) NOT NULL,
  duiEmpleado CHAR(10) NOT NULL,
  idDireccion INT NOT NULL,
  idTipoCargo INT NOT NULL,
  PRIMARY KEY (idEmpleado),
    FOREIGN KEY (idDireccion)
    REFERENCES Direcciones (idDireccion),
    FOREIGN KEY (idTipoCargo)
    REFERENCES Cargos (idTipoCargo)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Doctores (
  idDoctor INT NOT NULL AUTO_INCREMENT,
  idEmpleados INT NOT NULL,
  JVPM INT NOT NULL,
  PRIMARY KEY (idDoctor),
    FOREIGN KEY (idEmpleados)
    REFERENCES Empleados (idEmpleado)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Especialidades (
  idEspecialidad INT NOT NULL AUTO_INCREMENT,
  nombreEspecialidad VARCHAR(45) NOT NULL,
  PRIMARY KEY (idEspecialidad)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS TipoCitas(
  idTipoCita INT NOT NULL AUTO_INCREMENT,
  tipoCita VARCHAR(45) NOT NULL,
  PRIMARY KEY (idTipoCita)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Citas (
  idCita INT NOT NULL AUTO_INCREMENT,
  fechaHoraCita DATETIME(6) NOT NULL,
  idPaciente INT NOT NULL,
  idTipoCita INT NOT NULL,
  PRIMARY KEY (idCita),
    FOREIGN KEY (idPaciente)
    REFERENCES Pacientes (idPaciente),
    FOREIGN KEY (idTipoCita)
    REFERENCES TipoCitas (idTipoCita)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Consultorios (
  idConsultorio INT NOT NULL AUTO_INCREMENT,
  nombreConsultorio VARCHAR(45) NOT NULL,
  seccionConsultorio VARCHAR(45) NOT NULL,
  pisoConsultorio VARCHAR(45) NOT NULL,
  PRIMARY KEY (idConsultorio)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS TiposConsultas (
  idTipoConsulta INT NOT NULL AUTO_INCREMENT,
  tipoConsulta VARCHAR(45) NOT NULL,
  precioConsulta DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (idTipoConsulta)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS ExamenesFisicos (
  idExamenFisico INT NOT NULL AUTO_INCREMENT,
  pulso VARCHAR(45) NOT NULL,
  presionArterial VARCHAR(45) NOT NULL,
  temperatura VARCHAR(45) NOT NULL,
  estadoPiel VARCHAR(45) NOT NULL,
  comportamiento VARCHAR(45) NOT NULL,
  inspeccionOjos VARCHAR(45) NULL,
  inspeccionOidos VARCHAR(45) NULL,
  inspeccionCabeza VARCHAR(45) NULL,
  inspeccionAbdomen VARCHAR(45) NOT NULL,
  inspeccionExtremidades VARCHAR(45) NOT NULL,
  funcionSensorial VARCHAR(45) NOT NULL,
  PRIMARY KEY (idExamenFisico)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Recetas (
  idrecetas INT NOT NULL AUTO_INCREMENT,
  fechaReceta DATE NOT NULL,
  duracionReceta INT NOT NULL,
  PRIMARY KEY (idrecetas)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Expediente (
  idExpediente INT NOT NULL AUTO_INCREMENT,
  padecimiento LONGTEXT NULL,
  alergias LONGTEXT NULL,
  tratamientos LONGTEXT NULL,
  notasAdicionales VARCHAR(45) NULL,
  idPaciente INT NOT NULL,
  PRIMARY KEY (idExpediente),
    FOREIGN KEY (idPaciente)
    REFERENCES Pacientes (idPaciente)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Consultas (
  idConsulta INT NOT NULL UNIQUE AUTO_INCREMENT,
  DiagnosticoConsulta VARCHAR(255) NOT NULL,
  EstadoConsulta ENUM('finalizada', 'pendiente', 'cancelada') NOT NULL,
  idTipoConsultas INT NOT NULL,
  idExamenFisico INT NOT NULL,
  idDoctor INT NOT NULL,
  idRecetas INT NOT NULL,
  idCita INT NOT NULL,
  idConsultorio INT NOT NULL,
  idExpediente INT NOT NULL,
  PRIMARY KEY (idConsulta),
    FOREIGN KEY (idTipoConsultas)
    REFERENCES TiposConsultas (idTipoConsulta),
    FOREIGN KEY (idExamenFisico)
    REFERENCES ExamenesFisicos (idExamenFisico),
    FOREIGN KEY (idDoctor)
    REFERENCES Doctores(idDoctor),
    FOREIGN KEY (idrecetas)
    REFERENCES Recetas (idrecetas),
    FOREIGN KEY (idCita)
    REFERENCES Citas (idCita),
    FOREIGN KEY (idConsultorio)
    REFERENCES Consultorios (idConsultorio),
    FOREIGN KEY (idExpediente)
    REFERENCES Expediente (idExpediente)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS TiposProcedimientos (
  idTipoProcedimiento INT NOT NULL AUTO_INCREMENT,
  tipoProcedimiento VARCHAR(45) NOT NULL UNIQUE,
  descripcionProcedimiento VARCHAR(300) NOT NULL,
  PRIMARY KEY (idTipoProcedimiento) 
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS ProcedimientosMedicos (
  idProcedimiento INT NOT NULL UNIQUE AUTO_INCREMENT,
  fechaHoraProcedimiento DATETIME(6) NOT NULL,
  duracion TIME NOT NULL,
  idTipoProcedimiento INT NOT NULL,
  idConsulta INT NOT NULL,
  PRIMARY KEY (idProcedimiento),
    FOREIGN KEY (idTipoProcedimiento)
    REFERENCES TiposProcedimientos (idTipoProcedimiento),
    FOREIGN KEY (idConsulta)
    REFERENCES Consultas (idConsulta)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS DoctorEspecialidades (
  idDoctor INT NOT NULL ,
  idEspecialidad INT NOT NULL,
  PRIMARY KEY (idDoctor, idEspecialidad),
    FOREIGN KEY (idDoctor)
    REFERENCES Doctores (idDoctor),
    FOREIGN KEY (idEspecialidad)
    REFERENCES Especialidades (idEspecialidad)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Laboratorista (
  idLaboratorista INT NOT NULL AUTO_INCREMENT,
  idEmpleados INT NOT NULL,
  JVPLC INT NOT NULL,
  PRIMARY KEY (idLaboratorista),
    FOREIGN KEY (idEmpleados)
    REFERENCES Empleados (idEmpleado)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS EspecialidadLaboratorista (
  idLaboratorista INT NOT NULL ,
  idEspecialidad INT NOT NULL ,
  PRIMARY KEY (idLaboratorista, idEspecialidad),
    FOREIGN KEY (idLaboratorista)
    REFERENCES Laboratorista (idLaboratorista),
    FOREIGN KEY (idEspecialidad)
    REFERENCES Especialidades (idEspecialidad)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS TipoExamenes (
  idTipoExamen INT NOT NULL AUTO_INCREMENT,
  TipoExamen VARCHAR(45) NOT NULL UNIQUE,
  descripcionExamen VARCHAR(300) NOT NULL,
  PRIMARY KEY (idTipoExamen)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Examenes (
  idExamen INT NOT NULL AUTO_INCREMENT,
  fechaHoraExamen DATETIME(6) NOT NULL,
  muestraBiologica VARCHAR(45) NOT NULL,
  unidadesMedida VARCHAR(5) NOT NULL,
  idTipoExamen INT NOT NULL,
  idLaboratorista INT NOT NULL,
  idCita INT NOT NULL,
  PRIMARY KEY (idExamen),
    FOREIGN KEY (idTipoExamen)
    REFERENCES TipoExamenes(idTipoExamen),
    FOREIGN KEY (idLaboratorista)
    REFERENCES Laboratorista (idLaboratorista),
    FOREIGN KEY (idCita)
    REFERENCES Citas (idCita)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS TiposMedicamentos (
  idTipoMedicamento INT NOT NULL AUTO_INCREMENT,
  TipoMedicamento VARCHAR(45) NOT NULL UNIQUE,
  PRIMARY KEY (idTipoMedicamento)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Laboratorios (
  idLaboratorio INT NOT NULL AUTO_INCREMENT,
  nombreLaboratorio VARCHAR(45) NOT NULL,
  PRIMARY KEY (idLaboratorio)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Medicamentos (
  idMedicamentos INT NOT NULL AUTO_INCREMENT,
  nombreMedicamento VARCHAR(45) NOT NULL,
  formulaActiva VARCHAR(50) NOT NULL,
  idTipoMedicamento INT NOT NULL,
  idLaboratorio INT NOT NULL,
  PRIMARY KEY (idMedicamentos),
    FOREIGN KEY (idTipoMedicamento)
    REFERENCES TiposMedicamentos (idTipoMedicamento),
    FOREIGN KEY (idLaboratorio)
    REFERENCES Laboratorios (idLaboratorio)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS TipoEquipoMedico (
  idTipoEquipoMedico INT NOT NULL AUTO_INCREMENT,
  tipoEquipoMedico VARCHAR(45) NOT NULL UNIQUE,
  PRIMARY KEY (idTipoEquipoMedico)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Proveedores (
  idproveedores INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  direccion VARCHAR(45) NOT NULL,
  telefono VARCHAR(45) NOT NULL,
  PRIMARY KEY (idproveedores)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Inventario (
  idInventario INT NOT NULL AUTO_INCREMENT,
  bodega VARCHAR(45) NOT NULL,
  seccion VARCHAR(45) NOT NULL,
  pasillo VARCHAR(45) NOT NULL,
  estante VARCHAR(45) NOT NULL,
  PRIMARY KEY (idInventario)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS EquiposMedicos (
  idEquipoMedico INT NOT NULL AUTO_INCREMENT,
  nombreEquipo VARCHAR(45) NOT NULL,
  marcaEquipo VARCHAR(45) NULL,
  fechaAdquision DATE NOT NULL,
  idTipoEquipoMedico INT NOT NULL,
  idProveedores INT NOT NULL,
  idInventario INT NOT NULL,
  cantidad INT NOT NULL,
  PRIMARY KEY (idEquipoMedico),
    FOREIGN KEY (idTipoEquipoMedico)
    REFERENCES TipoEquipoMedico (idTipoEquipoMedico),
    FOREIGN KEY (idProveedores)
    REFERENCES Proveedores (idproveedores),
    FOREIGN KEY (idInventario)
    REFERENCES Inventario (idInventario)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS MedicamentosRecetados (
  idMedicamentos INT NOT NULL,
  idrecetas INT NOT NULL,
  dosis VARCHAR(200) NOT NULL,
  PRIMARY KEY (idMedicamentos, idrecetas),
    FOREIGN KEY (idMedicamentos)
    REFERENCES Medicamentos (idMedicamentos),
    FOREIGN KEY (idrecetas)
    REFERENCES Recetas (idrecetas)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Enfermeros (
  idEnfermeros INT NOT NULL AUTO_INCREMENT,
  idEmpleado INT NOT NULL,
  JVPE INT NOT NULL,
  PRIMARY KEY (idEnfermeros),
    FOREIGN KEY (idEmpleado)
    REFERENCES Empleados (idEmpleado)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS PersonalProcedimientos (
  idPersonalProcedimientos INT NOT NULL AUTO_INCREMENT,
  idEnfermero INT NOT NULL,
  idDoctor INT NOT NULL,
  idProcedimiento INT NOT NULL,
  PRIMARY KEY (idPersonalProcedimientos),
    FOREIGN KEY (idEnfermero)
    REFERENCES Enfermeros (idEnfermeros),
    FOREIGN KEY (idDoctor)
    REFERENCES Doctores (idDoctor),
    FOREIGN KEY (idProcedimiento)
    REFERENCES ProcedimientosMedicos (idProcedimiento)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS FacturaConsulta (
  idFacturaConsulta INT NOT NULL AUTO_INCREMENT,
  idConsulta INT NOT NULL,
  idPaciente INT NOT NULL,
  fecha DATE NOT NULL,
  total DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (idFacturaConsulta),
    FOREIGN KEY (idConsulta)
    REFERENCES Consultas (idConsulta),
    FOREIGN KEY (idPaciente)
    REFERENCES Pacientes (idPaciente)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS FacturasExamenes (
  idFacturaExamenes INT NOT NULL AUTO_INCREMENT,
  idPaciente INT NOT NULL,
  fechaFE DATETIME(2) NOT NULL,
  totalFE DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (idFacturaExamenes),
    FOREIGN KEY (idPaciente)
    REFERENCES Pacientes (idPaciente)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS FacturaProcedimientos (
  idFacturaProcedimientos INT NOT NULL AUTO_INCREMENT,
  idPaciente INT NOT NULL,
  fechaFP DATETIME(2) NOT NULL,
  totalFp DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (idFacturaProcedimientos),
    FOREIGN KEY (idPaciente)
    REFERENCES Pacientes (idPaciente)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS DetallesFacturaExamen (
  idDetallesFacturaExamen INT NOT NULL AUTO_INCREMENT,
  precioUnitario DECIMAL(6,2) NOT NULL,
  idFacturaProcedimientos INT NOT NULL,
  idProcedimiento INT NOT NULL,
  PRIMARY KEY (idDetallesFacturaExamen),
    FOREIGN KEY (idFacturaProcedimientos)
    REFERENCES FacturaProcedimientos (idFacturaProcedimientos),
    FOREIGN KEY (idProcedimiento)
    REFERENCES ProcedimientosMedicos(idProcedimiento)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS DetallesFacturaProcedimientos (
  idDetallesFacturaProcedimientos INT NOT NULL AUTO_INCREMENT,
  precioUnitario DECIMAL(6,2) NOT NULL,
  idFacturaProcedimientos INT NOT NULL,
  idProcedimiento INT NOT NULL,
  PRIMARY KEY (idDetallesFacturaProcedimientos),
    FOREIGN KEY (idFacturaProcedimientos)
    REFERENCES FacturaProcedimientos (idFacturaProcedimientos),
    FOREIGN KEY (idProcedimiento)
    REFERENCES ProcedimientosMedicos(idProcedimiento)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS InsumosMedicos (
  idInsumosMedicos INT NOT NULL AUTO_INCREMENT,
  idMedicamentos INT NOT NULL,
  idEquipoMedico INT NOT NULL,
  idProcedimiento INT NOT NULL,
  PRIMARY KEY (idInsumosMedicos),
    FOREIGN KEY (idMedicamentos)
    REFERENCES Medicamentos (idMedicamentos),
    FOREIGN KEY (idEquipoMedico)
    REFERENCES EquiposMedicos (idEquipoMedico),
    FOREIGN KEY (idProcedimiento)
    REFERENCES ProcedimientosMedicos (idProcedimiento)
)ENGINE = InnoDB;