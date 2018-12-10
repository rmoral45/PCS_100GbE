//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
//Date        : Fri Dec  7 09:56:29 2018
//Host        : Kyrie running 64-bit Ubuntu 16.04.5 LTS
//Command     : generate_target MicroGPIO_wrapper.bd
//Design      : MicroGPIO_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module MicroGPIO_wrapper
   (clock,
    dip_switches_16bits_tri_i,
    o_lock_clock,
    reset,
    sys_clock,
    usb_uart_rxd,
    usb_uart_txd);
  output clock;
  input [15:0]dip_switches_16bits_tri_i;
  output o_lock_clock;
  input reset;
  input sys_clock;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire clock;
  wire [15:0]dip_switches_16bits_tri_i;
  wire o_lock_clock;
  wire reset;
  wire sys_clock;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  MicroGPIO MicroGPIO_i
       (.clock(clock),
        .dip_switches_16bits_tri_i(dip_switches_16bits_tri_i),
        .o_lock_clock(o_lock_clock),
        .reset(reset),
        .sys_clock(sys_clock),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
endmodule
