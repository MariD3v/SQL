DROP DATABASE IF EXISTS empleados;
CREATE DATABASE empleados CHARACTER SET utf8mb4;
USE empleados;

CREATE TABLE departamento (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  presupuesto DOUBLE UNSIGNED NOT NULL,
  gastos DOUBLE UNSIGNED NOT NULL
);

CREATE TABLE empleado (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nif VARCHAR(9) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  id_departamento INT UNSIGNED,
  FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);

INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);

/*CONSULTAS BÁSICAS*/
/* 1.Lista el primer apellido de todos los empleados.*/
SELECT apellido1 FROM empleado;
/* 2.Lista el primer apellido de los empleados eliminando los apellidos que estén repetidos.*/
SELECT DISTINCT apellido1 FROM empleado;
/* 3.Lista todas las columnas de la tabla empleado.*/
SELECT * FROM empleado;
/* 4.Lista el nombre y los apellidos de todos los empleados.*/
SELECT nombre, apellido1, apellido2 FROM empleado;
/* 5.Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado.*/
SELECT id_departamento FROM empleado;
/* 6.Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado, eliminando los identificadores que aparecen repetidos.*/
SELECT DISTINCT id_departamento FROM empleado;
/* 7.Lista el nombre y apellidos de los empleados en una única columna.*/
SELECT CONCAT(nombre,' ', apellido1, ' ', apellido2) FROM empleado;
/* 8.Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en mayúscula.*/
SELECT UPPER(CONCAT(nombre, apellido1, apellido2)) FROM empleado;
/* 9.Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en minúscula.*/
SELECT LOWER(CONCAT(nombre, apellido1, apellido2)) FROM empleado;
/* 10.Lista el identificador de los empleados junto al nif, pero el nif deberá aparecer en dos columnas, una mostrará únicamente los dígitos del nif y la otra la letra.*/
SELECT id, SUBSTRING(nif, 1, LENGTH(nif) - 1), SUBSTRING(nif, LENGTH(nif)) FROM empleado;/* SELECT id, LEFT(nift,8), RIGTH(nif,1) FROM empleado;*/
/* 11.Lista el nombre de cada departamento y el valor del presupuesto actual del que dispone. Para calcular este dato tendrá que restar al valor del presupuesto inicial (columna presupuesto) los gastos que se han generado (columna gastos). Tenga en cuenta que en algunos casos pueden existir valores negativos. Utilice un alias apropiado para la nueva columna que está calculando.*/
SELECT nombre, (presupuesto - gastos) AS "presupuesto real" FROM departamento;
/* 12.Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.*/
SELECT nombre, (presupuesto - gastos) AS "presupuesto real" FROM departamento ORDER BY (presupuesto - gastos) ASC;
/* 13.Lista el nombre de todos los departamentos ordenados de forma ascendente.*/
SELECT nombre FROM departamento ORDER BY nombre ASC;
/* 14.Lista el nombre de todos los departamentos ordenados de forma descendente.*/
SELECT nombre FROM departamento ORDER BY nombre DESC;
/* 15.Lista los apellidos y el nombre de todos los empleados, ordenados de forma alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su nombre.*/
SELECT apellido1, apellido2, nombre FROM empleado ORDER BY apellido1 ASC, nombre ASC;
/* 16.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.*/
SELECT nombre, presupuesto FROM departamento ORDER BY presupuesto DESC LIMIT 3;
/* 17.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.*/
SELECT nombre, presupuesto FROM departamento ORDER BY presupuesto ASC LIMIT 3;
/* 18.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen mayor gasto.*/
SELECT nombre, gastos FROM departamento ORDER BY gastos DESC LIMIT 2;
/* 19.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen menor gasto.*/
SELECT nombre, gastos FROM departamento ORDER BY gastos ASC LIMIT 2;
/* 20.Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La tercera fila se debe incluir en la respuesta. La respuesta debe incluir todas las columnas de la tabla empleado.*/
SELECT * FROM empleado LIMIT 5 OFFSET 2;
/* 21.Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto mayor o igual a 150000 euros.*/
SELECT nombre, presupuesto FROM departamento WHERE presupuesto >= 150000;
/* 22.Devuelve una lista con el nombre de los departamentos y el gasto, de aquellos que tienen menos de 5000 euros de gastos.*/
SELECT nombre, gastos FROM departamento WHERE gastos < 5000;
/* 23.Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.*/
SELECT nombre, presupuesto FROM departamento WHERE 100000 < presupuesto AND presupuesto < 200000;
/* 24.Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.*/
SELECT nombre FROM departamento WHERE !(100000 < presupuesto AND presupuesto < 200000);
/* 25.Devuelve una lista con el nombre de los departamentos que tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.*/
SELECT nombre FROM departamento WHERE presupuesto BETWEEN 100000 AND 200000;
/* 26.Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.*/
SELECT nombre FROM departamento WHERE !(presupuesto BETWEEN 100000 AND 200000);
/* 27.Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean mayores que el presupuesto del que disponen.*/
SELECT nombre, gastos, presupuesto FROM departamento WHERE gastos > presupuesto;
/* 28.Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean menores que el presupuesto del que disponen.*/
SELECT nombre, gastos, presupuesto FROM departamento WHERE gastos < presupuesto;
/* 29.Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean iguales al presupuesto del que disponen.*/
SELECT nombre, gastos, presupuesto FROM departamento WHERE gastos = presupuesto;
/* 30.Lista todos los datos de los empleados cuyo segundo apellido sea NULL.*/
SELECT * FROM empleado WHERE apellido2 IS NULL;
/* 31.Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.*/
SELECT * FROM empleado WHERE apellido2 IS NOT NULL;
/* 32.Lista todos los datos de los empleados cuyo segundo apellido sea López.*/
SELECT * FROM empleado WHERE apellido2 = "López";
/* 33.Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Sin utilizar el operador IN.*/
SELECT * FROM empleado WHERE apellido2 = "Díaz" OR apellido2 = "Moreno";
/* 34.Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Utilizando el operador IN.*/
SELECT * FROM empleado WHERE apellido2 IN ("Díaz") OR apellido2 IN ("Moreno");
/* 35.Lista los nombres, apellidos y nif de los empleados que trabajan en el departamento 3.*/
SELECT nombre, apellido1, apellido2, nif FROM empleado WHERE id_departamento = 3;
/* 36.Lista los nombres, apellidos y nif de los empleados que trabajan en los departamentos 2, 4 o 5.*/
SELECT nombre, apellido1, apellido2, nif FROM empleado WHERE id_departamento IN (2,4,5);

