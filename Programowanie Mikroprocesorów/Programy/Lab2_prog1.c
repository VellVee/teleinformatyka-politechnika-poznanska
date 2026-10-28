/*
main.c
*/
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
	uint8_t a = 0;
	//
	// Set the clocking to run directly from the crystal.
	//
	ROM_SysCtlClockSet (SYSCTL_SYSDIV_20 | SYSCTL_USE_PLL | SYSCTL_OSC_MAIN | SYSCTL_XTAL_8MHZ);
	//
	// Enable GPIOA, GPIOJ, GPIOC
	//
	SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOA);
	SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOJ);
	SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOC);
	//
	// Set all GPIOA and GPIOC pins as outputs
	//	
	GPIOPinTypeGPIOOutput(GPIO_PORTA_BASE, GPIO_PINS_ALL);
	GPIOPinTypeGPIOOutput(GPIO_PORTC_BASE, GPIO_PINS_ALL);
	//
	// Set all GPIOJ pins as inputs
	//
	GPIOPinTypeGPIOInput(GPIO_PORTJ_BASE, GPIO_PIN_6|GPIO_PIN_7);
	for (;;)
	{
		//
		// Check button press and write data to port
		//
		while(GPIOPinRead(GPIO_PORTJ_BASE,GPIO_PIN_7) == GPIO_PIN_7)
			GPIOPinWrite (GPIO_PORTC_BASE, GPIO_PIN_6|GPIO_PIN_7, 0x80);
		while(GPIOPinRead(GPIO_PORTJ_BASE,GPIO_PIN_6) == GPIO_PIN_6)
			GPIOPinWrite (GPIO_PORTC_BASE, GPIO_PIN_6|GPIO_PIN_7, 0x40);
		//
		// Show some patterns on LEDs
		//
		GPIOPinWrite (GPIO_PORTA_BASE, 0xFF, a++);
		//
		// Delay for a while so changes can be visible
		//
		SysCtlDelay(SysCtlClockGet() / 2);
	}
	return 0;
} 