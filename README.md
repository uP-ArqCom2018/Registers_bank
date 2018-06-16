# Banco de registros
## Arquitectura de Computadoras

## Autores del bloque:
* Villarreal Luciano (@lvillarreal)
* Postemsky Marcos (@marcospostemsky)

## Banco de registros
Dentro de la carpeta src "bank_reg.vhd" describe el comportamiento del banco de registros, y dentro de la carpeta test_src se encuentra "bank_reg_tb.vhd", vhdl que describe el Test Bench utilizado para comprobar el funcionamiento del banco de registros.
El banco de registros está descripto de manera genérica, aunque por defecto se definió con un ancho de registro de 64 bits, y una cantidad de 32 registros.

### Pines de entrada/salida
Descripción de las funciones de los pines de entrada/salida.

Pines | I/O | Función
------|-----|--------
A [bit_dir_reg-1 : 0]| IN | Dirección en memoria del registro R_a_o
B [bit_dir_reg-1 : 0]| IN | Dirección en memoria del registro R_b_o
C [bit_dir_reg-1: 0]| IN | Dirección de escritura en memoria (banco de registros)
Reg_W_i | IN | Señal de escritura en dirección C de la memoria del dato W_c_i
W_c_i [n_reg-1 : 0]| IN | Dato de escritura en memoria
RST_i| IN | Reset del banco de registros, coloca todos los registros en 0. RST_i <= 0 para resetear.
CLK_i| IN | Clock.
R_a_o [n_neg-1 : 0]| OUT | Registro de salida de la dirección de memoria A
R_b_o [n_neg-1 : 0]| OUT | Registro de salida de la dirección de memoria B

### Datos genéricos
Descripción de valores genéricos para la descripción del bloque.

Contante | Función
---------|---------
bit_dir_reg| Indica la cantidad de bits de direccionamiento de los registros en memoria (5 por defecto)
n_reg| Indica la dimensión de los registros (64 por defecto)

### Comportamiento del banco de registros

El banco de registros siempre lee, es decir, en cada pulso de clock a la salida se tendrán los registros que se encuentran en la dirección A y B. Solo cambia su comportamiento cuando se activa la entrada Reg_W_i. La siguiente tabla describe de una mejor manera el comportamiento.

Entradas  | Comportamiento del banco de registros
--------  | -------------------------------------
Reg_W_i=0 | A la salida se tienen los registros de 64 bits ubicados en la dirección A y B.
Reg_W_i=1 | Igual que Reg_W_i=0, y además escribe en la dirección C, el dato de 64 bits ingresado por W_c_i.
