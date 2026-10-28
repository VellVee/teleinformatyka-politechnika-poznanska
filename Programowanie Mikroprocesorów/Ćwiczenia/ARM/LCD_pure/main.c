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

	//*****************************************************************************
	//
	// TI logo in array form (1 bit per pixel)
	//
	//*****************************************************************************
	const unsigned char TI_logo[(16*2)+5] = {
	IMAGE_FMT_1BPP_UNCOMP, 16,0, 16,0,
	0x0f,0xff,0x0f,0xff,0x0f,0xf3,0x0f,0xfa,0x0f,0x8f,0x0f,0x89,0x81,0x99,0x81,0x19,0x03,0x09,0x07,0x89,0x07,0xdf,0x3f,0xee,0x7f,0xf0,0xff,0xf8,0xff,0xf9,0xff,0xfb};
	//	1,1,1,1,0,0,0,0, 1,1,1,1,1,1,1,1,
	//	1,1,1,1,0,0,0,0, 1,1,1,1,1,1,1,1,
	//	1,1,1,1,0,0,0,0, 1,1,0,0,1,1,1,1,
	//	1,1,1,1,0,0,0,0, 0,1,0,1,1,1,1,1,
	//	1,1,1,1,0,0,0,0, 1,1,1,1,0,0,0,1,
	//	1,1,1,1,0,0,0,0, 1,0,0,1,0,0,0,1,
	//	1,0,0,0,0,0,0,1, 1,0,0,1,1,0,0,1,
	//	1,0,0,0,0,0,0,1, 1,0,0,1,1,0,0,0,
	//	1,1,0,0,0,0,0,0, 1,0,0,1,0,0,0,0,
	//	1,1,1,0,0,0,0,0, 1,0,0,1,0,0,0,1,
	//	1,1,1,0,0,0,0,0, 1,1,1,1,1,0,1,1,
	//	1,1,1,1,1,1,0,0, 0,1,1,1,0,1,1,1,
	//	1,1,1,1,1,1,1,0, 0,0,0,0,1,1,1,1,
	//	1,1,1,1,1,1,1,1, 0,0,0,1,1,1,1,1,
	//	1,1,1,1,1,1,1,1, 1,0,0,1,1,1,1,1,
	//	1,1,1,1,1,1,1,1, 1,1,0,1,1,1,1,1
	//*****************************************************************************
	//
	// Print some text to the display.
	//
	//***********************************************
	int
	main(void)
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
	GrContextFontSet(&sContext, g_psFontCm12);
	GrStringDrawCentered(&sContext, "Hello", -1,
GrContextDpyWidthGet(&sContext) / 2,
(GrContextDpyHeightGet(&sContext) / 2),
0);

	GrContextForegroundSet(&sContext, ClrCrimson);
	GrContextFontSet(&sContext, g_psFontCm20b);
	GrStringDrawCentered(&sContext, "EUP", -1,
GrContextDpyWidthGet(&sContext) / 2,
20 + (GrContextDpyHeightGet(&sContext) / 2),
0);


	unsigned long ii = 1;
	int x_min, x_max, y_min, y_max;
	//
	// Draw RGB rectangles
	//
	x_min = 20;
	x_max = 80;
	y_min = 20;
	y_max = 80;
	sRect.i16XMin = x_min;
	sRect.i16YMin = y_min;
	sRect.i16XMax = x_max;
	sRect.i16YMax = y_max;
	//	unsigned long temp_color = ColorTranslate(void *pvDisplayData, ii);
	GrContextForegroundSet(&sContext, ClrRed);
	GrRectFill(&sContext, &sRect);

	GrContextForegroundSet(&sContext, ClrBlack);
	GrContextFontSet(&sContext, g_psFontCm12);
	GrStringDrawCentered(&sContext, "Pole A", -1, x_min+(x_max-x_min)/2, y_min+(y_max-y_min)/2, 0);
	GrContextForegroundSet(&sContext, ClrCrimson);


	//-----------------------------------

	tRectangle rightUpRect;
	x_min = 240;
	x_max = 300;
	y_min = 20;
	y_max = 80;
	rightUpRect.i16XMin = x_min;
	rightUpRect.i16YMin = y_min;
	rightUpRect.i16XMax = x_max;
	rightUpRect.i16YMax = y_max;
	ii=ii+0.01;
	GrContextForegroundSet(&sContext, ClrGreen);
	GrRectFill(&sContext, &rightUpRect);

	GrContextForegroundSet(&sContext, ClrBlack);
	GrContextFontSet(&sContext, g_psFontCm12);
	GrStringDrawCentered(&sContext, "Pole B", -1, x_min+(x_max-x_min)/2, y_min+(y_max-y_min)/2, 0);
	GrContextForegroundSet(&sContext, ClrCrimson);


	//-----------------------------------

	tRectangle leftDown;
	x_min = 20;
	x_max = 80;
	y_min = 160;
	y_max = 220;
	leftDown.i16XMin = x_min;
	leftDown.i16YMin = y_min;
	leftDown.i16XMax = x_max;
	leftDown.i16YMax = y_max;
	ii=ii+0.01;
	GrContextForegroundSet(&sContext, ClrBlue);
	GrRectFill(&sContext, &leftDown);

	GrContextForegroundSet(&sContext, ClrBlack);
	GrContextFontSet(&sContext, g_psFontCm12);
	GrStringDrawCentered(&sContext, "Pole C", -1, x_min+(x_max-x_min)/2, y_min+(y_max-y_min)/2, 0);
	GrContextForegroundSet(&sContext, ClrCrimson);

	//-----------------------------------

	tRectangle rightDown;
	x_min = 240;
	x_max = 300;
	y_min = 160;
	y_max = 220;
	rightDown.i16XMin = x_min;
	rightDown.i16YMin = y_min;
	rightDown.i16XMax = x_max;
	rightDown.i16YMax = y_max;
	ii=ii+0.01;
	GrContextForegroundSet(&sContext, ClrYellow);
	GrRectFill(&sContext, &rightDown);

	GrContextForegroundSet(&sContext, ClrBlack);
	GrContextFontSet(&sContext, g_psFontCm12);
	GrStringDrawCentered(&sContext, "Pole D", -1, x_min+(x_max-x_min)/2, y_min+(y_max-y_min)/2, 0);
	GrContextForegroundSet(&sContext, ClrCrimson);
}

