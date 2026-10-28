	LJMP START 
	ORG 100H 
START:
	LCALL LCD_CLR ;
	MOV R0, #40H 
	MOV R1, #10 
	
ZAPETLENIE: 
	MOV @R0, #0  
	INC R0
	MOV A, R0 
	LCALL WRITE_HEX 
	LCALL DELAY_100MS
	DJNZ R1, ZAPETLENIE ; zmniejszam o 1 i wykonuje petle jeszcze raz
	SJMP $	; skok do samego siebie