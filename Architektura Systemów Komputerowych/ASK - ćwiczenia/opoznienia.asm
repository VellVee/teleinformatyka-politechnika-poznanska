.nolist
.include "m16def.inc"
.list
.listmac
.device ATmega16

//---------------------------

.org 0x0000
	rjmp Start
.org 0x0030
Start:
	ldi r16, 0x04
	out SPH, r16
	ldi r16, 0x5F
	out SPL, r16

	ldi r16, 255
	ldi r17, 255
	ldi r18, 21
Licz:
	dec r16      // r16 = r16 - 1
	brne Licz	 // jak r10 > 0 to skacze to licz, jak nie to idzie dalej
	dec r17
	brne Licz
	dec r18
	brne Licz
Loop:
	rjmp Loop
