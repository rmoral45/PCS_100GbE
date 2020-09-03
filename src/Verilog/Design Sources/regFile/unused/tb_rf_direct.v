`timescale 1ns/100ps

module tb_rf_direct;

        localparam N_LANES        = 20;
        localparam N_PCS_MODULES  = 24;
        localparam N_CHNL_MODULES = 4;
        /* inout from uBlaze */
        localparam NB_GPIO        = 32;
        
        /* s from PCS */
        localparam NB_STATUS      = 4;
        localparam NB_HIBER       = 20;
        localparam NB_BLK_LOCK    = 20;
        localparam NB_LANE_ALIGN  = 20;
        localparam NB_BER_CNT     = 20;
        localparam NB_BUS_BERCNT  = 20 * N_LANES;
        localparam NB_BER_COMMON  = 27;
        localparam NB_ERR_BLOCKS  = 32;
        localparam NB_TEST_PATT   = 16;
        localparam NB_LANE_ID     = 5;
        localparam NB_BUS_LANEID  = NB_LANE_ID * N_LANES;
        localparam NB_BIP_ERR     = 32;
        localparam NB_BUS_BIPERR  = NB_BIP_ERR * N_LANES;

        localparam NB_INV_SH_LIM    = 20;
        localparam NB_LOCK_WINDOW   = 20;
        localparam NB_UNLOCK_WINDOW = 20;
        localparam NB_INVALID_THR   = 20;
        localparam NB_VALID_THR     = 20;
        localparam NB_MASK          = 66;

        localparam NB_CHNL_UPDATE = 20;
        localparam NB_CHNL_MODE   = 4;
        localparam NB_CHNL_BURST  = 22;
        localparam NB_CHNL_PERIOD = 22;
        localparam NB_CHNL_REPEAT = 22;
        localparam NB_CHNL_SKEW   = 5;

        

         reg                             tb_i_clock;
         reg                             tb_i_reset;
         reg [NB_GPIO-1 : 0]             tb_i_gpio;
         reg [N_LANES-1 : 0]             tb_i_pcs_block_lock;
         reg [N_LANES-1 : 0]             tb_i_pcs_lane_aligned;
         reg                             tb_i_pcs_all_deskew;
         reg                             tb_i_pcs_all_reorder;
         reg [N_LANES-1 : 0]             tb_i_pcs_htb_i_ber;
         reg [NB_BUS_BERCNT-1 : 0]       tb_i_pcs_ber_counter;
         reg [NB_BER_COMMON-1 : 0]       tb_i_pcs_ber_common;
         reg [NB_ERR_BLOCKS-1 : 0]       tb_i_pcs_decoder_err;
         reg [NB_TEST_PATT-1 : 0]        tb_i_pcs_pattern_err;
         reg [NB_BUS_LANEID-1 : 0]       tb_i_pcs_lane_ids;
         reg [NB_BUS_BIPERR-1 : 0]       tb_i_pcs_bip_err;

         wire [NB_GPIO-1 : 0]             tb_o_gpio;
         wire                             tb_o_soft_reset;
         wire                             tb_o_loopback;
         wire                             tb_o_tx_test_pattern;
         wire                             tb_o_rx_test_pattern;
         wire [N_PCS_MODULES-1 : 0]       tb_o_enable_modules;

         wire [NB_INV_SH_LIM-1 : 0]       tb_o_blksync_invalid_sh_limit;
         wire [NB_LOCK_WINDOW-1 : 0]      tb_o_blksync_locked_window;
         wire [NB_UNLOCK_WINDOW-1 : 0]    tb_o_blksync_unlocked_window;
         wire [NB_INVALID_THR-1 : 0]      tb_o_align_invalid_thr;
         wire [NB_VALID_THR-1 : 0]        tb_o_align_valid_thr;
         wire [NB_MASK-1 : 0]             tb_o_align_mask;

         wire [N_LANES-1 : 0]             tb_o_channel_select; //1 canal por lane
         wire [N_CHNL_MODULES-1 : 0]      tb_o_channel_update;
         wire [N_LANES-1 : 0]             tb_o_channel_start_break; //1 canal por lane
         wire [NB_CHNL_MODE-1 : 0]        tb_o_channel_mode;
         wire [NB_CHNL_BURST-1 : 0]       tb_o_channel_burst;
         wire [NB_CHNL_PERIOD-1 : 0]      tb_o_channel_period;
         wire [NB_CHNL_REPEAT-1 : 0]      tb_o_channel_repeat;
         wire [NB_CHNL_SKEW-1 : 0]        tb_o_channel_skew;


/*------------  Localparams -------------*/

/* GPIO input format : {opcode,enb,data} */
localparam NB_OPCODE    = 7;
localparam NB_COMM_ENB  = 1;
localparam COMM_ENB_POS = NB_GPIO - 1 - NB_OPCODE;
localparam NB_COMM_DATA = NB_GPIO - NB_COMM_ENB - NB_OPCODE;
localparam COMM_DATA_POS = COMM_ENB_POS - 1;
localparam N_PCS_MODES = 4;

reg [NB_OPCODE-1 : 0]    opcode;
reg                      enable;
reg [NB_COMM_DATA-1 : 0] comm_data;

initial
begin
         tb_i_clock = 0;
         tb_i_reset = 1;
         tb_i_gpio  = 0;
         tb_i_pcs_block_lock ='hffffffff;
         tb_i_pcs_lane_aligned  = 'hffffffff;
         tb_i_pcs_all_deskew = 'hfffffff;
         tb_i_pcs_all_reorder = 1;
         tb_i_pcs_htb_i_ber = 'h0000;
         tb_i_pcs_ber_counter = 'hffffffffffffffffffffff;
         tb_i_pcs_ber_common = 'hfffffffffffffffffffffff;
         tb_i_pcs_decoder_err = 'h0000000000000000000000;
         tb_i_pcs_pattern_err = 'd0;
         tb_i_pcs_lane_ids = {5'd0, 5'd1,5'd2,5'd3,5'd4,5'd5,5'd6,5'd7,5'd8,5'd9,
                              5'd10,5'd11,5'd12,5'd13,5'd14,5'd15,5'd16,5'd17,5'd18, 5'd19 };
         tb_i_pcs_bip_err = 'd0;

        #30
                tb_i_reset = 0;

        #10   //Start parameter reading sequence ---- triple write 

                //Request 
                opcode = 'd40; //PCS_STATUS
                enable = 0;
                comm_data = 'd0 ;
                tb_i_gpio = {opcode,enable,comm_data};
                opcode = 'd40;
                enable = 1;
                comm_data = 'd0 ;
                tb_i_gpio = {opcode,enable,comm_data};
                opcode = 'd40;
                enable = 1;
                comm_data = 'd0 ;
                tb_i_gpio = {opcode,enable,comm_data};
        #10
                //Request 
                opcode = 'd67; //LANE MAP A
                enable = 0;
                comm_data = 'd0 ;
                tb_i_gpio = {opcode,enable,comm_data};
                opcode = 'd67;
                enable = 1;
                comm_data = 'd0 ;
                tb_i_gpio = {opcode,enable,comm_data};
                opcode = 'd67;
                enable = 1;
                comm_data = 'd0 ;
                tb_i_gpio = {opcode,enable,comm_data};
        #10
                //Request 
                opcode = 'd71; //LANE_MAP_E
                enable = 0;
                comm_data = 'd0 ;
                tb_i_gpio = {opcode,enable,comm_data};
                opcode = 'd71;
                enable = 1;
                comm_data = 'd0 ;
                tb_i_gpio = {opcode,enable,comm_data};
                opcode = 'd71;
                enable = 0;
                comm_data = 'd0 ;
                tb_i_gpio = {opcode,enable,comm_data};

        // ------------  Config  ---------------
        #10
                //Request 
                opcode = 'd1; //PCS_CONTROL
                enable = 1;
                comm_data = 'hff ;
                tb_i_gpio = {opcode,enable,comm_data};
        #10
                //Request 
                opcode = 'd2; //enable_modules
                enable = 1;
                comm_data = 'hffffff ;
                tb_i_gpio = {opcode,enable,comm_data};
        #10
                //Request 
                opcode = 'd3; //sh_invalid_lim
                enable = 1;
                comm_data = 'd40 ;
                tb_i_gpio = {opcode,enable,comm_data};
        #10
                //Request 
                opcode = 'd4; //blksync_locked_window
                enable = 1;
                comm_data = 'd2048 ;
                tb_i_gpio = {opcode,enable,comm_data};
        #10
                //Request 
                opcode = 'd5; //blksync_unlocked_window
                enable = 1;
                comm_data = 'd64 ;
                tb_i_gpio = {opcode,enable,comm_data};
        #10
                //Request 
                opcode = 'd6; //align_invalid_thr
                enable = 1;
                comm_data = 'd5 ;
                tb_i_gpio = {opcode,enable,comm_data};
        #10
                //Request 
                opcode = 'd7; //align_valid_thr
                enable = 1;
                comm_data = 'd1 ;
                tb_i_gpio = {opcode,enable,comm_data};
        #10
                //Request 
                opcode = 'd8; //AM_mask_low
                enable = 1;
                comm_data = 'd0 ;
                tb_i_gpio = {opcode,enable,comm_data};
        #10
                //Request 
                opcode = 'd9; //AM_mask_mid
                enable = 1;
                comm_data = 'hAAAAAA ;
                tb_i_gpio = {opcode,enable,comm_data};
        #10
                //Request 
                opcode = 'd10; //AM_mask_high
                enable = 1;
                comm_data = 'hFFFFFFFF ;
                tb_i_gpio = {opcode,enable,comm_data};
        /*#10
                //Request 
                opcode = 'd11; //LANE_MAP_E
                enable = 0;
                comm_data = 'd0 ;
                tb_i_gpio = {opcode,enable,comm_data};
        #10
                //Request 
                opcode = 'd71; //LANE_MAP_E
                enable = 0;
                comm_data = 'd0 ;
                tb_i_gpio = {opcode,enable,comm_data};
        #10
                //Request 
                opcode = 'd71; //LANE_MAP_E
                enable = 0;
                comm_data = 'd0 ;
                tb_i_gpio = {opcode,enable,comm_data};
        #10
                //Request 
                opcode = 'd71; //LANE_MAP_E
                enable = 0;
                comm_data = 'd0 ;
                tb_i_gpio = {opcode,enable,comm_data};
        */
end

always #1 tb_i_clock = ~tb_i_clock;


rf_direct
#(
 )
        u_rf_direct
        (
                .i_clock                (tb_i_clock),
                .i_reset                (tb_i_reset),
                .i_gpio                 (tb_i_gpio),
                .i_pcs_block_lock       (tb_i_pcs_block_lock),
                .i_pcs_lane_aligned     (tb_i_pcs_lane_aligned),
                .i_pcs_all_deskew       (tb_i_pcs_all_deskew),
                .i_pcs_all_reorder      (tb_i_pcs_all_reorder),
                .i_pcs_hi_ber           (tb_i_pcs_hi_ber),
                .i_pcs_ber_counter      (tb_i_pcs_ber_counter),
                .i_pcs_ber_common       (tb_i_pcs_ber_common),
                .i_pcs_decoder_err      (tb_i_pcs_decoder_err),
                .i_pcs_pattern_err      (tb_i_pcs_pattern_err),
                .i_pcs_lane_ids         (tb_i_pcs_lane_ids),
                .i_pcs_bip_err          (tb_i_pcs_bip_err),


                .o_gpio                         (tb_o_gpio),
                .o_soft_reset                   (tb_o_soft_reset),
                .o_loopback                     (tb_o_loopback),
                .o_tx_test_pattern              (tb_o_tx_test_pattern),
                .o_rx_test_pattern              (tb_o_rx_test_pattern),
                .o_enable_modules               (tb_o_enable_modules),
                .o_blksync_invalid_sh_limit     (tb_o_blksync_invalid_sh_limit),
                .o_blksync_locked_window        (tb_o_blksync_locked_window),
                .o_blksync_unlocked_window      (tb_o_blksync_unlocked_window),
                .o_align_invalid_thr            (tb_o_align_invalid_thr),
                .o_align_valid_thr              (tb_o_align_valid_thr),
                .o_align_mask                   (tb_o_align_mask),
                .o_channel_select               (tb_o_channel_select),
                .o_channel_update               (tb_o_channel_update),
                .o_channel_start_break          (tb_o_channel_start_break),
                .o_channel_mode                 (tb_o_channel_mode),
                .o_channel_burst                (tb_o_channel_burst),
                .o_channel_period               (tb_o_channel_period),
                .o_channel_repeat               (tb_o_channel_repeat),
                .o_channel_skew                 (tb_o_channel_skew)
        );
endmodule
