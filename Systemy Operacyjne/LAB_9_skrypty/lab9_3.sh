#!/bin/bash  
#Zadanie 3
     
read -p "podaj pierwsza liczbe " arg1  
read -p "podaj druga liczbe " arg2 
read -p "podaj znak (dodawanie(+), odejmowanie(-), mnozenie(*), dzielenie(/))" znak  
      
case $znak in  
	dodawanie|"+")  
		wynik=$(($arg1+$arg2))
		echo "Wynik $arg1 + $arg2 to: $wynik"
        echo  
        ;;  
    	odejmowanie|"-")  
        	wynik=$(($arg1-$arg2))
		echo "Wynik $arg1 - $arg2 to: $wynik" 
        ;;  
  	mnozenie|"*")  
		wynik=$(($arg1*$arg2))
		echo "Wynik $arg1 * $arg2 to: $wynik"
        ;;  
	dzielenie|"/")  
		wynik=$(($arg1/$arg2))
		echo "Wynik $arg1 / $arg2 to: $wynik"
		;;  
	*)
		echo "niewlasciwe dane"
		echo 
		;;
    esac 
