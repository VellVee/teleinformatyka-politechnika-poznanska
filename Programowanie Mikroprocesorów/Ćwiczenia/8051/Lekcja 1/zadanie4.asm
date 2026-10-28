; <etykieta><rozkaz><parametry><;komentarz>
; Migotanie diody + brzęczyk na całych bitach

	; Początek każdego programu
	LJMP START		
	ORG	100H

START:
	MOV A, #10 ; przeniesienie do akumulatora, po '#' dajemy wartość liczbową - 
			   ; to można dać przed pętle, ale podprogram może modyfikować zawartość akumulatora
	LCALL DELAY_100MS	; wywołujemy podprogram DELAY_100MS, który opóźnia o sekunde (o wartość z akumulatora)
	XRL P1,#10100000B	; XRL - suma modula dwa - daje taki sam efekt (pętla) - bity zapisujemy od końca 
	SJMP START ; dalej są śmieci - robimy pętle do STARTu
	NOP ; tak na wszelki wypadek, jakby entera nie było (musi być)