DROP DATABASE IF EXISTS universidad;
CREATE DATABASE IF NOT EXISTS Universidad CHARSET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE universidad;

CREATE TABLE persona(
dni VARCHAR(9) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellidos VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
telf VARCHAR(12) NOT NULL,
movil VARCHAR(12)) engine = innodb;

CREATE TABLE alumno(
dni VARCHAR(9) PRIMARY KEY,
n_exp INT UNSIGNED AUTO_INCREMENT  UNIQUE NOT NULL,
fecha_nac DATE NOT NULL,
FOREIGN KEY (dni) REFERENCES persona(dni) ON DELETE CASCADE ON UPDATE CASCADE) engine = innodb;

CREATE TABLE docente(
dni VARCHAR(9) PRIMARY KEY,
nss VARCHAR(12) UNIQUE NOT NULL,
tipo ENUM ('catedratico', 'personal fijo', 'personal suplente') NOT NULL, 
fecha_alta DATETIME NOT NULL,
FOREIGN KEY (dni) REFERENCES persona(dni) ON DELETE CASCADE ON UPDATE CASCADE) engine = innodb;

CREATE TABLE administrativo(
dni VARCHAR(9) PRIMARY KEY,
nivel INT UNSIGNED NOT NULL CHECK (nivel >=1 AND nivel <=30), 
competencia_digital VARCHAR(50),
FOREIGN KEY (dni) REFERENCES persona(dni) ON DELETE CASCADE ON UPDATE CASCADE) engine = innodb;

CREATE TABLE asignatura(
cod_asign INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Descripción VARCHAR(200) NOT NULL,
tipo ENUM('TRONCAL', 'OPTATIVA','LIBRE CONFIGURACION')) engine = innodb;

CREATE TABLE matricula(
dni VARCHAR(9),
cod_asign INT UNSIGNED, 
curso_lectivo VARCHAR(50),
FOREIGN KEY(dni) REFERENCES alumno(dni) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(cod_asign) REFERENCES asignatura(cod_asign) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(dni, cod_asig, curso_lectivo)) engine = innodb;

CREATE TABLE imparte(
dni VARCHAR(9),
cod_asign INT UNSIGNED,
curso_lectivo VARCHAR(50),
FOREIGN KEY(dni) REFERENCES docente(dni) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(cod_asign) REFERENCES asignatura(cod_asign) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(dni, cod_asig, curso_lectivo)) engine = innodb;

CREATE TABLE titulacion(
cod_titulacion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
descripción VARCHAR(200) NOT NULL) engine = innodb;

CREATE TABLE compuesta(
cod_titulacion INT UNSIGNED,
cod_asign INT UNSIGNED,
FOREIGN KEY(cod_titulacion) REFERENCES titulacion(cod_titulacion) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(cod_asign) REFERENCES asignatura(cod_asign) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(cod_titulacion, cod_asign)) engine = innodb;