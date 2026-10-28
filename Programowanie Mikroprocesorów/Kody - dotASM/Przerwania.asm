LED	EQU	P1.7
;********* Ustawienie TIMERÓW *********
;TIMER 0
T0_G	EQU	0	;GATE
T0_C	EQU	0	;COUNTER/-TIMER
T0_M	EQU	1	;MODE (0..3)
TIM0	EQU	T0_M+T0_C*4+T0_G*8
;TIMER 1
T1_G	EQU	0	;GATE
T1_C	EQU	0	;COUNTER/-TIMER
T1_M	EQU	0	;MODE (0..3)
TIM1	EQU	T1_M+T1_C*4+T1_G*8

TMOD_SET	EQU	TIM0+TIM1*16


TH0_SET		EQU	256-36	;timer na 10ms
TL0_SET		EQU	0
;**************************************

	LJMP	START	

;********* Przerwanie Timer 0 *********
	ORG	0BH
	MOV	TH0,#TH0_SET		
	DJNZ	R7,NO_1SEK		
	LCALL	LOOP			
	
	CJNE R4, #0, STOP		
	
	INC R6					
	CJNE R6, #100, NO_1SEK
	MOV R6, #0
	INC R5
	INC R2					
	CJNE R5, #100, NO_1SEK
	MOV R5, #0
	
NO_1SEK:
	RETI

STOP:
	LCALL WAIT_KEY
	MOV R4, #0		
	RETI
	
;**************************************
	ORG	100H	

START:
	LCALL	LCD_CLR			
	MOV	TMOD,#TMOD_SET		
	MOV	TH0,#TH0_SET		
	MOV	TL0,#TL0_SET
	SETB	EA		
	SETB	ET0		
	MOV	R7,#1		
	MOV R5, #0
	MOV R6, #0
	SETB	TR0		

	
DISP_LOOP:	
	LCALL 	WAIT_KEY		
	MOV R4, #1			
	SJMP 	DISP_LOOP	
	SJMP	$			
	
LOOP:
	LCALL LCD_CLR
	MOV A, R5			
	LCALL TO_BCD
	LCALL WRITE_HEX
	MOV A,#','			
	LCALL WRITE_DATA
	MOV A, R6			
	LCALL TO_BCD
	LCALL WRITE_HEX
	MOV A,#' '			
	LCALL WRITE_DATA
	MOV A,#'s'
	LCALL WRITE_DATA
	
	CJNE R2, #10, LOOP2
	MOV R2, #0
	LJMP ALARM
	
LOOP2:
	CJNE R2, #2, LOOP3
	LJMP ALARMOFF
	
LOOP3:	
	MOV	R7,#1 		
	RET				
	NOP	

ALARM:
	CPL P1.5				
	CPL P1.7
	LJMP LOOP2
	
ALARMOFF:
	SETB P1.5
	SETB P1.7
	LJMP LOOP3
	
TO_BCD: 				
	MOV B,#10			
	DIV AB				
	SWAP A				
	ORL A,B				
	RET
	NOP
