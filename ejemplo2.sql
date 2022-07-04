SQL> -- Ahora vamos a ver otras estructuras, como el IF, CURSOR, asi como la entrada de datos por el teclado y la estructura INTO

SQL> SET SERVEROUTPUT ON;

SQL> -- Vamos a ver como el usuario puede interactuar con la base de datos
SQL> DECLARE
  2  V_NAME VARCHAR(20) := '&NAME';
  3  BEGIN
  4  DBMS_OUTPUT.PUT_LINE('Hola ' || V_NAME);
  5  END;
  6  /
Introduzca un valor para name: Hector
antiguo   2: V_NAME VARCHAR(20) := '&NAME';
nuevo   2: V_NAME VARCHAR(20) := 'Hector';
Hola Hector                                                                     

Procedimiento PL/SQL terminado correctamente.

SQL> -- Lo que nos muestra SQL PLUS es lo siguiente:
SQL> -- pide un valor para NAME (que es el valor de V_NAME).
SQL> -- V_NAME tiene un valor inicial (o antiguo) que es '&NAME'
SQL> -- pero cuando el usuario ingresa su nombre, V_NAME tiene un nuevo valor
SQL> -- por ultimo, se imprime los mensajes del bloque anonimo.

SQL> -- La entrada de datos desde el teclado aplica tambien para NUMBER y CHAR.
SQL> DECLARE
  2  V_NUM1 NUMBER(2) := '&NUMERO1';
  3  V_NUM2 NUMBER(2) := '&NUMERO2';
  4  V_NUM3 NUMBER(2);
  5  V_LETRA CHAR(1) := '&LETRA';
  6  BEGIN
  7  V_NUM3 := V_NUM1 + V_NUM2;
  8  DBMS_OUTPUT.PUT_LINE('La letra es: ' || V_LETRA);
  9  DBMS_OUTPUT.PUT_LINE(V_NUM1 || ' + ' || V_NUM2 || ' = ' || V_NUM3);
 10  END;
 11  /
Introduzca un valor para numero1: 4
antiguo   2: V_NUM1 NUMBER(2) := '&NUMERO1';
nuevo   2: V_NUM1 NUMBER(2) := '4';
Introduzca un valor para numero2: 67
antiguo   3: V_NUM2 NUMBER(2) := '&NUMERO2';
nuevo   3: V_NUM2 NUMBER(2) := '67';
Introduzca un valor para letra: E
antiguo   5: V_LETRA CHAR(1) := '&LETRA';
nuevo   5: V_LETRA CHAR(1) := 'E';
La letra es: E                                                                  
4 + 67 = 71                                                                     

Procedimiento PL/SQL terminado correctamente.

SQL> -- Pasemos a la estructura del IF
SQL> -- Funciona igual que en otros lenguajes pero se escribe diferente
SQL> DECLARE
  2  V_NUM NUMBER(2);
  3  BEGIN
  4  V_NUM := 4;
  5  IF (V_NUM > 10) THEN
  6  DBMS_OUTPUT.PUT_LINE('El numero es mayor a 10');
  7  ELSE
  8  DBMS_OUTPUT.PUT_LINE('El numero es menor a 10');
  9  END IF;
 10  END;
 11  /
El numero es menor a 10                                                         

Procedimiento PL/SQL terminado correctamente.

SQL> -- Podemos ver que a diferencia de otros lenguajes, se agrega el THEN y no utiliza llaves, pero el final de todo el IF debe ser END IF

SQL> -- Ahora vamos a ver con IF anidados
SQL> DECLARE
  2  V_NUM NUMBER(2);
  3  BEGIN
  4  V_NUM := 4;
  5  IF (V_NUM > 20) THEN
  6  DBMS_OUTPUT.PUT_LINE('El numero es menor a 20');
  7  ELSIF (V_NUM > 10) THEN
  8  DBMS_OUTPUT.PUT_LINE('El numero es mayor a 10 pero menor a 20');
  9  ELSE
 10  DBMS_OUTPUT.PUT_LINE('El numero es menor a 10');
 11  END IF;
 12  END;
 13  /
El numero es menor a 10                                                         

Procedimiento PL/SQL terminado correctamente.

SQL> -- Pasamos con el CURSOR y FOR
SQL> -- Recordemos que el CURSOR y FOR recorre todos los registros que existen en la tabla.

SQL> -- Primero vamos a crear una tabla y vamos a agregarle algunos registros:
SQL> CREATE TABLE PERSONAL(
  2  ID NUMBER(3),
  3  AREA VARCHAR(25),
  4  NOMBRE VARCHAR(10),
  5  CONSTRAINT PK_PERSONAL PRIMARY KEY(ID)
  6  );

