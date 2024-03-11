DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  id_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

/*CONSULTAS BÁSICAS*/
/*1.Lista el nombre de todos los productos que hay en la tabla producto.*/
SELECT nombre FROM producto;
/*2.Lista los nombres y los precios de todos los productos de la tabla producto.*/
SELECT nombre, precio FROM producto;
/*3.Lista todas las columnas de la tabla producto.*/
SELECT * FROM producto;
/*4.Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).*/
SELECT nombre, precio*0.21, precio*0.21*1.07 FROM producto;
/*5.Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.*/
SELECT nombre AS 'nombre de producto', precio*0.21 AS euros, precio*0.21*1.07 AS dólares FROM producto;
/*6.Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.*/
SELECT UPPER(nombre), precio FROM producto;
/*7.Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.*/
SELECT LOWER(nombre), precio FROM producto;
/*8.Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante y renombrado como inicial.*/
SELECT nombre, LEFT(UPPER(nombre), 2) AS inicial FROM fabricante;
/*9.Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.*/
SELECT nombre, ROUND(precio) FROM producto;
/*10.Lista el identificador de los fabricantes que tienen productos en la tabla producto.*/
SELECT id_fabricante FROM producto;
/*11.Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los identificadores que aparecen repetidos.*/
SELECT DISTINCT id_fabricante FROM producto;
/*12.Lista los nombres de los fabricantes ordenados de forma ascendente.*/
SELECT nombre FROM fabricante ORDER BY nombre ASC; 
/*13.Lista los nombres de los fabricantes ordenados de forma descendente.*/
SELECT nombre FROM fabricante ORDER BY nombre DESC; 
/*14.Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.*/
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
/*15.Devuelve una lista con las 5 primeras filas de la tabla fabricante.*/
SELECT * FROM fabricante LIMIT 5;
/*16.Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.*/
SELECT * FROM fabricante LIMIT 2 OFFSET 3; /*Imprime 2 filas a partir de la 3º fila*/
/*17.Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)*/
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
/*18.Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)*/
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
/*19.Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2.*/
SELECT nombre FROM producto WHERE id_fabricante=2;
/*20.Lista el nombre de los productos que tienen un precio menor o igual a 120€.*/
SELECT nombre FROM producto WHERE precio <= 120;
/*21.Lista el nombre de los productos que tienen un precio mayor o igual a 400€.*/
SELECT nombre FROM producto WHERE precio >= 400;
/*22.Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.*/
SELECT nombre FROM producto WHERE precio < 400; /*Otra forma => SELECT nombre FROM producto WHERE !(precio >= 400); Otra forma => SELECT nombre FROM producto WHERE NOT precio >= 400;*/
/*23.Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.*/
SELECT * FROM producto WHERE 80 <= precio AND precio <= 300;
/*24.Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.*/
SELECT * FROM producto WHERE precio BETWEEN 60 AND 200;
/*25.Lista todos los productos que tengan un precio mayor que 200€ y que el identificador de fabricante sea igual a 6.*/
SELECT * FROM producto WHERE precio > 200 AND id_fabricante = 6;
/*26.Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.*/
SELECT * FROM producto WHERE id_fabricante = 1 OR id_fabricante = 3 OR id_fabricante = 5;
/*27.Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Utilizando el operador IN.*/
SELECT * FROM producto WHERE id_fabricante in (1,3,5);
/*28.Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que contiene el precio que se llame céntimos.*/
SELECT nombre, (precio * 100) AS céntimos FROM producto;
/*29.Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.*/
SELECT nombre FROM fabricante WHERE nombre LIKE 'S%';
/*30.Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.*/
SELECT nombre FROM fabricante WHERE nombre LIKE '%e';
/*31.Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.*/
SELECT nombre FROM fabricante WHERE nombre LIKE '%w%';
/*32.Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.*/
SELECT nombre FROM fabricante WHERE nombre LIKE '____';
/*33.Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.*/
SELECT nombre FROM producto WHERE nombre LIKE '%Portátil%';
/*34.Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.*/
SELECT nombre FROM producto WHERE nombre LIKE '%Monitor%' AND precio < 215;
/*35.Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).*/
SELECT nombre, precio FROM producto WHERE precio >= 180 ORDER BY precio DESC, nombre ASC;

