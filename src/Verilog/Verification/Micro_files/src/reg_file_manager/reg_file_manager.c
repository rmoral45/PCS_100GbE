#include "reg_file_manager.h"

#define PORT_IN	 		XPAR_AXI_GPIO_0_DEVICE_ID //XPAR_GPIO_0_DEVICE_ID
#define PORT_OUT 		XPAR_AXI_GPIO_0_DEVICE_ID //XPAR_GPIO_0_DEVICE_ID

void reg_file_init(){
	int Status;

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
}

void reg_file_write(u32 opcode, u32 data){
    u32 enable_mask = 0x80000000;
    //u32 instruction = (opcode << 24) | data;
    u32 instruction = (opcode << 22) | data;
    
    XGpio_DiscreteWrite(&GpioOutput, 1, instruction);
    XGpio_DiscreteWrite(&GpioOutput, 1, instruction | enable_mask);
    XGpio_DiscreteWrite(&GpioOutput, 1, instruction);
}

u32 reg_file_read(){
    u32 out = XGpio_DiscreteRead(&GpioInput, 1);
    out     = XGpio_DiscreteRead(&GpioInput, 1);
    out     = XGpio_DiscreteRead(&GpioInput, 1);
    return out;
}

void read_64bit_data(uint64_t * data, int data_addr){
    u32 reg_file_out;
    *data = 0;

    reg_file_write(READ_ADDR_CODE,data_addr);    

    reg_file_write(READ_DATA_HIGH_CODE,0);//leo parte alta del dato 
    reg_file_out = reg_file_read();
    *data       |= ((uint64_t) reg_file_out) << 32;

    reg_file_write(READ_DATA_LOW_CODE,0);//leo parte baja del dato 
    reg_file_out = reg_file_read();
    *data       |= ((uint64_t) reg_file_out);
}

void soft_delay(int delay){
    for(int i=0; i<delay; i++){}
    return;    
}
/*
void wait_mem_done(){
    reg_file_write(MEM_OP_TYPE, MEM_DONE_CODE, 0);
    while(!reg_file_read())
        reg_file_write(MEM_OP_TYPE, MEM_DONE_CODE, 0);
    return;
}
*/

