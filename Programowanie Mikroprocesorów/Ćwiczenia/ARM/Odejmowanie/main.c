/*
 * main.c
 */
#include "stdint.h"
#include "stdbool.h"
#include "inc/hw_types.h"
#include "inc/hw_memmap.h"
#include "driverlib/sysctl.h"
#include "driverlib/gpio.h"
#include "driverlib/rom.h"

#define GPIO_PINS_ALL GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7


int main(void) {
	ROM_SysCtlClockSet (SYSCTL_SYSDIV_20 | SYSCTL_USE_PLL | SYSCTL_OSC_MAIN | SYSCTL_XTAL_8MHZ);

	SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOA);
	SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOE);
	SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOG);
	SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOH);
	SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOJ);

	GPIOPinTypeGPIOOutput(GPIO_PORTA_BASE, GPIO_PINS_ALL);
	GPIOPinTypeGPIOOutput(GPIO_PORTE_BASE, GPIO_PINS_ALL);
	GPIOPinTypeGPIOOutput(GPIO_PORTG_BASE, GPIO_PINS_ALL);
	GPIOPinTypeGPIOInput(GPIO_PORTH_BASE, GPIO_PINS_ALL);
	GPIOPinTypeGPIOInput(GPIO_PORTJ_BASE, GPIO_PINS_ALL);

	uint8_t a = 0;
	uint8_t e = 0;
	uint8_t g = 0;

	for(;;){
		uint8_t portH = GPIOPinRead(GPIO_PORTH_BASE, GPIO_PINS_ALL);
		if (portH > 0){
			GPIOPinWrite(GPIO_PORTA_BASE,0xFF, ++a);
		}
		uint8_t portJ = GPIOPinRead(GPIO_PORTJ_BASE, GPIO_PINS_ALL);
		if(portJ > 0) {
			GPIOPinWrite(GPIO_PORTE_BASE, 0xFF, ++e);
		}

		if ((a-e)>=0 && (a-e)<0xFF) {
			GPIOPinWrite(GPIO_PORTG_BASE, 0xFF, a-e);
		} else {
			GPIOPinWrite(GPIO_PORTG_BASE, 0xFF, 0x80+(e-a));
		}

		SysCtlDelay(SysCtlClockGet() / 2);
	}

	return 0;
}