/*CONSULTAS MULTITABLA (INTERNA)*/
/*1.Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.*/
SELECT * FROM departamento INNER JOIN empleado ON id_departamento = departamento.id;
/*2.Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.*/
SELECT * FROM departamento INNER JOIN empleado ON id_departamento = departamento.id ORDER BY departamento.nombre ASC, apellido1 ASC, apellido2 ASC, empleado.nombre ASC;
/*3.Devuelve un listado con el identificador y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.*/
SELECT DISTINCT empleado.id_departamento, departamento.nombre FROM departamento INNER JOIN empleado ON id_departamento = departamento.id;
/*4.Devuelve un listado con el identificador, el nombre del departamento y el valor del presupuesto actual del que dispone, solamente de aquellos departamentos que tienen empleados. El valor del presupuesto actual lo puede calcular restando al valor del presupuesto inicial (columna presupuesto) el valor de los gastos que ha generado (columna gastos).*/
SELECT DISTINCT empleado.id_departamento, departamento.nombre, presupuesto-gastos FROM departamento INNER JOIN empleado ON id_departamento = departamento.id;
/*5.Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.*/
SELECT departamento.nombre FROM departamento INNER JOIN empleado ON id_departamento = departamento.id WHERE nif = '38382980M';
/*6.Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.*/
SELECT departamento.nombre FROM departamento INNER JOIN empleado ON id_departamento = departamento.id WHERE empleado.nombre = 'Pepe' AND empleado.apellido1 = 'Ruiz' AND empleado.apellido2 = 'Santana';
/*7.Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente.*/
SELECT empleado.* FROM departamento INNER JOIN empleado ON id_departamento = departamento.id WHERE departamento.nombre = 'I+D' ORDER BY empleado.nombre;
/*8.Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.*/
SELECT empleado.* FROM departamento INNER JOIN empleado ON id_departamento = departamento.id WHERE departamento.nombre = 'I+D' OR departamento.nombre = 'Contabilidad' OR departamento.nombre = 'Sistemas' ORDER BY empleado.nombre;
/*9.Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.*/
SELECT empleado.nombre FROM departamento INNER JOIN empleado ON id_departamento = departamento.id WHERE departamento.presupuesto > 200000 OR departamento.presupuesto < 100000;
/*10.Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos. */
SELECT DISTINCT departamento.nombre FROM departamento INNER JOIN empleado ON id_departamento = departamento.id WHERE empleado.apellido2 IS NULL;

