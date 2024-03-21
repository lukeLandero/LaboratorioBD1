CREATE DATABASE IF NOT EXISTS clinica;
USE clinica ;


CREATE TABLE IF NOT EXISTS departamentos (
  idDepartamento CHAR(2) NOT NULL,
  departamento VARCHAR(25) NOT NULL,
  pais VARCHAR(25) NOT NULL,
  PRIMARY KEY (idDepartamento)
  )ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS  municipios (
  idMunicipio CHAR(3) NOT NULL,
  Municipio VARCHAR(50) NOT NULL,
  idDepartamento CHAR(2) NOT NULL,
  PRIMARY KEY (idMunicipio),
    FOREIGN KEY (idDepartamento)
    REFERENCES departamentos(idDepartamento)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS distritos (
  idDistrito CHAR(5) NOT NULL,
  distrito VARCHAR(50) NOT NULL,
  idMunicipio CHAR(3) NOT NULL,
  PRIMARY KEY (idDistrito),
    FOREIGN KEY (idMunicipio)
    REFERENCES municipios(idMunicipio)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS direcciones (
  idDireccion INT NOT NULL,
  Linea1 VARCHAR(100) NULL,
  Linea2 VARCHAR(100) NULL,
  codigoPostal VARCHAR(5) NULL,
  idDistrito CHAR(5) NOT NULL,
  PRIMARY KEY (idDireccion),
    FOREIGN KEY (idDistrito)
    REFERENCES distritos(idDistrito)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS pacientes(
  idPaciente INT NOT NULL,
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
    REFERENCES direcciones(idDireccion)
)ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS cargos (
  idTipoCargo INT NOT NULL,
  TipoCargo VARCHAR(45) NOT NULL,
  PRIMARY KEY (idTipoCargo)
  )ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS empleados (
  idEmpleado INT NOT NULL AUTO_INCREMENT,
  nombreEmpleado VARCHAR(45) NOT NULL,
  apellidoEmpleado VARCHAR(45) NOT NULL,
  emailEmpleado VARCHAR(45) NOT NULL,
  telefonoEmpleado VARCHAR(45) NOT NULL,
  fechaContratacion VARCHAR(45) NOT NULL,
  duiEmpleado VARCHAR(45) NOT NULL,
  idDireccion INT NOT NULL,
  idTipoCargo INT NOT NULL,
  PRIMARY KEY (idEmpleado),
    FOREIGN KEY (idDireccion)
    REFERENCES direcciones(idDireccion),
    FOREIGN KEY (idTipoCargo)
    REFERENCES cargos(idTipoCargo)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS doctores(
  idDoctor INT NOT NULL AUTO_INCREMENT,
  idEmpleado INT NOT NULL,
  PRIMARY KEY (idDoctor),
    FOREIGN KEY (idEmpleado)
    REFERENCES empleados(idEmpleado)
)ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS especialidades (
  idEspecialidad INT NOT NULL,
  nombreEspecialidad VARCHAR(45) NOT NULL,
  PRIMARY KEY (idEspecialidad)
  )ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS consultorios (
  idConsultorio INT NOT NULL AUTO_INCREMENT,
  nombreConsultorio VARCHAR(45) NOT NULL,
  seccionConsultorio VARCHAR(45) NOT NULL,
  pisoConsultorio VARCHAR(45) NOT NULL,
  Consultorio VARCHAR(45) NOT NULL,
  PRIMARY KEY (idConsultorio)
  )ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS tipo_citas (
  idTipoCita INT NOT NULL AUTO_INCREMENT,
  tipoCita VARCHAR(45) NOT NULL,
  PRIMARY KEY (idTipoCita)
  )ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS citas (
  idCita INT NOT NULL,
  fechaHoraCita DATETIME(000) NOT NULL,
  idConsultorio INT NOT NULL,
  idTipoCita INT NOT NULL,
  idPaciente INT NOT NULL,
  PRIMARY KEY (idCita),
  UNIQUE INDEX idCita_UNIQUE (idCita),
    FOREIGN KEY (idConsultorio)
    REFERENCES consultorios(idConsultorio),
    FOREIGN KEY (idTipoCita)
    REFERENCES tipo_citas(idTipoCita),
    FOREIGN KEY (idPaciente)
    REFERENCES pacientes (idPaciente)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS tipo_consultas(
  idTipoConsulta INT NOT NULL,
  TipoConsulta VARCHAR(45) NOT NULL,
  PRIMARY KEY (idTipoConsulta)
  )ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS examenes_fisicos (
  idExamenFisico INT NOT NULL,
  pulso VARCHAR(45) NOT NULL,
  presionArterial VARCHAR(45) NOT NULL,
  temperatura VARCHAR(45) NOT NULL,
  estadoPiel VARCHAR(45) NOT NULL,
  comportamiento VARCHAR(45) NOT NULL,
  inspeccionOjos VARCHAR(45) NULL,
  inspeccionOidos VARCHAR(45) NULL,
  inspeccionCabez VARCHAR(45) NULL,
  inspeccionAbdomen VARCHAR(45) NOT NULL,
  inspeccionExtremidades VARCHAR(45) NOT NULL,
  funcionSensorial VARCHAR(45) NOT NULL,
  PRIMARY KEY (idExamenFisico)
  )ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS recetas (
  idReceta INT NOT NULL,
  instruccionReceta VARCHAR(45) NOT NULL,
  fechaReceta DATE NOT NULL,
  duracionReceta INT NOT NULL,
  PRIMARY KEY (idReceta)
  )ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS facturas(
  idFactura INT NOT NULL,
  fecha DATE NOT NULL,
  total DECIMAL(6,2) NOT NULL,
  idPaciente INT NOT NULL,
  PRIMARY KEY (idFactura),
    FOREIGN KEY (idPaciente)
    REFERENCES pacientes(idPaciente)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS consultas(
  idConsulta INT NOT NULL,
  fechaHoraConsulta DATETIME(6) NOT NULL,
  DiagnosticoConsulta VARCHAR(45) NOT NULL,
  EstadoConsulta ENUM('Finalizada', 'Pendiente', 'Cancelada') NOT NULL,
  tratamiento VARCHAR(45) NOT NULL,
  idTipoConsulta INT NOT NULL,
  idExamenFisico INT NOT NULL,
  idPaciente INT NOT NULL,
  idDoctor1 INT NOT NULL,
  idFactura INT NOT NULL,
  recetas_idReceta INT NOT NULL,
  facturas_idFactura INT NOT NULL,
  PRIMARY KEY (idConsulta),
  UNIQUE INDEX idConsulta_UNIQUE (idConsulta),
    FOREIGN KEY (idTipoConsulta)
    REFERENCES tipo_consultas (idTipoConsulta),
    FOREIGN KEY (idExamenFisico)
    REFERENCES examenes_fisicos (idExamenFisico),
    FOREIGN KEY (idPaciente)
    REFERENCES pacientes(idPaciente),
    FOREIGN KEY (idDoctor1)
    REFERENCES doctores(idDoctor),
    FOREIGN KEY (recetas_idReceta)
    REFERENCES recetas(idReceta),
    FOREIGN KEY (facturas_idFactura)
    REFERENCES facturas (idFactura)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS tipo_examenes (
  idTipoExamen INT NOT NULL,
  TipoExamen VARCHAR(45) NOT NULL,
  descripcionExamen VARCHAR(45) NOT NULL,
  precioExamen DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (idTipoExamen),
  UNIQUE INDEX TipoExamen_UNIQUE (TipoExamen)
  )ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS Laboratorista (
  idLaborotorista INT NOT NULL,
  idEmpleado INT NOT NULL,
  PRIMARY KEY (idLaborotorista),
    FOREIGN KEY (idEmpleado)
    REFERENCES empleados (idEmpleado)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS examenes (
  idExamen INT NOT NULL,
  fechaHoraExamen DATETIME(6) NOT NULL,
  muestraBiologica VARCHAR(45) NOT NULL,
  unidadesMedida VARCHAR(5) NOT NULL,
  idTipoExamen INT NOT NULL,
  idLaborotorista INT NOT NULL,
  idPaciente INT NOT NULL,
  idFactura INT NOT NULL,
  PRIMARY KEY (idExamen),
    FOREIGN KEY (idTipoExamen)
    REFERENCES tipo_examenes (idTipoExamen),
    FOREIGN KEY (idLaborotorista)
    REFERENCES Laboratorista(idLaborotorista),
    FOREIGN KEY (idPaciente)
    REFERENCES pacientes(idPaciente),
    FOREIGN KEY (idFactura)
    REFERENCES facturas(idFactura)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS examen_consulta (
  idExamenConsulta INT NOT NULL,
  idConsulta INT NOT NULL,
  idExamen INT NOT NULL,
  PRIMARY KEY (idExamenConsulta),
    FOREIGN KEY (idConsulta)
    REFERENCES consultas(idConsulta),
    FOREIGN KEY (idExamen)
    REFERENCES examenes(idExamen)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS historial_medico (
  idHistorialMedico INT NOT NULL,
  idExamenConsulta INT NOT NULL,
  PRIMARY KEY (idHistorialMedico),
    FOREIGN KEY (idExamenConsulta)
    REFERENCES examen_consulta(idExamenConsulta)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS tipo_procedimientos(
  idTipoProcedimiento INT NOT NULL,
  tipoProcedimiento VARCHAR(45) NOT NULL,
  precioProcedimiento DECIMAL(6,2) NOT NULL,
  descripcionProcedimiento VARCHAR(150) NOT NULL,
  PRIMARY KEY (idTipoProcedimiento),
  UNIQUE INDEX tipoProcedimiento_UNIQUE (tipoProcedimiento) 
  )ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS procedimientos_medicos(
  idProcedimiento INT NOT NULL,
  idTipoServicio INT NOT NULL,
  fechaHoraProcedimiento DATETIME(6) NOT NULL,
  duracion TIME NOT NULL,
  idDoctor INT NOT NULL,
  idPaciente INT NOT NULL,
  idFactura INT NOT NULL,
  PRIMARY KEY (idProcedimiento),
  UNIQUE INDEX idServicio_UNIQUE (idProcedimiento),
    FOREIGN KEY (idTipoServicio)
    REFERENCES tipo_procedimientos (idTipoProcedimiento),
    FOREIGN KEY (idDoctor)
    REFERENCES doctores(idDoctor),
    FOREIGN KEY (idPaciente)
    REFERENCES pacientes(idPaciente),
    FOREIGN KEY (idFactura)
    REFERENCES facturas(idFactura)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS doctor_especialidad(
  idDoctor INT NOT NULL,
  idEspecialidad INT NOT NULL,
  PRIMARY KEY (idDoctor, idEspecialidad),
    FOREIGN KEY (idDoctor)
    REFERENCES doctores (idDoctor),
    FOREIGN KEY (idEspecialidad)
    REFERENCES especialidades (idEspecialidad)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS LaborotoristaEspecialidades(
  idLaborotorista INT NOT NULL,
  idEspecialidad INT NOT NULL,
  PRIMARY KEY (idLaborotorista, idEspecialidad),
    FOREIGN KEY (idLaborotorista)
    REFERENCES Laboratorista (idLaborotorista),
    FOREIGN KEY (idEspecialidad)
    REFERENCES especialidades (idEspecialidad)
)ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS forma_farmaceutica (
  idFormaFarmaceutica INT NOT NULL,
  formaFarmaceutica VARCHAR(45) NOT NULL,
  PRIMARY KEY (idFormaFarmaceutica),
  UNIQUE INDEX formaFarmaceutica_UNIQUE (formaFarmaceutica)
  )ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS tipo_medicamento(
  idTipoMedicamento INT NOT NULL,
  TipoMedicamento VARCHAR(45) NOT NULL,
  PRIMARY KEY (idTipoMedicamento),
  UNIQUE INDEX TipoMedicamento_UNIQUE (TipoMedicamento)
  )ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS proveedores (
  idProveedor INT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  direccion VARCHAR(45) NOT NULL,
  telefono VARCHAR(45) NOT NULL,
  PRIMARY KEY (idProveedor)
  )ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS  medicamentos (
  idMedicamento INT NOT NULL,
  nombreMedicamento VARCHAR(45) NOT NULL,
  formula VARCHAR(45) NOT NULL,
  dosisMedicamento VARCHAR(45) NOT NULL,
  prescripciónRequerida TINYINT NOT NULL,
  cantidadMedicamrntos INT NOT NULL,
  precioMedicamento DECIMAL(6,2) NOT NULL,
  FechaAdquisionMedicamento DATE NOT NULL,
  idFormaFarmaceutica INT NOT NULL,
  idTipoMedicamento INT NOT NULL,
  idProveedor INT NOT NULL,
  PRIMARY KEY (idMedicamento),
    FOREIGN KEY (idFormaFarmaceutica)
    REFERENCES forma_farmaceutica (idFormaFarmaceutica),
    FOREIGN KEY (idTipoMedicamento)
    REFERENCES tipo_medicamento (idTipoMedicamento),
    FOREIGN KEY (idProveedor)
    REFERENCES proveedores (idProveedor)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS tipo_equipo_medico (
  idTipoEquipoMedico INT NOT NULL,
  tipoEquipoMedico VARCHAR(45) NOT NULL,
  PRIMARY KEY (idTipoEquipoMedico),
  UNIQUE INDEX tipoEquipoMedico_UNIQUE (tipoEquipoMedico)
  )ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS equipo_medico (
  idEquipoMedico INT NOT NULL,
  nombreEquipo VARCHAR(45) NOT NULL,
  marcaEquipo VARCHAR(45) NULL,
  ubicacionEquipo VARCHAR(45) NOT NULL,
  estadoEquipo VARCHAR(45) NOT NULL,
  fechaAdquision DATE NOT NULL,
  idTipoEquipoMedico INT NOT NULL,
  idProveedor INT NOT NULL,
  PRIMARY KEY (idEquipoMedico),
    FOREIGN KEY (idTipoEquipoMedico)
    REFERENCES tipo_equipo_medico(idTipoEquipoMedico),
    FOREIGN KEY (idProveedor)
    REFERENCES proveedores(idProveedor)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS procedimiento_equipo (
  idEquipoMedico INT NOT NULL,
  idProcedimiento INT NOT NULL,
  PRIMARY KEY (idEquipoMedico, idProcedimiento),
    FOREIGN KEY (idEquipoMedico)
    REFERENCES equipo_medico(idEquipoMedico),
    FOREIGN KEY (idProcedimiento)
    REFERENCES procedimientos_medicos(idProcedimiento)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS contactos (
  id INT NOT NULL,
  nombre VARCHAR(100) NULL DEFAULT NULL,
  correo VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (id)
  )ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS medicamentos_recetas(
  idMedicamento INT NOT NULL,
  idreceta INT NOT NULL,
  PRIMARY KEY (idMedicamento, idreceta),
    FOREIGN KEY (idMedicamento)
    REFERENCES medicamentos(idMedicamento),
    FOREIGN KEY (idreceta)
    REFERENCES recetas(idreceta)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS detalle_factura_medicamentos (
  idDetalleFacturaMedicamento INT NOT NULL,
  idFactura INT NOT NULL,
  idMedicamento INT NOT NULL,
  PRIMARY KEY (idDetalleFacturaMedicamento),
    FOREIGN KEY (idFactura)
    REFERENCES facturas(idFactura),
    FOREIGN KEY (idMedicamento)
    REFERENCES medicamentos(idMedicamento)
)ENGINE=InnoDB;
