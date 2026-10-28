#!/bin/bash

read -p "podaj liczbe wartosci " liczba

for((i=0;i<$liczba;i++))
	do
		read war
		tab[i]=$war
done

minimum(){
m=$1
for arg in $@
	do
	if [ $arg -lt $m ] 
		then
			m=$arg
	fi
done
echo $m
}

maksimum(){
m=$1
for arg in $@
	do
	if [ $arg -gt $m ] 
		then
			m=$arg
	fi
done
echo $m
}

echo "minimum: "
minimum ${tab[*]}
echo "maksimum: "
maksimum ${tab[*]}
