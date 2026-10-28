#!/bin/bash  
#Pętla for - skrypt 3 
      
for ((i=1; i<=20; i++));  
    do  
    if [[ $i -gt 10 && $i -lt 15 ]];  
		then  
		continue  
    fi  
    echo $i  
done  
