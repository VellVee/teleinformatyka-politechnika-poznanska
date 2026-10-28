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
out DDRA, r16

ldi r17, 26
out UBRRL, r17
ldi r16, 0
out UBRRH, r16

ldi r16, (1<<RXEN)|(1<<TXEN)
out UCSRB, r16

ldi r16, (1<<URSEL)|(0<<USBS)|(1<<UCSZ1)|(1<<UCSZ0)
out UCSRC, r16

//PD1 UART wbudowany

MAIN:
/*
ldi r16, 0x4b
call USART_Transmit
ldi r16, 0x41
call USART_Transmit
ldi r16, 0x4d
call USART_Transmit
ldi r16, 0x49
call USART_Transmit
ldi r16, 0x4c
call USART_Transmit
ldi r16, 0x4a
call USART_Transmit
ldi r16, 0x41
call USART_Transmit
ldi r16, 0x4d
call USART_Transmit
ldi r16, 0x4b
call USART_Transmit
ldi r16, 0x41

*/

call USART_Receive
call USART_Transmit

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