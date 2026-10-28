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
uint8_t ha = 0;
uint8_t jot = 0;
//
// Set the clocking to run directly from the crystal.
//
ROM_SysCtlClockSet (SYSCTL_SYSDIV_5 | SYSCTL_USE_PLL | SYSCTL_OSC_MAIN | SYSCTL_XTAL_8MHZ);

// Enable GPIOA, GPIOJ, GPIOE
SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOA);
SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOJ);
SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOE);
SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOH);
SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOG);

// Set all GPIOA, GPIOE, GPIOG pins as outputs
GPIOPinTypeGPIOOutput(GPIO_PORTA_BASE, GPIO_PINS_ALL);
GPIOPinTypeGPIOOutput(GPIO_PORTE_BASE, GPIO_PINS_ALL);
GPIOPinTypeGPIOOutput(GPIO_PORTG_BASE, GPIO_PINS_ALL);

// Set all GPIOJ pins as inputs
GPIOPinTypeGPIOInput(GPIO_PORTH_BASE, GPIO_PIN_6|GPIO_PIN_7);
GPIOPinTypeGPIOInput(GPIO_PORTJ_BASE, GPIO_PIN_6|GPIO_PIN_7);

for (;;)
{
// Check button press and write data to port
while(GPIOPinRead(GPIO_PORTH_BASE,GPIO_PIN_7) == GPIO_PIN_7)
{
ha++;
SysCtlDelay(SysCtlClockGet()/2);
}

while(GPIOPinRead(GPIO_PORTJ_BASE,GPIO_PIN_7) == GPIO_PIN_7)
{
jot++;
SysCtlDelay(SysCtlClockGet()/2);
}

// Write data to port
GPIOPinWrite (GPIO_PORTA_BASE, 0xFF, ha);
GPIOPinWrite (GPIO_PORTE_BASE, 0xFF, jot);
GPIOPinWrite (GPIO_PORTG_BASE, 0xFF, ha-jot);

}
return 0;
}