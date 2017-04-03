#!/bin/bash

# Script que ejecuta la prebeplayer

RED='\033[0;31m'
NC='\033[0m'

BLUE='\033[0;34m'
NB='\033[0m'

YELLOW='\033[1;33m'
NY='\033[0m'

echo -e " ${RED}¡¡ Bienvenido a la prebeplayer !!${NC} "

echo -e "${BLUE}Seleccione la opción deseada:${NB}"

op1="Reproduce la carpeta actual";
op2="Subir una carpeta";
op3="Cambiar de carpeta";
op4="Lista archivos y subcarpetas de la carpeta actual";
op5="Opciones del reproductor";
op6="Salir";

salida=1

while [ $salida -eq 1 ]; do
msj_ubica=$(echo "Te encuentras en la carpeta: ");
echo -e "${YELLOW}$msj_ubica${MY}" $(pwd)	
	select OPCIONES in  "$op1" "$op2" "$op3" "$op4" "$op5" "$op6" 
	do
		case $OPCIONES in	
			"$op1")
				
				accion=$(pwd)"/*"" &";
				mpg123 $accion;
				break
				;;
			"$op2")
				cd ..
				echo -e"${RED}Ahora estás en:${MC}" "$(pwd)"
				break
				read;
				;;
			"$op3")
				echo -e "${BLUE}Escriba la ruta a la que desea ingresar${MB}"
				read route;
				cd $route;			
				echo -e "${BLUE}Has cambiado a: $(pwd)${MB}"
				read;
				break
				;;
			"$op4")
				echo "${BLUE}Los archivos y carpetas son:${MB}"
				ls --color;
				echo "Puedes ingresar el NOMBRE de una cancion para reproducirla"
				read espera #Ingresa titulo de la cancion con o sin espacios
				mpg123 "$espera"; 
				break				
				;;
			"$op5")
				mpg123 --extendhelp
				read;
				break
				;;
			"$op6")
				salida=0;
				break
				;;		
			"*") echo -e Opcion no valida 

esac
done

done
