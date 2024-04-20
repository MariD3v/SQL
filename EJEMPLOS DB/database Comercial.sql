DROP DATABASE IF EXISTS comercial;
CREATE DATABASE comercial CHARACTER SET utf8mb4;
USE comercial;

CREATE TABLE cliente (
dni VARCHAR(9) PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
apellidos VARCHAR(60) NOT NULL,
fecha_nac DATE NOT NULL,
tipo_de_via VARCHAR(30) NOT NULL,
via VARCHAR(60) NOT NULL,
numero INT(3) NOT NULL,
piso VARCHAR(10) NOT NULL,
letra VARCHAR(10) NOT NULL,
cod_postal INT(5) NOT NULL
) engine = innodb;

CREATE TABLE factura (
cod_fac VARCHAR(6),
dni VARCHAR(9),
fecha_fac DATE,
importe INT NOT NULL,
FOREIGN KEY (dni) REFERENCES cliente(dni) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(cod_fac, dni, fecha_fac)
) engine = innodb;

CREATE TABLE articulo (
cod_art VARCHAR(7) PRIMARY KEY,
descripcion VARCHAR(255) NOT NULL,
precio INT NOT NULL,
stock INT NOT NULL
) engine = innodb;

CREATE TABLE albaran (
cod_alb VARCHAR(7),
cod_fac VARCHAR(6),
fecha_alb DATE,
cod_art VARCHAR(7),
cantidad INT NOT NULL,
FOREIGN KEY (cod_fac) REFERENCES factura(cod_fac) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (cod_art) REFERENCES articulo(cod_art) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (cod_alb, cod_fac, fecha_alb, cod_art)
) engine = innodb;

CREATE TABLE comercial (
dni VARCHAR(9) PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
apellidos VARCHAR(60) NOT NULL,
fecha_nac DATE NOT NULL,
tipo_de_via VARCHAR(30) NOT NULL,
via VARCHAR(60) NOT NULL,
numero INT(3) NOT NULL,
piso VARCHAR(10) NOT NULL,
letra VARCHAR(10) NOT NULL,
cod_postal INT(5) NOT NULL
) engine = innodb;

CREATE TABLE visitas (
dni_cli VARCHAR(9) NOT NULL,
dni_comercial VARCHAR(9) NOT NULL,
fecha_visita DATE NOT NULL,
FOREIGN KEY (dni_cli) REFERENCES cliente(dni) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (dni_comercial) REFERENCES comercial(dni) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (dni_cli, dni_comercial, fecha_visita)
) engine = innodb;

/*MANIPULACIÓN DE DATOS*/
INSERT INTO cliente (dni, nombre, apellidos, fecha_nac, tipo_de_via, via, numero, piso, letra, cod_postal) VALUES
	("11111111A", "Jose", "Perez Perez", "1974-08-01", "C/", "Lepanto", 25, "5º", "B", 30001),
	("22222222B", "Maria", "Sanchez Sanchez", "1985-03-25", "C/", "Cervantes", 1, "2º", "A", 30001),
	("33333333C", "Pedro", "Martinez Lopez", "1995-06-10", "C/", "Medina", 15, "1º", "C", 30009),
	("44444444D", "Juan", "Flores Puerta ", "1991-04-12", "C/", "Velazquez", 20, "4º", "D", 30008);
    
INSERT INTO factura (cod_fac, dni, fecha_fac, importe) VALUES
	("F-0001", "11111111A", "2012-02-01", 2800),
	("F-0002", "11111111A", "2012-03-02", 1500),
	("F-0003", "11111111A", "2012-08-15", 800),
	("F-0004", "22222222B", "2013-09-20", 3000),
	("F-0005", "22222222B", "2013-10-02", 900),
	("F-0006", "33333333C", "2013-11-15", 2500),
	("F-0007", "44444444D", "2014-02-02", 520),
	("F-0008", "44444444D", "2015-02-04", 2500);

INSERT INTO articulo (cod_art, descripcion, precio, stock) VALUES
	("ART-10", "Elevador potencia", 60, 50),
	("ART-80", "Condesador RJW ", 20, 200),
	("ART-77", "Placa Base ASUS 1155", 50, 35),
	("ART-100", "SAI 1500VA-Salicru", 500, 8),
	("ART-101", "Condesador RJW", 20, 200),
	("ART-120", "Ventilador led enermax", 10, 55),
	("ART-250", "Condesador RJW", 250, 40);
    
