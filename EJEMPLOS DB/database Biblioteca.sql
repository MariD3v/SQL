DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE IF NOT EXISTS biblioteca CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE biblioteca;

CREATE TABLE autor (
	cod_autor int unsigned auto_increment primary key,
	nombre varchar(50) not null,
	pais varchar(35) not null
) engine = innodb;

CREATE TABLE obra (
	cod_obra int unsigned auto_increment primary key,
	nombre varchar(50) not null,
	anyo varchar(35) not null,
	tipo varchar(35) not null,
	n_pags int,
	n_canciones int,
	duracion time
) engine = innodb;

CREATE TABLE publica (
	cod_autor int unsigned,
	cod_obra int unsigned,
	primary key (cod_obra,cod_autor),
	FOREIGN KEY (cod_obra) REFERENCES obra(cod_obra) ON DELETE RESTRICT ON UPDATE RESTRICT,
	FOREIGN KEY (cod_autor) REFERENCES autor(cod_autor) ON DELETE RESTRICT ON UPDATE RESTRICT,
	rol enum('escritor', 'publicador', 'editor') NOT NULL
) engine = innodb;

create table articulo (
	cod_art int unsigned auto_increment primary key,
	cod_obra int unsigned not null,
	foreign key (cod_obra) references obra(cod_obra),
	deteriorado boolean not null,
	comentario varchar(255)
) engine = innodb;

create table socio (
	cod_soc int unsigned auto_increment primary key,
	dni varchar(9) unique not null,
	nombre varchar(25) not null,
	apellidos varchar(35) not null,
	direccion varchar(255) not null
) engine = innodb;

create table presta (
	cod_art int unsigned,
	cod_soc int unsigned,
	fech_prest datetime not null,
	fech_tope datetime not null,
	fech_dev datetime,
	primary key (cod_art, cod_soc, fech_prest),
	foreign key (cod_soc) references socio(cod_soc),
	foreign key (cod_art) references articulo(cod_art)
) engine = innodb;

create table telfs (
	cod_soc int unsigned,
telf varchar(13) not null,
	primary key (cod_soc, telf),
	foreign key (cod_soc) references socio(cod_soc)
) engine = innodb;

