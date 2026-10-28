/*Zadanie domowe 1: Napisz program dla podsystemu SLAVE 
odbioru danych przez SPI z obs³ug¹ przerwania od odebranego
 znaku i wysy³ania do terminala przez UART. 
*/
.nolist
.include "m16def.inc"
.list
.listmac
.device ATmega16

.cseg
.org 0x0000
jmp START

.org 0x0014
jmp SPI_SLAVE

.org 0x0030

START:
ldi r16, LOW(RAMEND)
out SPL, r16
ldi r17, HIGH(RAMEND)
out SPH, r17
//Ustawienie portu A jako wyjocie
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

//Ustawienie SCK, MOSI, SS jako wejœcia
ldi r16, (0<<DDB7)|(0<<DDB5)|(0<<DDB4)

out PORTB, r16
//SPI jako SLAVE
ldi r16, (1<<SPIE)|(1<<SPE)|(0<<MSTR)|(1<<SPR0)
out SPCR, r16


sei //W³¹czenie przerwañ

jmp MAIN

MAIN:
nop
nop
nop

jmp MAIN 

.org 0x0100

SPI_SLAVE:
sbis SPSR, SPIF
rjmp SPI_SLAVE
in r16, SPDR
call USART_Transmit
reti

USART_Transmit:
sbis UCSRA, UDRE
rjmp USART_Transmit
out UDR, r16

ret