INSERT INTO albaran (cod_alb, cod_fac, fecha_alb, cod_art, cantidad) VALUES
	("A-0001", "F-0001", "2012-01-10", "ART-250", 10),
	("A-0002", "F-0001", "2012-01-20", "ART-120", 30),
	("A-0003", "F-0002", "2012-02-15", "ART-100", 3),
	("A-0004", "F-0003", "2012-04-03", "ART-80", 25),
	("A-0005", "F-0003", "2012-06-15", "ART-120", 10),
	("A-0006", "F-0003", "2012-07-25", "ART-77", 4),
	("A-0007", "F-0004", "2013-09-20", "ART-10", 50),
	("A-0008", "F-0005", "2013-10-02", "ART-10", 15),
	("A-0009", "F-0006", "2013-11-15", "ART-100", 5),
	("A-00010", "F-0007", "2014-02-01", "ART-101", 1),
	("A-00011", "F-0007", "2014-02-02", "ART-100", 1),
	("A-00012", "F-0008", "2015-02-04", "ART-100", 5);
    
INSERT INTO comercial (dni, nombre, apellidos, fecha_nac, tipo_de_via, via, numero, piso, letra, cod_postal) VALUES
	("55555555E", "Berta", "Fuertes Ruiz", "1980-08-01", "C/", "Medina", 40, "3º", "A", 30008),
	("66666666F", "Luis", "Perez Martinez", "1983-02-23", "C/", "Picasso", 3, "7º", "C", 30001),
	("77777777G", "Ramon", "Lucas Sanchez", "1995-06-12", "C/", "Nadal", 14, "1º", "D", 30009),
	("88888888H", "Juana", "Luna Puertas", "1991-05-15", "C/", "Colon", 20, "4º", "D", 30007);

INSERT INTO visitas (dni_cli, dni_comercial, fecha_visita) VALUES
	("11111111A", "66666666F", "2012-04-01"),
	("11111111A", "66666666F", "2012-06-01"),
	("22222222B", "66666666F", "2013-05-10"),
	("33333333C", "55555555E", "2014-07-12"),
	("33333333C", "66666666F", "2014-04-01"),
	("44444444D", "77777777G", "2012-02-07"),
	("44444444D", "66666666F", "2013-04-01"),
	("44444444D", "55555555E", "2014-04-15");

/*CONSULTAS*/

