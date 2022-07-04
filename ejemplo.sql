SQL> -- En este archivo solo se veran los tipos de bloques, su ejecucion y codigo basico

SQL> -- Activamos la salida para que las impresiones sean visibles.
SQL> SET SERVEROUTPUT ON

SQL> -- Para escribir el codigo en ORACLE es necesario utilizar un tipo de bloque, ya sea anonimo, de procedimiento o funcion.

SQL> -- ************ Bloque anonimo ************
SQL> -- Imprimimos Hello World
SQL> BEGIN
  2  DBMS_OUTPUT.PUT_LINE('Hello World');
  3  END;
  4  /
Hello World                                                                     

Procedimiento PL/SQL terminado correctamente.

SQL> -- Imprimimos un VARCHAR
SQL> DECLARE
  2  V_MENSAJE VARCHAR(17):='This is a message';
  3  BEGIN
  4  DBMS_OUTPUT.PUT_LINE(V_MENSAJE);
  5  END;
  6  /
This is a message                                                               

Procedimiento PL/SQL terminado correctamente.

SQL> -- Podemos realizar operaciones arimeticas
SQL> DECLARE
  2  V_NUM1 NUMBER(1) := 4;
  3  V_NUM2 NUMBER(1) := 3;
  4  V_RES NUMBER(1) := 0;
  5  BEGIN
  6  V_RES := V_NUM1 + V_NUM2;
  7  -- Para hacer concatenaciones en las impresiones se deben utilizar dos veces ||
  8  DBMS_OUTPUT.PUT_LINE('El resultado de la suma es: ' || V_RES);
  9  -- Incluso podemos realizar las operaciones en la impresion
 10  DBMS_OUTPUT.PUT_LINE('El resultado de la resta es: ' || (V_NUM1 - V_NUM2));
 11  END;
 12  /
El resultado de la suma es: 7                                                   
El resultado de la resta es: 1                                                  

Procedimiento PL/SQL terminado correctamente.

SQL> -- Recordemos que estos bloques solo se pueden usar vez y en caso de querramos volver a usar debemos escribir todo el codigo de nuevo
SQL> -- Los bloques anonimos pueden o no tener una parte de DECLARE, pero siempre tienen un inicio (BEGIN) y un final (END /) 

SQL> -- ************* Bloque de procedimiento ***********
SQL> -- OR REPLACE: nos permite reemplazar un procedimiento si este ya existe, no hay necesidad de borrarlo para volver a crearlo
SQL> CREATE OR REPLACE PROCEDURE SUMA
  2  AS
  3  V_NUM1 NUMBER(1);
  4  V_NUM2 NUMBER(1);
  5  V_RES NUMBER(1);
  6  BEGIN
  7  V_NUM1 := 3;
  8  V_NUM2 := 1;
  9  V_RES := V_NUM1 + V_NUM2;
 10  DBMS_OUTPUT.PUT_LINE('Este procedimiento suma ' || V_NUM1 || ' y ' || V_NUM2);
 11  DBMS_OUTPUT.PUT_LINE('El resultado de la suma es: ' || V_RES);
 12  END;
 13  /

Procedimiento creado.

SQL> -- Se nos muestra que el procedimiento esta creado. Para ejecutarlo:
SQL> EXEC SUMA;
Este procedimiento suma 3 y 1
El resultado de la suma es: 4

Procedimiento PL/SQL terminado correctamente.

SQL> -- o tambien
SQL> EXECUTE SUMA;
Este procedimiento suma 3 y 1                                                   
El resultado de la suma es: 4                                                   

Procedimiento PL/SQL terminado correctamente.

SQL> -- Si quisieramos mandar los valores a sumar al momento de ejecutar el procedimiento, el bloque debe escribirse de la siguiente manera
SQL> -- NOTA: Podriamos crear otro procedimiento, pero vamos a editar el que ya teniamos
SQL> CREATE OR REPLACE PROCEDURE SUMA(NUM1 NUMBER, NUM2 NUMBER)
  2  AS
  3  V_NUM1 NUMBER(1) := NUM1;
  4  V_NUM2 NUMBER(1) := NUM2;
  5  V_RES NUMBER(1);
  6  BEGIN
  7  V_RES := V_NUM1 + V_NUM2;
  8  DBMS_OUTPUT.PUT_LINE('Este procedimiento ahora pide los numeros que se van sumar');
  9  DBMS_OUTPUT.PUT_LINE('Este procedimiento suma ' || V_NUM1 || ' y ' || V_NUM2);
 10  DBMS_OUTPUT.PUT_LINE('El resultado de la suma es: ' || V_RES);
 11  END;
 12  /

