#!/bin/bash

samolot=()
read -p "Podaj liczbe miejsc w samolocie " miejsca

rezerwacja(){
miejsce=$(($1-1))
nazwisko=$2
if [[ $miejsce -lt $miejsca ]]
	then
		if [[ -z ${samolot[$miejsce]} ]]
			then
				samolot[$miejsce]=$nazwisko
				echo "zarezerwowalismy miejsce $1 dla $nazwisko"
			else
				echo "miejsce zajete"
		fi
else
	echo "nie ma takiego miejsca"
fi
}

odwolanie(){
miejsce=$(($1-1))
if [[ $miejsce -lt $miejsca ]]
	then
		if [[ -n ${samolot[$miejsce]} ]]
			then
				samolot[$miejsce]=""
				echo "Zwolniono miejsce $1"
			else 
				echo "Miejsce juz bylo wolne"
		fi
else
	echo "nie ma takiego miejsca"
fi
}

wyswietlm(){
miejsce=$(($1-1))
if [[ $miejsce -lt $miejsca ]]
	then
		if [[ -n ${samolot[$miejsce]} ]]
			then
				echo "Miejsce $1 jest zarezerwowane dla ${samolot[$miejsce]}"
			else 
				echo "Miejsce jest wolne"
		fi
else
	echo "nie ma takiego miejsca"
fi
}

wyswietls(){
for((i=0;i<$miejsca;i++))
	do
	if [[ -n ${samolot[i]} ]]
		then
		echo -n "[Z]"
	else 
		echo -n "[ ]"
	fi
	if (( ($i+1) %4 ==0 ))
		then 
			echo ""
	fi
done
}

while [[ 1 == 1 ]]
do
echo "1) rezerwacja miejsca"
echo "2) odwolanie rezerwacji"
echo "3) wyswietlenie miejsca"
echo "4) wyswietlenie samolotu"
echo "5) koniec programu"

read -p "wybierz opcje: " opcja

case $opcja in
	1) 
		read -p "podaj numer miejsca " nr
		read -p "podaj nazwisko " nz
		rezerwacja $nr $nz
		;;
	2) 
		read -p "podaj numer miejsca " nr
		odwolanie $nr
		;;
	3) 
		read -p "podaj numer miejsca " nr
		wyswietlm $nr
		;;
	4)
		wyswietls
		;;
	5)
		break
		;;
	*)
		echo "nie rozpoznano polecenia"
		;;
esac
done


