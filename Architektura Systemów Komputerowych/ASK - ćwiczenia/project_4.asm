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

	ldi r17, 2   // a = 2
	ldi r18, 3   // b = 3
	ldi r19, 4   // c = 4
	ldi r16, 10  // x = 10
	mov r20, r16 // 
	call Funkcja
	ldi r16, 1
	call Funkcja
	ldi r16, 0
	call Funkcja
//	ldi r16, 2
//	call Funkcja
Loop: 
	rjmp Loop

.org 0x0100
Funkcja:
	mul r16, r20 // x^2
	mul r17, r0  // 2x^2
	mov r21, r0  // 2x^2 do r21
	mul r16, r18
	mov r22, r0
	add r22, r19 // 3x + 4
	add r22, r21 // 2x^2 + 3x + 4
	ret
