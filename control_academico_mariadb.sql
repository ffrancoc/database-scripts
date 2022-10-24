-- BASE DE DATOS control_academico

-- TABLA PARA GUARDAR INFORMACIÓN DE LOS USUARIOS
create TABLE
  if NOT EXISTS usuario(
    id int not null PRIMARY KEY AUTO_INCREMENT,
    nombre CHARACTER VARYING(50),
    apellido CHARACTER VARYING(50),
    fecha_nacimiento DATE,
    telefono CHARACTER VARYING(20) UNIQUE,
    correo CHARACTER VARYING(50) UNIQUE,
    direccion CHARACTER VARYING(100),
    carnet CHARACTER VARYING(50) not null unique,
    admin BOOLEAN not null default false,
    clave CHARACTER VARYING(100) not null,
    fecha_creacion DATETIME not null DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME,
    estatus int not null DEFAULT 1
  );

-- TABLA PARA GUARDAR INFORMACIÓN DE LOS ALUMNOS
create table
  if not exists alumno(
    id int not null PRIMARY KEY AUTO_INCREMENT,
    nombre CHARACTER VARYING(50),
    apellido CHARACTER VARYING(50),
    fecha_nacimiento DATE,
    telefono CHARACTER VARYING(20) UNIQUE,
    correo CHARACTER VARYING(50) UNIQUE,
    direccion CHARACTER VARYING(100),
    carnet CHARACTER VARYING(50) not null unique,
    clave CHARACTER VARYING(100) not null,
    fecha_creacion DATETIME not null DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME,
    usuario_id int,
    estatus int not null DEFAULT 1,
    CONSTRAINT `fk_alumno_usuario` FOREIGN KEY (usuario_id) REFERENCES usuario(id) on DELETE
    set
      null
  );

-- TABLA PARA GUARDAR INFORMACIÓN DE LOS PROFESORES
create table
  if not exists profesor(
    id int not null PRIMARY KEY AUTO_INCREMENT,
    nombre CHARACTER VARYING(50),
    apellido CHARACTER VARYING(50),
    fecha_nacimiento DATE,
    telefono CHARACTER VARYING(20) UNIQUE,
    correo CHARACTER VARYING(50) UNIQUE,
    direccion CHARACTER VARYING(100),
    carnet CHARACTER VARYING(50) not null unique,
    clave CHARACTER VARYING(100) not null,
    fecha_creacion DATETIME not null DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME,
    usuario_id int,
    estatus int not null DEFAULT 1,
    CONSTRAINT `fk_profesor_usuario` FOREIGN KEY (usuario_id) REFERENCES usuario(id) on DELETE
    set
      null
  );

-- TABLA PARA GUARDAR INFORMACIÓN DE LAS ASIGNATURAS
create table
  if not exists asignatura(
    id int not null PRIMARY KEY AUTO_INCREMENT,
    nombre CHARACTER VARYING(50) not null UNIQUE,
    usuario_id int,
    CONSTRAINT `fk_asignatura_usuario` FOREIGN KEY (usuario_id) REFERENCES usuario(id) on DELETE
    set
      null
  );

-- TABLA PARA GUARDAR INFORMACIÓN DE LOS CURSOS
create table
  if not exists curso(
    id int not null PRIMARY KEY AUTO_INCREMENT,
    nombre CHARACTER VARYING(50) not null UNIQUE,
    description CHARACTER VARYING(100),
    asignatura_id int,
    fecha_creacion DATETIME not null DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME,
    usuario_id int,
    estatus int not null DEFAULT 1,
    CONSTRAINT `fk_curso_asignatura` FOREIGN KEY (asignatura_id) REFERENCES asignatura(id) on DELETE
    set
      null,
      CONSTRAINT `fk_curso_usuario` FOREIGN KEY (usuario_id) REFERENCES usuario(id) on DELETE
    set
      null
  );

-- TABLA PARA GUARDAR INFORMACIÓN DE LAS ASIGNACIONES ALUMNO - CURSO
create table
  if not exists asignacion_alumno_curso(
    id int not null primary key auto_increment,
    curso_id int not null,
    alumno_id int not null,
    CONSTRAINT `fk_asignacion_alumno_curso` FOREIGN KEY (curso_id) REFERENCES curso(id) on DELETE CASCADE,
    CONSTRAINT `fk_asignacion_alumno` FOREIGN KEY (alumno_id) REFERENCES alumno(id) on DELETE CASCADE
  );

-- TABLA PARA GUARDAR INFORMACIÓN DE LAS ASIGNACIONES PROFESOR - CURSO
create table
  if not exists asignacion_profesor_curso(
    curso_id int not null,
    profesor_id int not null,
    CONSTRAINT `fk_asignacion_profesor_curso` FOREIGN KEY (curso_id) REFERENCES curso(id) on DELETE CASCADE,
    CONSTRAINT `fk_asignacion_profesor` FOREIGN KEY (profesor_id) REFERENCES profesor(id) on DELETE CASCADE
  );

-- TABLA PARA GUARDAR INFORMACIÓN DE LAS NOTAS DE LOS CURSOS
create table
  if not exists nota(
    id int not null PRIMARY KEY AUTO_INCREMENT,
    asignacion_id int,
    unidad_i DECIMAL,
    unidad_ii DECIMAL,
    unidad_iii DECIMAL,
    unidad_iv DECIMAL,
    actividades DECIMAL,
    extra DECIMAL,
    CONSTRAINT `fk_nota_asignacion_alumno_curso` FOREIGN KEY (asignacion_id) REFERENCES asignacion_alumno_curso(id) on DELETE CASCADE
  );
