; <etykieta><rozkaz><parametry><;komentarz>
; Zapalanie diody

	; Początek każdego programu
	LJMP START		
	ORG	100H

START:
	CLR P1.7	; zerowanie bitu - P1.7 - port pierwszy, bit ostatni (ósmy)
	SJMP $ ; dalej są śmieci - robimy pętle do samego siebie (dolar)
	NOP ; tak na wszelki wypadek, jakby entera nie było (musi być)