Procedimiento creado.

SQL> EXEC SUMA(2, 4);
Este procedimiento ahora pide los numeros que se van sumar                      
Este procedimiento suma 2 y 4                                                   
El resultado de la suma es: 6                                                   

Procedimiento PL/SQL terminado correctamente.

SQL> -- En este bloque es posible omitir las variables, solo no las escribimos pero siempre el AS debe de escribirse.

SQL> -- ************ Funcion ************
SQL> -- Vamos a crear una funcion para la resta de dos numeros.
SQL> -- Recordemos que una funcion siempre va a retornar un valor, en este caso va a retornar un tipo de dato NUMBER. Si no retorna nada la funcion sera erronea
SQL> CREATE OR REPLACE FUNCTION FT_RESTA(NUM1 NUMBER, NUM2 NUMBER)
  2  RETURN NUMBER
  3  IS
  4  V_NUM1 NUMBER(2) := NUM1;
  5  V_NUM2 NUMBER(2) := NUM2;
  6  V_RES NUMBER(2);
  7  BEGIN
  8  V_RES := V_NUM1 - V_NUM2;
  9  DBMS_OUTPUT.PUT_LINE('Estamos en la funcion');
 10  DBMS_OUTPUT.PUT_LINE('Esta funcion resta ' || V_NUM1 || ' y ' || V_NUM2);
 11  RETURN V_RES;
 12  END;
 13  /

Funci�n creada.

SQL> -- Para poder ejecutar una funcion debemos de utilizar un bloque anonimo o de procedimiento. Si la intentamos ejecutar como un procedimiento nos mandara un error
SQL> FT_RESTA(5, 8);
SP2-0734: inicio "FT_RESTA(5..." de comando desconocido - resto de la l�nea ignorado.

SQL> -- NOTA: Por el RETURN debe existir una variable en el bloque para almacenar dicho valor.
SQL> -- En un bloque anonimo:
SQL> DECLARE
  2  V_NUM3 NUMBER(3);
  3  BEGIN
  4  DBMS_OUTPUT.PUT_LINE('Estamos en el bloque anonimo');
  5  V_NUM3 := FT_RESTA(5, 8);
  6  DBMS_OUTPUT.PUT_LINE('Ahora estamos en el bloque anonimo, la funcion nos devuelve: ' || V_NUM3);
  7  END;
  8  /
Estamos en el bloque anonimo                                                    
Estamos en la funcion                                                           
Esta funcion resta 5 y 8                                                        
Ahora estamos en el bloque anonimo, la funcion nos devuelve: -3                 

Procedimiento PL/SQL terminado correctamente.

SQL> -- En un procedimiento
SQL> CREATE OR REPLACE PROCEDURE IMPRESION(NUM1 NUMBER, NUM2 NUMBER)
  2  AS
  3  V_NUM1 NUMBER(2) := NUM1;
  4  V_NUM2 NUMBER(2) := NUM2;
  5  V_NUM3 NUMBER(2);
  6  BEGIN
  7  DBMS_OUTPUT.PUT_LINE('Estamos en el procedimiento');
  8  V_NUM3 := FT_RESTA(V_NUM1, V_NUM2);
  9  DBMS_OUTPUT.PUT_LINE('Ahora estamos en el procedimiento, la funcion nos devuelve: ' || V_NUM3);
 10  END;
 11  /

Procedimiento creado.

SQL> EXEC IMPRESION(2,9);
Estamos en el procedimiento                                                  
Estamos en la funcion                                                           
Esta funcion resta 2 y 9                                                        
Ahora estamos en el procedimiento, la funcion nos devuelve: -7                  

Procedimiento PL/SQL terminado correctamente.