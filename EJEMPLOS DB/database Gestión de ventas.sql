DROP DATABASE IF EXISTS ventas;
CREATE DATABASE ventas CHARACTER SET utf8mb4;
USE ventas;

CREATE TABLE cliente (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  ciudad VARCHAR(100),
  categoría INT UNSIGNED
);

CREATE TABLE comercial (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  comisión FLOAT
);

CREATE TABLE pedido (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  total DOUBLE NOT NULL,
  fecha DATE,
  id_cliente INT UNSIGNED NOT NULL,
  id_comercial INT UNSIGNED NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id),
  FOREIGN KEY (id_comercial) REFERENCES comercial(id)
);

INSERT INTO cliente VALUES(1, 'Aarón', 'Rivero', 'Gómez', 'Almería', 100);
INSERT INTO cliente VALUES(2, 'Adela', 'Salas', 'Díaz', 'Granada', 200);
INSERT INTO cliente VALUES(3, 'Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL);
INSERT INTO cliente VALUES(4, 'Adrián', 'Suárez', NULL, 'Jaén', 300);
INSERT INTO cliente VALUES(5, 'Marcos', 'Loyola', 'Méndez', 'Almería', 200);
INSERT INTO cliente VALUES(6, 'María', 'Santana', 'Moreno', 'Cádiz', 100);
INSERT INTO cliente VALUES(7, 'Pilar', 'Ruiz', NULL, 'Sevilla', 300);
INSERT INTO cliente VALUES(8, 'Pepe', 'Ruiz', 'Santana', 'Huelva', 200);
INSERT INTO cliente VALUES(9, 'Guillermo', 'López', 'Gómez', 'Granada', 225);
INSERT INTO cliente VALUES(10, 'Daniel', 'Santana', 'Loyola', 'Sevilla', 125);

INSERT INTO comercial VALUES(1, 'Daniel', 'Sáez', 'Vega', 0.15);
INSERT INTO comercial VALUES(2, 'Juan', 'Gómez', 'López', 0.13);
INSERT INTO comercial VALUES(3, 'Diego','Flores', 'Salas', 0.11);
INSERT INTO comercial VALUES(4, 'Marta','Herrera', 'Gil', 0.14);
INSERT INTO comercial VALUES(5, 'Antonio','Carretero', 'Ortega', 0.12);
INSERT INTO comercial VALUES(6, 'Manuel','Domínguez', 'Hernández', 0.13);
INSERT INTO comercial VALUES(7, 'Antonio','Vega', 'Hernández', 0.11);
INSERT INTO comercial VALUES(8, 'Alfredo','Ruiz', 'Flores', 0.05);

INSERT INTO pedido VALUES(1, 150.5, '2017-10-05', 5, 2);
INSERT INTO pedido VALUES(2, 270.65, '2016-09-10', 1, 5);
INSERT INTO pedido VALUES(3, 65.26, '2017-10-05', 2, 1);
INSERT INTO pedido VALUES(4, 110.5, '2016-08-17', 8, 3);
INSERT INTO pedido VALUES(5, 948.5, '2017-09-10', 5, 2);
INSERT INTO pedido VALUES(6, 2400.6, '2016-07-27', 7, 1);
INSERT INTO pedido VALUES(7, 5760, '2015-09-10', 2, 1);
INSERT INTO pedido VALUES(8, 1983.43, '2017-10-10', 4, 6);
INSERT INTO pedido VALUES(9, 2480.4, '2016-10-10', 8, 3);
INSERT INTO pedido VALUES(10, 250.45, '2015-06-27', 8, 2);
INSERT INTO pedido VALUES(11, 75.29, '2016-08-17', 3, 7);
INSERT INTO pedido VALUES(12, 3045.6, '2017-04-25', 2, 1);
INSERT INTO pedido VALUES(13, 545.75, '2019-01-25', 6, 1);
INSERT INTO pedido VALUES(14, 145.82, '2017-02-02', 6, 1);
INSERT INTO pedido VALUES(15, 370.85, '2019-03-11', 1, 5);
INSERT INTO pedido VALUES(16, 2389.23, '2019-03-11', 1, 5);

/*CONSULTAS BÁSICAS*/
/* 1.Devuelve un listado con todos los pedidos que se han realizado. Los pedidos deben estar ordenados por la fecha de realización, mostrando en primer lugar los pedidos más recientes.*/
SELECT * FROM pedido ORDER BY fecha DESC;
/* 2.Devuelve todos los datos de los dos pedidos de mayor valor.*/
SELECT * FROM pedido ORDER BY total DESC LIMIT 2;
/* 3.Devuelve un listado con los identificadores de los clientes que han realizado algún pedido. Tenga en cuenta que no debe mostrar identificadores que estén repetidos.*/
SELECT DISTINCT id_cliente FROM pedido;
/* 4.Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, cuya cantidad total sea superior a 500€.*/
SELECT * FROM pedido WHERE YEAR(fecha)=2017 AND total > 500;
/* 5.Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisión entre 0.05 y 0.11.*/
SELECT nombre, apellido1, apellido2 FROM comercial WHERE comisión >= 0.05 AND comisión <= 0.11;
/* 6.Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial.*/
SELECT comisión FROM comercial ORDER BY comisión DESC LIMIT 1;
/* 7.Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo segundo apellido no es NULL. El listado deberá estar ordenado alfabéticamente por apellidos y nombre.*/
SELECT id, nombre, apellido1 FROM cliente WHERE apellido2 IS NOT NULL ORDER BY apellido1 ASC, nombre ASC;
/* 8.Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n y también los nombres que empiezan por P. El listado deberá estar ordenado alfabéticamente.*/
SELECT nombre FROM cliente WHERE nombre LIKE 'A%n' OR nombre LIKE 'P%' ORDER BY nombre ASC;
/* 9.Devuelve un listado de los nombres de los clientes que no empiezan por A. El listado deberá estar ordenado alfabéticamente.*/
SELECT nombre FROM cliente WHERE NOT nombre LIKE 'A%' ORDER BY nombre ASC;
/* 10.Devuelve un listado con los nombres de los comerciales que terminan por 'el' o 'o'. Tenga en cuenta que se deberán eliminar los nombres repetidos.*/
SELECT DISTINCT nombre FROM comercial WHERE nombre LIKE '%el' OR nombre LIKE '%o';

/*CONSULTAS MULTITABLA (INTERNA)*/
/*1.Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.*/
SELECT DISTINCT cliente.id, cliente.nombre, cliente.apellido1, cliente.apellido2 FROM cliente INNER JOIN pedido ON id_cliente = cliente.id;
/*2.Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. El resultado debe mostrar todos los datos de los pedidos y del cliente. El listado debe mostrar los datos de los clientes ordenados alfabéticamente.*/
SELECT DISTINCT * FROM cliente INNER JOIN pedido ON id_cliente = cliente.id;
/*3.Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. El resultado debe mostrar todos los datos de los pedidos y de los comerciales. El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.*/
SELECT DISTINCT * FROM pedido INNER JOIN comercial ON id_comercial = comercial.id ORDER BY comercial.nombre ASC;
/*4.Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido.*/
SELECT DISTINCT * FROM pedido INNER JOIN cliente ON id_cliente = cliente.id INNER JOIN comercial ON comercial.id = id_comercial;
/*5.Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, cuya cantidad esté entre 300 € y 1000 €.*/
SELECT DISTINCT cliente.* FROM cliente INNER JOIN pedido ON id_cliente = cliente.id WHERE total > 300 AND total < 1000 AND fecha LIKE '2017%';
/*6.Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido realizado por María Santana Moreno.*/
SELECT DISTINCT comercial.nombre, comercial.apellido1, comercial.apellido2 FROM pedido INNER JOIN cliente ON id_cliente = cliente.id INNER JOIN comercial ON comercial.id = id_comercial WHERE cliente.nombre = 'María' AND cliente.apellido1 = 'Santana' AND cliente.apellido2 = 'Moreno';
/*7.Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.*/
SELECT DISTINCT cliente.nombre FROM pedido INNER JOIN cliente ON id_cliente = cliente.id INNER JOIN comercial ON comercial.id = id_comercial WHERE comercial.nombre = 'Daniel' AND comercial.apellido1 = 'Sáez' AND comercial.apellido2 = 'Vega';

/*CONSULTAS RESUMEN*/
/*1.Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.*/
SELECT SUM(total) FROM pedido;
/*2.Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.*/
SELECT AVG(total) FROM pedido;
/*3.Calcula el número total de comerciales distintos que aparecen en la tabla pedido.*/
SELECT COUNT(DISTINCT(id_comercial)) FROM pedido;
/*4.Calcula el número total de clientes que aparecen en la tabla cliente.*/
SELECT COUNT(*) FROM cliente;
/*5.Calcula cuál es la mayor cantidad que aparece en la tabla pedido.*/
SELECT MAX(total) FROM pedido;
/*6.Calcula cuál es la menor cantidad que aparece en la tabla pedido.*/
SELECT MIN(total) FROM pedido;
/*7.Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la tabla cliente.*/
SELECT MAX(categoría), ciudad FROM cliente GROUP BY ciudad;
/*8.Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes. Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes cantidades el mismo día. Se pide que se calcule cuál es el pedido de máximo valor para cada uno de los días en los que un cliente ha realizado un pedido. Muestra el identificador del cliente, nombre, apellidos, la fecha y el valor de la cantidad.*/
SELECT cliente.id, MAX(total), fecha, cliente.nombre, cliente.apellido1, cliente.apellido2 FROM pedido, cliente WHERE pedido.id_cliente = cliente.id GROUP BY fecha,cliente.nombre, cliente.apellido1, cliente.apellido2,cliente.id;
/*9.Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes, teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen la cantidad de 2000 €.*/
SELECT cliente.id, MAX(total), fecha, cliente.nombre, cliente.apellido1, cliente.apellido2 FROM pedido, cliente WHERE pedido.id_cliente = cliente.id GROUP BY fecha,cliente.nombre, cliente.apellido1, cliente.apellido2,cliente.id HAVING MAX(total)>2000;
/*10.Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la fecha 2016-08-17. Muestra el identificador del comercial, nombre, apellidos y total.*/
SELECT comercial.id, comercial.nombre, comercial.apellido1, comercial.apellido2, MAX(total), fecha FROM pedido, comercial WHERE comercial.id = pedido.id_comercial AND fecha = "2016-08-17" GROUP BY comercial.id, comercial.nombre, comercial.apellido1, comercial.apellido2, fecha;
/*11.Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido. Estos clientes también deben aparecer en el listado indicando que el número de pedidos realizados es 0.*/
SELECT cliente.id, cliente.nombre, cliente.apellido1, cliente.apellido2, COUNT(pedido.id) FROM cliente LEFT JOIN pedido ON pedido.id_cliente = cliente.id GROUP BY cliente.id, cliente.nombre, cliente.apellido1, cliente.apellido2;
/*12.Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes durante el año 2017.*/
SELECT cliente.id, cliente.nombre, cliente.apellido1, cliente.apellido2, COUNT(*) FROM cliente INNER JOIN pedido ON pedido.id_cliente = cliente.id WHERE YEAR(fecha) = 2017 GROUP BY cliente.id, cliente.nombre, cliente.apellido1, cliente.apellido2;
/*13.Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido y el valor de la máxima cantidad del pedido realizado por cada uno de los clientes. El resultado debe mostrar aquellos clientes que no han realizado ningún pedido indicando que la máxima cantidad de sus pedidos realizados es 0. Puede hacer uso de la función IFNULL.*/
SELECT cliente.id, cliente.nombre, cliente.apellido1, IFNULL(MAX(total),0) FROM cliente LEFT JOIN pedido ON pedido.id_cliente = cliente.id GROUP BY cliente.id, cliente.nombre, cliente.apellido1;
/*14.Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.*/
SELECT MAX(total), YEAR(fecha) FROM pedido GROUP BY YEAR(fecha);
/*15.Devuelve el número total de pedidos que se han realizado cada año.*/
SELECT COUNT(*), YEAR(fecha) FROM pedido GROUP BY YEAR(fecha);
