#!/bin/bash
# Systemy operacyjne - skrypt 6
# Operacje arytmetyczne i logiczne

wynik[0]=$(($1+$2))
wynik[1]=$(($1-$2))
wynik[2]=$(($1*$2))
wynik[3]=$(($1/$2))
wynik[4]=$(($1%$2))
wynik[5]=$(($1==$2))
wynik[6]=$(($1!=$2))
wynik[7]=$((${wynik[0]}+10))
wynik[8]=0
((wynik[8]+=10))
((wynik[8]*=wynik[0]))
#wyswietlenie informacji:
echo "wyniki: ${wynik[*]}"
