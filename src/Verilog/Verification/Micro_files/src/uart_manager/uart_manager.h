#include <stdio.h>
#include "xuartlite.h"

XUartLite uart_module;

void uart_init(void);
int uart_receive(unsigned char *, unsigned char *);
int uart_send(unsigned char *, uint16_t, unsigned char);
