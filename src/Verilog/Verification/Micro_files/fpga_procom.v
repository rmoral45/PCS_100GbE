/*-----------------------------------------------------------------------------
-- Archivo       : fpga_p6.v
-- Organizacion  : Fundacion Fulgor 
-------------------------------------------------------------------------------
-- Descripcion   : Top level de implementacion
-------------------------------------------------------------------------------
-- Autor         : Ariel Pola
-------------------------------------------------------------------------------*/

`include "fpga_files_procom.v"

module fpga
  #(
    parameter NB_GPIOS              = `NB_GPIOS,
    parameter NB_LEDS               = `NB_LEDS,
    parameter NB_ENABLE_RX          = `NB_ENABLE_RX,
    parameter NB_ENABLE_TOTAL       = `NB_ENABLE_TOTAL,
    parameter NB_DATA_RAM_LOG       = `NB_DATA_RAM_LOG,
    parameter NB_ADDR_RAM_LOG       = `NB_ADDR_RAM_LOG,
    parameter NB_DEVICES            = `NB_DEVICES,
    parameter INIT_FILE             = `INIT_FILE
    )
    (
    input                           clk100,
    input wire                      in_reset,
    input wire   [3 : 0]            i_sw,
    input wire                      in_rx_uart,
    output wire  [NB_LEDS-1 : 0]    out_leds,
    output wire                     out_tx_uart
    );
    
    
   ///////////////////////////////////////////
   // Vars
   ///////////////////////////////////////////
   wire          [NB_GPIOS-1 : 0]   gpo0;
   wire          [NB_GPIOS-1 : 0]   gpi0;
   wire                             locked;
   wire                             soft_reset;
   wire                             clockdsp;

   ///////////////////////////////////////////
   // MicroBlaze
   ///////////////////////////////////////////
   //design_1
MicroGPIO
u_micro
   (
   .clock100        (clockdsp)     ,  // Clock aplicacion
   .gpio_rtl_tri_i  (gpo0)       ,  // GPIO
   .gpio_rtl_tri_o  (gpi0)       ,  // GPIO
   .reset           (in_reset)   ,  // Hard Reset
   .sys_clock       (clk100)     ,  // Clock de FPGA
   .o_lock_clock    (locked)     ,  // Senal Lock Clock
   .usb_uart_rxd    (in_rx_uart ),  // UART
   .usb_uart_txd    (out_tx_uart)   // UART
   );

   ///////////////////////////////////////////
   // Leds
   ///////////////////////////////////////////
   assign out_leds[0] = locked;
   assign out_leds[1] = ~in_reset;
   assign out_leds[2] = gpo0[12];
   assign out_leds[3] = gpo0[13];

   assign out_leds[4] = gpo0[0];
   assign out_leds[5] = gpo0[1];
   assign out_leds[6] = gpo0[2];

   assign out_leds[7] = gpo0[3];
   assign out_leds[8] = gpo0[4];
   assign out_leds[9] = gpo0[5];

   assign out_leds[10] = gpo0[6];
   assign out_leds[11] = gpo0[7];
   assign out_leds[12] = gpo0[8];

   assign out_leds[13] = gpo0[9];
   assign out_leds[14] = gpo0[10];
   assign out_leds[15] = gpo0[11];
   
   assign gpi0[3  : 0] = i_sw;
   assign gpi0[31 : 4] = {28{1'b0}};

   ///////////////////////////////////////////
   // Register File
   ///////////////////////////////////////////

   //.out_rf_to_micro_data  (gpi0),

endmodule // fpga
