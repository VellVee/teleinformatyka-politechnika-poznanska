; Zadanie 5
	LJMP START		
	ORG	100H 

START:
	; Domyślnie RS1 i RS2 są na zero
	LCALL LCD_CLR	; wywołujemy podprogram LCD_CLR
	; Bank 00
	CLR RS0
	CLR RS1	
	MOV R0, #0
	MOV A, R0
	LCALL LCD
	; Bank 01
	CLR RS0
	SETB RS1
	MOV R0, #1
	MOV A, R0
	LCALL LCD
	; Bank 10
	SETB RS0
	CLR RS1	; tu jest zero
	MOV R0, #2
	MOV A, R0 
	LCALL LCD
	; Bank 11
	SETB RS0
	SETB RS1
	MOV R0, #3
	MOV A, R0 
	LCALL LCD
	
	SJMP START ;powrot do siebie
	NOP
	
LCD:
	LCALL WRITE_HEX 
	MOV A, #10
	LCALL DELAY_100MS
	LCALL LCD_CLR
	RET
	NOP
	