Tabla creada.

SQL> INSERT INTO PERSONAL VALUES(1, 'Limpieza', 'Fernando');

1 fila creada.

SQL> INSERT INTO PERSONAL VALUES(2, 'Tecnologia', 'Juan');

1 fila creada.

SQL> INSERT INTO PERSONAL VALUES(3, 'Carniceria', 'Fernanda');

1 fila creada.

SQL> INSERT INTO PERSONAL VALUES(4, 'Linea Blanca', 'Abril');

1 fila creada.

SQL> INSERT INTO PERSONAL VALUES(5, 'Farmacia', 'Daniel');

1 fila creada.

SQL> INSERT INTO PERSONAL VALUES(6, 'Limpieza', 'Mario');

1 fila creada.

SQL> INSERT INTO PERSONAL VALUES(7, 'Carniceria', 'Kevin');

1 fila creada.

SQL> INSERT INTO PERSONAL VALUES(8, 'Carniceria', 'Aline');

1 fila creada.

SQL> -- Tambien vamos a ver en esta parte la instruccion INTO.
SQL> -- INTO guarda el valor del registro de una columna en una variable.

SQL> -- En este caso, vamos a imprimir el nombre y area de cada empleado.
SQL> DECLARE
  2  V_NAME VARCHAR(10);
  3  V_AREA VARCHAR(15);
  4  CURSOR C_PERSONAL IS
  5  SELECT NOMBRE, AREA FROM PERSONAL;
  6  BEGIN
  7  OPEN C_PERSONAL;
  8  LOOP
  9  FETCH C_PERSONAL INTO V_NAME, V_AREA;
 10  -- Las variables para el INTO tuvieron que ser declaradas en DECLARE. Las variables del INTO respetan el orden del SELECT.
 11  DBMS_OUTPUT.PUT_LINE('El vendedor ' || V_NAME || ' esta en el area de ' || V_AREA);
 12  EXIT WHEN C_PERSONAL%NOTFOUND;
 13  END LOOP;
 14  CLOSE C_PERSONAL;
 15  END;
 16  /
El vendedor Fernando esta en el area de Limpieza                                
El vendedor Juan esta en el area de Tecnologia                                  
El vendedor Fernanda esta en el area de Carniceria                              
El vendedor Abril esta en el area de Linea Blanca                               
El vendedor Daniel esta en el area de Farmacia                                  
El vendedor Mario esta en el area de Limpieza                                   
El vendedor Kevin esta en el area de Carniceria                                 
El vendedor Aline esta en el area de Carniceria                                 
El vendedor Aline esta en el area de Carniceria                                 

Procedimiento PL/SQL terminado correctamente.

SQL> -- El CURSOR va registro por registro tomando el nombre y area asignada de cada empleado, los almacena en V_NAME y V_AREA y los imprime.

SQL> -- Vamos a hacer el ejemplo anterior con FOR:
SQL> BEGIN
  2  FOR V_TODO IN (SELECT NOMBRE, AREA FROM PERSONAL)
  3  LOOP
  4  DBMS_OUTPUT.PUT_LINE('El vendedor ' || V_TODO.NOMBRE || ' esta en el area de ' || V_TODO.AREA);
  5  END LOOP;
  6  END;
  7  /
El vendedor Fernando esta en el area de Limpieza                                
El vendedor Juan esta en el area de Tecnologia                                  
El vendedor Fernanda esta en el area de Carniceria                              
El vendedor Abril esta en el area de Linea Blanca                               
El vendedor Daniel esta en el area de Farmacia                                  
El vendedor Mario esta en el area de Limpieza                                   
El vendedor Kevin esta en el area de Carniceria                                 
El vendedor Aline esta en el area de Carniceria                                 

Procedimiento PL/SQL terminado correctamente.

SQL> -- Son menos lineas las que hay que escribir y no es necesaria la parte del DECLARE.
SQL> -- V_TODO funciona como un registro, el cual en cada ciclo almacena cada registro de la tabla y para hacer referencia a las campos solo se indica el nombre de la columna.

SQL> -- Regresando a la instruccion INTO
SQL> -- La podemos utilizar tambien para otras cosas, por ejemplo, insertar valores en una tabla.

SQL> -- Primero vamos a crear una tabla:
SQL> CREATE TABLE EMPLEADO(
  2  NOMBRE VARCHAR(10),
  3  AREA VARCHAR(25),
  4  SALARIO NUMBER(6,2)
  5  );

Tabla creada.