/*1.Hallar todos los datos de los clientes mayores de 35 años a fecha de hoy. Ordénalos alfabéticamente por cliente.*/
SELECT * FROM cliente WHERE DATEDIFF(NOW(), fecha_nac)/365 >= 35 ORDER BY apellidos ASC, nombre ASC;
/*2.Hallar todos los datos de los clientes mayores de 35 años que residan en un distrito de código postal 30001. Ordénalos alfabéticamente por cliente.*/
SELECT * FROM cliente WHERE DATEDIFF(NOW(), fecha_nac)/365 >= 35 AND cod_postal = 30001 ORDER BY nombre ASC, apellidos ASC;
/*3.Hallar el nº de clientes que residen en cada uno de los distritos (e.d que tengan mismo código postal). En la salida indicar el ćodigo postal y el nº de clientes correspondiente como num_cli.*/
SELECT cod_postal, COUNT(dni) AS num_cli FROM cliente GROUP BY cod_postal;
/*4.Hallar los diferentes códigos postales tanto de clientes como de comerciales. LLama al campo cod_postal y ordénalos por ese campo.*/
SELECT cod_postal FROM cliente UNION SELECT cod_postal FROM comercial; # UNION junta dos columnas y elimina por defecto los duplicados
/*5.Hallar la media de los stocks de artículos. (solo con dos decimales, redondeados) llama al campo media_stock.*/
SELECT ROUND(AVG(stock), 2) AS media_stock FROM articulo;
/*6.Hallar la media del precio unitario de los artículos que se hayan vendido en 2014 (que aparezcan en albaranes de 2014) (solo con dos decimales, redondeados) llama al campo media_precio.*/
SELECT ROUND(AVG(precio),2) AS media_precio FROM articulo, albaran WHERE articulo.cod_art = albaran.cod_art AND YEAR(fecha_alb) = 2014; 
/*7.Hallar el código y descripción de aquellos artículos que están por encima del precio medio de todos los artículos, ordenalos por codigo.*/
SELECT cod_art, descripcion FROM articulo WHERE precio > (SELECT AVG(precio) FROM articulo) ORDER BY cod_art DESC;
/*8.Hallar el valor total actual del almacen. (lo que valen todos los artículos que tenemos en stock almacenados) llama al campo valor_total.*/
SELECT SUM(stock*precio) AS valor_total FROM articulo;
/*9.Hallar el valor de la facturación total en 2012. llama al campo total_fac_2012.*/
SELECT SUM(importe) AS total_fac_2012 FROM factura WHERE YEAR(fecha_fac) = 2012;
/*10.Hallar el valor de la facturación total en cada distrito (codigo_postal de cliente). Incluye en la salida el código postal y la facturación total para ese distrito como total_fac.*/
SELECT SUM(importe) AS total_fac, cod_postal FROM factura, cliente WHERE factura.dni = cliente.dni GROUP BY cod_postal;
/*11.Hallar (en una solo consulta) el valor de la facturación total por cada año. Incluye en la salida el año como anyo y la facturaciṕon total como total_fac. Ordenalos por año.*/
SELECT SUM(importe) AS total_fac, YEAR(fecha_fac) AS anyo FROM factura GROUP BY YEAR(fecha_fac) ORDER BY YEAR(fecha_fac) ASC;
/*12.Hallar (para cada factura) el nº de albaranes que la componen. Incluye el cod_fac y el nº de albaranes en el resultado de la consulta como num_albaran ordenalos por cod_fac.*/
SELECT COUNT(*) AS num_albaran, cod_fac FROM albaran GROUP BY cod_fac ORDER BY cod_fac DESC;
/*13.Hallar todos los datos de la/s factura/s de mayor importe. Ordénalos por codigo de factura.*/
SELECT factura.* FROM factura WHERE importe = (SELECT MAX(importe) FROM factura) ORDER BY cod_fac ASC;
/*14.Hallar los cod_fac e importe de las facturas correspondientes a los tres mayores importes. Ordénalos por importe de mayor a menor y luego por cod_fac.*/
SELECT cod_fac, importe FROM factura f1 WHERE (SELECT COUNT(DISTINCT(importe)) FROM factura f2 WHERE f2.importe > f1.importe) < 3 ORDER BY f1.importe DESC, cod_fac ASC;
/*15.Hallar todos los datos de tres facturas de mayor importe. Ordénalos por importe de mayor a menor y luego por cod_fac.*/
SELECT * FROM factura ORDER BY importe DESC, cod_fac ASC LIMIT 3;
/*16.Hallar todos los datos de los artículos cuyo media de ventas para ese articulo (media del nº de unidades vendidas en cada albaran para ese artículo) suponga 40% o más del stock actual para ese artículo. Ordénalos por código de artículo.*/
SELECT A1.cod_art, A1.descripcion, A1.precio, A1.stock FROM articulo A1 INNER JOIN albaran ON albaran.cod_art= A1.cod_art GROUP BY A1.cod_art, A1.descripcion, A1.precio, A1.stock HAVING AVG(albaran.cantidad) >= (SELECT stock*0.4 FROM articulo A2 WHERE A1.cod_art = A2.cod_art) ;
/*17.Hallar todos los datos de albaranes de 2012 o 2014 pero que sus cantidades de articulos vendidos sea 10 o 30. Ordénalos por código de albaran. NO UTILICES BETWEEN. */

/*18.Hallar, para cada cliente, el dni junto con su facturación total como total_fact. */


/*MANIPULACIÓN DE DATOS*/

/*1.Actualizar todos los stocks de artículos incrementado en un 20% aquellos artículos cuyo stock esté por debajo de 10 unidades. Utiliza redondeo al alza para hallar el stock entero más próximo al cálculo realizado.*/

/*2.Actualizar todos los precios de artículos incrementado en un 8% aquellos artículos cuyo precio sea 250 o superior. Utiliza redondeo al alza para hallar el precio entero más próximo al cálculo realizado.*/

