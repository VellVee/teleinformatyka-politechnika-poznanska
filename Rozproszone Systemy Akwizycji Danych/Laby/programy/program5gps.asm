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

ldi r16, 0xFF
out DDRB, r16

ldi r17, 8
out UBRRL, r17
ldi r16, 0
out UBRRH, r16


; uaktywnienie nadajnika (Enable transmitter)
ldi r16, (1<<RXCIE)|(1<<TXEN)|(1<<RXEN)
out UCSRB,r16
; format ramki (Set frame format): 8data, 1stop bit
ldi r16, (1<<URSEL)|(0<<USBS)|(1<<UCSZ1)|(1<<UCSZ0)
out UCSRC,r16 

sei

//PD1 UART wbudowany

MAIN:

nop
nop
nop

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

RX_Complete:
in r16, UDR
call TEST_ZNAKU
reti




// podprogram testowania znaku i zapisu do RAM
// $GPGGA,183730 - fragment do wyodrębnienia
.org 0x0100
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
cpi r17, 6 // czy szukamy znaku na pozycji 5
breq Wykryj_Comma
cpi r17, 7 // czy szukamy znaku na pozycji 6
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
// rozpocznij konwersję ADC
//zapisz do RAM
Cyfra_01:
call send_ASCII
ret
Cyfra_02:
call send_ASCII
ldi r16, 58
call send_ASCII
ret
Cyfra_03:
call send_ASCII
ret
Cyfra_04:
call send_ASCII
ldi r16, 58
call send_ASCII
ret
Cyfra_05:
call send_ASCII
ret
Cyfra_06:
call send_ASCII
ldi r16, 0x0A
call send_ASCII
ldi r16, 0x0d
call send_ASCII
// odczytaj wynik ADC
ret
NIE_TEN_ZNAK:
ldi r17, 255 //r17 - licznik znaków
ret
