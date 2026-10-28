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
	uint8_t port_val = 0;
	ROM_SysCtlClockSet (SYSCTL_SYSDIV_5 | SYSCTL_USE_PLL | SYSCTL_OSC_MAIN | SYSCTL_XTAL_8MHZ);
	//ustawienie zegara z wykorzystaniem wbudowanej w ROM mikrokontrolera funkcji

	//
	// Enable GPIOA
	//
	SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOA);
	//
	// Set all GPIOA pins as outputs
	//
	GPIOPinTypeGPIOOutput(GPIO_PORTA_BASE, GPIO_PINS_ALL);
	//
	// Show some patterns on LEDs
	//
	for (;;)
	{
		//
		// Write data to port
		//
		GPIOPinWrite (GPIO_PORTA_BASE, 0xFF, port_val++);
		//
		// Delay for a while so changes can be visible
		//
		SysCtlDelay(SysCtlClockGet() / 2);
	}
	return 0;
}
