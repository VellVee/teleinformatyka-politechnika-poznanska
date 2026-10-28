#!/bin/bash  
#Zadanie 3
     
read -p "podaj pierwsza liczbe " arg1  
read -p "podaj druga liczbe " arg2 
read -p "podaj znak (dodawanie(+), odejmowanie(-), mnozenie(*), dzielenie(/))" znak  
      
dodaj(){
return $(($1+$2))
}
odejmij(){
return $(($1-$2))
}
pomnoz(){
return $(($1*$2))
}
podziel(){
return $(($1/$2))
}
case $znak in  
	dodawanie|"+")  
		dodaj $arg1 $arg2
		echo "Wynik $arg1 + $arg2 to: $?"
        echo  
        ;;  
    	odejmowanie|"-")  
		odejmij $arg1 $arg2
		echo "Wynik $arg1 - $arg2 to: $?"
        ;;  
  	mnozenie|"*")  
		pomnoz $arg1 $arg2
		echo "Wynik $arg1 * $arg2 to: $?"
        ;;  
	dzielenie|"/")  
		if [ $arg2 -eq 0 ]
			then
				echo "nie dziel przez 0"
		else
			podziel $arg1 $arg2
			echo "Wynik $arg1 / $arg2 to: $?"
		fi
		;;  
	*)
		echo "niewlasciwe dane"
		echo 
		;;
    esac 
