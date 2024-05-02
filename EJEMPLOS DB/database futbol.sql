DROP DATABASE IF EXISTS futbol;
CREATE DATABASE IF NOT EXISTS futbol CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci; 
USE futbol;

CREATE TABLE equipos (
	cod_equipo TINYINT,
    seleccion VARCHAR(40) NOT NULL,
    grupo VARCHAR(1) NOT NULL,
    ptos TINYINT DEFAULT 0,
    goles_favor TINYINT DEFAULT 0,
    goles_contra TINYINT DEFAULT 0,
    CHECK (grupo IN ("A","B","C","D","E","F","G","H")),
    PRIMARY KEY (cod_equipo)
) engine = innodb;

CREATE TABLE jugadores (
	cod_jugador INT,
    nombre VARCHAR(20) NOT NULL,
    alias VARCHAR(30),
    fecha_nac DATE,
    localidad_nac VARCHAR(50),
    cod_equipo TINYINT NOT NULL,
    FOREIGN KEY (cod_equipo) REFERENCES equipos(cod_equipo) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (cod_jugador)
) engine = innodb;

CREATE TABLE partidos (
	cod_partido TINYINT,
    cod_equipo1 TINYINT NOT NULL,
    cod_equipo2 TINYINT NOT NULL,
	fecha DATE NOT NULL,
    hora TIME NOT NULL,
    goles_eq1 TINYINT,
    goles_eq2 TINYINT,
    FOREIGN KEY (cod_equipo1) REFERENCES equipos (cod_equipo) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cod_equipo2) REFERENCES equipos (cod_equipo) ON UPDATE CASCADE ON DELETE CASCADE,   
    PRIMARY KEY (cod_partido)
) engine = innodb;

CREATE TABLE juegan (
	cod_partido TINYINT NOT NULL,
    cod_jugador INT NOT NULL,
    minutos_jugados INT DEFAULT 0,
    goles INT DEFAULT 0,
    titularidad ENUM('si','no'),
    FOREIGN KEY (cod_partido) REFERENCES partidos (cod_partido) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cod_jugador) REFERENCES jugadores (cod_jugador) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (cod_partido, cod_jugador)
) engine = innodb;

CREATE TABLE arbitros (
	cod_arbitro INT UNSIGNED, 
    nombre VARCHAR(40) UNIQUE NOT NULL,
    nacionalidad VARCHAR(30) NOT NULL,
    fecha_nac DATE,
    partidos_pitados INT UNSIGNED DEFAULT 0,
    PRIMARY KEY (cod_arbitro)
) engine = innodb;

/*MODIFICACIÓN DE TABLAS*/

-- 1 Añadir a la tabla PARTIDOS un campo nuevo llamado “cod_colegiado” de tipo numérico (entero sin signo).
ALTER TABLE partidos ADD cod_colegiado INT UNSIGNED;
-- 2 Crear una clave ajena entre la tabla ARBITROS y la tabla PARTIDOS con el campo “código_arbitro” y el campo “código_colegiado”.
ALTER TABLE partidos ADD FOREIGN KEY (cod_colegiado) REFERENCES arbitros(cod_arbitro);
-- 3 Modificar el campo “Nombre” de la tabla JUGADORES para ampliar la longitud a 40 caracteres.
ALTER TABLE jugadores MODIFY COLUMN nombre VARCHAR(40) NOT NULL;
-- 4 Modificar el campo “Alias” de la tabla “JUGADORES” para que no contenga valores repetidos (dos jugadores no pueden tener el mismo alias).
ALTER TABLE jugadores MODIFY COLUMN alias VARCHAR(30) UNIQUE;
-- 5 Modificar el tipo de dato del campo “Goles” de la tabla JUEGAN para que sea de tipo “byte”.
ALTER TABLE juegan MODIFY COLUMN goles TINYINT DEFAULT 0;
-- 6 Añadir una restricción (CONSTRAINT) que “chequee” que el campo “Minutos_Jugados” de la tabla “JUEGAN” no puede tener valores negativos ni valores mayor a 90 (min).
ALTER TABLE juegan ADD CONSTRAINT minutes CHECK(minutos_jugados >= 0 AND minutos_jugados <= 90);
-- 7 Elimina las tablas (con comandos), indicando el orden correcto según las referencias de cada tabla.
DROP TABLE juegan;
DROP TABLE partidos;
DROP TABLE arbitros;
DROP TABLE jugadores;
DROP TABLE equipos;
-- 8 Elimina el esquema “MUNDIAL” (con comandos).
DROP DATABASE futbol;