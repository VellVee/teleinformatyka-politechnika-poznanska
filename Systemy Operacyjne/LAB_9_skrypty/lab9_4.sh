 #!/bin/bash  
#Zadanie 4
if [ ! -d "./BACKUP" ]; 
	then 
		mkdir BACKUP	
fi

if [ $# == 0 ];
	then
		cp * BACKUP
	else	
		for arg in "$@";
		do 
		cp *.$arg BACKUP
		done
fi
