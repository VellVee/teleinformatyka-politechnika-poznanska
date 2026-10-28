.nolist
.include "m16def.inc"
.list
.listmac
.device ATmega16


.cseg
.org 0x0000
jmp start
;wektory przerwań

.org 0x0030
start:
;stos
ldi r16, low(RAMEND)
out SPL, r16

ldi r17, high(RAMEND)
out SPH, r17

;PBO jako wyjscie
ldi r16, 0b00000001
out DDRB, r16

MAIN:
ldi r16, 0x32
call send_ASCII
call wait_1s

ldi r16, 0x4b
call send_ASCII
call wait_1s

ldi r16, 0x41
call send_ASCII
call wait_1s

ldi r16, 0x4d
call send_ASCII
call wait_1s

ldi r16, 0x49
call send_ASCII
call wait_1s

ldi r16, 0x4c
call send_ASCII
call wait_1s

nop

jmp MAIN

.org 0x0100
;podprogramy
send_0:
cbi PORTB, 0
call wait_104us
ret

send_1:
sbi PORTB, 0
call wait_104us
ret

wait_104us:
ldi  r18, 220

Loop: 
dec  r18
brne Loop

ret

wait_1s:
ldi r18, 21
ldi r19, 75
ldi r20, 191
L1: dec r20
brne L1
dec r19
brne L1
dec r18
brne L1
nop

Loop2: 
dec  r18
brne Loop2

ret

test_C:
ror r16
brcc zero
call send_1
ret

zero:
call send_0
ret

send_ASCII:

call send_0

call test_C
call test_C
call test_C
call test_C
call test_C
call test_C
call test_C
call test_C

call send_1


ret
