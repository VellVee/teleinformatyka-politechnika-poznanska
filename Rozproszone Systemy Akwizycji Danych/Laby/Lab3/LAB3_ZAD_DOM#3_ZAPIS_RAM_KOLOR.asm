/*Zadanie 3: Napisz podprogram wysy³ana zapisanych w RAM danych (czas i wartoœæ)
 przez UART do terminala. Stosuj¹c komendy ANSII ESC Code sterowania znakami 
 wyœwietlanymi zaprezentuj czas w kolorze zielonym, wynik w kolorze czerwonym
  (mo¿na wybraæ inne kolory): 
18:37:30 FF
18:37:31 FE 
18:37:32 CF 
... itd 
Zastosuj znaki steruj¹ce przejœciem do nastêpnej linii i powrotem na 
pocz¹tek nowej linii. Podczas symulacji odczytu pamiêci mo¿na "rêcznie" wpisaæ dane do RAM.
*/
.nolist
.include "m16def.inc"
.list
.listmac
.device ATmega16

.cseg
.org 0x0000
jmp START

.org 0x0016
jmp RX_Complete

.org 0x0030

START:
ldi r16, LOW(RAMEND)
out SPL, r16
ldi r17, HIGH(RAMEND)
out SPH, r17

ldi Xh, 0
ldi Xl, 0
ldi Yh, 0
ldi Yl, 0

//Ustawienie portu A jako wyjœcie
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

ldi r17,255

sei

jmp MAIN

MAIN:

jmp PC

.org 0x0100

USART_Transmit:
sbis UCSRA, UDRE
rjmp USART_Transmit
out UDR, r16

ret

RX_Complete:
in r16, UDR
call TEST_ZNAKU
cpi r17, 12
breq send_data
reti

send_data:
//zielony  \e[32m
ldi r16, 92 	//\
call USART_Transmit
ldi r16, 101 	//e
call USART_Transmit
ldi r16, 91 	//[
call USART_Transmit
ldi r16, 51 	//3
call USART_Transmit
ldi r16, 50 	//2
call USART_Transmit
ldi r16, 109 	//m
call USART_Transmit

//czas

ldi Xl, 0

ld r16, X+
call USART_Transmit
ld r16, X+
call USART_Transmit

ldi r16, 58		//:
call USART_Transmit

ld r16, X+
call USART_Transmit
ld r16, X+
call USART_Transmit

ldi r16, 58 	//:
call USART_Transmit

ld r16, X+
call USART_Transmit
ld r16, X+
call USART_Transmit

ldi r16, 32		//spacja
call USART_Transmit

//czerwony \e[31m
ldi r16, 92 	//\
call USART_Transmit
ldi r16, 101 	//e
call USART_Transmit
ldi r16, 91 	//[
call USART_Transmit
ldi r16, 51 	//3
call USART_Transmit
ldi r16, 49 	//1
call USART_Transmit
ldi r16, 109 	//m
call USART_Transmit

//RAM Dane
ld r18, Y+
mov r19, r18
ldi r20, 0b11110000
and r18, r20

ror r19
ror r19
ror r19
ror r19

call SEND_RAW

mov r19, r18
ldi r20, 0b00001111
and r19, r20

call SEND_RAW

//konec linii
ldi r16, 10 	//LF
call USART_Transmit
reti

SEND_RAW:
jmp DETECT_CHAR
SEND_END:
ret

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

TEST_ZNAKU:
inc r17 // licznik znaków
cpi r17, 0 // czy szukamy znaku na pozycji 0
breq Wykryj_Dollar
cpi r17, 1 // czy szukamy znaku na pozycji 1
breq Wykryj_G
cpi r17, 2 // czy szukamy znaku na pozycji 2
breq Wykryj_P
cpi r17, 3 // czy szukamy znaku na pozycji 3
breq Wykryj_G
cpi r17, 4 // czy szukamy znaku na pozycji 4
breq Wykryj_G
cpi r17, 5 // czy szukamy znaku na pozycji 5
breq Wykryj_A
cpi r17, 6 // czy szukamy znaku na pozycji 6
breq Wykryj_Comma
cpi r17, 7 // czy szukamy znaku na pozycji 7
breq Cyfra_01
cpi r17, 8
breq Cyfra_02
cpi r17, 9
breq Cyfra_03
cpi r17, 10
breq Cyfra_04
cpi r17, 11
breq Cyfra_05
cpi r17, 12
breq Cyfra_06
ret

Wykryj_Dollar:
cpi r16, '$'
brne NIE_TEN_ZNAK
ret
Wykryj_G:
cpi r16, 'G'
brne NIE_TEN_ZNAK
ret
Wykryj_P:
cpi r16, 'P'
brne NIE_TEN_ZNAK
ret
Wykryj_A:
cpi r16, 'A'
brne NIE_TEN_ZNAK
ret
Wykryj_Comma:
cpi r16, ','
brne NIE_TEN_ZNAK
ret
//zapisz do RAM
Cyfra_01:
st X+, r16
ret
Cyfra_02:
st X+, r16
ret
Cyfra_03:
st X+, r16
ret
Cyfra_04:
st X+, r16
ret
Cyfra_05:
st X+, r16
ret
Cyfra_06:
st X+, r16
ret

NIE_TEN_ZNAK:
ldi r17, 255 //r17 - licznik znaków
ret
