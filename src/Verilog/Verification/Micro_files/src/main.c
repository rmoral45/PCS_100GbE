#include <stdio.h>
#include <string.h>
#include "xparameters.h"
#include "xil_cache.h"
#include "xgpio.h"
#include "platform.h"
#include "microblaze_sleep.h"
#include "uart_manager/uart_manager.h"
#include "reg_file_manager/reg_file_manager.h"

#define PORT_IN	 		XPAR_AXI_GPIO_0_DEVICE_ID //XPAR_GPIO_0_DEVICE_ID
#define PORT_OUT 		XPAR_AXI_GPIO_0_DEVICE_ID //XPAR_GPIO_0_DEVICE_ID

//Device_ID Operaciones
#define def_SOFT_RST            0
#define def_ENABLE_MODULES      1
#define def_LOG_RUN             2
#define def_LOG_READ            3


/*
XGpio GpioOutput;
XGpio GpioParameter;
XGpio GpioInput;
u32 GPO_Value;
u32 GPO_Param;
*/
#define BUFF_LEN 256
#define DATA_NBYTES 8

#define RESET 0x00
#define ENB_ALL 0x04
#define LOG 0x0b

int main()
{
	init_platform();
	int Status;

    reg_file_init();
    uart_init();

    u32 reg_file_out;
    u32 enable_reg;
    enable_reg = 0;
    int addr_counter;
    addr_counter = 0;

    //////variables de estado de register file////////////
 
    /////////////////////////////////////////////////////
    unsigned char device = 255;
    unsigned char data[BUFF_LEN];

    uint64_t *data_64;
    data_64 = &data[0];
    

    char * ack;

    while(1){
        
    	uart_receive(data, &device);
    	///////////////////////////////////////////////////////
    	//realizar checkeo de error de la funcion uart_receive
    	///////////////////////////////////////////////////////


    	///////////////////////////////////////////////////////
    	//realizar echo
    	//////////////////////////////////////////////////////

    	switch((uint8_t) device){
            
    		case RESET:
    			reg_file_write(RESET_CODE, 0); //pongo el reset
    			soft_delay(10);
    			reg_file_write(RESET_CODE, 0); // saco el reset
                ack = "ACK: System Reset";
                uart_send(ack, 18, 0);
				break;
			case ENB_ALL:
				enable_reg |= 0x000000ff;
				reg_file_write(ENABLE_CODE, enable_reg);
                ack = "ACK: Enable ALL";
                uart_send(ack, 15, 0);
				break;
			
			case LOG :
                addr_counter = 0;
                for(int j=0; j<1024; j++)
                {
                    read_64bit_data(data_64, addr_counter);
				    uart_send(data, DATA_NBYTES, 0);
                    addr_counter = addr_counter + 1;
                }
				break;
			default :
				break;		
    	}
    }
	cleanup_platform();
	return 0;
}
