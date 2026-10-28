SEG_ON EQU	P1.6	;wlaczenie wyswietlacza 7-segm.

;Pelne adresy urzadzen we/wy systemu DSM-51
; adresy skrocone sa dostepne przez symbole CSDS i CSDB
F_CSDS EQU 0FF30H ;bufor wyboru wskaznika
F_CSDB EQU 0FF38H ;bufor danych wskaznika

;Stale u�ywane w programie
DISPLAY EQU	00000001B		;wybrane wskazniki

	MOV 40H,#00111111B		;0 w wyswietlaczu
	MOV 41H,#00000110B		;1 w wyswietlaczu itd
	MOV 42H,#01011011B
	MOV 43H,#01001111B
	MOV 44H,#01100110B
	MOV 45H,#01101101B
	MOV 46H,#01111101B
	MOV 47H,#00000111B
	MOV 48H,#01111111B
	MOV 49H,#01101111B
	MOV	R1,#CSDB 		 	;adres bufora danych wskaznika	

	LJMP	START
	ORG	100H
	
START:
	MOV 30H, #0				;sekundy
	MOV 31H, #0				;dziesiatki sekund
	MOV 32H, #0				;minuty
	LCALL WAIT_KEY
	JZ TESTER				;jak A=0 to idz do testera
	MOV R4, A
	LJMP SEKUNDA1

TESTER:						; jak 0 to zamien na 1
	MOV A, #1
	MOV R4, A
	LJMP SEKUNDA1

MRUGACZ:					;trwa sekunde, wielokrotnie wyswietla 
	MOV	R0,#CSDS 		
    MOV	A,#DISPLAY
	MOVX @R0,A			
	MOV	A,30H			;ilosc sekund do A
	ADD A,#40H 			; ilosc sekund dodaje do 40H (0) i powtstaje np 46H i wie co wypisac
	MOV R0, A			; do R0 zapisuje np. 46H
	MOV A, @R0  		; do A wpisuje wartosc rejestru 46H np. #01111101B
	MOVX @R1,A			;wpisz wybrany segment
	CLR	SEG_ON			;wlacza wyswietlatacz 

	MOV A, #5
	LCALL DELAY_MS		; opoznienie 5ms
	SETB SEG_ON
	MOV	R0,#CSDS 		
    MOV	A,#DISPLAY
	RL A 				; przesuniecie wybranego segmentu w lewo		
	MOVX @R0,A			
	MOV	A,31H
	ADD A,#40H
	MOV R0, A
	MOV A, @R0
	MOVX @R1,A			
	CLR	SEG_ON			
	
	MOV A, #5
	LCALL DELAY_MS
	SETB SEG_ON
	MOV	R0,#CSDS 		
    MOV	A,#DISPLAY
	RL A			;przesun o 3 w lewo, komorka wyswietlacza
	RL A	
	RL A 				
	MOVX @R0,A						
	MOV	A,32H
	ADD A,#40H
	MOV R0, A
	MOV A, @R0
	MOVX @R1,A		;wpisz wybran segment
	CLR	SEG_ON		;wlacza wyswietlatacz 	
	
	MOV A, #5
	LCALL DELAY_MS
	SETB SEG_ON
	INC R3 
	CJNE R3, #68, MRUGACZ	;czas trwania tej petli*68 to okolo 1s
	LJMP SEKUNDA2

SEKUNDA1:				;pierwsza czesc sekundy	
  MOV R2, 30H
  MOV R3, #0
  LJMP MRUGACZ			
  
SEKUNDA2:				;druga czesc sekundy
  INC 30H
  CJNE R2, #9, SEKUNDA1
  LJMP DZIESIATKA
  
DZIESIATKA:				; zajmuje sie dziesiatkami sekund
  INC 31H
  MOV 30H, #0
  MOV A, 31H
  CJNE A, #6, SEKUNDA1	; jak nie 6-dziesiat to zwieksz sekunde
  LJMP MINUTA			; jak 6dziesiat to idz do minuty

MINUTA: 			;zwieksza minute
  INC 32H
  MOV 31H, #0
  MOV A, 32H
  MOV B, R4			;R4 to ile wpisalismy
  CJNE A, B, SEKUNDA1	;jak nie koniec to zwieksz sekunde
  LJMP ALARM			;jak koniec to alarm
  
ALARM:
  CPL P1.5			;wlacz brzeczyk i led
  CPL P1.7
  LJMP ALARM
	SJMP	$
	NOP