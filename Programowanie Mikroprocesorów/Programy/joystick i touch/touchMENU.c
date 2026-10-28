#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include "inc/hw_memmap.h" //Memory mapping of the used device (maps all the pins ports etc. to specific numbers)
#include "driverlib/fpu.h" //Routines for manipulating the floating-point unit in the Cortex-M processor.
#include "driverlib/sysctl.h" //Driver for the system controller
#include "driverlib/rom.h"		//Macros to facilitate calling functions in the ROM
#include "driverlib/pin_map.h" //Mapping of peripherals to pins for all parts
#include "driverlib/uart.h" 	// Driver for the UART
#include "grlib/grlib.h"	//Prototypes for the low level primitives provided by the graphics library
#include "drivers/ili9341_240x320x262K.h" //Display driver for the MULTI-INNO TECHNOLOGY
										// MI0283QT-9 TFT display with an ILI9341 controller.
#include "utils/uartstdio.h"		//Prototypes for the UART console functions.
#include "inc/hw_types.h"
#include "inc/hw_gpio.h"
#include "driverlib/gpio.h"
#include "driverlib/systick.h"
#include "drivers/touch.h"

#define GPIO_PINS_ALL GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7

//****************************************************************************
// Global system tick counter holds elapsed time since the application started
// expressed in 100ths of a second.
//*****************************************************************************
volatile uint32_t g_ui32SysTickCount;

int_fast32_t i32CenterX, i32CenterY;
//int i32CenterX_temp = 100;
//int i32CenterY_temp = 100;
tContext sContext;

//*****************************************************************************
// This is the interrupt handler for the SysTick interrupt.  It is used to
// update our local tick count which, in turn, is used to check for transmit
// timeouts.
//*****************************************************************************
void
SysTickIntHandler(void)
{
    g_ui32SysTickCount++;
}

//*****************************************************************************
//
//! Callback for calibration process
//!
//! \param X - x coordinate of point to check
//! \param Y - y coordinate of point to check
//! \param cX - x coordinate of circle center
//! \param cY - y coordinate of circle center
//! \param radius - circle radius
//!
//! \return boolean true if coordinates are within circle
//
//*****************************************************************************
inline bool IsInCircle(int32_t X,int32_t Y,int32_t cX,int32_t cY,int32_t radius)
{
	return ( (X-cX)*(X-cX) + (Y-cY)*(Y-cY) < (radius*radius) );
}



//*****************************************************************************
//
//! Callback for calibration process
//! \param ulMessage is type of event
//! \param lX is a x location of touch
//! \param lY is a y location of cross center
//!
//! \return None.
//
//*****************************************************************************

int32_t TouchCallback(uint32_t ulMessage, int32_t lX, int32_t lY)
{
//	i32CenterX = lX;
//	i32CenterY = lY;

	tRectangle sRect;
	sRect.i16XMin = 0;
	sRect.i16YMin = 0;
	sRect.i16XMax = 320;
	sRect.i16YMax = 240;
	GrContextForegroundSet(&sContext, ClrWhite);
	GrRectFill(&sContext, &sRect);

	char fullText[30];
	//GrContextForegroundSet(&sContext, ClrWhite);
	sprintf(fullText,"Pressed %d %d",i32CenterX, i32CenterY);


	GrStringDrawCentered(&sContext, fullText, -1, 50, 50, 0);


	GrContextForegroundSet(&sContext, ClrGreen);
	sprintf(fullText,"Pressed %d %d",lX, lY);

	i32CenterX = lX;		//ustaw 1X i 1Y jako wpolrzedne klikniecia
	i32CenterY = lY;

	GrStringDrawCentered(&sContext, fullText, -1, lX, lY, 0);
	return 0;
}

int color = ClrBlack;

int32_t initMenu(uint32_t ulMessage, int32_t lX, int32_t lY)
{
	int32_t size = 5;	//wielkosc pedzla

	int32_t icon_size_x = 50;	//ustawienia ikon menu
	int32_t icon_size_y = 50;
	int32_t margin_left = 10;
	
	//przycisk koloru czarnego
	tRectangle blackR;
	blackR.i16XMin = 50;
	blackR.i16YMin = 90;
	blackR.i16XMax = 150;
	blackR.i16YMax = 40;
	GrContextForegroundSet(&sContext, ClrBlack);
	GrRectFill(&sContext, &blackR);
	
	//przycisk koloru czerwonego
	tRectangle redR;
	redR.i16XMin = 180;
	redR.i16YMin = 90;
	redR.i16XMax = 280;
	redR.i16YMax = 40;
	GrContextForegroundSet(&sContext, ClrRed);
	GrRectFill(&sContext, &redR);
	
	//przycisk koloru zielonego
	tRectangle greenR;
	greenR.i16XMin = 50;
	greenR.i16YMin = 190;
	greenR.i16XMax = 150;
	greenR.i16YMax = 140;
	GrContextForegroundSet(&sContext, ClrGreen);
	GrRectFill(&sContext, &greenR);
	
	//przycisk koloru niebieskiego
	tRectangle blueR;
	blueR.i16XMin = 180;
	blueR.i16YMin = 190;
	blueR.i16XMax = 280;
	blueR.i16YMax = 140;
	GrContextForegroundSet(&sContext, ClrBlue);
	GrRectFill(&sContext, &blueR);
	
	if (lX>=blackR.i16XMin && lX<blackR.i16XMax && lY>=blackR.i16YMin && lY<blackR.i16YMax) {
		GrContextForegroundSet(&sContext, ClrYellow);
		GrRectFill(&sContext, &blackR);
		
	}	else if (lX>=redR.i16XMin && lX<redR.i16XMax && lY>=redR.i16YMin && lY<redR.i16YMax) {
		
		
	}	else if (lX>=greenR.i16XMin && lX<greenR.i16XMax && lY>=greenR.i16YMin && lY<greenR.i16YMax) {
		
		
	}	else if (lX>=blueR.i16XMin && lX<blueR.i16XMax && lY>=blueR.i16YMin && lY<blueR.i16YMax) {
		
		
	}

	i32CenterX = lX;
	i32CenterY = lY;
	return 0;
}

main(void)
{
    // Enable lazy stacking for interrupt handlers.  This allows floating-point instructions to be used within interrupt handlers, but at the expense of extra stack usage.
    ROM_FPULazyStackingEnable();
    // Set the clocking to run directly from the crystal.
    ROM_SysCtlClockSet(SYSCTL_SYSDIV_2_5 | SYSCTL_USE_PLL | SYSCTL_OSC_MAIN | SYSCTL_XTAL_8MHZ);
    // Initialize the display driver.
    ILI9341_240x320x262K_Init();
    // Initialize the graphics context.
    GrContextInit(&sContext, &g_sILI9341_240x320x262K);
    // Initialize touchscreen driver
    TouchScreenInit();
    TouchScreenCalibrate(&sContext);
    TouchScreenCallbackSet(initMenu);	//inicjalizacja painta

    //GrContextFontSet(&sContext, g_psFontCm12);

    while(1){}	//petla koncowa
}
