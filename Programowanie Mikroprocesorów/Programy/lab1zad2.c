#include <stdint.h>
#include <stdbool.h>
#include "inc/hw_gpio.h"
#include "inc/hw_memmap.h"
#include "driverlib/sysctl.h"
#include "driverlib/gpio.h"
#include "driverlib/rom.h"
#define GPIO_PINS_ALL GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7
int main(void)
{
uint8_t jot = 0;
uint8_t aa = 0;
uint16_t be = 1;
//
// Set the clocking to run directly from the crystal.
//
ROM_SysCtlClockSet (SYSCTL_SYSDIV_5 | SYSCTL_USE_PLL | SYSCTL_OSC_MAIN | SYSCTL_XTAL_8MHZ);
//
// Enable all
//
SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOA);
SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOB);
SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOC);
SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOD);
SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOE);
SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOF);
SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOG);
SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOH);
SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOJ);
//
// Set pins as outputs
//
GPIOPinTypeGPIOOutput(GPIO_PORTA_BASE, GPIO_PINS_ALL);
GPIOPinTypeGPIOOutput(GPIO_PORTB_BASE, GPIO_PINS_ALL);
GPIOPinTypeGPIOOutput(GPIO_PORTC_BASE, GPIO_PINS_ALL);
GPIOPinTypeGPIOOutput(GPIO_PORTD_BASE, GPIO_PINS_ALL);
GPIOPinTypeGPIOOutput(GPIO_PORTE_BASE, GPIO_PINS_ALL);
GPIOPinTypeGPIOOutput(GPIO_PORTF_BASE, GPIO_PINS_ALL);
GPIOPinTypeGPIOOutput(GPIO_PORTG_BASE, GPIO_PINS_ALL);
//
// Set all GPIOJ pins as inputs
//
GPIOPinTypeGPIOInput(GPIO_PORTJ_BASE, GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3);
for (;;)
{
while(GPIOPinRead(GPIO_PORTJ_BASE,GPIO_PIN_0) == GPIO_PIN_0){
jot=0;
aa=0;}
while(GPIOPinRead(GPIO_PORTJ_BASE,GPIO_PIN_1) == GPIO_PIN_1){
jot=1;
aa=0;}
while(GPIOPinRead(GPIO_PORTJ_BASE,GPIO_PIN_2) == GPIO_PIN_2){
jot=2;
aa=0;}
while(GPIOPinRead(GPIO_PORTJ_BASE,GPIO_PIN_3) == GPIO_PIN_3){
jot=3;
be=1;}

switch(jot){
case 0:{
GPIOPinWrite (GPIO_PORTA_BASE, 0xFF, 0);
GPIOPinWrite (GPIO_PORTB_BASE, 0xFF, 0);
GPIOPinWrite (GPIO_PORTC_BASE, 0xFF, 0);
GPIOPinWrite (GPIO_PORTD_BASE, 0xFF, 0);
GPIOPinWrite (GPIO_PORTE_BASE, 0xFF, 0);
GPIOPinWrite (GPIO_PORTF_BASE, 0xFF, 0);
GPIOPinWrite (GPIO_PORTG_BASE, 0xFF, 0);
GPIOPinWrite (GPIO_PORTH_BASE, 0xFF, 0);}
break;

case 1:{
GPIOPinWrite (GPIO_PORTA_BASE, 0xFF, ++aa);
GPIOPinWrite (GPIO_PORTB_BASE, 0xFF, aa);
GPIOPinWrite (GPIO_PORTC_BASE, 0xFF, aa);
GPIOPinWrite (GPIO_PORTD_BASE, 0xFF, aa);
GPIOPinWrite (GPIO_PORTE_BASE, 0xFF, aa);
GPIOPinWrite (GPIO_PORTF_BASE, 0xFF, aa);
GPIOPinWrite (GPIO_PORTG_BASE, 0xFF, aa);
GPIOPinWrite (GPIO_PORTH_BASE, 0xFF, aa);}
break;

case 2:{
GPIOPinWrite (GPIO_PORTA_BASE, 0xFF, ++aa%5);
GPIOPinWrite (GPIO_PORTB_BASE, 0xFF, aa%5);
GPIOPinWrite (GPIO_PORTC_BASE, 0xFF, aa%5);
GPIOPinWrite (GPIO_PORTD_BASE, 0xFF, aa%5);
GPIOPinWrite (GPIO_PORTE_BASE, 0xFF, aa%5);
GPIOPinWrite (GPIO_PORTF_BASE, 0xFF, aa%5);
GPIOPinWrite (GPIO_PORTG_BASE, 0xFF, aa%5);
GPIOPinWrite (GPIO_PORTH_BASE, 0xFF, aa%5);
aa++;}
break;

case 3:{
GPIOPinWrite (GPIO_PORTA_BASE, 0xFF, be);
GPIOPinWrite (GPIO_PORTB_BASE, 0xFF, be);
GPIOPinWrite (GPIO_PORTC_BASE, 0xFF, be);
GPIOPinWrite (GPIO_PORTD_BASE, 0xFF, be);
GPIOPinWrite (GPIO_PORTE_BASE, 0xFF, be);
GPIOPinWrite (GPIO_PORTF_BASE, 0xFF, be);
GPIOPinWrite (GPIO_PORTG_BASE, 0xFF, be);
GPIOPinWrite (GPIO_PORTH_BASE, 0xFF, be);
be=be*2;
if(be==256) 
be=1;
}
}
SysCtlDelay(SysCtlClockGet()/2);
}
return 0;
}