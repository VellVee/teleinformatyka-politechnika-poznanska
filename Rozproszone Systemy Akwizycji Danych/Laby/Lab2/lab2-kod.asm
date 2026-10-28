.nolist // komentarz
.include "m16def.inc" ; komentarz
.list
.listmac
.device ATmega16
.cseg
.org 0x0000
jmp 0x0030 ;skok do adresu 0x0030
// jmp START
// wektory przerwań
.org 0x0030
START:
//ustawienie stosu
ldi r16,LOW(RAMEND)
out SPL, r16
ldi r17,HIGH(RAMEND)
out SPH, r17

ldi r16, 0b00000001
out DDRB, r16//ustawia jedną linie PORTU B jako wyjście

ldi r16, 0b11111111
out DDRA, r16

// ustawienie parametrów UART
; zapisujemy rejestr UBRR
ldi r16, 25; dla 8MHz 9600
out UBRRL, r16
ldi r16, 0
out UBRRH, r16


; uaktywnienie nadajnika (Enable transmitter)
ldi r16, (1<<TXEN )|(1<<RXEN)// 1 zostaje przesuniety w lewo o tyle pozycji TXEN 
out UCSRB,r16


; format ramki (Set frame format): 8data, 1stop bit
ldi r16, (1<<URSEL)|(0<<USBS)|(1<<UCSZ1)|(1<<UCSZ0)
out UCSRC,r16
// dalsza część programu ...




MAIN:
/*to jak sam nadajnik
ldi r16, 'R'
call USART_Transmit
out PORTA,r16
CALL wait_1s

ldi r16, 'S'
call USART_Transmit
out PORTA,r16
CALL wait_1s

ldi r16, 'A'
call USART_Transmit
out PORTA,r16
CALL wait_1s

ldi r16, 'D'
call USART_Transmit
out PORTA,r16
CALL wait_1s*/

/*nadajnik i odbiornik>>>>>>>>>>>>>>>>>>>>>>*/
//odbierzemy dane:
call USART_Receive
out PORTA, r16
//odebrane dane wysyłamy z powrotem: // jezu emilia "spowrotem" serio  XDD
;call USART_Transmit
call send_ASCII
;call wait_1s

//


jmp MAIN


jmp PC
//---koniec głównego programu---
// --- podprogram ----------------------------------------------------------------------------------
.org 0x0100

send_0://na PB0 wysyłamy 0
cbi PORTB, 0//ustawia 0 na wybranej linii portu I/O (na bicie nr.0)
call wait_104us//symbol musi trwac 104us
ret
//--------------------------------------------------------------------------------------------------

send_1://na PB0 wysyłamy 1
sbi PORTB, 0//ustawia 1 na wybranej linii portu I/O (na bicie nr.0)
call wait_104us
ret
//-------------------------------------------------------------------------------------------------
wait_104us://wnętrze podprogramu musi zająć 102us (104-call-ret)

push r16 //wsadza na stos zeby nie nadpisac
ldi r16, 129 //wykonanie instrukcji ldi trwa 0.25 us
Loop_Count://wnętrze tej pętli musi trwać 101.75us(102-0.25)
dec r16//wykonanie instrukcji dec trwa 0.25 us
brne Loop_Count/*wykonanie instrukcji brne trwa 0.50 us (lub 0.25 w przypadku Z=0)*/
pop r16
ret
//-------------------------------------------------------------------------------------------------
test_C://testuje czy dany bit jest 0 czy 1
ror r16//przesuwamy najmłodszy bit rejestru r16 do rejestru C
brcc ZERO /*jeśli C jest 0 skacze do etykiety ZERO, jeśli C jest 1 to pomija instrukcję i  wykonuje kolejną poniższą*/
call send_1
ret
//-------------------------------------------------------------------------------------------------
ZERO:
call send_0
ret

//-------------------------------------------------------------------------------------------------
wait_1s:
ldi  r18, 41
ldi  r19, 150
ldi  r20, 128
L1: dec  r20
brne L1
dec  r19
brne L1
dec  r18
brne L1
ret
//-------------------------------------------------------------------------------------------------



send_ASCII:

//ramka-wysyła najpierw bit startu (0):
call send_0
//wysyla na port B 8 bitów danych
call test_C//przechodzimy do wysłania pierwszego bitu
call test_C
call test_C
call test_C
call test_C
call test_C
call test_C
call test_C
//bit stopu-koniec transmisji(1):
call send_1

RET


// ----------------------------------------------
// podprogramy sprzętowego nadajnika i odbiornika
USART_Transmit:
; Wait for empty transmit buffer
sbis UCSRA,UDRE //JESLI udre JEST 1 TO pracuje w petli, jesli nie jest spelniony to wychodzimy z petli
rjmp USART_Transmit
; Put data (r16) into buffer, sends the data
; ldi r16, 0x31
out UDR,r16
ret

// -----------

USART_Receive:
; Wait for data to be received
sbis UCSRA, RXC
rjmp USART_Receive// rjump jest krótsza
; Get and return received data from buffer
in r16, UDR
ret
