CREATE DATABASE nexus;
USE nexus;
-- Tabla Usuario
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    usuario VARCHAR(50) UNIQUE,
    contraseña VARCHAR(255),
    f_nacimiento DATE,
    biografia TEXT,
    notificaciones BOOLEAN DEFAULT TRUE
);


-- Tabla Interes
CREATE TABLE Interes (
    id_interes INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE
);

-- Relación N:M Usuario_Interes
CREATE TABLE Usuario_Interes (
    id_usuario INT,
    id_interes INT,
    PRIMARY KEY (id_usuario, id_interes),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_interes) REFERENCES Interes(id_interes)
);

-- Tabla Comentario
CREATE TABLE Comentario (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    id_autor INT,
    texto TEXT,
    fecha DATETIME,
    FOREIGN KEY (id_autor) REFERENCES Usuario(id_usuario)
);

-- Tabla Publicacion
CREATE TABLE Publicacion (
    id_publicacion INT AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT,
    fecha DATETIME,
    titulo VARCHAR(255),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabla Calificacion_U (usuario a usuario)
CREATE TABLE Calificacion_U (
    id_calificacion INT AUTO_INCREMENT PRIMARY KEY,
    calificacion DECIMAL(3,2),
    puntuacion INT,
    fecha DATETIME,
    id_emisor INT,
    id_receptor INT,
    FOREIGN KEY (id_emisor) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_receptor) REFERENCES Usuario(id_usuario)
);

-- Tabla Evento
CREATE TABLE Evento (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    descripcion TEXT,
    ubicacion VARCHAR(255),
    fecha DATE,
    hora TIME,
    f_inicio DATE,
    f_fin DATE,
    limite_participantes INT,
    restricciones TEXT,
    id_creador INT,
    FOREIGN KEY (id_creador) REFERENCES Usuario(id_usuario)
);

-- Tabla Calificacion_E (usuario a evento)
CREATE TABLE Calificacion_E (
    id_calificacion INT AUTO_INCREMENT PRIMARY KEY,
    calificacion DECIMAL(3,2),
    puntuacion INT,
    fecha DATETIME,
    id_usuario INT,
    id_evento INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_evento) REFERENCES Evento(id_evento)
);

-- Tabla Multimedia
CREATE TABLE Multimedia (
    id_multimedia INT AUTO_INCREMENT PRIMARY KEY,
    url TEXT
);

-- Tabla Tag
CREATE TABLE Tag (
    id_tag INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100)
);

-- Tabla Foro
CREATE TABLE Foro (
    id_foro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    descripcion TEXT,
    contenido TEXT
);

-- Relaciones

-- Publica_Comentario
CREATE TABLE Publica_Comentario (
    id_usuario INT,
    id_comentario INT,
    PRIMARY KEY (id_usuario, id_comentario),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_comentario) REFERENCES Comentario(id_comentario)
);

-- Reacciona_Publicacion
CREATE TABLE Reacciona_Publicacion (
    id_usuario INT,
    id_publicacion INT,
    tipo_reaccion ENUM('like', 'dislike', 'love'),
    PRIMARY KEY (id_usuario, id_publicacion),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_publicacion) REFERENCES Publicacion(id_publicacion)
);

-- Evento_Asistencia
CREATE TABLE Evento_Asistencia (
    id_usuario INT,
    id_evento INT,
    PRIMARY KEY (id_usuario, id_evento),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_evento) REFERENCES Evento(id_evento)
);

-- Evento_Multimedia
CREATE TABLE Evento_Multimedia (
    id_evento INT,
    id_multimedia INT,
    PRIMARY KEY (id_evento, id_multimedia),
    FOREIGN KEY (id_evento) REFERENCES Evento(id_evento),
    FOREIGN KEY (id_multimedia) REFERENCES Multimedia(id_multimedia)
);

-- Publicacion_Multimedia
CREATE TABLE Publicacion_Multimedia (
    id_publicacion INT,
    id_multimedia INT,
    PRIMARY KEY (id_publicacion, id_multimedia),
    FOREIGN KEY (id_publicacion) REFERENCES Publicacion(id_publicacion),
    FOREIGN KEY (id_multimedia) REFERENCES Multimedia(id_multimedia)
);

-- Publicacion_Tag
CREATE TABLE Publicacion_Tag (
    id_publicacion INT,
    id_tag INT,
    PRIMARY KEY (id_publicacion, id_tag),
    FOREIGN KEY (id_publicacion) REFERENCES Publicacion(id_publicacion),
    FOREIGN KEY (id_tag) REFERENCES Tag(id_tag)
);

-- Foro_Tag
CREATE TABLE Foro_Tag (
    id_foro INT,
    id_tag INT,
    PRIMARY KEY (id_foro, id_tag),
    FOREIGN KEY (id_foro) REFERENCES Foro(id_foro),
    FOREIGN KEY (id_tag) REFERENCES Tag(id_tag)
);