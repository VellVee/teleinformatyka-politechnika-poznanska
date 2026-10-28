    #!/bin/bash  
    #while
      
read -p "wprowadz liczbe startowa: " poczatek
read -p "wprowadz liczbe koncowa: " koniec
read -p "wprowadz moment przerwania " przerwanie
read -p "pomijanie wartosci dol " pomin_start
read -p "pomijanie wartosci stop " pomin_stop

((poczatek--))
while [ $poczatek -le $koniec ]  
	do 
	((poczatek++))
	if [ $poczatek -eq $przerwanie ]
		then
		break
	fi
	if [[ $poczatek -ge $pomin_start && $poczatek -le $pomin_stop ]]
		then 
		continue
	fi
	echo "$poczatek"
done  
