#include <stdint.h>
#include <stdbool.h>
#include "inc/hw_memmap.h"
#include "driverlib/fpu.h"
#include "driverlib/sysctl.h"
#include "driverlib/rom.h"
#include "driverlib/pin_map.h"
#include "driverlib/uart.h"
#include "grlib/grlib.h"
#include "utils/uartstdio.h"
#include "driverlib/gpio.h"
#include "drivers/ili9341_240x320x262K.h"

#define GPIO_PINS_ALL GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7

int main(void)
{
	tContext sContext;
	tRectangle sRect;
	tRectangle sRect2;
	ROM_FPULazyStackingEnable();
	ROM_SysCtlClockSet(SYSCTL_SYSDIV_4 | SYSCTL_USE_PLL | SYSCTL_XTAL_16MHZ | SYSCTL_OSC_MAIN);
	ILI9341_240x320x262K_Init();
	GrContextInit(&sContext, &g_sILI9341_240x320x262K);

    SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOA);
    SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOB);
    SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOC);
    SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOD);
    SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOE);
    SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOF);
    SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOG);
    SysCtlPeripheralEnable (SYSCTL_PERIPH_GPIOJ);
	
    GPIOPinTypeGPIOInput(GPIO_PORTA_BASE, GPIO_PINS_ALL);
	GPIOPinTypeGPIOInput(GPIO_PORTB_BASE, GPIO_PINS_ALL);
    GPIOPinTypeGPIOInput(GPIO_PORTC_BASE, GPIO_PINS_ALL);
    GPIOPinTypeGPIOInput(GPIO_PORTD_BASE, GPIO_PINS_ALL);
	GPIOPinTypeGPIOInput(GPIO_PORTE_BASE, GPIO_PINS_ALL);
	GPIOPinTypeGPIOInput(GPIO_PORTF_BASE, GPIO_PINS_ALL);
	GPIOPinTypeGPIOInput(GPIO_PORTG_BASE, GPIO_PINS_ALL);
    GPIOPinTypeGPIOInput(GPIO_PORTJ_BASE, GPIO_PINS_ALL);


    GrContextFontSet(&sContext,g_psFontCm16b);
    GrContextForegroundSet(&sContext, ClrBlue);
    int czy_gora = 0;
    int czy_dol = 0;
    int czy_enter = 0;
    int wybrany = 1;

    while(1){

        czy_dol = GPIOPinRead(GPIO_PORTE_BASE,GPIO_PIN_5);
        czy_gora = GPIOPinRead(GPIO_PORTB_BASE,GPIO_PIN_0);
        czy_enter = GPIOPinRead(GPIO_PORTA_BASE,GPIO_PIN_0);

            if(czy_gora != 0){
                if(wybrany != 1){
                    wybrany--;
                }
            }

            if(czy_dol != 0){
                if(wybrany != 4){
                    wybrany++;
                }
            }

            sRect.i16XMin = 0;
            sRect.i16YMin = 0;
            sRect.i16XMax = 500;
            sRect.i16YMax = 500;
            GrContextForegroundSet(&sContext, ClrWhite);
            GrRectFill(&sContext, &sRect);                  //czysc ekran

            sRect.i16XMin = 50;
            sRect.i16YMin = 90;
            sRect.i16XMax = 150;
            sRect.i16YMax = 40;
            GrContextForegroundSet(&sContext, ClrYellow);
            GrRectFill(&sContext, &sRect);

            sRect.i16XMin = 180;
            sRect.i16YMin = 90;
            sRect.i16XMax = 280;
            sRect.i16YMax = 40;
            GrContextForegroundSet(&sContext, ClrBlue);
            GrRectFill(&sContext, &sRect);

            sRect.i16XMin = 50;
            sRect.i16YMin = 190;
            sRect.i16XMax = 150;
            sRect.i16YMax = 140;
            GrContextForegroundSet(&sContext, ClrGreen);
            GrRectFill(&sContext, &sRect);

            sRect.i16XMin = 180;
            sRect.i16YMin = 190;
            sRect.i16XMax = 280;
            sRect.i16YMax = 140;
            GrContextForegroundSet(&sContext, ClrBlack);
            GrRectFill(&sContext, &sRect);

        switch(wybrany)
        {
            case 1:{ 
                sRect.i16XMin = 50;
                sRect.i16YMin = 90;
                sRect.i16XMax = 150;
                sRect.i16YMax = 40;
                GrContextForegroundSet(&sContext, ClrRed);
                GrRectFill(&sContext, &sRect);
            }break;

            case 2:{ 
                sRect.i16XMin = 180;
                sRect.i16YMin = 90;
                sRect.i16XMax = 280;
                sRect.i16YMax = 40;
                GrContextForegroundSet(&sContext, ClrRed);
                GrRectFill(&sContext, &sRect);               
            }break;

            case 3:{ 
                sRect.i16XMin = 50;
                sRect.i16YMin = 190;
                sRect.i16XMax = 150;
                sRect.i16YMax = 140;
                GrContextForegroundSet(&sContext, ClrRed);
                GrRectFill(&sContext, &sRect);
            }break;

            case 4:{ 
                sRect.i16XMin = 180;
                sRect.i16YMin = 190;
                sRect.i16XMax = 280;
                sRect.i16YMax = 140;
                GrContextForegroundSet(&sContext, ClrRed);
                GrRectFill(&sContext, &sRect);
            }break;
        }

        
        if(czy_enter!=0){
            switch(wybrany)
        {
            case 1:{ 
                sRect.i16XMin = 0;
                sRect.i16YMin = 0;
                sRect.i16XMax = 500;
                sRect.i16YMax = 500;
                GrContextForegroundSet(&sContext, ClrWhite);
                GrRectFill(&sContext, &sRect);

                GrContextForegroundSet(&sContext, ClrGreen);
	            GrContextFontSet(&sContext, g_psFontCm20i);
	            GrStringDrawCentered(&sContext, "Procedura 1", -1, 160 , 100, 0);

                goto w8naEnter;
            }break;

            case 2:{ 
                sRect.i16XMin = 0;
                sRect.i16YMin = 0;
                sRect.i16XMax = 500;
                sRect.i16YMax = 500;
                GrContextForegroundSet(&sContext, ClrWhite);
                GrRectFill(&sContext, &sRect);

                GrContextForegroundSet(&sContext, ClrPink);
	            GrContextFontSet(&sContext, g_psFontCm20i);
	            GrStringDrawCentered(&sContext, "Procedura 2", -1, 160 , 100, 0);

                goto w8naEnter;
            }break;

            case 3:{ 
                sRect.i16XMin = 0;
                sRect.i16YMin = 0;
                sRect.i16XMax = 500;
                sRect.i16YMax = 500;
                GrContextForegroundSet(&sContext, ClrWhite);
                GrRectFill(&sContext, &sRect);

                GrContextForegroundSet(&sContext, ClrBlack);
	            GrContextFontSet(&sContext, g_psFontCm20i);
	            GrStringDrawCentered(&sContext, "Procedura 3", -1, 160 , 100, 0);

                goto w8naEnter;
            }break;

            case 4:{ 
                sRect.i16XMin = 0;
                sRect.i16YMin = 0;
                sRect.i16XMax = 500;
                sRect.i16YMax = 500;
                GrContextForegroundSet(&sContext, ClrWhite);
                GrRectFill(&sContext, &sRect);

                GrContextForegroundSet(&sContext, ClrBrown);
	            GrContextFontSet(&sContext, g_psFontCm20i);
	            GrStringDrawCentered(&sContext, "Procedura 4", -1, 160 , 100, 0);

                goto w8naEnter;
            }break;
        }
            
        }

    kontynuuj:

    SysCtlDelay(SysCtlClockGet()/2);
    }

    w8naEnter:
    czy_enter=0;
    while(1){
        SysCtlDelay(SysCtlClockGet()/2);
        czy_enter = GPIOPinRead(GPIO_PORTA_BASE,GPIO_PIN_0);
        if(czy_enter != 0)
        {
            goto kontynuuj;
        }
        //SysCtlDelay(SysCtlClockGet()/2);
    }
}