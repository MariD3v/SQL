/*TEORIA CONSULTAS

SELECT columna [ALL (muestra todo), DISTINCT (elimina duplicados), operaciones, AS, CONCAT]
  	[FROM] tabla
	[WHERE] condición 
	[GROUP BY]
	[HAVING]
	[ORDER BY] [ASC(ordena ascendente), DESC(ordena descendente)]
	[LIMIT] (nº de filas a mostrar)
    
INSERT: se utiliza para insertar registros en las tablas de la base de datos.
UPDATE: se utiliza para actualizar los registros de una tabla.
DELETE: se utiliza para eliminar registros de una tabla.
*/
/*
TIPOS DE CONDICIONES
1. Comparar valores -> <, <=, >, >=, =, <>
2. Comprobar si un valor está dentro de un rango de valores -> BETWEEN...AND...
3. Comprobar si un valor está dentro de un conjunto de valores -> IN 
4. Comprobar cadenas con patrones LIKE % (cualquier conjunto de valores), LIKE _ (cualquier caracter, solo 1)
5. Comprobar si una columna tiene valores nulos IS (NOT) NULL
*/

GROUP BY (3 CASOS)

*Quiero conseguir el maximo precio de la tabla articulo
SELECT MAX(precio) FROM articulo; /* No se agrupa, porque no hay FK (id_categoria)*/
*Tengo un articulo que petenece a una categoria (en otra tabla), consigue el maximo precio por categoria
SELECT MAX(precio), id_categoria FROM articulo GROUP BY id_categoria; /* Se agrupa y podria ser sin relacionar las tablas*/
*Tengo un articulo que petenece a una categoria (en otra tabla), consigue el maximo precio por categoria y muestra el nombre de departamento
SELECT MAX(precio), id_categoria FROM articulo INNER JOIN categoria ON articulo.id_categoria = categoria.id GROUP BY id_categoria; /*Es necesario relacionar tablas porque necesitamos atributos de las dos tablas y agrupamos por FK (id_categoria)*/

CON LEFT JOIN COUNT(id.articulo)
CON INNER JOIN COUNT(*) O (id.atributo)