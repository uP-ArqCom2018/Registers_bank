#!/usr/bin/python
# Autor: Villarreal Luciano

#-----------------------------

# Programa para crear automaticamente los archivos Manifest.py para hdlmake, usando ghdl y gtkwave.

# Si se ejecuta sin argumentos, se crean los archivos Manifest.py en las carpetas correspondientes.
# Si se utiliza el comando "-e" se realiza la compilacion y simulacion automaticamente. -> user@ ./auto.py -e
# Si se utiliza el comando "-b" se borran los archivos creados para dejar limpio el espacio de trabajo.
# Si se utiliza el comando "--help" o "-h" se muestra la ayuda del programa

# Se debe organizar el proyecto de la siguiete manera, respetando las capetas.

# Proyecto
# |__ auto.py
# |__ src
# |   |__ CodigoFuente1.vhd
# |   |__ CodigoFuente2.vhd
# |   |__   ...
# |   |__ codigoFuenteN.vhd
# |__ test
#     |__ testbench.vhd
#-----------------------------

# En la carpeta sim se generan los archivos relacionados a la simulacion.
# En la carpeta src se deben guardar los archivos fuente.
# En la carpeta test se debe guardar el testbench.

import os
import sys 


# En src se deben colocar los nombres de los archivos fuente sin extension 
src = ['bank_reg']

# En tb se debe colocar el nombre del testbench sin extension
tb = 'bank_reg_tb'

#En time se indica el tiempo de simulacion en microsegundos
time = 1000

# Se crea el Manifest.py en carpeta src
f = open('src/Manifest.py','w')
f.write('files = [ \n ')

for i in range(0,len(src)-1):
	f.write('"%s.vhd", '%(src[i]))

f.write('"')
f.write(src[len(src)-1]+'.vhd')
f.write('"\n]\n') 
f.close();

# Se crea el Manifest.py en carpeta test
f = open('test/Manifest.py','w')
f.write('files = [ \n "%s.vhd", \n]\n' %(tb))
f.write('\nmodules = {\n "local" : [ "../src"],\n}\n')
f.close()

# Se crea el Manifest.py en la carpeta sim (simulacion)
# Si la carpeta sim no existe, la crea.
if not os.path.exists("sim"):
	os.mkdir("sim")

f = open('sim/Manifest.py','w')
f.write('action = "simulation"\nsim_tool = "ghdl"\nsim_top = "%s"\n' %(tb))
f.write('\nsim_post_cmd = "ghdl -r %s --stop-time=%dus --vcd=%s.vcd; gtkwave %s.vcd"\n' %(tb,time,tb,tb))
f.write('\nmodules = {\n  "local" : [ "../test" ],\n}\n')

f.close()

# Comando -e: realiza la compilacion y la simulacion
if len(sys.argv) > 1 and sys.argv[1] == '-e':
    os.chdir('sim')
    os.system('hdlmake')
    os.system('make')

# Comando -b: borra los archivos creados, externos al disenio
if len(sys.argv) > 1 and sys.argv[1] == '-b':

	os.system('rm -r sim')
	os.system('rm src/Manifest.py')
	os.system('rm test/Manifest.py')

# Comando -h o --help
if len(sys.argv) > 1 and (sys.argv[1] == '--help' or sys.argv[1] == '-h'):
	print('\n\t\t\t\t----- auto.py -----')
	print('\nDebe abrir auto.py con un editor de textos, y agregar los codigos fuente y testbench en las variables src y tb respectivamente')
	print('\n \t \t \t ARGUMENTOS')
	print('\nSin argumentos: Crea los archivos Manifest.py y la carpeta sim para la simulacion')
	print('\n-e : Realiza la ejecucion de la compilacion y la simulacion automaticamente')
	print('\n-b : Borra los archivos y carpetas creadas')