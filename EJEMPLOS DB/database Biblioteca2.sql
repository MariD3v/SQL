DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE IF NOT EXISTS biblioteca CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE biblioteca;

create table libros(
  codigo int auto_increment,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  stock int,
  primary key(codigo)
);

create table empleados(
 documento char(8),
 nombre varchar(20),
 apellido varchar(20),
 sueldo decimal(6,2),
 cantidadhijos int,
 seccion varchar(20),
 primary key(documento)
);

insert into empleados values
	('22222222','Juan','Perez',300,2,'Contaduria'),
	('22333333','Luis','Lopez',300,0,'Contaduria'),
	('22444444','Marta','Perez',500,1,'Sistemas'),
	('22555555','Susana','Garcia',400,2,'Secretaria'),
	('22666666','Jose Maria','Morales',400,3,'Secretaria');


 insert into libros(titulo,autor,editorial,precio,stock) values
	('Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00, 9),
 	('Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00, 50),
	('Aprenda PHP','Mario Molina','Siglo XXI',40.00, 3),
	('El aleph','Borges','Emece',10.00, 18),
	('Ilusiones','Richard Bach','Planeta',15.00, 22),
	('Java en 10 minutos','Mario Molina','Siglo XXI',50.00, 7),
	('Martin Fierro','Jose Hernandez','Planeta',20.00, 3),
	('Martin Fierro','Jose Hernandez','Emece',30.00, 70),
	('Uno','Richard Bach','Planeta',10.00, 120);
  
/*PROCEDIMIENTOS ALMACENADOS*/

-- 1. Elimine el procedimiento llamado "pa_empleados_sueldo" si existe.
DROP PROCEDURE IF EXISTS pa_empleados_sueldo;
-- 2. Cree un procedimiento almacenado llamado "pa_empleados_sueldo" que seleccione los nombres, apellidos y sueldos de los empleados.
DELIMITER $$
USE `biblioteca`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_empleados_sueldo`()
BEGIN
	SELECT nombre, apellido, sueldo FROM empleados;
END$$
DELIMITER ;
-- 3. Ejecute el procedimiento creado anteriormente.
CALL pa_empleados_sueldo;
-- 4. Elimine el procedimiento llamado "pa_empleados_hijos" si existe.
DROP PROCEDURE IF EXISTS pa_empleados_hijos;
-- 5. Cree un procedimiento almacenado llamado "pa_empleados_hijos" que seleccione los nombres, apellidos y cantidad de hijos de los empleados con hijos.
DELIMITER $$
USE `biblioteca`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_empleados_hijos`()
BEGIN
	SELECT nombre, apellido, cantidadhijos FROM empleados WHERE cantidadhijos != 0;
END$$
DELIMITER ;
-- 6. Ejecute el procedimiento creado anteriormente.
CALL pa_empleados_hijos;
-- 7. Actualice la cantidad de hijos de algún empleado sin hijos y vuelva a ejecutar el procedimiento para verificar que ahora si aparece en la lista.
UPDATE empleados SET cantidadhijos=1 WHERE documento = 22333333; -- SI aparece
  
/*PROCEDIMIENTOS ALMACENADOS CON VARIABLES*/

-- 1.Elimine el procedimiento llamado "pa_empleados_sueldo" si existe.
DROP PROCEDURE IF EXISTS pa_empleados_sueldo;
-- 2.Cree un procedimiento almacenado llamado "pa_empleados_sueldo" que seleccione los nombres, apellidos y sueldos de los empleados que tengan un sueldo superior o igual al enviado como parámetro.
DELIMITER $$
USE `biblioteca`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_empleados_sueldo`(IN p_sueldo INT)
BEGIN
	SELECT nombre, apellido, sueldo FROM empleados WHERE sueldo >= p_sueldo;
END$$
DELIMITER ;
-- 3.Ejecute el procedimiento creado anteriormente con distintos valores.
call biblioteca.pa_empleados_sueldo(300);
call biblioteca.pa_empleados_sueldo(400);
-- 4.Elimine el procedimiento almacenado "pa_empleados_actualizar_sueldo" si existe.
DROP PROCEDURE IF EXISTS pa_empleados_actualizar_sueldo;
-- 5.Cree un procedimiento almacenado llamado "pa_empleados_actualizar_sueldo" que actualice los sueldos iguales al enviado como primer parámetro con el valor enviado como segundo parámetro.
DELIMITER $$
USE `biblioteca`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_empleados_actualizar_sueldo`(IN p_sueldo_nuevo DECIMAL(6,2),IN p_sueldo_viejo DECIMAL(6,2))
BEGIN
	UPDATE empleados SET sueldo = p_sueldo_nuevo WHERE sueldo = p_sueldo_viejo;
END$$
DELIMITER ;
;
-- 6.Ejecute el procedimiento creado anteriormente y verifique si se ha ejecutado correctamente.
call biblioteca.pa_empleados_actualizar_sueldo(1000, 500);
  
