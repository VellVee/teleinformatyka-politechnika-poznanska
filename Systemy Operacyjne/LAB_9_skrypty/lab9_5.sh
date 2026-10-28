#!/bin/bash  
#Zadnaie 5
#case skrypt      
read -p "podaj ciag ktory ma sie znajdowac w nazwie: " arg1  
read -p "podaj nazwe pliku do ktorego maja zostac wyszukane pliki: " arg2 
read -p "podaj sciezke w ktorej ma wyszukiwac" arg4
read -p "Podaj typ ktory ma zostac wyszukany: " arg3  

find $arg4 -type $arg3 -name "*$arg1*" | cat > $arg2.txt 