/*CONSULTAS RESUMEN*/
/*1.Calcula la suma del presupuesto de todos los departamentos.*/
SELECT SUM(presupuesto) FROM departamento;
/*2.Calcula la media del presupuesto de todos los departamentos.*/
SELECT AVG(presupuesto) FROM departamento;
/*3.Calcula el valor mínimo del presupuesto de todos los departamentos.*/
SELECT MIN(presupuesto) FROM departamento;
/*4.Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con menor presupuesto.*/
SELECT departamento.nombre, presupuesto FROM departamento WHERE (SELECT MIN(presupuesto) FROM departamento) = presupuesto;
/*5.Calcula el valor máximo del presupuesto de todos los departamentos.*/
SELECT MAX(presupuesto) FROM departamento;
/*6.Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con mayor presupuesto.*/
SELECT departamento.nombre, presupuesto FROM departamento WHERE (SELECT MAX(presupuesto) FROM departamento) = presupuesto;
/*7.Calcula el número total de empleados que hay en la tabla empleado.*/
SELECT COUNT(*) FROM empleado;
/*8.Calcula el número de empleados que no tienen NULL en su segundo apellido.*/
SELECT COUNT(*) FROM empleado WHERE apellido2 IS NOT NULL;
/*9.Calcula el número de empleados que hay en cada departamento. Tienes que devolver dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.*/
SELECT departamento.nombre, COUNT(*) FROM empleado, departamento WHERE id_departamento = departamento.id GROUP BY departamento.id, departamento.nombre;
/*10.Calcula el nombre de los departamentos que tienen más de 2 empleados. El resultado debe tener dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.*/
SELECT departamento.nombre, COUNT(*) FROM empleado, departamento WHERE id_departamento = departamento.id GROUP BY departamento.id, departamento.nombre HAVING COUNT(*) > 2;
/*11.Calcula el número de empleados que trabajan en cada uno de los departamentos. El resultado de esta consulta también tiene que incluir aquellos departamentos que no tienen ningún empleado asociado.*/
SELECT COUNT(empleado.id), departamento.nombre FROM departamento LEFT JOIN empleado ON empleado.id_departamento = departamento.id GROUP BY departamento.id, departamento.nombre;
/*12.Calcula el número de empleados que trabajan en cada unos de los departamentos que tienen un presupuesto mayor a 200000 euros.*/
SELECT COUNT(*), departamento.nombre FROM departamento INNER JOIN empleado ON empleado.id_departamento = departamento.id WHERE presupuesto > 200000 GROUP BY departamento.id, departamento.nombre;


