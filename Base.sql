DROP DATABASE IF EXISTS pruebas;
CREATE DATABASE IF NOT EXISTS pruebas CHARACTER SET utf8;

USE pruebas;

CREATE TABLE tbl_autores (
    ID_AUTOR INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    NOMBRE VARCHAR(150) NOT NULL,
    APELLIDO VARCHAR(100) NOT NULL,
    SEUDONIMO VARCHAR(100),
    GENERO ENUM('M', 'F'),
    FECHA_NACIMIENTO DATE NOT NULL,
    PAIS_ORIGEN VARCHAR(40) NOT NULL,
    FECHA_CREACION DATETIME DEFAULT current_timestamp
);

CREATE TABLE tbl_libros (
    ID_LIBRO INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    ID_AUTOR INT UNSIGNED NOT NULL,
    TITULO VARCHAR(100) NOT NULL,
    DESCRIPCION VARCHAR(300),
    VENTAS INT UNSIGNED DEFAULT 0,
    STOCK INT UNSIGNED DEFAULT 10,
    PAGINAS INT UNSIGNED NOT NULL DEFAULT 0,
    FECHA_PUBLICACION DATE NOT NUll,
    FECHA_CREACION DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_autor) REFERENCES tbl_autores(id_autor) ON DELETE CASCADE
);

CREATE TABLE tbl_usuarios (
    ID_USUARIO INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    NOMBRE VARCHAR(150) NOT NULL,
    APELLIDO VARCHAR(100) NOT NULL,
    USERNAME VARCHAR(300) NOT NUll UNIQUE,
    EMAIL VARCHAR(300) NOT NUll UNIQUE,
    FECHA_CREACION DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO 
    tbl_autores (nombre, apellido, seudonimo, fecha_nacimiento, genero, pais_origen)
VALUES 
    ('Stephen Edwin', 'King', 'Richard Bachman', '1947-09-27', 'M', 'USA'),
    ('Joanne', 'Rowling', 'J.K Rowling', '1947-09-27', 'F', 'Reino unido'),
    ('Daniel', 'Brown',  NULL, '1964-06-22', 'M', 'USA'),
    ('John', 'Katzenbach ', NULL,'1950-06-23', 'M', 'USA'),
    ('John Ronald', 'Reuel Tolkien', NULL, '1892-01-03', 'M', 'Reino unido'),
    ('Miguel', 'de Unamuno', NULL, '1892-01-03', 'M', 'USA'),
    ('Arturo', 'Pérez Reverte', NULL, '1951-11-25', 'M', 'España'),
    ('George Raymond', 'Richard Martin', NULL, '1948-09-20', 'M', 'USA');

INSERT INTO 
    tbl_libros (id_autor, titulo, fecha_publicacion,ventas, paginas)
VALUES 
    (1, 'Carrie','1974-01-01',10,100),
    (1, 'El misterio de Salmes Lot','1975-01-01',100,100),
    (1, 'El resplando','1977-01-01',10,100),
    (1, 'Rabia','1977-01-01',10,100),
    (1, 'El umbral de la noche','1978-01-01',10,100),
    (1, 'La danza de la muerte','1978-01-01',10,100),
    (1, 'La larga marcha','1979-01-01',10,100),
    (1, 'La zona muerta','1979-01-01',10,100),
    (1, 'Ojos de fuego','1980-01-01',10,100),
    (1, 'Cujo','1981-01-01',10,100),
    (1, 'La torre oscura 1 El pistolero','1982-01-01',10,100),
    (1, 'La torre oscura 2 La invocación','1987-01-01',10,100),
    (1, 'Apocalipsis','1990-01-01',10,100),
    (1, 'La torre oscura 3 Las tierras baldías','1991-01-01',10,100),
    (1, 'La torre oscura 4 Bola de cristal','1997-01-01',10,100),
    (1, 'La torre oscura 5 Los de Calla','2003-01-01',10,100),
    (1, 'La torre oscura 6 La torre oscura','2004-01-01',10,100),
    (1, 'La torre oscura 7 Canción de Susannah','2004-01-01',10,100),
    (1, 'La niebla','1981-01-01',10,100),

    (2, 'Harry Potter y la Piedra Filosofal', '1997-06-30',30,150),
    (2, 'Harry Potter y la Cámara Secreta', '1998-07-2',52,60),
    (2, 'Harry Potter y el Prisionero de Azkaban','1999-07-8',30,10),
    (2, 'Harry Potter y el Cáliz de Fuego','2000-03-20',5,40),
    (2, 'Harry Potter y la Orden del Fénix','2003-06-21',14,90),
    (2, 'Harry Potter y el Misterio del Príncipe','2005-06-16',20,54),
    (2, 'Harry Potter y las Reliquias de la Muerte','2021-07-21',21,20),

    (3, 'Origen', '2017-01-01',10,100),
    (3, 'Inferno', '2013-01-01',10,100),
    (3, 'El simbolo perdido', '2009-01-01',10,100),
    (3, 'El código Da Vinci', '2006-01-01',10,100),
    (3, 'La consipiración', '2003-01-01',10,100),

    (4, 'Al calor del verano', '1982-01-01',10,100),
    (4, 'Un asunto pendiente', '1987-01-01',10,100),
    (4, 'Juicio Final', '1992-01-01',10,100),
    (4, 'La sombra', '1995-01-01',10,100),
    (4, 'Juego de ingenios', '1997-01-01',10,100),
    (4, 'El psicoanalista', '2002-01-01',10,100),
    (4, 'La historia del loco', '2004-01-01',10,100),
    (4, 'El hombre equivocado', '2006-01-01',10,100),
    (4, 'El estudiante', '2014-01-01',10,100),

    (5, 'El hobbit','1937-01-01',10,100),
    (5, 'Las dos torres','1954-01-01',10,100),
    (5, 'El señor de los anillos','1954-01-01',10,100),
    (5, 'La comunidad del anillo','1954-01-01',10,100),
    (5, 'El retorno del rey','1955-01-01',10,100),

    (6, 'La niebla','1914-01-01',10,100),

    (7, 'Eva','2017-01-01',10,100),
    (7, 'Falcó','2016-01-01',10,100),
    (7, 'Hombre buenos','2015-01-01',10,100),
    (7, 'Los barcos se pierden en tierra','2011-01-01',10,100),

    (8, 'Juego de tronos','1996-08-01',10,100),
    (8, 'Choque de reyes','1998-11-16',0,40),
    (8, 'Tormenta de espadas','2005-10-17',0,40),
    (8, 'Festin de cuervos','2011-07-12',5,65),
    (8, 'Danza de dragones','2011-07-12',2,70);


INSERT INTO 
    tbl_usuarios (NOMBRE, APELLIDO, USERNAME, EMAIL)
VALUES
    ('Eduardo', 'García', 'eduardogpg', 'eduardo@codigofacilito.com'),
    ('Codi1', 'Facilito', 'codigofacilito1', 'ayuda1@codigofacilito.com'),
    ('Codi2', 'Facilito', 'codigofacilito2', 'ayuda2@codigofacilito.com'),
    ('Codi3', 'Facilito', 'codigofacilito3', 'ayuda3@codigofacilito.com');

