DROP DATABASE IF EXISTS gimnasio;
CREATE DATABASE IF NOT EXISTS gimnasio CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE gimnasio;

CREATE TABLE socio (
dni VARCHAR(13) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellidos VARCHAR(50) NOT NULL,
fecha_alta DATE NOT NULL,
calle VARCHAR(100) NOT NULL,
num INT UNSIGNED NOT NULL,
piso VARCHAR(10) NOT NULL,
cod_postal VARCHAR(10) NOT NULL,
socio_principal VARCHAR(13),
observaciones VARCHAR(255),
FOREIGN KEY (socio_principal) REFERENCES socio(dni) ON DELETE CASCADE ON UPDATE CASCADE) engine = innodb;

CREATE TABLE cuota (
cod_cuota INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
fecha DATE NOT NULL,
importe DECIMAL(6,2) NOT NULL,
iban VARCHAR(13) NOT NULL,
dni VARCHAR(13) NOT NULL,
FOREIGN KEY (dni) REFERENCES socio(dni) ON DELETE CASCADE ON UPDATE CASCADE) engine = innodb;

CREATE TABLE fraccion(
cod_cuota INT UNSIGNED,
orden INT UNSIGNED,
fecha DATE NOT NULL,
importe DECIMAL(6,2) NOT NULL,
PRIMARY KEY (cod_cuota,orden),
FOREIGN KEY (cod_cuota) REFERENCES cuota(cod_cuota) ON DELETE CASCADE ON UPDATE CASCADE) engine = innodb;

CREATE TABLE supervisor(
cod_empleado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
dni VARCHAR(9) UNIQUE NOT NULL,
nombre VARCHAR(50) NOT NULL,
apellidos VARCHAR(50) NOT NULL,
especialidad VARCHAR(50)) engine = innodb;

CREATE TABLE pista(
num_pista INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
superficie INT NOT NULL CHECK (superficie>=1 AND superficie<=20000),
localización ENUM ('central','lateral-izq','lateral-der') NOT NULL,
estado VARCHAR(50)) engine = innodb;

CREATE TABLE reserva(
dni VARCHAR(9),
num_pista INT UNSIGNED,
fecha DATE,
hora TIME,
PRIMARY KEY (dni,num_pista,fecha,hora),
FOREIGN KEY (dni) REFERENCES socio(dni) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (num_pista) REFERENCES pista(num_pista) ON DELETE CASCADE ON UPDATE CASCADE)engine = innodb;

CREATE TABLE supervisa(
cod_empleado INT UNSIGNED,
num_pista INT UNSIGNED,
fecha DATE,
PRIMARY KEY (cod_empleado,num_pista,fecha),
FOREIGN KEY (cod_empleado) REFERENCES supervisor(cod_empleado) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (num_pista) REFERENCES pista(num_pista) ON DELETE CASCADE ON UPDATE CASCADE) engine = innodb;