/*CONSULTAS MULTITABLA (INTERNA)*/
/*1.Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.*/
SELECT producto.nombre, precio, fabricante.nombre FROM producto, fabricante WHERE producto.id_fabricante = fabricante.id; /*SELECT producto.nombre, precio, fabricante.nombre FROM producto INNER JOIN fabricante ON producto.id_fabricante = fabricante.id;*/
/*2.Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.*/
SELECT producto.nombre, precio, fabricante.nombre FROM producto, fabricante WHERE producto.id_fabricante = fabricante.id ORDER BY fabricante.nombre;
/*3.Devuelve una lista con el identificador del producto, nombre del producto, identificador del fabricante y nombre del fabricante, de todos los productos de la base de datos.*/
SELECT producto.id, producto.nombre, fabricante.id, fabricante.nombre FROM productos, fabricante WHERE producto.id_fabricante = fabricante.id;
/*4.Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.*/
SELECT producto.nombre, precio, fabricante.nombre FROM productos, fabricante WHERE producto.id_fabricante = fabricante.id ORDER BY precio ASC LIMIT 1;
/*5.Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.*/
SELECT producto.nombre, precio, fabricante.nombre FROM productos, fabricante WHERE producto.id_fabricante = fabricante.id ORDER BY precio DESC LIMIT 1;
/*6.Devuelve una lista de todos los productos del fabricante Lenovo.*/
SELECT producto.* FROM producto, fabricante WHERE producto.id_fabricante = fabricante.id AND fabricante.nombre = 'Lenovo'; /*Aunque no obtengamos datos de fabricante, debemos ponerlo en el FROM para utilizar fabricante.id en en WHERE*/
/*7.Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.*/
SELECT producto.* FROM producto, fabricante WHERE producto.id_fabricante = fabricante.id AND fabricante.nombre = 'Crucial' AND precio > 200;
/*8.Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard Seagate. Sin utilizar el operador IN.*/
SELECT producto.* FROM producto INNER JOIN fabricante ON id_fabricante = fabricante.id WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Hewlett-Packard' OR fabricante.nombre = 'Seagate';
/*9.Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard Seagate. Utilizando el operador IN.*/
SELECT producto.* FROM producto INNER JOIN fabricante ON id_fabricante = fabricante.id WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');
/*10.Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.*/
SELECT producto.nombre, precio FROM producto INNER JOIN fabricante ON id_fabricante = fabricante.id WHERE fabricante.nombre LIKE '%e';
/*11.Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.*/
SELECT producto.nombre, precio FROM producto INNER JOIN fabricante ON id_fabricante = fabricante.id WHERE fabricante.nombre LIKE '%w%';
/*12.Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)*/
SELECT producto.nombre, precio, fabricante.nombre FROM producto INNER JOIN fabricante ON id_fabricante = fabricante.id WHERE precio >= 180 ORDER BY precio DESC, nombre ASC;
/*13.Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.*/
SELECT DISTINCT id_fabricante, fabricante.nombre FROM producto INNER JOIN fabricante ON id_fabricante = fabricante.id;

