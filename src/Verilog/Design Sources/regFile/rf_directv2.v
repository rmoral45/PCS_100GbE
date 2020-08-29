`timescale 1ns/100ps

/*
 * EL canal se maneja con la siguiente secuencia : 
 * 1) limpio los selectores de canal
 * 2) uso channel_select para seleccionar el canal correspondiente a cada lane
 * 3) seteo channel
 *
 *
 *
 *
 *
 * 
 *
 */

module rf_direct
#(

        parameter N_LANES        = 20,
        parameter N_PCS_MODULES  = 24,
        parameter N_CHNL_MODULES = 4,
        /* inout from uBlaze */
        parameter NB_GPIO        = 32,
        
        /* inputs from PCS */
        parameter NB_STATUS      = 4,
        parameter NB_HIBER       = 20,
        parameter NB_BLK_LOCK    = 20,
        parameter NB_LANE_ALIGN  = 20,
        parameter NB_BER_CNT     = 20,
        parameter NB_BUS_BERCNT  = 20 * N_LANES,
        parameter NB_BER_COMMON  = 27,
        parameter NB_ERR_BLOCKS  = 32,
        parameter NB_TEST_PATT   = 16,
        parameter NB_LANE_ID     = 5,
        parameter NB_BUS_LANEID  = NB_LANE_ID * N_LANES,
        parameter NB_BIP_ERR     = 32,
        parameter NB_BUS_BIPERR  = NB_BIP_ERR * N_LANES,

        parameter NB_INV_SH_LIM    = 20,
        parameter NB_LOCK_WINDOW   = 20,
        parameter NB_UNLOCK_WINDOW = 20,
        parameter NB_INVALID_THR   = 20,
        parameter NB_VALID_THR     = 20,
        parameter NB_MASK          = 66,

        parameter NB_CHNL_UPDATE = 20,
        parameter NB_CHNL_MODE   = 4,
        parameter NB_CHNL_BURST  = 22,
        parameter NB_CHNL_PERIOD = 22,
        parameter NB_CHNL_REPEAT = 22,
        parameter NB_CHNL_SKEW   = 5
 )
 (
        input  wire                             i_clock,
        input  wire                             i_reset,
        input  wire [NB_GPIO-1 : 0]             i_gpio,
        input  wire [N_LANES-1 : 0]             i_pcs_block_lock,
        input  wire [N_LANES-1 : 0]             i_pcs_lane_aligned,
        input  wire                             i_pcs_all_deskew,
        input  wire                             i_pcs_all_reorder,
        input  wire [N_LANES-1 : 0]             i_pcs_hi_ber,
        input  wire [NB_BUS_BERCNT-1 : 0]       i_pcs_ber_counter,
        input  wire [NB_BER_COMMON-1 : 0]       i_pcs_ber_common,
        input  wire [NB_ERR_BLOCKS-1 : 0]       i_pcs_decoder_err,
        input  wire [NB_TEST_PATT-1 : 0]        i_pcs_pattern_err,
        input  wire [NB_BUS_LANEID-1 : 0]       i_pcs_lane_ids,
        input  wire [NB_BUS_BIPERR-1 : 0]       i_pcs_bip_err,

        output wire [NB_GPIO-1 : 0]             o_gpio,
        output wire                             o_soft_reset,
        output wire                             o_loopback,
        output wire                             o_tx_test_pattern,
        output wire                             o_rx_test_pattern,
        output wire [N_PCS_MODULES-1 : 0]       o_enable_modules,

        output wire [NB_INV_SH_LIM-1 : 0]       o_blksync_invalid_sh_limit,
        output wire [NB_LOCK_WINDOW-1 : 0]      o_blksync_locked_window,
        output wire [NB_UNLOCK_WINDOW-1 : 0]    o_blksync_unlocked_window,
        output wire [NB_INVALID_THR-1 : 0]      o_align_invalid_thr,
        output wire [NB_VALID_THR-1 : 0]        o_align_valid_thr,
        output wire [NB_MASK-1 : 0]             o_align_mask,

        output wire [N_LANES-1 : 0]             o_channel_select, //1 canal por lane
        output wire [N_CHNL_MODULES-1 : 0]      o_channel_update,
        output wire [N_LANES-1 : 0]             o_channel_start_break, //1 canal por lane
        output wire [NB_CHNL_MODE-1 : 0]        o_channel_mode,
        output wire [NB_CHNL_BURST-1 : 0]       o_channel_burst,
        output wire [NB_CHNL_PERIOD-1 : 0]      o_channel_period,
        output wire [NB_CHNL_REPEAT-1 : 0]      o_channel_repeat,
        output wire [NB_CHNL_SKEW-1 : 0]        o_channel_skew

 );

/*------------  Localparams -------------*/

/* GPIO input format : {opcode,enb,data} */
localparam NB_OPCODE    = 7;
localparam NB_COMM_ENB  = 1;
localparam COMM_ENB_POS = NB_GPIO - 1 - NB_OPCODE;
localparam NB_COMM_DATA = NB_GPIO - NB_COMM_ENB - NB_OPCODE;
localparam COMM_DATA_POS = COMM_ENB_POS - 1;
localparam N_PCS_MODES = 4;

/*-------------- OPCODES -----------------*/

/*------ MDIO ------*/

/* WRonly */
localparam [NB_OPCODE-1 : 0]  PCS_CONTROL_WR              = 'd1;
localparam [NB_OPCODE-1 : 0]  PCS_ENABLE_MODULES_WR       = 'd2;
localparam [NB_OPCODE-1 : 0]  PCS_BLKSYNC_INVALID_SH_LIM  = 'd3;
localparam [NB_OPCODE-1 : 0]  PCS_BLKSYNC_LOCKED_WINDOW   = 'd4;
localparam [NB_OPCODE-1 : 0]  PCS_BLKSYNC_UNLOCKED_WINDOW = 'd5;

localparam [NB_OPCODE-1 : 0]  PCS_ALIGN_INVALID_THR       = 'd6;
localparam [NB_OPCODE-1 : 0]  PCS_ALIGN_VALID_THR         = 'd7;
localparam [NB_OPCODE-1 : 0]  PCS_ALIGN_MASK_LOW          = 'd8;
localparam [NB_OPCODE-1 : 0]  PCS_ALIGN_MASK_MID          = 'd9;
localparam [NB_OPCODE-1 : 0]  PCS_ALIGN_MASK_HIGH         = 'd10;

localparam [NB_OPCODE-1 : 0]  CHNL_UPDATE_WR              = 'd11;
localparam [NB_OPCODE-1 : 0]  CHNL_START_SEQ_WR           = 'd12;
localparam [NB_OPCODE-1 : 0]  CHNL_BLOCK_SEL_WR           = 'd13; 
localparam [NB_OPCODE-1 : 0]  CHNL_MODE_WR                = 'd14;
localparam [NB_OPCODE-1 : 0]  CHNL_BURST_WR               = 'd15;
localparam [NB_OPCODE-1 : 0]  CHNL_PERIOD_WR              = 'd16;
localparam [NB_OPCODE-1 : 0]  CHNL_REPEAT_WR              = 'd17;
localparam [NB_OPCODE-1 : 0]  CHNL_LANE_SEL_WR            = 'd18;
localparam [NB_OPCODE-1 : 0]  CHNL_SKEW_WR                = 'd19;

/* RO regs */
localparam [NB_OPCODE-1 : 0]  PCS_STATUS_RD               = 'd40;
localparam [NB_OPCODE-1 : 0]  PCS_HI_BER_RD               = 'd41;
localparam [NB_OPCODE-1 : 0]  PCS_BLOCK_LOCK_RD           = 'd42;
localparam [NB_OPCODE-1 : 0]  PCS_ALIGN_LOCK_RD           = 'd43;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_0_RD        = 'd44;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_1_RD        = 'd45;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_2_RD        = 'd46;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_3_RD        = 'd47;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_4_RD        = 'd48;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_5_RD        = 'd49;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_6_RD        = 'd50;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_7_RD        = 'd51;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_8_RD        = 'd52;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_9_RD        = 'd53;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_10_RD       = 'd54;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_11_RD       = 'd55;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_12_RD       = 'd56;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_13_RD       = 'd57;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_14_RD       = 'd58;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_15_RD       = 'd59;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_16_RD       = 'd60;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_17_RD       = 'd61;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_18_RD       = 'd62;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_LANE_19_RD       = 'd63;
localparam [NB_OPCODE-1 : 0]  PCS_BERCNT_COMMON_RD        = 'd64;
localparam [NB_OPCODE-1 : 0]  PCS_ERR_BLOCKS_RD           = 'd65;
localparam [NB_OPCODE-1 : 0]  PCS_TEST_PATTRN_ERR_RD      = 'd66;
localparam [NB_OPCODE-1 : 0]  PCS_LANE_MAP_A_RD           = 'd67;
localparam [NB_OPCODE-1 : 0]  PCS_LANE_MAP_B_RD           = 'd68;
localparam [NB_OPCODE-1 : 0]  PCS_LANE_MAP_C_RD           = 'd69;
localparam [NB_OPCODE-1 : 0]  PCS_LANE_MAP_D_RD           = 'd70;
localparam [NB_OPCODE-1 : 0]  PCS_LANE_MAP_E_RD           = 'd71;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_0_RD        = 'd72;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_1_RD        = 'd73;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_2_RD        = 'd74;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_3_RD        = 'd75;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_4_RD        = 'd76;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_5_RD        = 'd77;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_6_RD        = 'd78;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_7_RD        = 'd79;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_8_RD        = 'd80;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_9_RD        = 'd81;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_10_RD       = 'd82;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_11_RD       = 'd83;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_12_RD       = 'd84;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_13_RD       = 'd85;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_14_RD       = 'd86;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_15_RD       = 'd87;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_16_RD       = 'd88;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_17_RD       = 'd89;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_18_RD       = 'd90;
localparam [NB_OPCODE-1 : 0]  PCS_BIPERR_LANE_19_RD       = 'd91;

 /* fixme aca debe ir la cantidad registro escribibles y si algun registro como por
  *  ejemplo la msascara necesita multiples escrituras sumar dicho valor tambien
  */
localparam N_CONFIG_REGS = 22; 
/*-----------  Internal Signals ---------*/ 

wire [NB_OPCODE-1 : 0]            comm_opcode;
wire [NB_COMM_DATA-1 : 0]         comm_data;
wire                              comm_enable;
reg [NB_GPIO-1 : 0]               gpio_out_data;
reg [NB_GPIO-1 : 0]               gpio_out_data_next;

(* keep = "true" *) reg [NB_COMM_DATA-1 : 0]   config_memory [N_CONFIG_REGS -1 : 0];

/*----------- Read logic ------------ */

assign comm_opcode = i_gpio[NB_GPIO-1 -: NB_OPCODE];
assign comm_data   = i_gpio[0 +: NB_COMM_DATA];
assign comm_enable = i_gpio[COMM_ENB_POS];

always @ (posedge i_clock)
begin
        if (i_reset)
                gpio_out_data <= {NB_GPIO{1'b0}};

        else if (comm_enable)
                gpio_out_data <= gpio_out_data_next;
end

assign o_gpio = gpio_out_data;
always @ (*)
begin
        gpio_out_data_next = gpio_out_data;

        case(comm_opcode)
        PCS_STATUS_RD:
                gpio_out_data_next = {28'd0, &i_pcs_block_lock, &i_pcs_lane_aligned, 
                                            i_pcs_all_deskew, i_pcs_all_reorder};

        PCS_HI_BER_RD:
                gpio_out_data_next = {12'd0, i_pcs_hi_ber};

        PCS_BLOCK_LOCK_RD:
                gpio_out_data_next = {12'd0, i_pcs_block_lock};

        PCS_ALIGN_LOCK_RD:
                gpio_out_data_next = {12'd0, i_pcs_lane_aligned};

        PCS_BERCNT_LANE_0_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*0 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_1_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*1 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_2_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*2 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_3_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*3 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_4_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*4 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_5_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*5 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_6_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*6 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_7_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*7 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_8_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*8 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_9_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*9 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_10_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*10 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_11_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*11 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_12_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*12 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_13_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*13 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_14_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*14 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_15_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*15 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_16_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*16 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_17_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*17 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_18_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*18 -: NB_BER_CNT]};

        PCS_BERCNT_LANE_19_RD:
                gpio_out_data_next = {12'd0, i_pcs_ber_counter[NB_BUS_BERCNT - 1 - NB_BER_CNT*19 -: NB_BER_CNT]};

        PCS_BERCNT_COMMON_RD:
                gpio_out_data_next = {5'd0, i_pcs_ber_common};

        PCS_ERR_BLOCKS_RD:
                gpio_out_data_next = i_pcs_decoder_err;

        PCS_TEST_PATTRN_ERR_RD:
                gpio_out_data_next = {16'd0, i_pcs_pattern_err} ;

        /* 8bit aligned ids */
        PCS_LANE_MAP_A_RD:
                gpio_out_data_next = { 3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*0  -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*1  -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*2  -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*3  -: NB_LANE_ID]
                                     };
        PCS_LANE_MAP_B_RD:
                gpio_out_data_next = { 3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*4  -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*5  -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*6  -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*7  -: NB_LANE_ID]
                                     };
        PCS_LANE_MAP_C_RD:
                gpio_out_data_next = { 3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*8  -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*9  -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*10 -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*11 -: NB_LANE_ID]
                                     };
        PCS_LANE_MAP_D_RD:
                gpio_out_data_next = { 3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*12 -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*13 -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*14 -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*15 -: NB_LANE_ID]
                                     };

        PCS_LANE_MAP_E_RD:
                gpio_out_data_next = { 3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*16 -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*17 -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*18 -: NB_LANE_ID],
                                       3'b0,i_pcs_lane_ids[NB_BUS_LANEID - 1 - NB_LANE_ID*19 -: NB_LANE_ID]
                                     };
        PCS_BIPERR_LANE_0_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*0 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_1_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*1 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_2_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*2 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_3_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*3 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_4_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*4 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_5_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*5 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_6_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*6 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_7_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*7 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_8_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*8 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_9_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*9 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_10_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*10 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_11_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*11 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_12_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*12 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_13_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*13 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_14_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*14 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_15_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*15 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_16_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*16 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_17_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*17 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_18_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*18 -: NB_BIP_ERR];
       
        PCS_BIPERR_LANE_19_RD:
                gpio_out_data_next = i_pcs_bip_err[NB_BUS_BIPERR - 1 - NB_BIP_ERR*19 -: NB_BIP_ERR];
       //FIXME
        /*
        PCS_FCHK:
                gpio_out_data_next = ;
        PCS_FCHK:
                gpio_out_data_next = ;
        PCS_FCHK:
                gpio_out_data_next = ;
        PCS_FCHK:
                gpio_out_data_next = ;
        */
        endcase
end

/*------------ Write logic ------------*/

localparam NB_WR_ADDR = $clog2(N_CONFIG_REGS);
wire [NB_WR_ADDR-1 : 0] wr_addr;
assign wr_addr = (comm_opcode > N_CONFIG_REGS) ? 0 : comm_opcode;

integer k;
always @ (posedge i_clock)
begin
        if (i_reset)
        begin
                for(k = 0; k < N_CONFIG_REGS; k=k+1)
                        config_memory[k] <= {NB_COMM_DATA{1'b0}};
        end
        else if (comm_enable)
               config_memory[wr_addr] <= comm_data;
end
/* estos van sobre la misma posisicon de memoria*/
assign o_soft_reset               = config_memory[PCS_CONTROL_WR][0];
assign o_loopback                 = config_memory[PCS_CONTROL_WR][1];
assign o_tx_test_pattern          = config_memory[PCS_CONTROL_WR][2];
assign o_rx_test_pattern          = config_memory[PCS_CONTROL_WR][3];
/*hast aca misma posicion*/

assign o_enable_modules           = config_memory[PCS_ENABLE_MODULES_WR]; 

//FIXME
//setear los bits correstos
assign o_blksync_invalid_sh_limit = config_memory[PCS_BLKSYNC_INVALID_SH_LIM]  [0 +: N_LANES];
assign o_blksync_locked_window    = config_memory[PCS_BLKSYNC_LOCKED_WINDOW]   [0 +: N_LANES];
assign o_blksync_unlocked_window  = config_memory[PCS_BLKSYNC_UNLOCKED_WINDOW] [0 +: N_LANES];
assign o_align_invalid_thr        = config_memory[PCS_ALIGN_INVALID_THR]        [0 +: N_LANES];
assign o_align_valid_thr          = config_memory[PCS_ALIGN_VALID_THR]         [0 +: N_LANES];
assign o_align_mask               = {config_memory[PCS_ALIGN_MASK_HIGH],
                                     config_memory[PCS_ALIGN_MASK_MID],
                                     config_memory[PCS_ALIGN_MASK_LOW]};

//FIXME revisar localparams de configuracion de canal

assign o_channel_select           = config_memory[CHNL_LANE_SEL_WR]  [0 +: N_LANES];        //1 canal por lane
assign o_channel_update           = config_memory[CHNL_UPDATE_WR]    [0 +: N_CHNL_MODULES]; // 1 por modulo
assign o_channel_start_break      = config_memory[CHNL_START_SEQ_WR] [0 +: N_LANES];        //1 canal por lane
assign o_channel_mode             = config_memory[CHNL_MODE_WR]      [0 +: NB_CHNL_MODE];
assign o_channel_burst            = config_memory[CHNL_BURST_WR]     [0 +: NB_CHNL_BURST];
assign o_channel_period           = config_memory[CHNL_PERIOD_WR]    [0 +: NB_CHNL_PERIOD];
assign o_channel_repeat           = config_memory[CHNL_REPEAT_WR]    [0 +: NB_CHNL_REPEAT];
assign o_channel_skew             = config_memory[CHNL_SKEW_WR]      [0 +: NB_CHNL_SKEW]; 

endmodule
