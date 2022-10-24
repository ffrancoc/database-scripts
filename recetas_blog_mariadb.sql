-- BASE DE DATOS recetas_blog

-- TABLA PARA GUARDAR INFORMACIÓN DE LOS USUARIOS
create table
  if not exists usuario(
    id int not null PRIMARY KEY AUTO_INCREMENT,
    usuario CHARACTER VARYING(50) not null unique,
    clave CHARACTER VARYING(100) not null,
    imagen TEXT not null,
    fecha_creacion DATETIME not null DEFAULT CURRENT_TIMESTAMP,
    estatus int not null default 1
  );

-- TABLE PARA GUARDAR INFORMACIÓN DE LAS RECETAS
create table
  if not exists receta(
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre CHARACTER VARYING(80) not null,
    descripcion CHARACTER VARYING(100) not null,
    preparacion TEXT not null,
    imagen TEXT not null,
    etiquetas TEXT,
    likes INT UNSIGNED NOT NULL DEFAULT 0,
    dislike INT UNSIGNED NOT NULL DEFAULT 0,
    author_id int,
    fecha_creacion DATETIME not null DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME
  );

-- TABLA PARA GUARDAR LOS INGREDIENTES DE LAS RECETAS
create table
  if not exists ingrediente(
    descripcion CHARACTER VARYING(100) not null,
    receta_id int,
    CONSTRAINT `fk_ingrediente_receta` FOREIGN KEY (receta_id) REFERENCES receta(id) on DELETE CASCADE
  );

-- TABLA PARA GUARDAR INFORMACIÓN DE LOS COMENTARIOS DE LOS USUARIOS
create table
  if not exists comentario(
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    mensaje text not null,
    usuario_id int,
    CONSTRAINT `fk_comentario_usuario` FOREIGN KEY (usuario_id) REFERENCES usuario(id) on DELETE CASCADE
  );
