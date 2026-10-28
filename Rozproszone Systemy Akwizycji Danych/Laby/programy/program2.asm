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

;port A jako wyjście do prezentacji danych
ldi r16, 0xFF
out DDRA, r16
// ustawienie parametrów UART
; zapisujemy rejestr UBRR
ldi r16, 26 ; dla 8MHz 9600
out UBRRL, r16
ldi r16, 0
out UBRRH, r16
; uaktywnienie nadajnika (Enable transmitter)
ldi r16, 1<<TXEN // (1<<RXEN)
out UCSRB,r16
; format ramki (Set frame format): 8data, 1stop bit
ldi r16, (1<<URSEL)|(0<<USBS)|(1<<UCSZ1)|(1<<UCSZ0)
out UCSRC,r16

MAIN:
ldi r16, 0x4b
call USART_Transmit
call wait_1s

ldi r16, 0x41
call USART_Transmit
call wait_1s

ldi r16, 0x4d
call USART_Transmit
call wait_1s

ldi r16, 0x49
call USART_Transmit
call wait_1s

ldi r16, 0x4c
call USART_Transmit
call wait_1s

ldi r16, 0x4a
call USART_Transmit
call wait_1s

ldi r16, 0x41
call USART_Transmit
call wait_1s

ldi r16, 0x4d
call USART_Transmit
call wait_1s

ldi r16, 0x4b
call USART_Transmit
call wait_1s

ldi r16, 0x41
call USART_Transmit
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

USART_Transmit:
; Wait for empty transmit buffer
sbis UCSRA,UDRE
rjmp USART_Transmit
; Put data (r16) into buffer, sends the data
;ldi r16, 0x4b
out UDR,r16
ret
USART_Receive:
; Wait for data to be received
sbis UCSRA, RXC
rjmp USART_Receive
; Get and return received data from buffer
in r16, UDR
ret