SQL> -- Ahora vamos a crear un bloque anonimo, podria ser un procedimiento (aunque es lo mismo), pero eso lo veremos mas adelante
SQL> DECLARE
  2  V_SALARIO  NUMBER(6,2);
  3  BEGIN
  4  -- Usamos el FOR, aunque podriamos usar el CURSOR
  5  FOR V_TODO IN (SELECT NOMBRE, AREA FROM PERSONAL)
  6  LOOP
  7  -- Notemos que la tabla tiene 3 campos y de PERSONAL solo tenemos 2 columnas, asique vamos a utilizar lo que hemos visto anteriormente
  8  IF (V_TODO.AREA = 'Limpieza') THEN
  9  V_SALARIO := 5000.00;
 10  ELSIF (V_TODO.AREA = 'Tecnologia') THEN
 11  V_SALARIO := 6500.00;
 12  ELSIF (V_TODO.AREA = 'Carniceria') THEN
 13  V_SALARIO := 5000.00;
 14  ELSIF (V_TODO.AREA = 'Linea Blanca') THEN
 15  V_SALARIO := 4900.00;
 16  ELSE
 17  V_SALARIO := 4000.00;
 18  END IF;
 19  INSERT INTO EMPLEADO VALUES(V_TODO.NOMBRE, V_TODO.AREA, V_SALARIO);
 20  END LOOP;
 21  END;
 22  /

Procedimiento PL/SQL terminado correctamente.

SQL> -- Revisamos la tabla EMPLEADO
SQL> SELECT * FROM EMPLEADO;

NOMBRE     AREA                         SALARIO                                 
---------- ------------------------- ----------                                 
Fernando   Limpieza                        5000                                 
Juan       Tecnologia                      6500                                 
Fernanda   Carniceria                      5000                                 
Abril      Linea Blanca                    4900                                 
Daniel     Farmacia                        4000                                 
Mario      Limpieza                        5000                                 
Kevin      Carniceria                      5000                                 
Aline      Carniceria                      5000                                 

8 filas seleccionadas.

SQL> -- Podemos ver que se lleno EMPLEADO apartir de otra tabla y dependiendo del area de trabajo se asigna un salario al empleado

SQL> -- Si quisieramos hacer lo mismo con un procedimiento, el codigo seria el siguiente
SQL> -- pero antes, debemos borrar los registros de EMPLEADO para asegurarnos que el procedimiento funcione:
SQL> DELETE FROM EMPLEADO;

8 filas suprimidas.

SQL> -- El procedimiento seria el siguiente
SQL> CREATE OR REPLACE PROCEDURE P_EMPLEADO
  2  AS
  3  V_SALARIO  NUMBER(6,2);
  4  BEGIN
  5  FOR V_TODO IN (SELECT NOMBRE, AREA FROM PERSONAL)
  6  LOOP
  7  IF (V_TODO.AREA = 'Limpieza') THEN
  8  V_SALARIO := 5000.00;
  9  ELSIF (V_TODO.AREA = 'Tecnologia') THEN
 10  V_SALARIO := 6500.00;
 11  ELSIF (V_TODO.AREA = 'Carniceria') THEN
 12  V_SALARIO := 5000.00;
 13  ELSIF (V_TODO.AREA = 'Linea Blanca') THEN
 14  V_SALARIO := 4900.00;
 15  ELSE
 16  V_SALARIO := 4000.00;
 17  END IF;
 18  INSERT INTO EMPLEADO VALUES(V_TODO.NOMBRE, V_TODO.AREA, V_SALARIO);
 19  END LOOP;
 20  END;
 21  /

Procedimiento creado.

SQL> -- Ejecutamos el procedimiento
SQL> EXEC P_EMPLEADO;

Procedimiento PL/SQL terminado correctamente.

SQL> -- Revisamos la tabla EMPLEADO
SQL> SELECT * FROM EMPLEADO;

NOMBRE     AREA                         SALARIO                                 
---------- ------------------------- ----------                                 
Fernando   Limpieza                        5000                                 
Juan       Tecnologia                      6500                                 
Fernanda   Carniceria                      5000                                 
Abril      Linea Blanca                    4900                                 
Daniel     Farmacia                        4000                                 
Mario      Limpieza                        5000                                 
Kevin      Carniceria                      5000                                 
Aline      Carniceria                      5000                                 

8 filas seleccionadas.

SQL> -- Obtenemos el mismo resultado que en le bloque anonimo

SQL> -- Estos solo son algunos ejemplos de las instrucciones mencionadas anteriormente, hay mas formas en las que es posible usarlas, pero estas son solo algunas.