DROP DATABASE IF EXISTS BOMBONES;
CREATE DATABASE BOMBONES;
USE BOMBONES;

CREATE TABLE CAJAS(
    IdCaja      CHAR(6) NOT NULL,
    NombreCaja  VARCHAR(40) NOT NULL,
    Tamano      INTEGER NOT NULL, 
    Precio      FLOAT NOT NULL,
    Cantidad    FLOAT NOT NULL,
    CONSTRAINT PK_CAJAS PRIMARY KEY (IdCaja),
    CONSTRAINT UK01_CAJAS UNIQUE (NombreCaja),
    CONSTRAINT CHK01_CAJAS CHECK (Precio>=0)
 ) ENGINE=INNODB;    

 CREATE TABLE PEDIDOS(
    IdPedido           CHAR(6) NOT NULL,
    IdCliente          CHAR(6) NOT NULL,
    FechaPedido        DATE NOT NULL,
    CalleEnvio         VARCHAR(40) NOT NULL,
    CiudadEnvio        VARCHAR(25) NOT NULL,
    CodigoPostalEnvio  CHAR(5) NOT NULL,
    CONSTRAINT PK_PEDIDOS PRIMARY KEY (IdPedido)
 ) ENGINE=INNODB;

 CREATE TABLE DETALLES_PEDIDOS(
    IdPedido   CHAR(6) NOT NULL,
    IdCaja       CHAR(6) NOT NULL,
    CantidadP  FLOAT NOT NULL,
    CONSTRAINT PK_DETALLES_PEDIDOS PRIMARY KEY (IdPedido,IdCaja),
    CONSTRAINT FK01_DETALLES_PEDIDOS FOREIGN KEY (IdPedido)
      REFERENCES PEDIDOS(IdPedido) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK02_DETALLES_PEDIDOS FOREIGN KEY (IdCaja)
      REFERENCES CAJAS(IdCaja) ON UPDATE CASCADE,
    CONSTRAINT CHK01_DETALLES_PEDIDOS CHECK (CantidadP>=0)
 )ENGINE=INNODB;

CREATE UNIQUE INDEX IND01_DETALLES_PE ON DETALLES_PEDIDOS(IdCaja,IdPedido); 

INSERT INTO PEDIDOS VALUES 
   ('1','237','1993/11/02','123, Gran Vía','Madrid','22110'),
   ('2','386','1993/11/02','12, Castellana','Madrid','22900'),
   ('3','158','1993/11/02','12, Pseo de la Habana','Guadalajara','17013'),
   ('4','332','1993/11/02','11, Ruiz Manero','Rota','70001'),
   ('5','373','1993/11/02','113, Diagonal','Manresa','21203'),
   ('6','1','1993/11/02','1099 Broadway','New York','10014'),
   ('7','275','1993/11/02','334 Casas de sala','San Fernando','91344'),
   ('8','374','1993/11/03','416 N. Elm Dr.','Hunter','12442'),
   ('9','348','1993/11/03','10 Pepper Dr.','San Jose','95148')
   ;


INSERT INTO CAJAS VALUES 
   ('ALPI','Colección Alpina',12,12.47,400),
   ('AUTU','Colección Otoño',16,25.84,200),
   ('BITT','Agridulce',16,16.68,200),
   ('CHER','Clásicos Cherry',8,9.77,500),
   ('FUDG','Fantasía de moca y chocolate',12,10.82,400),
   ('HEAV','Avellanas Celestiales',8,9.47,300),
   ('ISLA','Colección Isla',16,21.04,400),
   ('LOVE','Corazones amantes',8,10.52,300),
   ('MARZ','Maravillas de mazapán',12,19.38,500),
   ('NORT','Colección Viento',16,19.98,700),
   ('PACI','Opulencia del Pacífico',8,12.62,500),
   ('PEAN','Delicias de Mantequilla de Cacahuete',12,11.42,900),
   ('SWEE','Dulces y Amargos',16,16.48,300)
   ;


INSERT INTO DETALLES_PEDIDOS VALUES 
   ('1','ALPI',2),
   ('2','PEAN',1),
   ('2','LOVE',2),
   ('3','CHER',2),
   ('3','NORT',1),
   ('4','AUTU',1),
   ('4','BITT',2),
   ('4','PACI',1),
   ('5','AUTU',2),
   ('5','BITT',2),
   ('5','FUDG',1),
   ('5','ISLA',1),
   ('6','BITT',1),
   ('6','FUDG',1),
   ('6','HEAV',2),
   ('6','NORT',2),
   ('6','PEAN',1),
   ('6','SWEE',2),
   ('7','PEAN',1),
   ('8','FUDG',1),
   ('8','MARZ',2),
   ('9','NORT',2),
   ('9','PACI',1)
   ;

