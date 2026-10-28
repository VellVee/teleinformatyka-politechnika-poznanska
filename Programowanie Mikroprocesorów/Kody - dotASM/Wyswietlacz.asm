SEG_ON EQU	P1.6	;wlaczenie wyswietlacza 7-segm.

;Pelne adresy urzadzen we/wy systemu DSM-51
; adresy skrocone sa dostepne przez symbole CSDS i CSDB
F_CSDS EQU 0FF30H ;bufor wyboru wskaznika
F_CSDB EQU 0FF38H ;bufor danych wskaznika

;Stale u�ywane w programie
DISPLAY EQU	00000001B	;wybrane wskaznik
	
	LJMP	START
	ORG	100H
START:
	LCALL WAIT_KEY
	MOV R4, A

	MOV 30H, #0
	MOV 31H, #0
	MOV 32H, #0
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

MIN:

SECDZIE: 
SECJED:
  MOV 50H,#55
  
MALA:  
  MOV 51H,#DISPLAY
  SETB SEG_ON
  MOV A,51H
  
  MOV R0,#CSDS
  MOVX	@R0,A
  
  MOV	R1,#CSDB 	;adres bufora
	 			;danych wskaznika
  MOV A,#40H
  ADD A,30H
  MOV 20H,A
  MOV R0,A
  MOV A,@R0
  
  MOVX	@R1,A	;wpisz wybrane segmenty

  CLR	SEG_ON	
  
  ;USTAWIENIE DELAY ABY WYSWIETLACZ NIE MRYGAŁ I ABY FUNKCJA ODLICZALA 18MS
  MOV A, #6
  LCALL DELAY_MS

  SETB SEG_ON
  MOV A,51H
  RL A ;PRZESUNIECIE AKUMULATORIA W LEWO
  MOV 51H,A
  MOV R0,#CSDS
  MOVX	@R0,A
  
  MOV	R1,#CSDB 
  MOV A,#40H
  ADD A,31H ;;10s
  MOV 20H,A
  MOV R0,A
  MOV A,@R0
  
  MOVX	@R1,A	;wpisz wybrane segmenty

  CLR	SEG_ON
  
  ;USTAWIENIE DELAY ABY WYSWIETLACZ NIE MRYGAŁ I ABY FUNKCJA ODLICZALA 18MS
  MOV A, #6
  LCALL DELAY_MS

  SETB SEG_ON
  MOV A,51H
  RL A
  MOV 51H,A
  MOV R0,#CSDS
  MOVX	@R0,A
  
  MOV	R1,#CSDB 
  MOV A,#40H
  ADD A,32H
  MOV 20H,A
  MOV R0,A
  MOV A,@R0
  
  MOVX	@R1,A	;wpisz wybrane segmenty

  CLR	SEG_ON
  
  ;USTAWIENIE DELAY ABY WYSWIETLACZ NIE MRYGAŁ I ABY FUNKCJA ODLICZALA 18MS
  MOV A, #6
  LCALL DELAY_MS
  
  DJNZ 50H,MALA

  INC 30H
  MOV A, 30H
  CJNE A, #10, SECJED

  INC 31H
  MOV 30H, #0
  MOV A, 31H
  CJNE A, #6, SECDZIE

  INC 32H
  MOV 31H, #0
  MOV A, 32H
  MOV B, R4
  CJNE A, B, MIN

  LJMP ALARM
ALARM:
  CPL P1.5
  LJMP ALARM

	SJMP	$
	NOP
