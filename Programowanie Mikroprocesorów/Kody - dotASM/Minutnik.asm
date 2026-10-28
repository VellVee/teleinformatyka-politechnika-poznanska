SEG_ON EQU	P1.6	;wlaczenie wyswietlacza 7-segm.

;Pelne adresy urzadzen we/wy systemu DSM-51
; adresy skrocone sa dostepne przez symbole CSDS i CSDB
F_CSDS EQU 0FF30H ;bufor wyboru wskaznika
F_CSDB EQU 0FF38H ;bufor danych wskaznika

;Stale u�ywane w programie
DISPLAY EQU	00000001B	;wybrane wskazniki

	MOV 40H,#00111111B
	MOV 41H,#00000110B
	MOV 42H,#01011011B
	MOV 43H,#01001111B
	MOV 44H,#01100110B
	MOV 45H,#01101101B
	MOV 46H,#01111101B
	MOV 47H,#00000111B
	MOV 48H,#01111111B
	MOV 49H,#01101111B
	MOV	R1,#CSDB 		

	LJMP	START
	ORG	100H
	
START:
	MOV 30H, #0
	MOV 31H, #0
	MOV 32H, #0
	LCALL WAIT_KEY
	JZ TESTER
	MOV R4, A
	LJMP SEKUNDA1

TESTER:
	MOV A, #1
	MOV R4, A
	LJMP SEKUNDA1

MRUGACZ:				
	MOV	R0,#CSDS 		
    MOV	A,#DISPLAY
	MOVX @R0,A			
	MOV	A,30H
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
	RL A 				
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
	RL A
	RL A	
	RL A 				
	MOVX @R0,A						
	MOV	A,32H
	ADD A,#40H
	MOV R0, A
	MOV A, @R0
	MOVX @R1,A			
	CLR	SEG_ON			
	
	MOV A, #5
	LCALL DELAY_MS
	SETB SEG_ON
	INC R3 
	CJNE R3, #70, MRUGACZ
	LJMP SEKUNDA2

SEKUNDA1:					
  MOV R2, 30H
  MOV R3, #0
  LJMP MRUGACZ			
  
SEKUNDA2:					
  INC 30H
  CJNE R2, #9, SEKUNDA1
  LJMP DZIESIATKA
  
DZIESIATKA:
  INC 31H
  MOV 30H, #0
  MOV A, 31H
  CJNE A, #6, SEKUNDA1
  LJMP MINUTA

MINUTA: 
  INC 32H
  MOV 31H, #0
  MOV A, 32H
  MOV B, R4
  CJNE A, B, SEKUNDA1
  LJMP ALARM
  
ALARM:
  CPL P1.5
  CPL P1.7
  LJMP ALARM
	SJMP	$
	NOP