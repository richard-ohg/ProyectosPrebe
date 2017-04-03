#!/bin/bash

clear
while true
do
	echo "Usuario: "
	read user
	echo "Password: "
	read -s PASSWD
	 export PASSWD
        ORIGPASS=`egrep -w "$user" /etc/shadow | cut -d: -f2`
        export ALGO=`echo $ORIGPASS | cut -d'$' -f2`
        export SALT=`echo $ORIGPASS | cut -d'$' -f3`
        GENPASS=$(perl -le 'print crypt("$ENV{PASSWD}","\$$ENV{ALGO}\$$ENV{SALT}\$")')
        #echo $GENPASS
if cat /etc/passwd | egrep -q $user
#if su - $user
	then
	if [ "$GENPASS" == "$ORIGPASS" ]
		then
while true
do

	trap '' 2

	echo -e "\e[1;34mPREBESHELL  \e[1;33mUsuario:`whoami` \e[0;36mEstas en: `pwd` $ \e[1;37m" 

	read comando

	#type $comando && whereis $comando
	#$comando is a shell builtin
	#$comando

	case $comando in
	'salir')
		trap 2
		break
	;;
	'hola')
		echo 'hola mundo'
	;;
	'arbol')
		echo 'Dame la ruta: '
		read rutaA
		#ls -R $ruta | egrep ":" | sed -e 's/://' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'
		ls -1FR $rutaA
	;;
	'fecha')
		echo "Hoy es: `cat /proc/driver/rtc | egrep "rtc_date" | egrep -o  "\w+-\w+-\w+"`"
	;;
	'hora')
		echo "Son las: `cat /proc/driver/rtc | egrep "rtc_time" | egrep -o  "\w+:\w+:\w+"`"
	;;
	'limpiar')
	clear
	;;
	'buscar')
		echo "Ruta donde buscar: "
		read ruta
		echo "Archivo o directorio a buscar: "
		read archivo

		if ls $ruta | egrep -ow $archivo
		then
			echo "Archivo encontrado: `ls $ruta | egrep $archivo`"
		else
			echo "Archivo no encontrado :'v"
		fi
	;;
	'creditos')
		echo -e "-----------------Desarrolladores------------------------\n"
		echo -e "\tQuiñones Rivera Josue Emanuel\tPrebecario 3\n"
		echo -e "\tHernandez Gutierrez Pedro Noe\tPrebecario 26\n"
		echo -e "\tHernandez Gonzalez Ricardo Omar\tPrebecario 8\n"
	;;
	'ayuda')
		echo -e "---------------Comandos disponibles---------------------\n"
		echo -e "\tarbol\tPermite listar desde una ruta especificada, sin argumentos desde donde estas.\n"
		echo -e "\tfecha\tMuestra la fecha del sistema.\n"
		echo -e "\thora\tMuestra la hora del sistema.\n"
		echo -e "\tbuscar\tPermite una busqueda de un archivo en un directorio especifico, ambos argumentos se piden despues de ingresar el comando.\n"
		echo -e "\tayuda\tMuestra los comandos reconocidos en esta PREBESHELL.\n"
		echo -e "\tcreditos\tMuestra informacion sobre los desarrolladores de esta PREBESHELL.\n"
		echo -e "\tinfosis\tDa un panorama general de la computadora que esta ejecutando la PREBESHELL.\n"
		echo -e "\thola\tHola mundo ¿por que no?\n"
		echo -e "\tlimpiar\tLimpia la pantalla.\n"
		echo -e "\tsalir\tPermite cerrar la PREBESHELL.\n"
		echo -e "\tpokemon\tJuego de pokemon (QUIZ).\n"
		echo -e "\tprebeplayer\tReproductor MP3.\n"
		echo -e "\tahorcado\tJuego de ahorcado.\n"
	;;
	'infosis')
		echo -e "\e[1;32m---------------Informacion sobre tu PC------------------\e[1;37m\n"
		echo -e "\n\e[1;32m---------------Modelo de tu computadora------------------\e[1;37m\n"
		echo "`cat /proc/cpuinfo | egrep "name"`"
		echo -e "\n\e[1;32m------------Version de tu Sistema Operativo--------------\e[1;37m\n"
		echo `cat /proc/version` 
		echo -e "\n\e[1;32m----------------------Memoria---------------------------\e[1;37m\n"
		echo `cat /proc/meminfo | egrep "MemTotal"`
		echo `cat /proc/meminfo | egrep "MemFree"`
		echo `cat /proc/meminfo | egrep "MemAvailable"`
		echo -e "\n\e[1;32m---------------Sistema operativo------------------------\e[1;37m\n"
		echo `cat /proc/sys/kernel/ostype`
		echo -e "\n\e[1;32m--------------Memoria Cache------------------------\e[1;37m\n"
		echo `cat /proc/cpuinfo | egrep "cache"`

	;;
	'pokemon')
		bash ./Juego1Poke.sh
	;;
	'ahorcado')
	bash ./ahorcado.sh
	;;
	'prebeplayer')
	bash ./prebeplayer.sh
	;;
	*)
		$comando
		#echo "No se reconoce el comando $comando"
	;;
	esac

	#fi

done
break
else
	echo -e "Contrasenia no valida"
fi
else
		echo -e "Usuario no existente\n"
fi
done

exit