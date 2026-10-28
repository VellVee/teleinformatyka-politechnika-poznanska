; <etykieta><rozkaz><parametry><;komentarz>
; Migotanie diody 

	; Początek każdego programu
	LJMP START		
	ORG	100H

START:
	MOV A, #10 ; przeniesienie do akumulatora, po '#' dajemy wartość liczbową - 
			   ; to można dać przed pętle, ale podprogram może modyfikować zawartość akumulatora
	LCALL DELAY_100MS	; wywołujemy podprogram DELAY_100MS, który opóźnia o sekunde (o wartość z akumulatora)
	CPL P1.7	; negujemy bit P1.7 - dioda się raz zapala, a raz nie
	SJMP START ; dalej są śmieci - robimy pętle do STARTu
	NOP ; tak na wszelki wypadek, jakby entera nie było (musi być)