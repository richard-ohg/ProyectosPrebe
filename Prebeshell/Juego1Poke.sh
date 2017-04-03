#!/bin/bash
arreglo[0]="red"
arreglo[1]="bulbasaur"
arreglo[2]="ivysaur"
arreglo[3]="venusaur"
arreglo[4]="charmander"
arreglo[5]="charmeleon"
arreglo[6]="charizard"
arreglo[7]="squirtle"
arreglo[8]="wartortle"
arreglo[9]="blastoise"
arreglo[10]="caterpi"
arreglo[11]="metapod"
arreglo[12]="butterfree"
arreglo[13]="weedle"
arreglo[14]="kakuna"
arreglo[15]="beedrill"
arreglo[16]="pidgey"
arreglo[17]="pidgeotto"
arreglo[18]="pidgeot"
arreglo[19]="rattata"
arreglo[20]="raticane"
arreglo[21]="spearow"
arreglo[22]="fearow"
arreglo[23]="ekans"
arreglo[24]="arbok"
arreglo[25]="pikachu"
arreglo[26]="raichu"
arreglo[27]="sandshrew"
arreglo[28]="sandslash"
arreglo[29]="eevee"
arreglo[30]="magikarp"

let contador=0
let marcador=0

RED='\033[0;31m'
NC='\033[0m'

BLUE='\033[0;34m'

YELLOW='\033[1;33m'

cat ./0.txt
echo -e "${YELLOW}vamos a ver que tanto sabes de pokemon${NC}"
echo -e "${RED}si te sale el comodin (logo de pokemon) escribe el nombre del primer entrenador de gbc${NC}"
read -rsp $'Pulsa cualquier tecla para continuar...\n' -n1 key
        while [ $contador -ne 10 ]; do
                clear
                pokemon=`echo $(($RANDOM % 30))`
                let nombrepokemon=$pokemon
                cat ./$nombrepokemon.txt
                echo -e "${YELLOW}escribe el nombre del pokemon que aparece arriba (solo minusculas):3${NC} "
                read cadena
                if [ $cadena == ${arreglo[$pokemon]} ];
                then
                        clear
                        echo -e "${BLUE}muy bien$"
                        read -rsp $'Presiona cualquier tecla para continuar\n' -n1 key
                        let marcador=$marcador+1
                else
                        echo -e "${RED}error, no se llama asi chaval"
                        read -rsp $'Presiona cualquier tecla para continuar\n' -n1 key
                fi
                let contador=$contador+1
        done
echo -e "${YELLOW}tu marcador final es $marcador${NC}"
