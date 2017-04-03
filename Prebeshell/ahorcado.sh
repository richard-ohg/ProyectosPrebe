#!/bin/bash

# Script para jugar ahorcado
# Figuras del ahorcado obtenidas de la página:
# https://programaresdivertido.wordpress.com/2014/08/29/programando-un-ahorcado-en-consola-con-java-nivel-medio/

echo -e "\t\t\t\t\nJUEGO DEL AHORCADO.";

# Instrucciones del juego

		echo -e "\n\t\tInstrucciones:"
		echo -e "\t\t\t
		\tEl juego consiste en adivinar letra por letra una
		\tpalabra, la cual no contendrá ni caracteres 
		\tespeciales ni acentos (a excepción de Mayúsculas).\n
		\tPrimero te aparecerán guiones que indicarán la longitud 
        \t\tde la palabra que se busca, posteriormente elegirás
		\tletras que creas pueden estar contenidas en la misma,
		\tsi tu letra está en la palabra, esta sustituirá
		\tel guión correspondiente a su posición con lo cual
		\testarás más cerca de adivinar la palabra mientras 
		\tque en el caso contrario perderás una vida.\n\n";

# Se generará un número aleatorio y se guarda en numero
numero=$(($RANDOM%150));
i=1; #inicia contador para recorrer el archivo

#archivo_pal= cat ./opciones.txt;
#archivo_pistas= cat ./pistas.txt;

for find in $(<opciones.txt) 
do  #ciclo para encontrar la palabra que corresponde al numero aleatorio

	if [ $i -eq $numero ];
	then
		palabra=$find; #aqui asigna la palabra del archivo a la variable palabra
	fi
	let i=$i+1;
done

i=1;

while read line 
do  
	if [ $i -eq $numero ]; then
		pista=$line; #aqui asigna la cadena del archivo a la variable pista
	fi
	let i=$i+1;
done <pistas.txt

#echo $find;

longitud=${#palabra}; #regresa la longitud de la palabra

for ((x=1; x<=$longitud; x++)); do
	array_pal[$x]=`expr substr $palabra $x 1`;
	resp[$x]=0; #arreglo para la respuesta del usuario
done


# Para el ciclo y la interfaz del juego

vidas=7;
lets_restantes=$longitud;

while [ $vidas -gt 0 ] && [ $lets_restantes -ne 0 ]; do
	
	echo -e "\t\tAdivine la siguiente palabra\n";
	echo -e "\nPista: $pista";
	echo -e "\nVidas: $vidas\n";
	
	let indice=8-$vidas;
	
	cat "figura"$indice".txt"; #imprime el numero de figura dependiendo de los errores

	for ((x=1; x<=$longitud; x++)); do  #ciclo para imprimir un _ o la letra, dependiendo si está bien o mal
		if [ ${resp[$x]} -eq 0 ]; then
			echo -n " _ ";
		else
			echo -n " ${array_pal[$x]} ";
		fi
	done
	
	
	echo -n "Ingrese un caracter:";
	read -n 1 c;
	
	n_acierto=0;

	for ((x=1; x<=$longitud; x++)); do
		if [ "$c" == "${array_pal[$x]}" ]; then
			resp[$x]=1;
			
			let lets_restantes=$lets_restantes-1;
			let n_acierto=$n_acierto+1;
		fi
	done

	clear;
	if [ $n_acierto -eq 0 ]; then
		echo "Lo siento, la letra no está dentro de la palabra"; 
		let vidas=$vidas-1;
	else
		echo "Acertaste";
	fi

done

clear;

if [ $lets_restantes -eq 0 ]; then
	echo -e "\t\t\t\t\tExcelente, la palabra es: $palabra\n";
	echo -e "\t\t\tHas ganado.";
	cat ./figura0.txt;
	echo -e "\n";
else
	echo -e "Suerte para la próxima, la palabra era:\t$palabra\n";
	cat ./figura8.txt;
	echo -e "\n";
fi
exit