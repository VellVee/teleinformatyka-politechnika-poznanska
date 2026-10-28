#!/bin/bash
# Systemy operacyjne - skrypt 4
# Tablice

tab[0]=1
tab[1]=2
tab[2]=3
tab[3]=4
tab[4]=5
tab[5]=6

#wyswietlenie pojedynczego:
echo "${tab[0]}"

#wyswietlenie wszystkich:
echo "${tab[*]}"
echo "${tab[@]}"
