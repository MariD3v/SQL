
DROP DATABASE IF EXISTS empresa;
CREATE DATABASE empresa CHARACTER SET utf8mb4;
USE empresa;

create table clientes (
 codigo int unsigned auto_increment,
 nombre varchar(30) not null,
 domicilio varchar(30),
 ciudad varchar(20),
 codigoprovincia tinyint unsigned,
 telefono varchar(11),
 primary key(codigo)
);
create table provincias(
 codigo tinyint unsigned auto_increment,
 nombre varchar(20),
 primary key (codigo)
);

insert into provincias (nombre) values
	('Cordoba'),
	('Santa Fe'),
    ('Corrientes'),
    ('Misiones'),
    ('Salta'),
    ('Buenos Aires'),
    ('Neuquen');
    
insert into clientes (nombre,domicilio,ciudad,codigoProvincia,telefono) values 
	('Lopez Marcos', 'Colon 111', 'Córdoba',1,'null'),
    ('Perez Ana', 'San Martin 222', 'Cruz del Eje',1,'4578585'),
    ('Garcia Juan', 'Rivadavia 333', 'Villa Maria',1,'4578445'),
    ('Perez Luis', 'Sarmiento 444', 'Rosario',2,null),
    ('Pereyra Lucas', 'San Martin 555', 'Cruz del Eje',1,'4253685'),
    ('Gomez Ines', 'San Martin 666', 'Santa Fe',2,'0345252525'),
    ('Torres Fabiola', 'Alem 777', 'Villa del Rosario',1,'4554455'),
    ('Lopez Carlos', 'Irigoyen 888', 'Cruz del Eje',1,null),
    ('Ramos Betina', 'San Martin 999', 'Cordoba',1,'4223366'),
    ('Lopez Lucas', 'San Martin 1010', 'Posadas',4,'0457858745');
    
/*PROCEDIMIENTOS ALMACENADOS*/
/*1. Crearemos un procedimiento almacenado que le enviemos como parámetro los nombres de dos provincias y genere como resultado la cantidad de clientes que tenemos en cada una 
de dichas provincias. Dentro del procedimiento almacenado definimos dos variables locales llamadas 'canti1' y 'canti2' que almacenan en forma temporal la cantidad de clientes 
que hay en cada una de las dos provincias consultadas.*/

DELIMITER $$
USE `empresa`$$
CREATE PROCEDURE `pa_empresa` (IN provincia1 VARCHAR(30),IN provincia2 VARCHAR(30))
BEGIN
	DECLARE cant1 INT;
    DECLARE cant2 INT;
	SELECT COUNT(clientes.codigo) INTO cant1 FROM provincias LEFT JOIN clientes ON clientes.codigoprovincia = provincias.codigo WHERE provincias.nombre = provincia1;
    SELECT COUNT(clientes.codigo) INTO cant2 FROM provincias LEFT JOIN clientes ON clientes.codigoprovincia = provincias.codigo WHERE provincias.nombre = provincia2;
    SELECT cant1, cant2;
END$$
DELIMITER ;

/*2. Llamamos luego al procedimiento almacenado pasando dos provincias que queremos conocer la cantidad de clientes.*/
call empresa.pa_empresa('Códoba', 'Santa Fe');
