/*Zadanie domowe 2: Napisz podprogram wysy³ania do terminala wartoœci zapisanej w rejestrze 
8-bitowym na postaæ heksadecymaln¹ (znaki ASCII), czyli np. wartoœæ 0xFF 
powinna zostaæ wyœwietlana w terminalu jako FF (odpowiednie znaki ASCII). 
*/
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
//Ustawienie portu A jako wyjŒcie
ldi r16, 0xFF
out DDRA, r16
//Ustawienie parametrów UART'a
ldi r16, 25
out UBRRL, r16
ldi r16, 0
out UBRRH, r16

//Uaktywnienie nadajnika (Enable transmitter)
ldi r16, (1<<RXCIE) | (1<<TXEN) | (1<<RXEN)
out UCSRB,r16
//Format ramki (Set frame format): 8data, 1stop bit
ldi r16, (1<<URSEL) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0)
out UCSRC, r16

jmp MAIN

MAIN:
ldi r18, 0xAB //DANE 1010'1011
mov r19, r18
ldi r20, 0b11110000//maska do oddzeilenia 4 starszych bitów
and r19, r20

ror r19
ror r19
ror r19
ror r19
//r19 ma starsz¹ czêœæ danych (A)


call SEND_DATA

mov r19, r18
ldi r20, 0b00001111//maska do oddzeilenia 4 m³odszych  bitów
and r19, r20
//r19 ma m³odsz¹ czêœæ danych (B)

call SEND_DATA

jmp PC

.org 0x0100

SEND_DATA:
jmp DETECT_CHAR

SEND_END:
ret

//ZNAKI HEXA:
DETECT_CHAR:
ldi r16, '0'
cpi r19, 0 
breq send
ldi r16, '1'
cpi r19, 1 
breq send
ldi r16, '2'
cpi r19, 2 
breq send
ldi r16, '3'
cpi r19, 3 
breq send
ldi r16, '4'
cpi r19, 4 
breq send
ldi r16, '5'
cpi r19, 5 
breq send
ldi r16, '6'
cpi r19, 6 
breq send
ldi r16, '7'
cpi r19, 7 
breq send
ldi r16, '8'
cpi r19, 8 
breq send
ldi r16, '9'
cpi r19, 9 
breq send
ldi r16, 'A'
cpi r19, 10 
breq send
ldi r16, 'B'
cpi r19, 11
breq send
ldi r16, 'C'
cpi r19, 12
breq send
ldi r16, 'D'
cpi r19, 13
breq send
ldi r16, 'E'
cpi r19, 14 
breq send
ldi r16, 'F'
cpi r19, 15
breq send


jmp SEND_END

send:
call USART_Transmit
jmp SEND_END

USART_Transmit:
sbis UCSRA, UDRE
rjmp USART_Transmit
out UDR, r16

ret
