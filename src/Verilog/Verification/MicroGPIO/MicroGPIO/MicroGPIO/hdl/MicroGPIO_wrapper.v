//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
//Date        : Fri Dec  7 10:57:53 2018
//Host        : Kyrie running 64-bit Ubuntu 16.04.5 LTS
//Command     : generate_target MicroGPIO_wrapper.bd
//Design      : MicroGPIO_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module MicroGPIO_wrapper
   (clock100,
    gpio_rtl_tri_io,
    o_lock_clock,
    reset,
    sys_clock,
    usb_uart_rxd,
    usb_uart_txd);
  output clock100;
  inout [31:0]gpio_rtl_tri_io;
  output o_lock_clock;
  input reset;
  input sys_clock;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire clock100;
  wire [0:0]gpio_rtl_tri_i_0;
  wire [1:1]gpio_rtl_tri_i_1;
  wire [10:10]gpio_rtl_tri_i_10;
  wire [11:11]gpio_rtl_tri_i_11;
  wire [12:12]gpio_rtl_tri_i_12;
  wire [13:13]gpio_rtl_tri_i_13;
  wire [14:14]gpio_rtl_tri_i_14;
  wire [15:15]gpio_rtl_tri_i_15;
  wire [16:16]gpio_rtl_tri_i_16;
  wire [17:17]gpio_rtl_tri_i_17;
  wire [18:18]gpio_rtl_tri_i_18;
  wire [19:19]gpio_rtl_tri_i_19;
  wire [2:2]gpio_rtl_tri_i_2;
  wire [20:20]gpio_rtl_tri_i_20;
  wire [21:21]gpio_rtl_tri_i_21;
  wire [22:22]gpio_rtl_tri_i_22;
  wire [23:23]gpio_rtl_tri_i_23;
  wire [24:24]gpio_rtl_tri_i_24;
  wire [25:25]gpio_rtl_tri_i_25;
  wire [26:26]gpio_rtl_tri_i_26;
  wire [27:27]gpio_rtl_tri_i_27;
  wire [28:28]gpio_rtl_tri_i_28;
  wire [29:29]gpio_rtl_tri_i_29;
  wire [3:3]gpio_rtl_tri_i_3;
  wire [30:30]gpio_rtl_tri_i_30;
  wire [31:31]gpio_rtl_tri_i_31;
  wire [4:4]gpio_rtl_tri_i_4;
  wire [5:5]gpio_rtl_tri_i_5;
  wire [6:6]gpio_rtl_tri_i_6;
  wire [7:7]gpio_rtl_tri_i_7;
  wire [8:8]gpio_rtl_tri_i_8;
  wire [9:9]gpio_rtl_tri_i_9;
  wire [0:0]gpio_rtl_tri_io_0;
  wire [1:1]gpio_rtl_tri_io_1;
  wire [10:10]gpio_rtl_tri_io_10;
  wire [11:11]gpio_rtl_tri_io_11;
  wire [12:12]gpio_rtl_tri_io_12;
  wire [13:13]gpio_rtl_tri_io_13;
  wire [14:14]gpio_rtl_tri_io_14;
  wire [15:15]gpio_rtl_tri_io_15;
  wire [16:16]gpio_rtl_tri_io_16;
  wire [17:17]gpio_rtl_tri_io_17;
  wire [18:18]gpio_rtl_tri_io_18;
  wire [19:19]gpio_rtl_tri_io_19;
  wire [2:2]gpio_rtl_tri_io_2;
  wire [20:20]gpio_rtl_tri_io_20;
  wire [21:21]gpio_rtl_tri_io_21;
  wire [22:22]gpio_rtl_tri_io_22;
  wire [23:23]gpio_rtl_tri_io_23;
  wire [24:24]gpio_rtl_tri_io_24;
  wire [25:25]gpio_rtl_tri_io_25;
  wire [26:26]gpio_rtl_tri_io_26;
  wire [27:27]gpio_rtl_tri_io_27;
  wire [28:28]gpio_rtl_tri_io_28;
  wire [29:29]gpio_rtl_tri_io_29;
  wire [3:3]gpio_rtl_tri_io_3;
  wire [30:30]gpio_rtl_tri_io_30;
  wire [31:31]gpio_rtl_tri_io_31;
  wire [4:4]gpio_rtl_tri_io_4;
  wire [5:5]gpio_rtl_tri_io_5;
  wire [6:6]gpio_rtl_tri_io_6;
  wire [7:7]gpio_rtl_tri_io_7;
  wire [8:8]gpio_rtl_tri_io_8;
  wire [9:9]gpio_rtl_tri_io_9;
  wire [0:0]gpio_rtl_tri_o_0;
  wire [1:1]gpio_rtl_tri_o_1;
  wire [10:10]gpio_rtl_tri_o_10;
  wire [11:11]gpio_rtl_tri_o_11;
  wire [12:12]gpio_rtl_tri_o_12;
  wire [13:13]gpio_rtl_tri_o_13;
  wire [14:14]gpio_rtl_tri_o_14;
  wire [15:15]gpio_rtl_tri_o_15;
  wire [16:16]gpio_rtl_tri_o_16;
  wire [17:17]gpio_rtl_tri_o_17;
  wire [18:18]gpio_rtl_tri_o_18;
  wire [19:19]gpio_rtl_tri_o_19;
  wire [2:2]gpio_rtl_tri_o_2;
  wire [20:20]gpio_rtl_tri_o_20;
  wire [21:21]gpio_rtl_tri_o_21;
  wire [22:22]gpio_rtl_tri_o_22;
  wire [23:23]gpio_rtl_tri_o_23;
  wire [24:24]gpio_rtl_tri_o_24;
  wire [25:25]gpio_rtl_tri_o_25;
  wire [26:26]gpio_rtl_tri_o_26;
  wire [27:27]gpio_rtl_tri_o_27;
  wire [28:28]gpio_rtl_tri_o_28;
  wire [29:29]gpio_rtl_tri_o_29;
  wire [3:3]gpio_rtl_tri_o_3;
  wire [30:30]gpio_rtl_tri_o_30;
  wire [31:31]gpio_rtl_tri_o_31;
  wire [4:4]gpio_rtl_tri_o_4;
  wire [5:5]gpio_rtl_tri_o_5;
  wire [6:6]gpio_rtl_tri_o_6;
  wire [7:7]gpio_rtl_tri_o_7;
  wire [8:8]gpio_rtl_tri_o_8;
  wire [9:9]gpio_rtl_tri_o_9;
  wire [0:0]gpio_rtl_tri_t_0;
  wire [1:1]gpio_rtl_tri_t_1;
  wire [10:10]gpio_rtl_tri_t_10;
  wire [11:11]gpio_rtl_tri_t_11;
  wire [12:12]gpio_rtl_tri_t_12;
  wire [13:13]gpio_rtl_tri_t_13;
  wire [14:14]gpio_rtl_tri_t_14;
  wire [15:15]gpio_rtl_tri_t_15;
  wire [16:16]gpio_rtl_tri_t_16;
  wire [17:17]gpio_rtl_tri_t_17;
  wire [18:18]gpio_rtl_tri_t_18;
  wire [19:19]gpio_rtl_tri_t_19;
  wire [2:2]gpio_rtl_tri_t_2;
  wire [20:20]gpio_rtl_tri_t_20;
  wire [21:21]gpio_rtl_tri_t_21;
  wire [22:22]gpio_rtl_tri_t_22;
  wire [23:23]gpio_rtl_tri_t_23;
  wire [24:24]gpio_rtl_tri_t_24;
  wire [25:25]gpio_rtl_tri_t_25;
  wire [26:26]gpio_rtl_tri_t_26;
  wire [27:27]gpio_rtl_tri_t_27;
  wire [28:28]gpio_rtl_tri_t_28;
  wire [29:29]gpio_rtl_tri_t_29;
  wire [3:3]gpio_rtl_tri_t_3;
  wire [30:30]gpio_rtl_tri_t_30;
  wire [31:31]gpio_rtl_tri_t_31;
  wire [4:4]gpio_rtl_tri_t_4;
  wire [5:5]gpio_rtl_tri_t_5;
  wire [6:6]gpio_rtl_tri_t_6;
  wire [7:7]gpio_rtl_tri_t_7;
  wire [8:8]gpio_rtl_tri_t_8;
  wire [9:9]gpio_rtl_tri_t_9;
  wire o_lock_clock;
  wire reset;
  wire sys_clock;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  MicroGPIO MicroGPIO_i
       (.clock100(clock100),
        .gpio_rtl_tri_i({gpio_rtl_tri_i_31,gpio_rtl_tri_i_30,gpio_rtl_tri_i_29,gpio_rtl_tri_i_28,gpio_rtl_tri_i_27,gpio_rtl_tri_i_26,gpio_rtl_tri_i_25,gpio_rtl_tri_i_24,gpio_rtl_tri_i_23,gpio_rtl_tri_i_22,gpio_rtl_tri_i_21,gpio_rtl_tri_i_20,gpio_rtl_tri_i_19,gpio_rtl_tri_i_18,gpio_rtl_tri_i_17,gpio_rtl_tri_i_16,gpio_rtl_tri_i_15,gpio_rtl_tri_i_14,gpio_rtl_tri_i_13,gpio_rtl_tri_i_12,gpio_rtl_tri_i_11,gpio_rtl_tri_i_10,gpio_rtl_tri_i_9,gpio_rtl_tri_i_8,gpio_rtl_tri_i_7,gpio_rtl_tri_i_6,gpio_rtl_tri_i_5,gpio_rtl_tri_i_4,gpio_rtl_tri_i_3,gpio_rtl_tri_i_2,gpio_rtl_tri_i_1,gpio_rtl_tri_i_0}),
        .gpio_rtl_tri_o({gpio_rtl_tri_o_31,gpio_rtl_tri_o_30,gpio_rtl_tri_o_29,gpio_rtl_tri_o_28,gpio_rtl_tri_o_27,gpio_rtl_tri_o_26,gpio_rtl_tri_o_25,gpio_rtl_tri_o_24,gpio_rtl_tri_o_23,gpio_rtl_tri_o_22,gpio_rtl_tri_o_21,gpio_rtl_tri_o_20,gpio_rtl_tri_o_19,gpio_rtl_tri_o_18,gpio_rtl_tri_o_17,gpio_rtl_tri_o_16,gpio_rtl_tri_o_15,gpio_rtl_tri_o_14,gpio_rtl_tri_o_13,gpio_rtl_tri_o_12,gpio_rtl_tri_o_11,gpio_rtl_tri_o_10,gpio_rtl_tri_o_9,gpio_rtl_tri_o_8,gpio_rtl_tri_o_7,gpio_rtl_tri_o_6,gpio_rtl_tri_o_5,gpio_rtl_tri_o_4,gpio_rtl_tri_o_3,gpio_rtl_tri_o_2,gpio_rtl_tri_o_1,gpio_rtl_tri_o_0}),
        .gpio_rtl_tri_t({gpio_rtl_tri_t_31,gpio_rtl_tri_t_30,gpio_rtl_tri_t_29,gpio_rtl_tri_t_28,gpio_rtl_tri_t_27,gpio_rtl_tri_t_26,gpio_rtl_tri_t_25,gpio_rtl_tri_t_24,gpio_rtl_tri_t_23,gpio_rtl_tri_t_22,gpio_rtl_tri_t_21,gpio_rtl_tri_t_20,gpio_rtl_tri_t_19,gpio_rtl_tri_t_18,gpio_rtl_tri_t_17,gpio_rtl_tri_t_16,gpio_rtl_tri_t_15,gpio_rtl_tri_t_14,gpio_rtl_tri_t_13,gpio_rtl_tri_t_12,gpio_rtl_tri_t_11,gpio_rtl_tri_t_10,gpio_rtl_tri_t_9,gpio_rtl_tri_t_8,gpio_rtl_tri_t_7,gpio_rtl_tri_t_6,gpio_rtl_tri_t_5,gpio_rtl_tri_t_4,gpio_rtl_tri_t_3,gpio_rtl_tri_t_2,gpio_rtl_tri_t_1,gpio_rtl_tri_t_0}),
        .o_lock_clock(o_lock_clock),
        .reset(reset),
        .sys_clock(sys_clock),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
  IOBUF gpio_rtl_tri_iobuf_0
       (.I(gpio_rtl_tri_o_0),
        .IO(gpio_rtl_tri_io[0]),
        .O(gpio_rtl_tri_i_0),
        .T(gpio_rtl_tri_t_0));
  IOBUF gpio_rtl_tri_iobuf_1
       (.I(gpio_rtl_tri_o_1),
        .IO(gpio_rtl_tri_io[1]),
        .O(gpio_rtl_tri_i_1),
        .T(gpio_rtl_tri_t_1));
  IOBUF gpio_rtl_tri_iobuf_10
       (.I(gpio_rtl_tri_o_10),
        .IO(gpio_rtl_tri_io[10]),
        .O(gpio_rtl_tri_i_10),
        .T(gpio_rtl_tri_t_10));
  IOBUF gpio_rtl_tri_iobuf_11
       (.I(gpio_rtl_tri_o_11),
        .IO(gpio_rtl_tri_io[11]),
        .O(gpio_rtl_tri_i_11),
        .T(gpio_rtl_tri_t_11));
  IOBUF gpio_rtl_tri_iobuf_12
       (.I(gpio_rtl_tri_o_12),
        .IO(gpio_rtl_tri_io[12]),
        .O(gpio_rtl_tri_i_12),
        .T(gpio_rtl_tri_t_12));
  IOBUF gpio_rtl_tri_iobuf_13
       (.I(gpio_rtl_tri_o_13),
        .IO(gpio_rtl_tri_io[13]),
        .O(gpio_rtl_tri_i_13),
        .T(gpio_rtl_tri_t_13));
  IOBUF gpio_rtl_tri_iobuf_14
       (.I(gpio_rtl_tri_o_14),
        .IO(gpio_rtl_tri_io[14]),
        .O(gpio_rtl_tri_i_14),
        .T(gpio_rtl_tri_t_14));
  IOBUF gpio_rtl_tri_iobuf_15
       (.I(gpio_rtl_tri_o_15),
        .IO(gpio_rtl_tri_io[15]),
        .O(gpio_rtl_tri_i_15),
        .T(gpio_rtl_tri_t_15));
  IOBUF gpio_rtl_tri_iobuf_16
       (.I(gpio_rtl_tri_o_16),
        .IO(gpio_rtl_tri_io[16]),
        .O(gpio_rtl_tri_i_16),
        .T(gpio_rtl_tri_t_16));
  IOBUF gpio_rtl_tri_iobuf_17
       (.I(gpio_rtl_tri_o_17),
        .IO(gpio_rtl_tri_io[17]),
        .O(gpio_rtl_tri_i_17),
        .T(gpio_rtl_tri_t_17));
  IOBUF gpio_rtl_tri_iobuf_18
       (.I(gpio_rtl_tri_o_18),
        .IO(gpio_rtl_tri_io[18]),
        .O(gpio_rtl_tri_i_18),
        .T(gpio_rtl_tri_t_18));
  IOBUF gpio_rtl_tri_iobuf_19
       (.I(gpio_rtl_tri_o_19),
        .IO(gpio_rtl_tri_io[19]),
        .O(gpio_rtl_tri_i_19),
        .T(gpio_rtl_tri_t_19));
  IOBUF gpio_rtl_tri_iobuf_2
       (.I(gpio_rtl_tri_o_2),
        .IO(gpio_rtl_tri_io[2]),
        .O(gpio_rtl_tri_i_2),
        .T(gpio_rtl_tri_t_2));
  IOBUF gpio_rtl_tri_iobuf_20
       (.I(gpio_rtl_tri_o_20),
        .IO(gpio_rtl_tri_io[20]),
        .O(gpio_rtl_tri_i_20),
        .T(gpio_rtl_tri_t_20));
  IOBUF gpio_rtl_tri_iobuf_21
       (.I(gpio_rtl_tri_o_21),
        .IO(gpio_rtl_tri_io[21]),
        .O(gpio_rtl_tri_i_21),
        .T(gpio_rtl_tri_t_21));
  IOBUF gpio_rtl_tri_iobuf_22
       (.I(gpio_rtl_tri_o_22),
        .IO(gpio_rtl_tri_io[22]),
        .O(gpio_rtl_tri_i_22),
        .T(gpio_rtl_tri_t_22));
  IOBUF gpio_rtl_tri_iobuf_23
       (.I(gpio_rtl_tri_o_23),
        .IO(gpio_rtl_tri_io[23]),
        .O(gpio_rtl_tri_i_23),
        .T(gpio_rtl_tri_t_23));
  IOBUF gpio_rtl_tri_iobuf_24
       (.I(gpio_rtl_tri_o_24),
        .IO(gpio_rtl_tri_io[24]),
        .O(gpio_rtl_tri_i_24),
        .T(gpio_rtl_tri_t_24));
  IOBUF gpio_rtl_tri_iobuf_25
       (.I(gpio_rtl_tri_o_25),
        .IO(gpio_rtl_tri_io[25]),
        .O(gpio_rtl_tri_i_25),
        .T(gpio_rtl_tri_t_25));
  IOBUF gpio_rtl_tri_iobuf_26
       (.I(gpio_rtl_tri_o_26),
        .IO(gpio_rtl_tri_io[26]),
        .O(gpio_rtl_tri_i_26),
        .T(gpio_rtl_tri_t_26));
  IOBUF gpio_rtl_tri_iobuf_27
       (.I(gpio_rtl_tri_o_27),
        .IO(gpio_rtl_tri_io[27]),
        .O(gpio_rtl_tri_i_27),
        .T(gpio_rtl_tri_t_27));
  IOBUF gpio_rtl_tri_iobuf_28
       (.I(gpio_rtl_tri_o_28),
        .IO(gpio_rtl_tri_io[28]),
        .O(gpio_rtl_tri_i_28),
        .T(gpio_rtl_tri_t_28));
  IOBUF gpio_rtl_tri_iobuf_29
       (.I(gpio_rtl_tri_o_29),
        .IO(gpio_rtl_tri_io[29]),
        .O(gpio_rtl_tri_i_29),
        .T(gpio_rtl_tri_t_29));
  IOBUF gpio_rtl_tri_iobuf_3
       (.I(gpio_rtl_tri_o_3),
        .IO(gpio_rtl_tri_io[3]),
        .O(gpio_rtl_tri_i_3),
        .T(gpio_rtl_tri_t_3));
  IOBUF gpio_rtl_tri_iobuf_30
       (.I(gpio_rtl_tri_o_30),
        .IO(gpio_rtl_tri_io[30]),
        .O(gpio_rtl_tri_i_30),
        .T(gpio_rtl_tri_t_30));
  IOBUF gpio_rtl_tri_iobuf_31
       (.I(gpio_rtl_tri_o_31),
        .IO(gpio_rtl_tri_io[31]),
        .O(gpio_rtl_tri_i_31),
        .T(gpio_rtl_tri_t_31));
  IOBUF gpio_rtl_tri_iobuf_4
       (.I(gpio_rtl_tri_o_4),
        .IO(gpio_rtl_tri_io[4]),
        .O(gpio_rtl_tri_i_4),
        .T(gpio_rtl_tri_t_4));
  IOBUF gpio_rtl_tri_iobuf_5
       (.I(gpio_rtl_tri_o_5),
        .IO(gpio_rtl_tri_io[5]),
        .O(gpio_rtl_tri_i_5),
        .T(gpio_rtl_tri_t_5));
  IOBUF gpio_rtl_tri_iobuf_6
       (.I(gpio_rtl_tri_o_6),
        .IO(gpio_rtl_tri_io[6]),
        .O(gpio_rtl_tri_i_6),
        .T(gpio_rtl_tri_t_6));
  IOBUF gpio_rtl_tri_iobuf_7
       (.I(gpio_rtl_tri_o_7),
        .IO(gpio_rtl_tri_io[7]),
        .O(gpio_rtl_tri_i_7),
        .T(gpio_rtl_tri_t_7));
  IOBUF gpio_rtl_tri_iobuf_8
       (.I(gpio_rtl_tri_o_8),
        .IO(gpio_rtl_tri_io[8]),
        .O(gpio_rtl_tri_i_8),
        .T(gpio_rtl_tri_t_8));
  IOBUF gpio_rtl_tri_iobuf_9
       (.I(gpio_rtl_tri_o_9),
        .IO(gpio_rtl_tri_io[9]),
        .O(gpio_rtl_tri_i_9),
        .T(gpio_rtl_tri_t_9));
endmodule
