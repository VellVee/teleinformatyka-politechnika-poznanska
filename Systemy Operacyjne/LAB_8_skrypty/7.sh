#!/bin/bash  

# Systemy operacyjne -skrypt 7
# if else
      

if [ $# -eq 2 ];
	then
	if [ $1 -gt $2 ];  
   		then  
  		echo "$1 jest wieksze niz $2."
	else
		echo "$2 jest wieksze niz $1."
	fi
	if [ $1 -lt $2 ];  
    		then  
    		echo "$1 jest mniejsze niz $2." 
	else
		echo "$2 jest mniejsze niz $1."
	fi
	if [ $1 -eq $2 ];  
    		then  
    		echo "$1 jest rowne $2." 	
	fi
	if [ $1 -ne $2 ];  
    		then  
    		echo "$1 nie jest rowne $2." 
		fi
else
	echo "Podano niewlasciwa liczbe arguemntow"
fi
