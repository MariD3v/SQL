DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE IF NOT EXISTS biblioteca CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE biblioteca;

CREATE TABLE autor (
	cod_autorintunsignedauto_incrementprimarykey,
	nombre varchar(50) notnull,
	paisvarchar(35) notnull
) engine = innodb;

CREATE TABLE obra (
	cod_obraintunsignedauto_incrementprimarykey,
	nombre varchar(50) notnull,
	anyovarchar(35) notnull,
	tipo varchar(35) notnull,
	n_pagsint,
	n_cancionesint,
	duracion time
) engine = innodb;

CREATE TABLE publica (
	cod_autorintunsigned,
	cod_obraintunsigned,
	primarykey (cod_obra,cod_autor),
	FOREIGN KEY (cod_obra) REFERENCES obra(cod_obra) ON DELETE RESTRICT ON UPDATE RESTRICT,
	FOREIGN KEY (cod_autor) REFERENCES autor(cod_autor) ON DELETE RESTRICT ON UPDATE RESTRICT,
	rol enum('escritor', 'publicador', 'editor') NOT NULL
) engine = innodb;

create table articulo (
	cod_artintunsignedauto_incrementprimarykey,
	cod_obraintunsignednotnull,
	foreignkey (cod_obra) references obra(cod_obra),
	deteriorado booleannotnull,
	comentario varchar(255)
) engine = innodb;

create table socio (
	cod_socintunsignedauto_incrementprimarykey,
	dnivarchar(9) uniquenotnull,
	nombre varchar(25) notnull,
	apellidos varchar(35) notnull,
	direccionvarchar(255) notnull
) engine = innodb;

create table presta (
	cod_artintunsigned,
	cod_socintunsigned,
	fech_prestdatetimenotnull,
	fech_topedatetimenotnull,
	fech_devdatetime,
	primarykey (cod_art, cod_soc, fech_prest),
	foreignkey (cod_soc) references socio(cod_soc),
	foreignkey (cod_art) references articulo(cod_art)
) engine = innodb;

create table telfs (
	cod_socintunsigned,
telfvarchar(13) notnull,
	primarykey (cod_soc, telf),
	foreignkey (cod_soc) references socio(cod_soc)
) engine = innodb;

