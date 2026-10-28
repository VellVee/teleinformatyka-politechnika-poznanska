	//*****************************************************************************
	// hello.c - Simple hello world example.
	//
	// Maciej Kucia July 2013
	//
	// This is part of revision 1.0 of the EK-LM4F232 Firmware Package.
	//*****************************************************************************

	#include <stdint.h>
	#include <stdbool.h>
	#include "inc/hw_memmap.h"
	#include "driverlib/fpu.h"
	#include "driverlib/sysctl.h"
	#include "driverlib/rom.h"
	#include "driverlib/pin_map.h"
	#include "driverlib/uart.h"
	#include "grlib/grlib.h"
	#include "drivers/ili9341_240x320x262K.h"
	#include "utils/uartstdio.h"
	#include "driverlib/gpio.h"

	extern const uint8_t g_pui8Image[];

	int main(void)
	{
	tContext sContext;
	tRectangle sRect;
	//
	// Enable lazy stacking for interrupt handlers. This allows floating-point
	// instructions to be used within interrupt handlers, but at the expense of
	// extra stack usage.
	//
	ROM_FPULazyStackingEnable();
	//
	// Set the clocking to run directly from the crystal.
	//
	ROM_SysCtlClockSet(SYSCTL_SYSDIV_4 | SYSCTL_USE_PLL | SYSCTL_XTAL_16MHZ |
SYSCTL_OSC_MAIN);

	//
	// Initialize the display driver.
	//
	ILI9341_240x320x262K_Init();
	//
	// Initialize the graphics context.
	//
	GrContextInit(&sContext, &g_sILI9341_240x320x262K);
	//
	// Print some text
	//

	GrContextBackgroundSet(&sContext, ClrWhite);

	//
	// Wgraj trojkat
	//

	GrImageDraw(&sContext, g_pui8Image, 0, 0);

	//
	// Flush any cached drawing operations.
	//
	GrFlush(&sContext);

	//
	// We are finished. Hang around doing nothing.
	//
	while(1)
	{
	}
}
