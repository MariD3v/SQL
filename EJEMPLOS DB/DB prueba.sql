create database prueba;
drop database prueba; /*Asi borramos la base de datos*/

use prueba; /*Para seleccionar la base de datos que queremos usar*/
create table Usuario(id int, email varchar(255), username varchar(50));
drop table Usuario; /*Para borrar una tabla*/

alter table Usuario add edad int; /*Asi agregamos un atributo/campo a la tabla*/
alter table Usuario drop column edad; /*Asi borramos un atributo/campo*/
alter table Usuario modify column email varchar(50); /*Asi modificamos un atributo*/

insert into Usuario (email, username) /*Asi agregamos valores a la tabla*/
values ('mari.d3v@gmail.com', 'MariTrabajo'); 
delete from Usuario where email = 'wouskaa@gmail.com' limit 1; /*Asi borramos porque id es null,
si id no fuera null, deberiamos borrar indicando el id de la fila*/
alter table Usuario add primary key (id); /*Asi asignamos id como pk*/
alter table Usuario modify column id int auto_increment; /*Asi definimos que id vaya incrementando a partir del 1*/
delete from Usuario where id = 1; /*Ahora si podemos eliminar el atributo desde el id, 
si no pusieramos where nos daria un error fatal que eliminaria todos los valores de la tabla*/
select * from Usuario; /*Asi nos muestra la tabla*/
select * from Usuario where email = 'wouskaa@gmail.com'; /*Asi nos muestra la tabla de forma selectiva*/
update Usuario set edad = 32 where id = 2; /*Asi actualizamos el valor de un atributo, 
si no pusieramos where nos daria un error fatal que cambiaria todos los valores de edad a 32*/
