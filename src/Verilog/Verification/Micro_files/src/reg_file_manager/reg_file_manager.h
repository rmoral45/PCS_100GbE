#include "xgpio.h"
#include <stdio.h>


//REG_OP CODES DEFINES
#define RESET_CODE 6
#define ENABLE_CODE 0
#define READ_MEM_ENB_CODE 1
#define READ_ADDR_CODE 2 
#define READ_DATA_LOW_CODE 3
#define READ_DATA_HIGH_CODE 4
#define READ_CTRL_CODE 5

XGpio GpioOutput;
XGpio GpioParameter;
XGpio GpioInput;

void 	reg_file_init	(void);
void 	reg_file_write	(u32, u32);
u32 	reg_file_read	(void);
void 	wait_mem_done 	(void);  
void 	soft_delay		(int);
void 	read_64bit_data	(uint64_t * , int);