/*CONSULTAS RESUMEN*/
/*1.Calcula el número total de productos que hay en la tabla productos.*/
SELECT COUNT(*) FROM producto;
/*2.Calcula el número total de fabricantes que hay en la tabla fabricante.*/
SELECT COUNT(*) FROM fabricante;
/*3.Calcula el número de valores distintos de identificador de fabricante aparecen en la tabla productos.*/
SELECT COUNT(DISTINCT id_fabricante) FROM producto;
/*4.Calcula la media del precio de todos los productos.*/
SELECT AVG(precio) FROM producto;
/*5.Calcula el precio más barato de todos los productos.*/
SELECT MIN(precio) FROM producto;
/*6.Calcula el precio más caro de todos los productos.*/
SELECT MAX(precio) FROM producto;
/*7.Lista el nombre y el precio del producto más barato.*/
SELECT nombre,precio FROM producto WHERE precio = (SELECT MIN(precio) FROM producto);
/*8.Lista el nombre y el precio del producto más caro.*/
SELECT nombre,precio FROM producto WHERE precio = (SELECT MAX(precio) FROM producto);
/*9.Calcula la suma de los precios de todos los productos.*/
SELECT SUM(precio) FROM producto;
/*10.Calcula el número de productos que tiene el fabricante Asus.*/
SELECT COUNT(*) FROM producto, fabricante WHERE producto.id_fabricante = fabricante.id AND fabricante.nombre = 'Asus';
/*11.Calcula la media del precio de todos los productos del fabricante Asus.*/
SELECT AVG(precio) FROM producto, fabricante WHERE producto.id_fabricante = fabricante.id AND fabricante.nombre = 'Asus';
/*12.Calcula el precio más barato de todos los productos del fabricante Asus.*/
SELECT MIN(precio) FROM producto, fabricante WHERE producto.id_fabricante = fabricante.id AND fabricante.nombre = 'Asus';
/*13.Calcula el precio más caro de todos los productos del fabricante Asus.*/
SELECT MAX(precio) FROM producto, fabricante WHERE producto.id_fabricante = fabricante.id AND fabricante.nombre = 'Asus';
/*14.Calcula la suma de todos los productos del fabricante Asus.*/
SELECT SUM(precio) FROM producto, fabricante WHERE producto.id_fabricante = fabricante.id AND fabricante.nombre = 'Asus';
/*15.Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial.*/
SELECT MAX(precio),MIN(precio),AVG(precio),COUNT(*) FROM producto, fabricante WHERE producto.id_fabricante = fabricante.id AND fabricante.nombre = 'Crucial';
/*16.Muestra el número total de productos que tiene cada uno de los fabricantes. El listado también debe incluir los fabricantes que no tienen ningún producto. El resultado mostrará dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene. Ordene el resultado descendentemente por el número de productos.*/
SELECT fabricante.nombre,COUNT(producto.nombre) FROM fabricante LEFT JOIN producto ON fabricante.id = producto.id_fabricante GROUP BY fabricante.nombre ORDER BY 2 DESC;
/*17.Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes. El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.*/
SELECT MAX(precio), MIN(precio), AVG(precio), fabricante.nombre FROM producto, fabricante WHERE producto.id_fabricante= fabricante.id GROUP BY fabricante.nombre;
/*18.Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. No es necesario mostrar el nombre del fabricante, con el identificador del fabricante es suficiente.*/
SELECT MAX(precio), MIN(precio), AVG(precio), COUNT(producto.nombre), fabricante.id FROM producto, fabricante WHERE producto.id_fabricante= fabricante.id GROUP BY fabricante.id HAVING AVG(precio) > 200;
/*19.Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. Es necesario mostrar el nombre del fabricante.*/
SELECT MAX(precio), MIN(precio), AVG(precio), COUNT(producto.nombre), fabricante.nombre FROM producto, fabricante WHERE producto.id_fabricante= fabricante.id GROUP BY fabricante.id, fabricante.nombre HAVING AVG(precio) > 200;
/*20.Calcula el número de productos que tienen un precio mayor o igual a 180€.*/
SELECT COUNT(*) FROM producto WHERE precio >=180;
/*21.Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.*/
SELECT COUNT(*) FROM producto WHERE precio >=180 GROUP BY id_fabricante;
/*22.Lista el precio medio de los productos de cada fabricante, mostrando solamente el identificador del fabricante.*/
SELECT AVG(precio), id_fabricante FROM producto GROUP BY id_fabricante;
/*23.Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.*/
SELECT AVG(precio), fabricante.nombre FROM producto, fabricante WHERE fabricante.id = producto.id_fabricante GROUP BY fabricante.id, fabricante.nombre;
/*24.Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.*/
SELECT fabricante.nombre FROM fabricante, producto WHERE fabricante.id = producto.id_fabricante GROUP BY fabricante.id, fabricante.nombre HAVING AVG(precio)>= 150;
/*25.Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.*/
SELECT fabricante.nombre FROM fabricante, producto WHERE fabricante.id = producto.id_fabricante GROUP BY fabricante.id, fabricante.nombre HAVING COUNT(*) >=2;
/*26.Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.*/
SELECT fabricante.nombre, COUNT(*) FROM producto, fabricante WHERE fabricante.id = producto.id_fabricante AND precio >= 220 GROUP BY fabricante.id, fabricante.nombre;
/*27.Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus productos es superior a 1000 €.*/
SELECT fabricante.nombre FROM fabricante, producto WHERE fabricante.id = producto.id_fabricante GROUP BY fabricante.id, fabricante.nombre HAVING SUM(precio) > 1000;

