# Bases de Datos: Programación

Definición
--------------------------------------------------------------------------------------------------------------------------------------------------------
Al igual que un lenguaje de programación de alto nivel, ORACLE cuenta con su propio lenguaje.

Antecedentes
--------------------------------------------------------------------------------------------------------------------------------------------------------
- Conocimientos de algún lenguaje de alto nivel (Python, Java, C, etc.).

- [Repositorios de Bases de Datos](https://github.com/BarrigueteHector/Bases-de-Datos-Repositorios).

Desarrollo
--------------------------------------------------------------------------------------------------------------------------------------------------------
***Todo lo visto en este repositorio es nivel básico de programación en ORACLE. Esto es solo la punta del iceberg.***

El lenguaje de programación con el que cuenta ORACLE es parecido a otros lenguajes de alto nivel, pero el código se debe escribir en bloques (anónimos, de función o procedimiento).

Las características de cada bloque son los siguientes:
- **Anónimos**: No se guardan en memoria. Se pueden ejecutar una sola vez (al momento de crearse).
- **Procedimientos**: Se guardan en memoria y se pueden ejecutar en cualquier momento. Pueden o no recibir parametros.
- **Funciones**: Se guardan en memoria y solo se ejecutan en bloques de procedimiento. Deben retornar algún valor.

Todos los bloques tienen partes especificas en las que solo se deben colocar las variables y el código. En [Guia](https://github.com/BarrigueteHector/Bases-de-Datos-Programacion/blob/main/guia.sql) se menciona de manera detallada cada parte.

Otras instrucciones presentes son las siguientes:

- Existe la estructura **IF** que revisa que una condicion sea cierta o falsa para ejecutar un código en específico. También existe el **CURSOR** (es un tipo de **FOR**, aunque existe el **FOR**) que recorre todos los registros de una tabla.
- Es posible que se ingresen datos (valores) por medio del teclado utilizando el simbolo **&**.
- Una instrucción que no se ha mencionado en los demas repositorios es **INTO** (distinta a la que se encuentra en el **INSERT**), permite guardar los valores de los campos de un registro.
- Los disparadores (**TRIGGERS**) ejecutan automáticamente alguna acción (código), se debe de indicar si se ejecuta antes (**BEFORE**) o después (**AFTER**) de que se inserte (**INSERT**), actualice (**UPDATE**) y/o borre (**DELETE**) un registro de alguna tabla.

Antes de mencionar los archivos del repositorio, hablemos rápidamente de los **TRIGGERS**, estos tienen ciertas reglas, la más importante de todas es que no pueden ejecutarse sobre una tabla que esté mutando (cambiando). En otras palabras, si hacemos una acción que active algún **TRIGGER**, pero este modifica la misma tabla del **TRIGGER**, tendremos un error, debido a que estamos cambiando la tabla que está cambiando debido a la acción que activó el **TRIGGER**.

En el archivo [Guia](https://github.com/BarrigueteHector/Bases-de-Datos-Programacion/blob/main/guia.sql) presenta como se debe escribir cada bloque, así como algunas instrucciones básicas. 

En el archivo [Ejemplo](https://github.com/BarrigueteHector/Bases-de-Datos-Programacion/blob/main/ejemplo.sql) se encuentran ejemplos de los tres tipos de bloques y código básico.

En el archivo [Ejemplo 2](https://github.com/BarrigueteHector/Bases-de-Datos-Programacion/blob/main/ejemplo2.sql) hay ejemplos de las instrucciones **IF**, **CURSOR**, **FOR**, **INTO** e ingreso de datos por medio del teclado.

En el archivo [Ejemplo 3](https://github.com/BarrigueteHector/Bases-de-Datos-Programacion/blob/main/ejemplo3.sql) se presentan ejemplos de **TRIGGERS**. Se piensa añadir en un futuro más ejemplos que sean un poco más complejos.

Los ejemplos presentados en cada uno de los archivos correspondientes solo son algunas formas en las que es posible usar cada instrucción, es posible explotar más la programación en ORACLE.
Aunque son pocos, espero que sean suficientes y lo bastante claros para aprender o reforzar conocimientos. 

NOTAS
--------------------------------------------------------------------------------------------------------------------------------------------------------
**NOTA #1**: Los repositorios **Bases de Datos** están hechos con base en el curso de Bases de Datos de la Facultad de Ingeniería de la UNAM. 
