-- ************ Bloque anonimo ************
-- Una forma de crear un bloque anonimo es la siguiente, pero esta forma carece de variables
BEGIN
    <CODIGO>
END;
/

-- La otra forma de crearlo y permitiendonos usar variables es la siguiente:
DECLARE
    <VARIABLES> <TYPE>;
BEGIN
    <CODIGO>
END;
/

-- El bloque anónimo se ejecuta al terminar de escribir el código (después del /).

-- ************ Procedimiento ************
CREATE OR REPLACE PROCEDURE <PROCEDURE_NAME>(<PARAMETER_NAME> IN <TYPE>) -- Es posible omitir los parametros
AS
    <VARIABLES> -- Se pueden omitir
BEGIN
    <CODIGO>
END;
/

-- ************ Ejecución de un procedimiento ************
EXECUTE <PROCEDURE_NAME>(<PARAMETER_NAME>);
EXEC <PROCEDURE_NAME>(<PARAMETER_NAME>);

-- ************ Funcion ************
CREATE OR REPLACE FUNCTION <FUNCTION_NAME>(<PARAMETER_NAME> IN <TYPE>) 
RETURN <TYPE>
IS
    <VARIABLES>
BEGIN
    <CODIGO>
END;
/

-- ************ Ejecución de una funcion ************
<FUNCTION_NAME>(<PARAMETER_NAME>);

-- ************ Impresion ************
DBMS_OUTPUT.PUT_LINE('<CADENA>');

-- ************ Asignacion ************
<VARIABLE> := <VALOR>;

-- ************ Entrada de datos ************
<VARIABLE> := '&<CADENA>';

-- ************ IF ************
IF <CONDICION> THEN
    <CODIGO>
END IF;

-- ************ IF ELSE ************
IF <CONDICION> THEN
    <CODIGO>
ELSE
    <CODIGO>
END IF;

-- ************ IF ELSE IF ************
IF <CONDICION> THEN
    <CODIGO>
ELSIF <CONDICION> THEN
    <CODIGO>
ELSE
    <CODIGO>
END IF;

-- ************ CURSOR ************
DECLARE
    <VARIABLES> -- Todas las vairables que vamos a usar en el cursor
    CURSOR <CURSOR_NAME> IS -- El nombre del cursor
    SELECT <COLUMN_NAME>, ... , <COLUMN_NAME> FROM <TABLE>; -- La consulta (Columnas y tablas que vamos a usar)
BEGIN
    OPEN <CURSOR_NAME>; -- Se abre el cursor
    LOOP -- Se ejecuta hasta que se termina la consulta
        FETCH <CURSOR_NAME> INTO <VARIABLES>; -- Se obtienen los datos de la consulta
        <CODIGO> -- Se ejecuta el código
        EXIT WHEN <CURSOR_NAME>%NOTFOUND -- Se sale del loop cuando ya no encuentra mas registros
    END LOOP; -- Se termina la consulta
    CLOSE <CURSOR_NAME>;
END;
/

-- ************ FOR ************
BEGIN
FOR <CURSOR_NAME> (SELECT <COLUMN_NAME>, ... , <COLUMN_NAME> FROM <TABLE>)
LOOP
    <CODIGO>
END LOOP;
END;

-- ************ TRIGGER ************
CREATE OR REPLACE TRIGGER <TRIGGER_NAME>
<TIME> <EVENT> ON <TABLE>
FOR EACH ROW
DECLARE -- Se puede omitir
    <VARIABLES> -- Todas las vairables que vamos a usar en el trigger. Se pueden omitir
BEGIN
    <CODIGO>
END;

-- TIME: BEFORE, AFTER, INSTEAD OF (aplica para vistas)
-- EVENT: INSERT, UPDATE, DELETE