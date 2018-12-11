#include <stdio.h>
#include <string.h>
#include "xparameters.h"
#include "xil_cache.h"
#include "xgpio.h"
#include "platform.h"
#include "xuartlite.h"
#include "microblaze_sleep.h"

#define PORT_IN	 		XPAR_AXI_GPIO_0_DEVICE_ID //XPAR_GPIO_0_DEVICE_ID
#define PORT_OUT 		XPAR_AXI_GPIO_0_DEVICE_ID //XPAR_GPIO_0_DEVICE_ID

//Device_ID Operaciones
#define def_SOFT_RST            0
#define def_ENABLE_MODULES      1
#define def_LOG_RUN             2
#define def_LOG_READ            3

#define HEADER_SIZE 4 //cabecera + L.high + L.low + device
#define MAX_DATA  256 // por ejem
#define NLEDS 4
#define LED_PINS 3
#define LED_MASK 0x7 // 4'b0111

XGpio GpioOutput;
XGpio GpioParameter;
XGpio GpioInput;
u32 GPO_Value;
u32 GPO_Param;
XUartLite uart_module;

//Funcion para recibir 1 byte bloqueante
//XUartLite_RecvByte((&uart_module)->RegBaseAddress)

int main()
{
	init_platform();
	int Status;
	XUartLite_Initialize(&uart_module, 0);

	GPO_Value=0x00000000;
	GPO_Param=0x00000000;
	unsigned char cabecera[4];

	Status=XGpio_Initialize(&GpioInput, PORT_IN);
	if(Status!=XST_SUCCESS){
        return XST_FAILURE;
    }
	Status=XGpio_Initialize(&GpioOutput, PORT_OUT);
	if(Status!=XST_SUCCESS){
		return XST_FAILURE;
	}
	XGpio_SetDataDirection(&GpioOutput, 1, 0x00000000);
	XGpio_SetDataDirection(&GpioInput, 1, 0xFFFFFFFF);

	u32 value;
    unsigned char datos;

    uint32_t switch_state = 0x00000000;
	uint32_t state = 0x00000000;
	unsigned char state;
	uint16_t data_bytes = 0;
	uint8_t i = 0;
	uint8_t color_counter = 0;
	uint8_t color = 0x00;
	unsigned char data[MAX_DATA];
	unsigned char frame[MAX_DATA + HEADER_SIZE];
	while(1){
    
		for (i=0; i < HEADER_SIZE; i++){//leo la cabecera
			read(stdin,&cabecera[i],1); // xq usar read??????
			//cabecera[i]=XUartLite_RecvByte((&uart_module)->RegBaseAddress);
		}
		//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		// ACA es donde se escribe toda la funcionalidad
		//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		if(cabecera[0] & 1<<4 ){ //si el 5to bit esta en 1,en ese caso es una trama larga
			
			/*
			 ********************************************************
			  POR AHORA NO VOY A ENVIAR NUNCA ESTE TIPO DE TRAMAS
			 ******************************************************** 
			*/
	
		} 

		else{ //es una trama corta
			data_bytes = cabecera[0] & 0x0F;
			if (cabecera[HEADER_SIZE - 1]){ //opero sobre los leds
		
				if( cabecera[HEADER_SIZE -1] & (1<<7) ){ //encender leds,entonces debo leer datos para saber el color
	
					color_counter = 0;
					for (i=0 ;i < data_bytes + 1; i++) // + 1 xq tmb se va aenviar el fin de trama que sirve p checkear errores 
						data[i]=XUartLite_RecvByte((&uart_module)->RegBaseAddress);
					for(i =0; i < NLEDS; i++){
				
						if(cabecera[HEADER_SIZE] & (1<<i)){
							color = data[color_counter] & LED_MASK; // me quedo solo con los primeros 3 bits
							led_state |= (color << i*LED_PINS );
							color_counter++;
						}
			
					}
					XGpio_DiscreteWrite(&GpioOutput,1, led_state );
					frame[0] = (unsigned char) (0xA2);
					frame[1] = (unsigned char) (0x00);
					frame[2] = (unsigned char) (0x00);
					frame[3] = (unsigned char) (0x00);
					frame[4] = 'O';
					frame[6] = 'K';
					frame[7] = (unsigned char) (0x42); // terminacion del frame,creo q en el python la cabecera y 
					//el fin de trama debian ser iguales, revisar desp
					//envio trama completa
					while(XUartLite_IsSending(&uart_module)){}
					XUartLite_Send(&uart_module, frame, 7); //7 es la cant de frame que se van a enviar
				
				}
				else{ //apago los led indicados
					
					for(i =0; i < NLEDS; i++){
				
						if(cabecera[HEADER_SIZE] & (1<<i))
							led_state &= ~(LED_MASK << i*LED_PINS )
			
					}
					XGpio_DiscreteWrite(&GpioOutput,1, led_state );
					frame[0] = (unsigned char) (0xA2);
					frame[1] = (unsigned char) (0x00);
					frame[2] = (unsigned char) (0x00);
					frame[3] = (unsigned char) (0x00);
					frame[4] = 'O';
					frame[6] = 'K';
					frame[7] = (unsigned char) (0x42); // terminacion del frame,creo q en el python la cabecera y 
					//el fin de trama debian ser iguales, revisar desp
					//envio trama completa
					while(XUartLite_IsSending(&uart_module)){}
					XUartLite_Send(&uart_module, frame, 7); //7 es la cant de frame que se van a enviar

	
				}
	

			}
	
			else { //se pidio el estado de los switch,solamente hay que leer el puerto y responder
				switch_state = XGpio_DiscreteRead(&GpioInput, 1);
				state = (unsigned char) (switch_state & 0x0000000F);
				//tengo que rearmar la trama(va a ser corta)
				frame[0] = (unsigned char) (0xA1);
				frame[1] = (unsigned char) (0x00);
				frame[2] = (unsigned char) (0x00);
				frame[3] = (unsigned char) (0x00);
				frame[4] = state;
				frame[5] = (unsigned char) (0x41); // terminacion del frame,creo q en el python la cabecera y 
				//el fin de trama debian ser iguales, revisar desp
				//envio trama completa
				while(XUartLite_IsSending(&uart_module)){}
				XUartLite_Send(&uart_module, frame, 6); //6 es la cant de frame que se van a enviar

			}
	

		}
		//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		// FIN de toda la funcionalidad
		//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    }
	
	cleanup_platform();
	return 0;
}


/*
	Como se puede leer el estado de los switch pero no escribirlos si el campo device == 0 esta indicando
	realizar operacion de lectura sobre los switch.
	En caso de ser distinto de 0 device contendra informacion de que leds encender/apagar, si el MSB esta en 1
	se deben prender los led indicados en los primeros 3/4(dependiendo la cant de leds) bits de device,
	si esta en 0 se deben apagar.

	En cada byte de data se recibira el color del led que se quiere encender,ordenado de izquierda a derecha,
	ej : si device=0b10000101 se deben encender led0 y led1,luego el primer byte de data contiene el
	color de led0 y el segundo el color de led1.Osea deberia recibir tantos bytes de datos como leds quiera
	encender.

	CUIDADO: Aunque no necesito leer la seccion de datos como en el caso de apagado de leds,tengo que leer cualquier
	cosa que quede en el buffer para vaciarlo,minimo el fin de trama. 

	DEVICE {
						MSB 									LSB
			bits -> | ON/OFF | X | X | X | LED3 | LED2 | LED1 | LED0 |
			
		   }
*/