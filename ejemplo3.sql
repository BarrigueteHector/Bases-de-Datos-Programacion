SQL> -- Los TRIGGERS son muy variados, todo depende de cuando va a funcionar y como va a funcionar. Se puede ejecutar antes o despues de que se ejecute una accion.

SQL> -- Solo si se inserta, actualiza y/o elimina un registro a una tabla.

SQL> -- Creamos una tabla
SQL> CREATE TABLE PRODUCTO(
  2  ID NUMBER(2) PRIMARY KEY,
  3  NOMBRE VARCHAR(20),
  4  PRECIO NUMBER(5,2),
  5  CANTIDAD NUMBER(3)
  6  );

Tabla creada.

SQL> -- Y antes de agregar registros, vamos a hacer el primer TRIGGER que sera de insercion
SQL> CREATE OR REPLACE TRIGGER TG_PRODUCTO_I
  2  AFTER INSERT ON PRODUCTO
  3  FOR EACH ROW
  4  BEGIN
  5  DBMS_OUTPUT.PUT_LINE('Se agrego un nuevo producto correctamente');
  6  END;
  7  /

Disparador creado.

SQL> -- Ahora si, vamos a agregar unos registros y debemos de recibir el mensaje del TRIGGER
SQL> INSERT INTO PRODUCTO VALUES(1, 'Tomate', 40.00, 100);
Se agrego un nuevo producto correctamente                                       

1 fila creada.

SQL> INSERT INTO PRODUCTO VALUES(2, 'Aguacate', 80.00, 50);
Se agrego un nuevo producto correctamente                                       

1 fila creada.

SQL> -- Los mensajes fueron impresos

SQL> -- Hagamos los otros TRIGGER:
SQL> CREATE OR REPLACE TRIGGER TG_PRODUCTO_U
  2  AFTER UPDATE ON PRODUCTO
  3  FOR EACH ROW
  4  BEGIN
  5  DBMS_OUTPUT.PUT_LINE('Se actualizo producto correctamente');
  6  END;
  7  /

Disparador creado.

SQL> CREATE OR REPLACE TRIGGER TG_PRODUCTO_D
  2  AFTER DELETE ON PRODUCTO
  3  FOR EACH ROW
  4  BEGIN
  5  DBMS_OUTPUT.PUT_LINE('Se elimino un producto correctamente');
  6  END;
  7  /

Disparador creado.

SQL> -- Hagamos una actualizacion y deberia de imprimirse el mensaje del TRIGGER de actualizacion
SQL> UPDATE PRODUCTO SET PRECIO = 35.00 WHERE ID = 1;
Se actualizo producto correctamente                                             

1 fila actualizada.

SQL> -- Ahora una eliminacion
SQL> DELETE FROM PRODUCTO WHERE ID = 2;
Se elimino un producto correctamente                                            

1 fila suprimida.

SQL> -- En ambos casos recibimos el mensaje correspondiente

SQL> -- Aunque los TRIGGER anteriores son correctos, hay una forma en la que podemos juntarlos en uno solo
SQL> CREATE OR REPLACE TRIGGER TG_PRODUCTO
  2  AFTER INSERT OR UPDATE OR DELETE ON PRODUCTO
  3  FOR EACH ROW
  4  BEGIN
  5  -- Podemos hacer referencia a una insercion, actualizacion o eliminacion por medio de INSERTING, UPDATING y DELETING respectivamente
  6  IF INSERTING THEN
  7  DBMS_OUTPUT.PUT_LINE('Se agrego un nuevo producto correctamente');
  8  ELSIF UPDATING THEN
  9  DBMS_OUTPUT.PUT_LINE('Se actualizo producto correctamente');
 10  ELSE
 11  DBMS_OUTPUT.PUT_LINE('Se elimino un producto correctamente');
 12  END IF;
 13  END;
 14  /

Disparador creado.

SQL> -- Antes de probarlo, eliminemos los TRIGGER que habiamos hecho, para ello usamos DROP TRIGGER
SQL> DROP TRIGGER TG_PRODUCTO_I;

Disparador borrado.

SQL> DROP TRIGGER TG_PRODUCTO_U;

Disparador borrado.

SQL> DROP TRIGGER TG_PRODUCTO_D;

Disparador borrado.

SQL> -- Ahora si, vamos a probarlo:
SQL> UPDATE PRODUCTO SET CANTIDAD = 40 WHERE ID = 1;
Se actualizo producto correctamente                                             

1 fila actualizada.

SQL> INSERT INTO PRODUCTO VALUES(2, 'Zanahoria', 30.00, 30);
Se agrego un nuevo producto correctamente                                       

1 fila creada.

SQL> DELETE FROM PRODUCTO WHERE ID = 2;
Se elimino un producto correctamente                                            

