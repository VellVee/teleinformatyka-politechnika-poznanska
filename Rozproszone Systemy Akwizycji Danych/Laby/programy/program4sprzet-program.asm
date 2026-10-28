.nolist
.include "m16def.inc"
.list
.listmac
.device ATmega16

.cseg
.org 0x0000
jmp START

.org 0x0030
START:
ldi r16, LOW(RAMEND)
out SPL, r16
ldi r17, HIGH(RAMEND)
out SPH, r17

ldi r16, 0xFF
out DDRB, r16

ldi r17, 8
out UBRRL, r17
ldi r16, 0
out UBRRH, r16

ldi r16, (1<<RXEN)|(1<<TXEN)
out UCSRB, r16

ldi r16, (1<<URSEL)|(0<<USBS)|(1<<UCSZ1)|(1<<UCSZ0)
out UCSRC, r16

//PD1 UART wbudowany

MAIN:

call USART_Receive
//call USART_Transmit
call send_ASCII

jmp MAIN

USART_Transmit:
sbis UCSRA, UDRE
rjmp USART_Transmit

out UDR, r16
ret


USART_Receive:
sbis UCSRA, RXC
rjmp USART_Receive

in r16, UDR
ret

jmp PC


send_0:
cbi PORTB, 0
call wait_17us
ret

send_1:
sbi PORTB, 0
call wait_17us
ret

wait_17us:
ldi  r18, 39

Loop: 
dec  r18
brne Loop

ret


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

