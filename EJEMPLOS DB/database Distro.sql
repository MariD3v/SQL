DROP DATABASE IF EXISTS distro;
CREATE DATABASE  distro;
USE distro;

CREATE TABLE oficinas (
  oficina int(11) NOT NULL DEFAULT '0',
  ciudad char(15) NOT NULL DEFAULT '',
  region char(10) NOT NULL DEFAULT '',
  dir int(11) NOT NULL DEFAULT '0',
  objetivo decimal(10,0) DEFAULT NULL,
  ventas decimal(10,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (oficina)
);

CREATE TABLE  repventas (
  numempl int(11) NOT NULL DEFAULT '0',
  nombre char(15) UNIQUE NOT NULL DEFAULT '',
  edad int(11) DEFAULT NULL,
  oficinarep int(11) DEFAULT NULL,
  titulo char(10) DEFAULT NULL,
  contrato date NOT NULL ,
  director int(11) DEFAULT NULL,
  cuota decimal(10,0) DEFAULT NULL,
  ventas decimal(10,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (numempl)
);

CREATE TABLE clientes (
  numclie int(11) NOT NULL DEFAULT '0',
  empresa char(20) NOT NULL DEFAULT '',
  repclie int(11) NOT NULL DEFAULT '0',
  limitecredito decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (numclie)
);


CREATE TABLE  productos (
  idfab char(3) NOT NULL DEFAULT '',
  idproducto char(5) NOT NULL DEFAULT '',
  descripcion char(20) NOT NULL DEFAULT '',
  precio decimal(10,0) NOT NULL DEFAULT '0',
  existencias int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (idfab,idproducto)
);

CREATE TABLE  pedidos (
  numpedido int(11) NOT NULL DEFAULT '0',
  fechapedido date NOT NULL ,
  clie int(11) NOT NULL DEFAULT '0',
  rep int(11) NOT NULL DEFAULT '0',
  fab char(3) NOT NULL DEFAULT '',
  producto char(5) NOT NULL DEFAULT '',
  cant int(11) NOT NULL DEFAULT '0',
  importe decimal(10,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (numpedido)
);


INSERT INTO productos (idfab, idproducto, descripcion, precio, existencias) VALUES
	('ACI', '41001', 'Articulo Tipo 1', 55, 277),
	('ACI', '41002', 'Articulo Tipo 2', 76, 167),
	('ACI', '41003', 'Articulo Tipo 3', 107, 207),
	('ACI', '41004', 'Articulo Tipo 4', 117, 139),
	('ACI', '4100X', 'Ajustador', 25, 37),
	('ACI', '4100Y', 'Extractor', 2750, 25),
	('ACI', '4100Z', 'Montador', 2500, 28),
	('BIC', '41003', 'Manivela', 652, 3),
	('BIC', '41089', 'Reten', 225, 78),
	('BIC', '41672', 'Placa', 180, 0),
	('FEA', '112', 'Cubierta', 148, 115),
	('FEA', '114', 'Bancada Motor', 243, 15),
	('IMM', '773C', 'Riostra 1/2 Tm', 975, 28),
	('IMM', '775C', 'Riostra 1-Tm', 1425, 5),
	('IMM', '779C', 'Riostra 2-Tm', 1875, 9),
	('IMM', '878H', 'Soporte Riostra', 54, 223),
	('IMM', '887P', 'Perno Riostra', 250, 24),
	('IMM', '887X', 'Retenedor Riostra', 475, 32),
	('QSA', 'XK47', 'Reductor', 355, 38),
	('QSA', 'XK48', 'Reductor', 134, 203),
	('QSA', 'XK48A', 'Reductor', 117, 37),
	('REI', '2A44G', 'Pasador Bisagra', 350, 14),
	('REI', '2A44L', 'Bisagra Izqda.', 4500, 12),
	('REI', '2A44R', 'Bisagra Dcha.', 4500, 12),
	('REI', '2A45C', 'V Stago Trinquete', 79, 210);

INSERT INTO repventas (numempl, nombre, edad, oficinarep, titulo, contrato, director, cuota, ventas) VALUES
	(106, 'Sam Clark', 52, 11, 'VP Ventas', '1988-06-14', NULL, 275000, 299912),
	(104, 'Bob Smith', 33, 12, 'Dir Ventas', '1987-05-19', 106, 200000, 142594),
	(108, 'Larry Fitch', 62, 21, 'Dir Ventas', '1989-10-12', 106, 350000, 361865),
	(109, 'Mary Jones', 31, 11, 'Rep Ventas', '1989-10-12', 106, 300000, 392725),
	(101, 'Dan Roberts', 45, 11, 'Rep Ventas', '1986-10-20', 104, 300000, 305673),
	(102, 'Sue Smith', 48, 21, 'Rep Ventas', '1989-12-10', 108, 350000, 474050),
	(103, 'Paul Cruz', 29, 11, 'Rep Ventas', '1987-03-01', 104, 235715, 286775),
	(105, 'Bill Adams', 37, 13, 'Rep Ventas', '1988-02-12', 104, 350000, 367911),
	(107, 'Nancy Angelli', 49, 22, 'Rep Ventas', '1988-11-14', 108, 300000, 186042),
	(110, 'Tom Snyder', 41, NULL, 'Rep Ventas', '1990-01-13', 101, NULL, 75985);

INSERT INTO oficinas (oficina, ciudad, region, dir, objetivo, ventas) VALUES
	(12, 'Chicago', 'Este', 104, 800000, 735042),
	(13, 'Atlanta', 'Este', 105, 350000, 367911),
	(21, 'Los Angeles', 'Oeste', 108, 725000, 835915),
	(22, 'Denver', 'Oeste', 108, 300000, 186042),
	(11, 'New York', 'Este', 106, 575000, 692637);


INSERT INTO clientes (numclie, empresa, repclie, limitecredito) VALUES
	(2101, 'Jones Mfg.', 106, 65000),
	(2105, 'AAA Investments', 101, 45000),
	(2119, 'Solomon Inc.', 109, 25000),
	(2122, 'Three-Way Lines', 105, 30000),
	(2106, 'Fred Lewis Corp.', 102, 65000),
	(2108, 'Holm Landis', 109, 55000),
	(2109, 'Chen Associates', 103, 25000),
	(2111, 'JCP Inc.', 103, 50000),
	(2112, 'Zetacorp', 108, 50000),
	(2113, 'Ian Schmidt', 104, 20000),
	(2114, 'Orion Corp.', 102, 20000),
	(2115, 'Smithson Corp.', 101, 20000),
	(2117, 'J.P. Sinclair', 106, 35000),
	(2118, 'Midwest Systems', 108, 60000),
	(2107, 'Ace International', 110, 35000),
	(2120, 'Rico Enterprises', 102, 50000),
	(2121, 'QMA Assoc.', 103, 45000),
	(2103, 'Acme Mfg.', 105, 50000),
	(2123, 'Carter Sons', 102, 40000),
	(2124, 'Peter Brothers', 107, 40000),
	(2102, 'First Corp.', 101, 65000);

INSERT INTO pedidos (numpedido, fechapedido, clie, rep, fab, producto, cant, importe) VALUES
	(112963, '1989-12-17', 2103, 105, 'ACI', '41004', 28, 3276),
	(112979, '1989-12-12', 2114, 102, 'ACI', '4100Z', 6, 15000),
	(110036, '1990-01-20', 2107, 110, 'ACI', '4100Z', 9, 22500),
	(112968, '1989-12-12', 2102, 101, 'ACI', '41004', 34, 3978),
	(112983, '1989-12-27', 2103, 105, 'ACI', '41004', 6, 702),
	(112987, '1989-12-31', 2103, 105, 'ACI', '4100Y', 11, 27500),
	(112989, '1990-01-03', 2101, 106, 'FEA', '114', 6, 1458),
	(112961, '1989-12-17', 2117, 106, 'REI', '2A44L', 7, 31500),
	(112997, '1990-01-08', 2124, 107, 'BIC', '41003', 1, 652),
	(113003, '1990-01-25', 2108, 109, 'IMM', '779C', 3, 5625),
	(113007, '1990-01-08', 2112, 108, 'IMM', '773C', 3, 2925),
	(113012, '1990-01-11', 2111, 105, 'ACI', '41003', 35, 3745),
	(113013, '1990-01-14', 2118, 108, 'BIC', '41003', 1, 652),
	(113024, '1990-01-20', 2114, 108, 'QSA', 'XK47', 20, 7100),
	(113027, '1990-01-22', 2103, 105, 'ACI', '41002', 54, 4104),
	(113042, '1990-02-02', 2113, 101, 'REI', '2A44R', 5, 22500),
	(113045, '1990-02-02', 2112, 108, 'REI', '2A44R', 10, 45000),
	(113048, '1990-02-10', 2120, 102, 'IMM', '779C', 2, 3750),
	(113049, '1990-02-10', 2118, 108, 'QSA', 'XK47', 2, 776),
	(113051, '1990-02-10', 2118, 108, 'QSA', 'XK47', 4, 1420),
	(113055, '1990-02-15', 2108, 101, 'ACI', '4100X', 6, 150),
	(113057, '1990-02-18', 2111, 103, 'ACI', '4100X', 24, 600),
	(113058, '1990-02-23', 2108, 109, 'FEA', '112', 10, 1480),
	(113062, '1990-02-24', 2124, 107, 'FEA', '114', 10, 2430),
	(113065, '1990-02-27', 2106, 102, 'QSA', 'XK47', 6, 2130),
	(113069, '1990-03-02', 2109, 107, 'IMM', '775C', 22, 31350),
	(113034, '1990-01-29', 2107, 110, 'REI', '2A45C', 8, 632),
	(112992, '1989-11-04', 2118, 108, 'ACI', '41002', 10, 760),
	(112975, '1989-10-12', 2111, 103, 'REI', '2A44G', 6, 2100),
	(112993, '1990-01-04', 2106, 102, 'REI', '2A45C', 24, 1896);

ALTER TABLE oficinas ADD
CONSTRAINT FK_oficinas FOREIGN KEY (dir) REFERENCES repventas (numempl);

ALTER TABLE repventas ADD
CONSTRAINT FK1_repventas FOREIGN KEY (oficinarep) REFERENCES oficinas (oficina);

ALTER TABLE repventas ADD
CONSTRAINT FK2_repventas FOREIGN KEY (director) REFERENCES repventas (numempl);

ALTER TABLE clientes ADD
CONSTRAINT FK_clientes FOREIGN KEY (repclie) REFERENCES repventas (numempl);

ALTER TABLE pedidos ADD
CONSTRAINT FK1_pedidos FOREIGN KEY (clie) REFERENCES clientes (numclie);

ALTER TABLE pedidos ADD
CONSTRAINT FK2_pedidos FOREIGN KEY (rep) REFERENCES repventas (numempl);

ALTER TABLE pedidos ADD
CONSTRAINT FK3_pedidos FOREIGN KEY (fab,producto) REFERENCES productos (idfab,idproducto);

/*CONSULTAS MULTITABLA (INTERNA)*/
/*1. Lista nombre y objetivo (diferencia entre cuota y ventas) de los empleados.*/
SELECT nombre, (cuota-ventas) AS objetivo FROM repventas;
/*2. Lista los nombres, oficinas y fechas de contrato de todos los vendedores.*/
SELECT nombre, oficinarep, contrato FROM repventas;
/*3. Muestra los identificadores de cada producto, su descripción y valor (existencias por precio) de cada producto almacenado.*/
SELECT idfab, idproducto, descripcion, (existencias*precio) AS valor FROM productos;
/*4. Listar nombre y ventas de los empleados que están dirigidos por el empleado número 104.*/
SELECT nombre, ventas FROM repventas WHERE director=104;
/*5. Listar empleados que no tienen oficina asignada*/
SELECT * FROM repventas WHERE oficinarep<=>NULL ;//IS NULL también
/*6. .Hallar el número e importe de los pedidos cuyo importe está entre 20000 y 30000. Utiliza Between*/
SELECT numpedido,importe FROM pedidos WHERE importe BETWEEN 20000 AND 30000;
/*7. Lista el nombre de cada uno de los vendedores y la ciudad y región donde trabajan.*/
SELECT nombre,ciudad,region FROM repventas,oficinas WHERE oficinarep=oficina;
/*8. Lista la ciudad de las oficinas y los nombres y títulos de sus directores que dirijan una oficina que tenga un objetivo superior a 600000.*/
SELECT ciudad,nombre,titulo FROM oficinas,repventas WHERE dir=numempl AND objetivo>600000;
/*9. Lista todos los números de los pedidos, mostrando los importes y las descripciones del producto.*/
SELECT numpedido, importe, descripcion FROM pedido, productos WHERE producto = idproducto AND idfab = fab; /*PRIMARY KEY COMPUESTA!!*/
/*10. Lista los números de los pedidos superiores a 30000 euros incluyendo el importe, el nombre del vendedor que tomó el pedido, la ciudad de la oficina en donde trabaja ese vendedor y el nombre del cliente que lo solicitó*/
SELECT numpedido,importe,nombre,ciudad,empresa FROM pedidos,clientes,repventas,oficinas WHERE clie=numclie AND rep=numempl AND oficinarep=oficina AND importe>30000; /*UNIÓN DE 3 TABLAS*/
SELECT numpedido,importe,nombre,ciudad,empresa FROM pedidos INNER JOIN repventas ON rep = numemple INNER JOIN clientes ON clie=numclie INNER JOIN oficinas ON oficinarep=oficina WHERE importe >30000;/*Con inner join*/