1 fila suprimida.

SQL> -- Los mensajes se imprimen correctamente dependiendo de la accion.

SQL> -- Claro que los TRIGGER pueden hacer mas que solo imprimir, al igual que en un procedimiento, es posible usarlos para acciones más complejas

SQL> -- Que tal si hacemos una tabla que tenga los registros de las acciones que se hagan sobre PRODUCTO

SQL> -- Primero vamos a crear una tabla:
SQL> CREATE TABLE BITACORA(
  2  TIPO VARCHAR(10),
  3  USUARIO VARCHAR(10),
  4  FECHA TIMESTAMP
  5  );

Tabla creada.

SQL> -- Al igual que en un procedimiento o funcion, podemos editar un TRIGGER que ya teniamos, en este caso TG_PRODUCTO
SQL> CREATE OR REPLACE TRIGGER TG_PRODUCTO
  2  AFTER INSERT OR UPDATE OR DELETE ON PRODUCTO
  3  FOR EACH ROW
  4  BEGIN
  5  IF INSERTING THEN
  6  INSERT INTO BITACORA VALUES('Insert', USER, SYSDATE);
  7  ELSIF UPDATING THEN
  8  INSERT INTO BITACORA VALUES('Update', USER, SYSDATE);
  9  ELSE
 10  INSERT INTO BITACORA VALUES('Delete', USER, SYSDATE);
 11  END IF;
 12  END;
 13  /

Disparador creado.

SQL> -- USER: toma el nombre del usuario que hizo la accion
SQL> -- SYSDATE: es la fecha actual

SQL> -- Revisemos que tenemos en ambas tablas
SQL> SELECT * FROM PRODUCTO;

        ID NOMBRE                   PRECIO   CANTIDAD                           
---------- -------------------- ---------- ----------                           
         1 Tomate                       35         40                           

SQL> -- Solo tenemos un producto en PRODUCTO

SQL> SELECT * FROM BITACORA;

ninguna fila seleccionada

SQL> -- No tenemos nada en BITACORA, lo cual es correcto

SQL> -- Vamos a probarlo
SQL> DELETE FROM PRODUCTO;

1 fila suprimida.

SQL> -- Eliminamos todos los productos, revisemos la bitacora
SQL> SELECT * FROM BITACORA;

TIPO       USUARIO    FECHA                                                     
---------- ---------- -----------------------------------                       
Delete     REPO       03/07/22 21:33:56.000000                                  

SQL> -- Se registro la accion realizada, el usuario que la hizo y el tiempo en el que se ejecuto. Lo mismo debe pasar si hacemos una insercion o actualizacion

SQL> INSERT INTO PRODUCTO VALUES(1, 'Jitomate', 30.00, 200);

1 fila creada.

SQL> INSERT INTO PRODUCTO VALUES(2, 'Fresa', 45.00, 150);

1 fila creada.

SQL> INSERT INTO PRODUCTO VALUES(3, 'Cebolla', 20.00, 100);

1 fila creada.

SQL> -- Hicimos 3 inserciones, asique debieron registrarse 3 inserciones
SQL> SELECT * FROM BITACORA;

TIPO       USUARIO    FECHA                                                     
---------- ---------- -----------------------------------                       
Delete     REPO       03/07/22 21:33:56.000000                                  
Insert     REPO       03/07/22 21:33:56.000000                                  
Insert     REPO       03/07/22 21:33:56.000000                                  
Insert     REPO       03/07/22 21:33:56.000000                                  

SQL> -- Los registros se hicieron
SQL> UPDATE PRODUCTO SET PRECIO = 40 WHERE ID = 2;

1 fila actualizada.

SQL> UPDATE PRODUCTO SET CANTIDAD = 10 WHERE ID = 1;

1 fila actualizada.

SQL> -- Ahora hicimos 2 actualizaciones, se tuvieron que hacer 2 registros de actualizacion en la bitacora
SQL> SELECT * FROM BITACORA;

TIPO       USUARIO    FECHA                                                     
---------- ---------- -----------------------------------                       
Delete     REPO       03/07/22 21:33:56.000000                                  
Insert     REPO       03/07/22 21:33:56.000000                                  
Insert     REPO       03/07/22 21:33:56.000000                                  
Insert     REPO       03/07/22 21:33:56.000000                                  
Update     REPO       03/07/22 21:33:56.000000                                  
Update     REPO       03/07/22 21:33:56.000000                                  

6 filas seleccionadas.

SQL> -- Dichos registros si se hicieron

SQL> -- Estos son solo algunos ejemplos sencillos de lo que puede hacer un TRIGGER. Recordemos que pueden ser tan complejos como un procedimiento o funcion.