#!/bin/bash  

# Systemy operacyjne - Lab 9
#Zadanie 2

for arg in "$@";
do 
echo "tworze plik $arg"
touch $arg.txt
done 

