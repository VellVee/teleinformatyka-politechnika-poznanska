LED    EQU    P1.7
;********* Ustawienie TIMER�w *********
;TIMER 0
T0_G    EQU    0    ;GATE
T0_C    EQU    0    ;COUNTER/-TIMER
T0_M    EQU    1    ;MODE (0..3)
TIM0    EQU    T0_M+T0_C*4+T0_G*8
;TIMER 1
T1_G    EQU    0    ;GATE
T1_C    EQU    0    ;COUNTER/-TIMER
T1_M    EQU    0    ;MODE (0..3)
TIM1    EQU    T1_M+T1_C*4+T1_G*8

TMOD_SET    EQU    TIM0+TIM1*16

;50[ms] = 50 000[�S]*(11.0592[MHz]/12) =
;    = 46 080 cykli = 180 * 256
TH0_SET        EQU    256-180
TL0_SET        EQU    0
;**************************************
    LJMP    START
    ORG    100H
START:
    LCALL WPROWADZ 
    MOV 40H, A

    LCALL WPROWADZ 
    MOV 41H, A

    LCALL WPROWADZ 
    MOV 42H, A

    LCALL WPROWADZ 
    MOV 43H, A

    LCALL WPROWADZ 
    MOV 44H, A

    LCALL WPROWADZ 
    MOV 45H, A

    MOV    TMOD,#TMOD_SET        ;Timer 0 liczy czas
    MOV    TH0,#TH0_SET        ;Timer 0 na 50ms
    MOV    TL0,#TL0_SET
    SETB TR0            ;start Timera
	
	;---------------------------------------------------------------------------------------------------
	
LOOP:            		;Petla mrugania diody TEST
    LCALL LCD_CLR		; wyczysc wyswietlacz
    MOV    R7,#20       ;odczekaj czas 20*50ms=1s
	
	MOV A, 40H			
	LCALL TO_BCD
	LCALL WRITE_HEX
	MOV A,#':'
	LCALL WRITE_DATA
	MOV A, 41H			
	LCALL TO_BCD
	LCALL WRITE_HEX
	MOV A,#':'
	LCALL WRITE_DATA
	MOV A, 42H			
	LCALL TO_BCD
	LCALL WRITE_HEX
	
    INC 42H				
	MOV A, 42H				
	CJNE A, #60, TIME_N50
	MOV 42H, #0
	INC 41H
	MOV A, 41H				
	CJNE A, #60, TIME_N50
	MOV 41H, #0
	INC 40H
	MOV A, 40H				
	CJNE A, #24, TIME_N50
	MOV 40H, #0
	;---------------------------------------------------------------------------------------------------
	
TIME_N50:
    JNB    TF0,$            ;czekaj, az Timer 0 odliczy 50ms
    MOV    TH0,#TH0_SET     ;TH0 na 50ms
    CLR    TF0            	;zerowanie flagi timera 0
    DJNZ    R7,TIME_N50     ;odczekanie N*50ms
    CJNE R3, #1, ALARMUJ
	INC R4
	CJNE R4, #5, LOOP
	LJMP WYLACZ
	
ALARMUJ:
	MOV A, 40H	
	MOV B, 43H
	CJNE A, B, LOOP
	MOV A, 41H				
	MOV B, 44H
	CJNE A, B, LOOP
	MOV A, 42H				
	MOV B, 45H
	CJNE A, B, LOOP
	CPL P1.5				
	CPL P1.7	
	MOV R3, #1
	MOV R4, #2
	LJMP LOOP

WPROWADZ:
    LCALL WAIT_KEY
    MOV B, #10
    MUL AB
    MOV R1,A
    LCALL WAIT_KEY
    ADD A,R1
    RET
    NOP
	
TO_BCD: 				
	MOV B,#10			
	DIV AB				
	SWAP A				
	ORL A,B				
	RET
	NOP		
	
WYLACZ:
	SETB P1.5
	SETB P1.7
	LJMP LOOP
	