/*1 CONSULTAS*/
-- 1 Mostrar para cada caja cuantas veces se ha pedido. Indicando el nombre de la caja en la respuesta 
SELECT NombreCaja, SUM(CantidadP) FROM CAJAS INNER JOIN DETALLES_PEDIDOS ON DETALLES_PEDIDOS.IdCaja = CAJAS.IdCaja GROUP BY NombreCaja;
-- 2 Mostrar el código de los clientes que han pedido alguna vez la caja de mayor precio.
SELECT PEDIDOS.IdCliente, Precio FROM PEDIDOS, DETALLES_PEDIDOS, CAJAS WHERE DETALLES_PEDIDOS.IdCaja = CAJAS.IdCaja AND PEDIDOS.IdPedido = DETALLES_PEDIDOS.IdPedido AND Precio = (SELECT MAX(Precio) FROM CAJAS);
-- 3 Listar los nombres de las cajas que se hayan pedido más de una vez y cuantas veces se han pedido.
SELECT NombreCaja, COUNT(CantidadP) FROM CAJAS INNER JOIN DETALLES_PEDIDOS ON DETALLES_PEDIDOS.IdCaja = CAJAS.IdCaja GROUP BY NombreCaja HAVING COUNT(CantidadP) > 1;
-- 4 Hallar los datos de las 6 cajas de mayor tamaño. Ordénalo por cantidad de menor a mayor.
SELECT * FROM cajas ORDER BY tamano DESC, cantidad ASC LIMIT 6;
-- 5 Mostrar cuál es el código de la caja que más se ha vendido.
SELECT IdCaja, SUM(CantidadP) FROM DETALLES_PEDIDOS GROUP BY IdCaja HAVING SUM(CantidadP) >= ALL(SELECT SUM(CantidadP) FROM DETALLES_PEDIDOS GROUP BY IdCaja);
-- 6 Mostrar cuál es el valor de venta de todas las cajas que quedan disponibles y que alguna vez hayan sido pedidas por un cliente de Madrid.
SELECT SUM(Precio*Cantidad) FROM PEDIDOS, DETALLES_PEDIDOS, CAJAS WHERE DETALLES_PEDIDOS.IdCaja = CAJAS.IdCaja AND PEDIDOS.IdPedido = DETALLES_PEDIDOS.IdPedido AND CiudadEnvio = 'Madrid' AND Cantidad > 1;
-- 7 Hallar el código, nombre de aquellas cajas cuya cantidad en stock esté entre los 3 mayores. Ordénalo por cantidad de mayor a menor.
SELECT IdCaja, NombreCaja, Cantidad FROM CAJAS C1 WHERE (SELECT COUNT(DISTINCT(Cantidad)) FROM CAJAS C2 WHERE C1.Cantidad > C2.Cantidad) < 3 ORDER BY Cantidad DESC;

/*2 MANIPULACIÓN DE DATOS*/
-- 1 Inserta una nueva caja con los siguientes campos: 'NEW', '3 Chocolates', 23, 15.98, 200. (
INSERT INTO CAJAS(IdCaja, NombreCaja, Tamano, Precio, Cantidad) VALUES ('NEW', '3 Chocolates', 23,15.98,200); 
-- 2 De las cajas ALPI aumentar la cantidad de 400 a 600
UPDATE CAJAS SET Cantidad = 600 WHERE IdCaja = 'ALPI';
-- 3 Decrementar en un 10% ( =*0,9) el precio de aquellas cajas cuya cantidad pedida sea superior a 3 en total (no necesariamente en un solo pedido)
UPDATE CAJAS SET Precio = Precio * 0.9 WHERE IdCaja IN (SELECT CAJAS.IdCaja FROM CAJAS INNER JOIN DETALLES_PEDIDOS ON DETALLES_PEDIDOS.IdCaja = CAJAS.IdCaja GROUP BY IdCaja HAVING SUM(CantidadP) > 3);
-- 4 Alterar la tabla detalle_pedido para añadir la clave ajena ‘IdCliente’ que hay en dicha tabla. Llama a esa clave ajena EXT_CLI.
ALTER TABLE DETALLES_PEDIDOS ADD COLUMN IdCliente CHAR(6) NOT NULL;
ALTER TABLE DETALLES_PEDIDOS ADD CONSTRAIN EXT_CLI FOREIGN KEY DETALLE_PEDIDOS(IdCliente) REFERENCES PEDIDOS(IdCliente);
-- 5 Añadir un campo ‘tipo’ a la tabla caja, que tendrá lo siguientes valores: negro, blanco, con leche
ALTER TABLE CAJAS ADD COLUMN tipo ENUM("negro","blanco","con leche");
-- 6 Elimina la caja de mayor precio
DELETE * FROM CAJAS WHERE Precio = (SELECT MAX(Precio) FROM CAJAS);

/*3. OTROS OBJETOS DE LA BBDD*/
-- 1 Crear una vista llamada V_COLECCIÓN, que muestre los códigos de aquellos clientes que han pedido alguna caja en cuyo nombre esté la palabra “Colección”
CREATE VIEW V_COLECCIÓN AS SELECT IdCliente FROM PEDIDOS INNER JOIN DETALLES_PEDIDOS ON PEDIDOS.IdPedido = DETALLES_PEDIDOS.IdPedido INNER JOIN CAJAS ON DETALLES_PEDIDOS.IdCaja = CAJAS.IdCaja WHERE NombreCaja LIKE "%Colección%";
-- 2 Consulta la vista creada anteriormente.
SHOW CREATE VIEW V_COLECCIÓN;

/*4. USUARIOS Y PERMISOS*/
-- 1 Dar todos los privilegios al usuario id01 sobre la tabla pedidos, con la posibilidad de que id01 pueda conceder los permisos a otros usuarios. 
CREATE USER "id01"@"%" IDENTIFIED BY "123";
GRANT ALL PRIVILEGES ON bombones.pedidos TO "id01"@"%" WITH GRANT OPTION;
-- 2 Crea el usuario global id02 con clave PSW y asígnale permisos para que pueda insertar y modificar en la tabla cajas
CREATE USER "id02"@"%" IDENTIFIED BY "PSW";
GRANT INSERT, UPDATE ON bombones.cajas TO "id02"@"%";
-- 3 Quitar el permiso select al usuario id01 sobre la tabla pedidos
REVOKE SELECT ON bombones.pedidos FROM "id01"@"%";
