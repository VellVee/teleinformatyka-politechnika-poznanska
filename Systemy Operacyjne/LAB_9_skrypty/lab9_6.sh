#!/bin/bash  
#Zadanie 6
read -p "Podaj liczbe wyrazow ciagu: " ile

if [ $ile -le 0 ];
	 then echo "bledne dane"

elif [ $ile -eq 1 ]; 
	then
		tab[0]=0
else	
	tab[0]=0
	tab[1]=1
	for ((i=2;i<$ile;i++))
		do
		 tab[i]=$((${tab[i-2]}+${tab[i-1]}))
	done
fi
echo ${tab[*]}



