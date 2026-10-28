#!/bin/bash  

#case skrypt      
echo "Podaj swoj numer grupy?"  
echo "I1L, I1P, I2L, I2P, I3L, I3P"  
read -p "Twoja grupa to: " numer  
      
case $numer in  
	I1L|i1l)  
		echo "Zajecia z systemow operacyjnych masz w poniedzialki 17.00"
        echo  
        ;;  
    I1P|i1p)  
        echo "Zajecia z systemow operacyjnych masz we wtorki o 11.45"  
        echo  
        ;;  
    I2L|i2l)  
		echo "Zajecia z systemow operacyjnych masz w poniedzialki 15.15"  
		echo  
        ;;  
	I2P|i2p)  
		echo "Zajecia z systemow operacyjnych masz w poniedzialki 8.00"  
		echo  
		;;  
	I3L|i3l)  
		echo "Zajecia z systemow operacyjnych masz w poniedzialki 11.45"  
		echo  
		;;  
	I3P|i3p)  
		echo "Zajecia z systemow operacyjnych masz w piatki o 9.45"  
		echo  
		;;  
	*)
		echo "Nie ma takiej grupy"
		echo 
		;;
    esac 