/*SUBCONSULTAS*/

/*1.Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
SELECT * FROM producto WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre='Lenovo');
/*2.Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto,fabricante WHERE id_fabricante = fabricante.id AND fabricante.nombre = 'Lenovo');
/*3.Lista el nombre del producto más caro del fabricante Lenovo.*/
SELECT nombre FROM producto WHERE precio = (SELECT MAX(precio) FROM producto,fabricante WHERE id_fabricante = fabricante.id AND fabricante.nombre = 'Lenovo') AND id_fabricante = (SELECT id FROM fabricante WHERE nombre = 'Lenovo');
/*4.Lista el nombre del producto más barato del fabricante Hewlett-Packard.*/
SELECT nombre FROM producto WHERE precio = (SELECT MIN(precio) FROM producto,fabricante WHERE id_fabricante = fabricante.id AND fabricante.nombre = 'Hewlett-Packard') AND id_fabricante = (SELECT id FROM fabricante WHERE nombre = 'Hewlett-Packard');
/*5.Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.*/
SELECT * FROM producto WHERE precio >= (SELECT MAX(precio) FROM producto,fabricante WHERE id_fabricante = fabricante.id AND fabricante.nombre = 'Lenovo');
/*6.Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.*/
SELECT * FROM producto WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre = 'Asus') AND precio > (SELECT AVG(precio) FROM producto,fabricante WHERE id_fabricante = fabricante.id AND fabricante.nombre = "Asus");
/*7.Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.*/
SELECT * FROM producto WHERE precio >= ALL(SELECT precio FROM producto);
/*8.Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.*/
SELECT * FROM producto WHERE precio <= ALL(SELECT precio FROM producto);
/*9.Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).*/
SELECT nombre FROM fabricante WHERE id = ANY(SELECT id_fabricante FROM producto);
/*10.Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY)*/
SELECT nombre FROM fabricante WHERE NOT id = ANY(SELECT id_fabricante FROM producto);
/*11.Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).*/
SELECT nombre FROM fabricante WHERE id IN (SELECT id_fabricante FROM producto);
/*12.Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).*/
SELECT nombre FROM fabricante WHERE id NOT IN (SELECT id_fabricante FROM producto);
/*13.Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).*/
SELECT nombre FROM fabricante WHERE EXISTS (SELECT id_fabricante FROM producto WHERE id_fabricante = fabricante.id);
/*14.Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).*/
SELECT nombre FROM fabricante WHERE NOT EXISTS (SELECT id_fabricante FROM producto WHERE id_fabricante = fabricante.id);
