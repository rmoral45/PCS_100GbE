#include "uart_manager.h"


//Funcion para recibir 1 byte bloqueante
//XUartLite_RecvByte((&uart_module)->RegBaseAddress)

void uart_init(){
	XUartLite_Initialize(&uart_module, 0);
}
int uart_receive(unsigned char *data, unsigned char *device){
    unsigned char header[3];
    unsigned char tail;
    unsigned int LS_flag;
    uint16_t data_length;

    header[0] = 0x00;
    while ((header[0]&(0xe0)) != 0xa0){
        read(stdin,&header[0],1);
    }
    read(stdin,&header[1],1);
    read(stdin,&header[2],1);
    read(stdin, device,1);

    LS_flag = (header[0]&0x10)>>4;
    if (LS_flag == 0){
        data_length = header[0]&0x0f;
    }
    else{
        data_length = (header[1]<<8)|header[2];
    }
    read(stdin, data, data_length);
    read(stdin, &tail, 1);

    if(tail == header[0]){
        return 0;
    }
    else{
        return -1;
    }
}

int uart_send(unsigned char *data, uint16_t length, unsigned char device){
    unsigned char header[3];
    unsigned char tail;
    
    header[0] = 0xa0;
    if (length>15){
        header[0] |= 0x10;
        header[1] = length>>8;
        header[2] = length&0xff;
    }
    else{
        header[0] |= length;
        header[1] = 0;
        header[2] = 0;
    }
    tail = header[0];
    
    while(XUartLite_IsSending(&uart_module)){}
    XUartLite_Send(&uart_module, header,3);
    while(XUartLite_IsSending(&uart_module)){}
    XUartLite_Send(&uart_module, &(device),1);
    for (int i=0; i<length; i++){
        while(XUartLite_IsSending(&uart_module)){}
        XUartLite_Send(&uart_module, &data[i], 1);
    }
    while(XUartLite_IsSending(&uart_module)){}
    XUartLite_Send(&uart_module, &(tail),1);

}
