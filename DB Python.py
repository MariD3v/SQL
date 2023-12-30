import mysql.connector

db = mysql.connector.connect(
    host='localhost',
    user='root',
    password='****',
    database='prueba'
)

cursor = db.cursor() #Utilizaremos el cursor con el lenguaje SQL para manejar la db

cursor.execute('select * from Usuario limit 5') #Aqui le pasamos el comando que queremos ejecutar en la bd (Ver el contenido de la tabla Usuario), ponemos limit 5 (lo que significa que como maximo solo consultara 5 elementos de la tabla)
resultado = cursor.fetchall() #Almacenamos todos los resultados en una variable, si queremos almacenar solo el primer resultado encontrado es con fetchone()
print(resultado)

cursor.execute('show create table Usuario') # Para ver el código usado al crear la tabla Usuario
resultado2 = cursor.fetchall() 
print(resultado2)

insertData = 'insert into Usuario (email, username, edad) values (%s, %s, %s)' #Para insertar valores en tablas. 
values = ('nuevocorreo@mari.com', 'mariFlori', 5) #Valores que reemplazan a los %s
# cursor.execute(insertData, values) #Aqui ejecutamos el comando para insertar datos

updateData = 'update Usuario set email = %s where email = %s' #Para cambiar/actualizar datos de tablas
values = ('correoactualizado@mari.com', 'nuevocorreo@mari.com')
#cursor.execute(updateData, values) #Aqui ejecutamos el comando para cambiar datos

deleteData = 'delete from Usuario where email= %s' #Para eliminar datos de tablas
values = ('correoactualizado@mari.com', )
#cursor.execute(deleteData, values) #Aqui ejecutamos el comando para eliminar datos

#db.commit() #Asi cargamos los nuevos datos en la db, pero cada vez que se ejecuta se cargarian otra vez.