
module rf_write
#(
    parameter NB_ENABLE_RF  = 1,
    parameter NB_ADDR       = 9, //slice of GPIOmused for addr
    parameter NB_I_DATA     = 22, //slice of GPIO used for data
    parameter NB_GPIO       = 32,
    parameter N_LANES       = 20,

    //Channel parameters
    parameter NB_CODED_BLOCK = 66,
    parameter NB_ERR_MASK    = NB_CODED_BLOCK-2,    //mascara, se romperan los bits cuya posicon en la mascara sea 1
    parameter MAX_ERR_BURST  = 1024,                //cantidad de bloques consecutivos que se romperan
    parameter MAX_ERR_PERIOD = 1024,                //cantidad de bloqus por periodo de error ver NOTAS.
    parameter MAX_ERR_REPEAT = 10,                  //cantidad de veces que se repite el mismo patron de error
    parameter NB_BURST_CNT   = $clog2(MAX_ERR_BURST),
    parameter NB_PERIOD_CNT  = $clog2(MAX_ERR_PERIOD),
    parameter NB_REPEAT_CNT  = $clog2(MAX_ERR_REPEAT),
    parameter N_MODES        = 4,
    parameter MAX_SKEW_INDEX = NB_CODED_BLOCK-2,
    parameter NB_SKEW_INDEX  = $clog2(MAX_SKEW_INDEX),
    //Block sync parameters
    parameter MAX_WINDOW     = 4096,
    parameter MAX_INVALID_SH = (MAX_WINDOW/2), 
    parameter NB_WINDOW_CNT  = $clog2(MAX_WINDOW),
    parameter NB_INVALID_CNT = $clog2(MAX_INVALID_SH),
    parameter NB_INDEX       = $clog2(NB_CODED_BLOCK),
    //Am checker parameters
    parameter NB_AM          = 48,
    parameter MAX_INV_AM     = 8,
    parameter NB_INV_AM      = $clog2(MAX_INV_AM),
    parameter MAX_VAL_AM     = 20,
    parameter NB_VAL_AM      = $clog2(MAX_VAL_AM),
    parameter NB_AM_PERIOD   = 14,

    //Default parameters
    parameter AM_PERIOD_BLOCKS        = 16383
 )   
(
    input wire                  i_clock,
    input wire                  i_reset,
    input wire [NB_GPIO-1 : 0]  i_gpio_data,

    //-----------------------Global-----------------------
    output wire                                 o_pcs__i_rf_reset,
    output wire                                 o_pcs__i_rf_loopback,
    output wire                                 o_pcs__i_rf_idle_pattern_mode,
    output wire                                 o_clock_comp__i_rf_enable,

    //-----------------------Tx-----------------------
    output wire                                 o_frame_gen__i_rf_enable,
    output wire                                 o_encoder__i_rf_enable,
    output wire                                 o_scrambler__i_rf_enable,
    output wire                                 o_scrambler__i_rf_bypass,
    output wire                                 o_tx_pc__i_rf_enable,
    output wire                                 o_pcs__i_rf_enable_tx_am_insertion,

    //-----------------------Channel-----------------------
    output wire [N_LANES-1              : 0]    o_channel__i_rf_update_payload,
    output wire [N_MODES-1              : 0]    o_channel__i_rf_payload_mode,
    output wire [NB_ERR_MASK-1          : 0]    o_channel__i_rf_payload_err_mask,
    output wire [NB_BURST_CNT-1         : 0]    o_channel__i_rf_payload_err_burst,
    output wire [NB_PERIOD_CNT-1        : 0]    o_channel__i_rf_payload_err_period,
    output wire [NB_REPEAT_CNT-1        : 0]    o_channel__i_rf_payload_err_repeat,
    output wire [N_LANES-1              : 0]    o_channel__i_rf_update_shbreaker,
    output wire [N_MODES-1              : 0]    o_channel__i_rf_shbreaker_mode,
    output wire [NB_BURST_CNT-1         : 0]    o_channel__i_rf_shbreaker_err_burst,
    output wire [NB_PERIOD_CNT-1        : 0]    o_channel__i_rf_shbreaker_err_period,
    output wire [NB_REPEAT_CNT-1        : 0]    o_channel__i_rf_shbreaker_err_repeat,
    output wire [N_LANES-1              : 0]    o_channel__i_rf_update_bitskew,
    output wire [NB_SKEW_INDEX-1        : 0]    o_channel__i_rf_bit_skew_index,

    //-----------------------Rx-----------------------
    output wire                                 o_blksync__i_rf_enable,
    output wire                                 o_aligner__i_rf_enable,
    output wire                                 o_deskew__i_rf_enable,
    output wire                                 o_reorder__i_rf_enable,
    output wire                                 o_descrambler__i_rf_enable,
    output wire                                 o_descrambler__i_rf_bypass,
    output wire                                 o_ptrncheck__i_rf_enable,
    output wire                                 o_decoder__i_rf_enable,
    output wire [NB_WINDOW_CNT-1        : 0]    o_blksync__i_rf_locked_timer_limit,
    output wire [NB_WINDOW_CNT-1        : 0]    o_blksync__i_rf_unlocked_timer_limit,
    output wire [NB_INVALID_CNT-1       : 0]    o_blksync__i_rf_sh_invalid_limit,
    output wire [NB_INV_AM-1            : 0]    o_aligner__i_rf_invalid_am_thr,
    output wire [NB_VAL_AM-1            : 0]    o_aligner__i_rf_valid_am_thr,
    output wire [NB_AM_PERIOD-1         : 0]    o_aligner__i_rf_am_period,
    output wire [NB_AM-1                : 0]    o_aligner__i_rf_compare_mask,
    
    output wire                                 o_reorder__i_rf_reset_order,
        
    //-----------------------COR registers-----------------------
    output wire [N_LANES-1 : 0]                 o_bermonitor__i_rf_cor_hi_ber,
    output wire [N_LANES-1 : 0]                 o_aligner__i_cor_bip_error,
    output wire [N_LANES-1 : 0]                 o_aligner__i_cor_resync_counters,
    output wire [N_LANES-1 : 0]                 o_aligner__i_cor_am_lock,
    output wire [N_LANES-1 : 0]                 o_aligner__i_cor_lanes_id,

    output wire                                 o_deskew__i_cor_invalid_deskew,
    output wire [N_LANES-1 : 0]                 o_blocklock__i_cor_sh_lock,
    output wire                                 o_ptrncheck__i_cor_mismatch_counters,
    output wire                                 o_decoder__i_cor_err_counter
);

/*
    - Se tienen 348 posiciones de memoria para usar --> 9 bits (LSB) del gpio son direccionamiento.
    - Se debe usar un bit para el enable de la escritura del rf register seleccionado (bit 31, MSB bit).
    - Restan un total de 32 - 9 - 1 = 22 bits para dato.
    - Por lo tanto: 
        i_gpio_data[21:0]   = rf_input_data
        i_gpio_data[30:22]  = rf_input_addr
        i_gpio_data[31]     = rf_input_enable
*/

    //REGISTER DECLARATION INCLUDE
    `include "./wr_reg_decl.v"

    //REGISTER ADDRESS INCLUDE
    `include "./reg_addr_decl.v"

    wire                            rf_input_enable;
    wire    [NB_ADDR-1      : 0]    rf_input_addr;
    wire    [NB_I_DATA-1    : 0]    rf_input_data;

    assign                          rf_input_enable = i_gpio_data[NB_GPIO- NB_ENABLE_RF];
    assign                          rf_input_data   = i_gpio_data[NB_GPIO - NB_ENABLE_RF - NB_ADDR - 1 -: NB_I_DATA];
    assign                          rf_input_addr   = i_gpio_data[NB_GPIO - NB_ENABLE_RF - 1 -: NB_ADDR];


    
    //REGISTER LOGIC
    always @ (posedge i_clock) begin
        if (i_reset)
            pcs__i_rf_reset <= 1'b0;
        else if ((rf_input_addr == PCS__I_RF_RESET) && rf_input_enable)   
            pcs__i_rf_reset <= rf_input_data[0];
        else
            pcs__i_rf_reset <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            pcs__i_rf_loopback <= 1'b0;
        else if ((rf_input_addr == PCS__I_RF_LOOPBACK) && rf_input_enable)   
            pcs__i_rf_loopback <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            pcs__i_rf_idle_pattern_mode <= 1'b0;
        else if ((rf_input_addr == PCS__I_RF_IDLE_PATTERN_MODE) && rf_input_enable)   
            pcs__i_rf_idle_pattern_mode <= rf_input_data[0];
     end

    always @ (posedge i_clock) begin
        if (i_reset)
            encoder__i_rf_enable <= 1'b0;
        else if ((rf_input_addr == ENCODER__I_RF_ENABLE) && rf_input_enable)   
            encoder__i_rf_enable <= rf_input_data[0];
     end

    always @ (posedge i_clock) begin
        if (i_reset)
            frame_gen__i_rf_enable <= 1'b0;
        else if ((rf_input_addr == FRAME_GENERATOR__I_RF_ENABLE) && rf_input_enable)   
            frame_gen__i_rf_enable <= rf_input_data[0];
     end

    always @ (posedge i_clock) begin
        if (i_reset)
            tx_pc__i_rf_enable <= 1'b0;
        else if ((rf_input_addr == TX_PC__I_RF_ENABLE) && rf_input_enable)   
            tx_pc__i_rf_enable <= rf_input_data[0];
     end     

     always @ (posedge i_clock) begin
        if (i_reset)
            pcs__i_rf_enable_tx_am_insertion <= 1'b1;
        else if ((rf_input_addr == PCS__I_RF_ENABLE_TX_AM_INSERTION) && rf_input_enable)   
            pcs__i_rf_enable_tx_am_insertion <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            scrambler__i_rf_enable <= 1'b1;
        else if ((rf_input_addr == SCRAMBLER__I_RF_ENABLE) && rf_input_enable)   
            scrambler__i_rf_enable <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            scrambler__i_rf_bypass <= 1'b0;
        else if ((rf_input_addr == SCRAMBLER__I_RF_BYPASS) && rf_input_enable)   
            scrambler__i_rf_bypass <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            deskew__i_rf_enable <= 1'b1;
        else if ((rf_input_addr == DESKEW__I_RF_ENABLE) && rf_input_enable)   
            deskew__i_rf_enable <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            deskew__i_rf_cor_invalid_skew <= 1'b1;
        else if ((rf_input_addr == DESKEW__O_COR_INVALID_SKEW) && rf_input_enable)   
            deskew__i_rf_cor_invalid_skew <= rf_input_data[0];
     end     

     always @ (posedge i_clock) begin
        if (i_reset)
            reorder__i_rf_reset_order <= 1'b0;
        else if ((rf_input_addr == REORDER__I_RF_RESET_ORDER) && rf_input_enable)   
            reorder__i_rf_reset_order <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            descrambler__i_rf_enable <= 1'b1;
        else if ((rf_input_addr == DESCRAMBLER__I_RF_ENABLE) && rf_input_enable)   
            descrambler__i_rf_enable <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            descrambler__i_rf_bypass <= 1'b0;
        else if ((rf_input_addr == DESCRAMBLER__I_RF_BYPASS) && rf_input_enable)   
            descrambler__i_rf_bypass <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            decoder__i_rf_cor_err_counter <= 1'b1;
        else if ((rf_input_addr == DECODER__I_COR_ERROR_COUNTER) && rf_input_enable)   
            decoder__i_rf_cor_err_counter <= rf_input_data[0];
        else
            decoder__i_rf_cor_err_counter <= 1'b0;
     end    

    always @ (posedge i_clock) begin
        if (i_reset)
            decoder__i_rf_enable <= 1'b1;
        else if ((rf_input_addr == DECODER__I_RF_ENABLE) && rf_input_enable)   
            decoder__i_rf_enable <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_update_payload_base <= 1'b0;
        else if ((rf_input_addr == CHANNEL__I_RF_UPDATE_PAYLOAD_BASE) && rf_input_enable)   
            channel__i_rf_update_payload_base <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel1__i_rf_update_payload <= 1'b0 ;
        else if ((rf_input_addr == CHANNEL1__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel1__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel2__i_rf_update_payload <= 1'b0 ;
        else if ((rf_input_addr == CHANNEL2__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel2__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel3__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL3__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel3__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel4__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL4__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel4__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel5__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL5__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel5__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel6__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL6__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel6__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel7__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL7__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel7__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel8__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL8__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel8__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel9__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL9__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel9__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel10__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL10__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel10__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel11__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL11__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel11__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel12__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL12__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel12__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel13__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL13__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel13__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel14__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL14__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel14__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel15__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL15__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel15__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel16__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL16__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel16__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel17__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL17__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel17__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel18__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL18__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel18__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel19__i_rf_update_payload <= 1'b0;
        else if ((rf_input_addr == CHANNEL19__I_RF_UPDATE_PAYLOAD) && rf_input_enable)   
            channel19__i_rf_update_payload <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_payload_mode <= 4'b0100;
        else if ((rf_input_addr == CHANNEL__I_RF_PAYLOAD_MODE) && rf_input_enable)   
            channel__i_rf_payload_mode <= rf_input_data[N_MODES-1 : 0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_payload_err_mask <= {NB_ERR_MASK{1'b1}};
        else if ((rf_input_addr == CHANNEL__I_RF_PAYLOAD_ERR_MASK) && rf_input_enable)   
            channel__i_rf_payload_err_mask <= rf_input_data[NB_I_DATA-1 : 0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_payload_err_burst <= 0;
        else if ((rf_input_addr == CHANNEL__I_RF_PAYLOAD_ERR_BURST) && rf_input_enable)   
            channel__i_rf_payload_err_burst <= rf_input_data[NB_BURST_CNT-1 : 0]; 
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_payload_err_period <= 0;
        else if ((rf_input_addr == CHANNEL__I_RF_PAYLOAD_ERR_PERIOD) && rf_input_enable)   
            channel__i_rf_payload_err_period <= rf_input_data[NB_PERIOD_CNT-1 : 0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_payload_err_repeat <= 0;
        else if ((rf_input_addr == CHANNEL__I_RF_PAYLOAD_ERR_REPEAT) && rf_input_enable)   
            channel__i_rf_payload_err_repeat <= rf_input_data[NB_REPEAT_CNT-1 : 0]; 
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_update_shbreaker_base <= 1'b0;
        else if ((rf_input_addr == CHANNEL__I_RF_UPDATE_SHBREAKER_BASE) && rf_input_enable)   
            channel__i_rf_update_shbreaker_base <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel1__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL1__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel1__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel2__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL2__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel2__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel3__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL3__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel3__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel4__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL4__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel4__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel5__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL5__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel5__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel6__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL6__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel6__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel7__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL7__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel7__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel8__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL8__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel8__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel9__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL9__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel9__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel10__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL10__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel10__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel11__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL11__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel11__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel12__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL12__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel12__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel13__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL13__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel13__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel14__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL14__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel14__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel15__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL15__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel15__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel16__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL16__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel16__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel17__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL17__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel17__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel18__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL18__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel18__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel19__i_rf_update_shbreaker <= 1'b0;
        else if ((rf_input_addr == CHANNEL19__I_RF_UPDATE_SHBREAKER) && rf_input_enable)   
            channel19__i_rf_update_shbreaker <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_shbreaker_mode <= 4'b0100;
        else if ((rf_input_addr == CHANNEL__I_RF_SHBREAKER_MODE) && rf_input_enable)   
            channel__i_rf_shbreaker_mode <= rf_input_data[N_MODES-1 : 0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_shbreaker_err_burst <= 0;
        else if ((rf_input_addr == CHANNEL__I_RF_SHBREAKER_ERR_BURST) && rf_input_enable)   
            channel__i_rf_shbreaker_err_burst <= rf_input_data[NB_BURST_CNT-1 : 0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_shbreaker_err_period <= 0;
        else if ((rf_input_addr == CHANNEL__I_RF_SHBREAKER_ERR_PERIOD) && rf_input_enable)   
            channel__i_rf_shbreaker_err_period <= rf_input_data[NB_PERIOD_CNT-1 : 0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_shbreaker_err_repeat <= 0;
        else if ((rf_input_addr == CHANNEL__I_RF_SHBREAKER_ERR_REPEAT) && rf_input_enable)   
            channel__i_rf_shbreaker_err_repeat <= rf_input_data[NB_REPEAT_CNT-1 : 0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_update_bitskew_base <= 1'b0;
        else if ((rf_input_addr == CHANNEL__I_RF_UPDATE_BITSKEW_BASE) && rf_input_enable)   
            channel__i_rf_update_bitskew_base <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel1__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL1__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel1__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel2__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL2__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel2__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel3__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL3__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel3__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel4__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL4__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel4__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel5__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL5__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel5__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel6__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL6__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel6__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel7__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL7__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel7__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel8__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL8__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel8__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel9__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL9__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel9__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel10__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL10__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel10__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel11__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL11__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel11__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel12__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL12__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel12__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel13__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL13__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel13__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel14__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL14__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel14__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel15__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL15__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel15__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel16__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL16__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel16__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel17__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL17__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel17__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel18__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL18__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel18__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel19__i_rf_update_bitskew <= 1'b0;
        else if ((rf_input_addr == CHANNEL19__I_RF_UPDATE_BITSKEW) && rf_input_enable)   
            channel19__i_rf_update_bitskew <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_bit_skew_index <= 0;
        else if ((rf_input_addr == CHANNEL__I_RF_BIT_SKEW_INDEX) && rf_input_enable)   
            channel__i_rf_bit_skew_index <= rf_input_data[NB_SKEW_INDEX-1 : 0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            blksync__i_rf_enable <= 1'b1;
        else if ((rf_input_addr == BLKSYNC__I_RF_ENABLE) && rf_input_enable)   
            blksync__i_rf_enable <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner__i_rf_enable <= 1'b1;
        else if ((rf_input_addr == ALIGNER__I_RF_ENABLE) && rf_input_enable)   
            aligner__i_rf_enable <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            reorder__i_rf_enable <= 1'b1;
        else if ((rf_input_addr == REORDER__I_RF_ENABLE) && rf_input_enable)   
            reorder__i_rf_enable <= rf_input_data[0];
     end


     always @ (posedge i_clock) begin
        if (i_reset)
            ptrncheck__i_rf_enable <= 1'b0;
        else if ((rf_input_addr == PTRNCHECK__I_RF_ENABLE) && rf_input_enable)   
            ptrncheck__i_rf_enable <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            ptrncheck__i_rf_cor_mismatch_counter <= 1'b0;
        else if ((rf_input_addr == PTRNCHECK__I_COR_MISMATH_COUNTER) && rf_input_enable)   
            ptrncheck__i_rf_cor_mismatch_counter <= rf_input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            blksync__i_rf_locked_timer_limit <= 1024; 
        else if ((rf_input_addr == BLKSYNC__I_RF_LOCKED_TIMER_LIMIT) && rf_input_enable)   
            blksync__i_rf_locked_timer_limit <= rf_input_data[NB_WINDOW_CNT-1 : 0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            blksync__i_rf_unlocked_timer_limit <= 64; 
        else if ((rf_input_addr == BLKSYNC__I_RF_UNLOCKED_TIMER_LIMIT) && rf_input_enable)   
            blksync__i_rf_unlocked_timer_limit <= rf_input_data[NB_WINDOW_CNT-1 : 0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            blksync__i_rf_sh_invalid_limit <= MAX_INVALID_SH;
        else if ((rf_input_addr == BLKSYNC__I_RF_SH_INVALID_LIMIT) && rf_input_enable)   
            blksync__i_rf_sh_invalid_limit <= rf_input_data[NB_INVALID_CNT-1 : 0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner__i_rf_invalid_am_thr <= MAX_INV_AM;
        else if ((rf_input_addr == ALIGNER__I_RF_INVALID_AM_THR) && rf_input_enable)   
            aligner__i_rf_invalid_am_thr <= rf_input_data[NB_INV_AM-1 : 0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner__i_rf_valid_am_thr <= MAX_VAL_AM;
        else if ((rf_input_addr == ALIGNER__I_RF_VALID_AM_THR) && rf_input_enable)   
            aligner__i_rf_valid_am_thr <= rf_input_data[NB_VAL_AM-1 : 0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner__i_rf_am_period <= AM_PERIOD_BLOCKS;
        else if ((rf_input_addr == ALIGNER__I_RF_AM_PERIOD) && rf_input_enable)   
            aligner__i_rf_am_period <= rf_input_data[NB_AM_PERIOD-1 : 0];
     end
     
     always @ (posedge i_clock) begin
        if (i_reset)
            aligner__i_rf_am_compare_mask <= {NB_AM{1'b1}};
//        else if ((rf_input_addr == ALIGNER__O_RF_COMPARE_MASK_1) && rf_input_enable)   
//            aligner__i_rf_am_period <= rf_input_data[NB_AM_PERIOD-1 : 0];
     end     
     
     

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock__i_rf_cor_sh_lock_base <= 1'b0;
        else if ((rf_input_addr == BLKSYNC__I_COR_BLOCK_LOCK_BASE) && rf_input_enable)   
            block_lock__i_rf_cor_sh_lock_base <= 1'b1;
        else
            block_lock__i_rf_cor_sh_lock_base <= 1'b0;
     end

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock1__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC1__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock1__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock1__i_rf_cor_sh_lock <= 1'b0;
     end

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock2__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC2__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock2__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock2__i_rf_cor_sh_lock <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock3__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC3__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock3__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock3__i_rf_cor_sh_lock <= 1'b0;
     end 

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock4__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC4__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock4__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock4__i_rf_cor_sh_lock <= 1'b0;
     end 

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock5__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC5__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock5__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock5__i_rf_cor_sh_lock <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock6__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC6__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock6__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock6__i_rf_cor_sh_lock <= 1'b0;
     end    

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock7__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC7__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock7__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock7__i_rf_cor_sh_lock <= 1'b0;
     end   

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock8__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC8__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock8__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock8__i_rf_cor_sh_lock <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock9__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC9__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock9__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock9__i_rf_cor_sh_lock <= 1'b0;
     end     

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock10__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC10__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock10__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock10__i_rf_cor_sh_lock <= 1'b0;
     end      

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock11__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC11__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock11__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock11__i_rf_cor_sh_lock <= 1'b0;
     end     

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock12__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC12__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock12__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock12__i_rf_cor_sh_lock <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock13__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC13__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock13__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock13__i_rf_cor_sh_lock <= 1'b0;
     end      

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock14__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC14__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock14__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock14__i_rf_cor_sh_lock <= 1'b0;
     end    

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock15__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC15__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock15__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock15__i_rf_cor_sh_lock <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock16__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC16__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock16__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock16__i_rf_cor_sh_lock <= 1'b0;
     end   

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock17__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC17__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock17__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock17__i_rf_cor_sh_lock <= 1'b0;
     end             

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock18__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC18__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock18__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock18__i_rf_cor_sh_lock <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            block_lock19__i_rf_cor_sh_lock <= 1'b0;
        else if ((rf_input_addr == BLKSYNC19__I_COR_BLOCK_LOCK) && rf_input_enable)   
            block_lock19__i_rf_cor_sh_lock <= 1'b1;
        else
            block_lock19__i_rf_cor_sh_lock <= 1'b0;
     end          


     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor__i_rf_cor_hi_ber_base <= 1'b0;
        else if ((rf_input_addr == BERMONITOR__I_RF_COR_HI_BER_BASE) && rf_input_enable)   
            bermonitor__i_rf_cor_hi_ber_base <= 1'b1;
        else
            bermonitor__i_rf_cor_hi_ber_base <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor1__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR1__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor1__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor1__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor2__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR2__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor2__i_rf_cor_hi_ber <= 1'b1;
        else 
            bermonitor2__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor3__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR3__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor3__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor3__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor4__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR4__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor4__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor4__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor5__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR5__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor5__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor5__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor6__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR6__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor6__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor6__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor7__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR7__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor7__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor7__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor8__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR8__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor8__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor8__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor9__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR9__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor9__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor9__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor10__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR10__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor10__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor10__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor11__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR11__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor11__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor11__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor12__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR12__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor12__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor12__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor13__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR13__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor13__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor13__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor14__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR14__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor14__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor14__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor15__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR15__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor15__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor15__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor16__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR16__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor16__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor16__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor17__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR17__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor17__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor17__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor18__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR18__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor18__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor18__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor19__i_rf_cor_hi_ber <= 1'b0;
        else if ((rf_input_addr == BERMONITOR19__I_RF_COR_HI_BER) && rf_input_enable)   
            bermonitor19__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor19__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner__i_cor_bip_error_base <= 1'b0;
        else if ((rf_input_addr == ALIGNER__I_COR_BIP_ERROR_BASE) && rf_input_enable)   
            aligner__i_cor_bip_error_base <= 1'b1;
        else
            aligner__i_cor_bip_error_base <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner1__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER1__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner1__i_cor_bip_error <= 1'b1;
        else
            aligner1__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner2__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER2__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner2__i_cor_bip_error <= 1'b1;
        else
            aligner2__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner3__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER3__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner3__i_cor_bip_error <= 1'b1;
        else
            aligner3__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner4__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER4__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner4__i_cor_bip_error <= 1'b1;
        else
            aligner4__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner5__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER5__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner5__i_cor_bip_error <= 1'b1;
        else
            aligner5__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner6__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER6__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner6__i_cor_bip_error <= 1'b1;
        else
            aligner6__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner7__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER7__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner7__i_cor_bip_error <= 1'b1;
        else
            aligner7__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner8__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER8__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner8__i_cor_bip_error <= 1'b1;
        else
            aligner8__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner9__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER9__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner9__i_cor_bip_error <= 1'b1;
        else
            aligner9__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner10__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER10__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner10__i_cor_bip_error <= 1'b1;
        else
            aligner10__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner11__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER11__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner11__i_cor_bip_error <= 1'b1;
        else
            aligner11__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner12__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER12__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner12__i_cor_bip_error <= 1'b1;
        else
            aligner12__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner13__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER13__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner13__i_cor_bip_error <= 1'b1;
        else
            aligner13__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner14__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER14__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner14__i_cor_bip_error <= 1'b1;
        else
            aligner14__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner15__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER15__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner15__i_cor_bip_error <= 1'b1;
        else
            aligner15__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner16__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER16__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner16__i_cor_bip_error <= 1'b1;
        else
            aligner16__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner17__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER17__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner17__i_cor_bip_error <= 1'b1;
        else
            aligner17__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner18__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER18__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner18__i_cor_bip_error <= 1'b1;
        else
            aligner18__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner19__i_cor_bip_error <= 1'b0;
        else if ((rf_input_addr == ALIGNER19__I_COR_BIP_ERROR) && rf_input_enable)   
            aligner19__i_cor_bip_error <= 1'b1;
        else
            aligner19__i_cor_bip_error <= 1'b0;
     end

    //====== 
    always @ (posedge i_clock) begin
        if (i_reset)
            aligner__i_cor_resync_counter_base <= 1'b0;
        else if ((rf_input_addr == ALIGNER__I_COR_RESYNC_COUNTER_BASE) && rf_input_enable)   
            aligner__i_cor_resync_counter_base <= 1'b1;
        else
            aligner__i_cor_resync_counter_base <= 1'b0;
     end

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner1__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER1__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner1__i_cor_resync_counter <= 1'b1;
        else
            aligner1__i_cor_resync_counter <= 1'b0;
     end

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner2__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER2__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner2__i_cor_resync_counter <= 1'b1;
        else
            aligner2__i_cor_resync_counter <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner3__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER3__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner3__i_cor_resync_counter <= 1'b1;
        else
            aligner3__i_cor_resync_counter <= 1'b0;
     end 

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner4__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER4__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner4__i_cor_resync_counter <= 1'b1;
        else
            aligner4__i_cor_resync_counter <= 1'b0;
     end 

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner5__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER5__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner5__i_cor_resync_counter <= 1'b1;
        else
            aligner5__i_cor_resync_counter <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner6__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER6__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner6__i_cor_resync_counter <= 1'b1;
        else
            aligner6__i_cor_resync_counter <= 1'b0;
     end    

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner7__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER7__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner7__i_cor_resync_counter <= 1'b1;
        else
            aligner7__i_cor_resync_counter <= 1'b0;
     end   

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner8__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER8__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner8__i_cor_resync_counter <= 1'b1;
        else
            aligner8__i_cor_resync_counter <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner9__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER9__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner9__i_cor_resync_counter <= 1'b1;
        else
            aligner9__i_cor_resync_counter <= 1'b0;
     end     

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner10__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER10__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner10__i_cor_resync_counter <= 1'b1;
        else
            aligner10__i_cor_resync_counter <= 1'b0;
     end      

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner11__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER11__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner11__i_cor_resync_counter <= 1'b1;
        else
            aligner11__i_cor_resync_counter <= 1'b0;
     end     

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner12__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER12__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner12__i_cor_resync_counter <= 1'b1;
        else
            aligner12__i_cor_resync_counter <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner13__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER13__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner13__i_cor_resync_counter <= 1'b1;
        else
            aligner13__i_cor_resync_counter <= 1'b0;
     end      

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner14__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER14__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner14__i_cor_resync_counter <= 1'b1;
        else
            aligner14__i_cor_resync_counter <= 1'b0;
     end    

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner15__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER15__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner15__i_cor_resync_counter <= 1'b1;
        else
            aligner15__i_cor_resync_counter <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner16__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER16__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner16__i_cor_resync_counter <= 1'b1;
        else
            aligner16__i_cor_resync_counter <= 1'b0;
     end   

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner17__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER17__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner17__i_cor_resync_counter <= 1'b1;
        else
            aligner17__i_cor_resync_counter <= 1'b0;
     end             

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner18__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER18__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner18__i_cor_resync_counter <= 1'b1;
        else
            aligner18__i_cor_resync_counter <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner19__i_cor_resync_counter <= 1'b0;
        else if ((rf_input_addr == ALIGNER19__I_COR_RESYNC_COUNTER) && rf_input_enable)   
            aligner19__i_cor_resync_counter <= 1'b1;
        else
            aligner19__i_cor_resync_counter <= 1'b0;
     end                                                                            

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner__i_cor_am_lock_base <= 1'b0;
        else if ((rf_input_addr == ALIGNER__I_COR_AM_LOCK_BASE) && rf_input_enable)   
            aligner__i_cor_am_lock_base <= 1'b1;
        else
            aligner__i_cor_am_lock_base <= 1'b0;
     end

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner1__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER1__I_COR_AM_LOCK) && rf_input_enable)   
            aligner1__i_cor_am_lock <= 1'b1;
        else
            aligner1__i_cor_am_lock <= 1'b0;
     end

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner2__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER2__I_COR_AM_LOCK) && rf_input_enable)   
            aligner2__i_cor_am_lock <= 1'b1;
        else
            aligner2__i_cor_am_lock <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner3__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER3__I_COR_AM_LOCK) && rf_input_enable)   
            aligner3__i_cor_am_lock <= 1'b1;
        else
            aligner3__i_cor_am_lock <= 1'b0;
     end 

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner4__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER4__I_COR_AM_LOCK) && rf_input_enable)   
            aligner4__i_cor_am_lock <= 1'b1;
        else
            aligner4__i_cor_am_lock <= 1'b0;
     end 

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner5__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER5__I_COR_AM_LOCK) && rf_input_enable)   
            aligner5__i_cor_am_lock <= 1'b1;
        else
            aligner5__i_cor_am_lock <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner6__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER6__I_COR_AM_LOCK) && rf_input_enable)   
            aligner6__i_cor_am_lock <= 1'b1;
        else
            aligner6__i_cor_am_lock <= 1'b0;
     end    

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner7__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER7__I_COR_AM_LOCK) && rf_input_enable)   
            aligner7__i_cor_am_lock <= 1'b1;
        else
            aligner7__i_cor_am_lock <= 1'b0;
     end   

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner8__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER8__I_COR_AM_LOCK) && rf_input_enable)   
            aligner8__i_cor_am_lock <= 1'b1;
        else
            aligner8__i_cor_am_lock <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner9__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER9__I_COR_AM_LOCK) && rf_input_enable)   
            aligner9__i_cor_am_lock <= 1'b1;
        else
            aligner9__i_cor_am_lock <= 1'b0;
     end     

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner10__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER10__I_COR_AM_LOCK) && rf_input_enable)   
            aligner10__i_cor_am_lock <= 1'b1;
        else
            aligner10__i_cor_am_lock <= 1'b0;
     end      

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner11__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER11__I_COR_AM_LOCK) && rf_input_enable)   
            aligner11__i_cor_am_lock <= 1'b1;
        else
            aligner11__i_cor_am_lock <= 1'b0;
     end     

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner12__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER12__I_COR_AM_LOCK) && rf_input_enable)   
            aligner12__i_cor_am_lock <= 1'b1;
        else
            aligner12__i_cor_am_lock <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner13__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER13__I_COR_AM_LOCK) && rf_input_enable)   
            aligner13__i_cor_am_lock <= 1'b1;
        else
            aligner13__i_cor_am_lock <= 1'b0;
     end      

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner14__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER14__I_COR_AM_LOCK) && rf_input_enable)   
            aligner14__i_cor_am_lock <= 1'b1;
        else
            aligner14__i_cor_am_lock <= 1'b0;
     end    

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner15__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER15__I_COR_AM_LOCK) && rf_input_enable)   
            aligner15__i_cor_am_lock <= 1'b1;
        else
            aligner15__i_cor_am_lock <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner16__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER16__I_COR_AM_LOCK) && rf_input_enable)   
            aligner16__i_cor_am_lock <= 1'b1;
        else
            aligner16__i_cor_am_lock <= 1'b0;
     end   

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner17__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER17__I_COR_AM_LOCK) && rf_input_enable)   
            aligner17__i_cor_am_lock <= 1'b1;
        else
            aligner17__i_cor_am_lock <= 1'b0;
     end             

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner18__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER18__I_COR_AM_LOCK) && rf_input_enable)   
            aligner18__i_cor_am_lock <= 1'b1;
        else
            aligner18__i_cor_am_lock <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner19__i_cor_am_lock <= 1'b0;
        else if ((rf_input_addr == ALIGNER19__I_COR_AM_LOCK) && rf_input_enable)   
            aligner19__i_cor_am_lock <= 1'b1;
        else
            aligner19__i_cor_am_lock <= 1'b0;
     end         

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner__i_cor_lanes_id_base <= 1'b0;
        else if ((rf_input_addr == ALIGNER__I_COR_LANE_ID_BASE) && rf_input_enable)   
            aligner__i_cor_lanes_id_base <= 1'b1;
        else
            aligner__i_cor_lanes_id_base <= 1'b0;
     end

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner1__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER1__I_COR_LANE_ID) && rf_input_enable)   
            aligner1__i_cor_lanes_id <= 1'b1;
        else
            aligner1__i_cor_lanes_id <= 1'b0;
     end

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner2__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER2__I_COR_LANE_ID) && rf_input_enable)   
            aligner2__i_cor_lanes_id <= 1'b1;
        else
            aligner2__i_cor_lanes_id <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner3__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER3__I_COR_LANE_ID) && rf_input_enable)   
            aligner3__i_cor_lanes_id <= 1'b1;
        else
            aligner3__i_cor_lanes_id <= 1'b0;
     end 

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner4__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER4__I_COR_LANE_ID) && rf_input_enable)   
            aligner4__i_cor_lanes_id <= 1'b1;
        else
            aligner4__i_cor_lanes_id <= 1'b0;
     end 

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner6__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER6__I_COR_LANE_ID) && rf_input_enable)   
            aligner6__i_cor_lanes_id <= 1'b1;
        else
            aligner6__i_cor_lanes_id <= 1'b0;
     end    

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner7__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER7__I_COR_LANE_ID) && rf_input_enable)   
            aligner7__i_cor_lanes_id <= 1'b1;
        else
            aligner7__i_cor_lanes_id <= 1'b0;
     end   

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner8__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER8__I_COR_LANE_ID) && rf_input_enable)   
            aligner8__i_cor_lanes_id <= 1'b1;
        else
            aligner8__i_cor_lanes_id <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner9__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER9__I_COR_LANE_ID) && rf_input_enable)   
            aligner9__i_cor_lanes_id <= 1'b1;
        else
            aligner9__i_cor_lanes_id <= 1'b0;
     end     

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner10__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER10__I_COR_LANE_ID) && rf_input_enable)   
            aligner10__i_cor_lanes_id <= 1'b1;
        else
            aligner10__i_cor_lanes_id <= 1'b0;
     end      

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner11__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER11__I_COR_LANE_ID) && rf_input_enable)   
            aligner11__i_cor_lanes_id <= 1'b1;
        else
            aligner11__i_cor_lanes_id <= 1'b0;
     end     

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner12__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER12__I_COR_LANE_ID) && rf_input_enable)   
            aligner12__i_cor_lanes_id <= 1'b1;
        else
            aligner12__i_cor_lanes_id <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner13__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER13__I_COR_LANE_ID) && rf_input_enable)   
            aligner13__i_cor_lanes_id <= 1'b1;
        else
            aligner13__i_cor_lanes_id <= 1'b0;
     end      

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner14__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER14__I_COR_LANE_ID) && rf_input_enable)   
            aligner14__i_cor_lanes_id <= 1'b1;
        else
            aligner14__i_cor_lanes_id <= 1'b0;
     end    

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner15__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER15__I_COR_LANE_ID) && rf_input_enable)   
            aligner15__i_cor_lanes_id <= 1'b1;
        else
            aligner15__i_cor_lanes_id <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner16__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER16__I_COR_LANE_ID) && rf_input_enable)   
            aligner16__i_cor_lanes_id <= 1'b1;
        else
            aligner16__i_cor_lanes_id <= 1'b0;
     end   

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner17__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER17__I_COR_LANE_ID) && rf_input_enable)   
            aligner17__i_cor_lanes_id <= 1'b1;
        else
            aligner17__i_cor_lanes_id <= 1'b0;
     end             

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner18__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER18__I_COR_LANE_ID) && rf_input_enable)   
            aligner18__i_cor_lanes_id <= 1'b1;
        else
            aligner18__i_cor_lanes_id <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner19__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER19__I_COR_LANE_ID) && rf_input_enable)   
            aligner19__i_cor_lanes_id <= 1'b1;
        else
            aligner19__i_cor_lanes_id <= 1'b0;
     end    

    always @ (posedge i_clock) begin
        if (i_reset)
            aligner19__i_cor_lanes_id <= 1'b0;
        else if ((rf_input_addr == ALIGNER19__I_COR_LANE_ID) && rf_input_enable)   
            aligner19__i_cor_lanes_id <= 1'b1;
        else
            aligner19__i_cor_lanes_id <= 1'b0;
     end  

    always @ (posedge i_clock) begin
        if (i_reset)
            pcs__i_rf_enable_clock_comp <= 1'b0;
        else if ((rf_input_addr == TX_CLOCK_COMP__I_RF_ENABLE || rf_input_addr == RX_CLOCK_COMP__I_RF_ENABLE) && rf_input_enable)   
            pcs__i_rf_enable_clock_comp <= 1'b1;
     end       
        


//====================================================================================     

    // OUTPUT ASSIGMENTS
    assign o_pcs__i_rf_reset = pcs__i_rf_reset ;
    assign o_pcs__i_rf_loopback = pcs__i_rf_loopback ;
    assign o_pcs__i_rf_idle_pattern_mode = pcs__i_rf_idle_pattern_mode ;
    assign o_pcs__i_rf_enable_tx_am_insertion = pcs__i_rf_enable_tx_am_insertion ;
    assign o_scrambler__i_rf_enable = scrambler__i_rf_enable ;
    assign o_scrambler__i_rf_bypass = scrambler__i_rf_bypass ;
    assign o_deskew__i_rf_enable = deskew__i_rf_enable ;
    assign o_reorder__i_rf_enable = reorder__i_rf_enable ;
    assign o_reorder__i_rf_reset_order = reorder__i_rf_reset_order ;
    assign o_descrambler__i_rf_enable = descrambler__i_rf_enable ;
    assign o_descrambler__i_rf_bypass = descrambler__i_rf_bypass ;
    assign o_decoder__i_rf_enable = decoder__i_rf_enable ;
    assign o_decoder__i_cor_err_counter = decoder__i_rf_cor_err_counter;
    assign o_deskew__i_cor_invalid_deskew = deskew__i_rf_cor_invalid_skew;
    assign o_ptrncheck__i_cor_mismatch_counters = ptrncheck__i_rf_cor_mismatch_counter;

    assign o_channel__i_rf_update_payload = {
    channel__i_rf_update_payload_base, 
    channel1__i_rf_update_payload,
    channel2__i_rf_update_payload,
    channel3__i_rf_update_payload,
    channel4__i_rf_update_payload,
    channel5__i_rf_update_payload,
    channel6__i_rf_update_payload,
    channel7__i_rf_update_payload,
    channel8__i_rf_update_payload,
    channel9__i_rf_update_payload,
    channel10__i_rf_update_payload,
    channel11__i_rf_update_payload,
    channel12__i_rf_update_payload,
    channel13__i_rf_update_payload,
    channel14__i_rf_update_payload,
    channel15__i_rf_update_payload,
    channel16__i_rf_update_payload,
    channel17__i_rf_update_payload,
    channel18__i_rf_update_payload,
    channel19__i_rf_update_payload
    } ;

    assign o_channel__i_rf_payload_mode = channel__i_rf_payload_mode ;
    assign o_channel__i_rf_payload_err_mask = channel__i_rf_payload_err_mask ;
    assign o_channel__i_rf_payload_err_burst = channel__i_rf_payload_err_burst ;
    assign o_channel__i_rf_payload_err_period = channel__i_rf_payload_err_period ;
    assign o_channel__i_rf_payload_err_repeat = channel__i_rf_payload_err_repeat;

    assign o_channel__i_rf_update_shbreaker = {
        channel__i_rf_update_shbreaker_base,
        channel1__i_rf_update_shbreaker,
        channel2__i_rf_update_shbreaker,
        channel3__i_rf_update_shbreaker,
        channel4__i_rf_update_shbreaker,
        channel5__i_rf_update_shbreaker,
        channel6__i_rf_update_shbreaker,
        channel7__i_rf_update_shbreaker,
        channel8__i_rf_update_shbreaker,
        channel9__i_rf_update_shbreaker,
        channel10__i_rf_update_shbreaker,
        channel11__i_rf_update_shbreaker,
        channel12__i_rf_update_shbreaker,
        channel13__i_rf_update_shbreaker,
        channel14__i_rf_update_shbreaker,
        channel15__i_rf_update_shbreaker,
        channel16__i_rf_update_shbreaker,
        channel17__i_rf_update_shbreaker,
        channel18__i_rf_update_shbreaker,
        channel19__i_rf_update_shbreaker
    };

    assign o_channel__i_rf_shbreaker_mode = channel__i_rf_shbreaker_mode;
    assign o_channel__i_rf_shbreaker_err_burst = channel__i_rf_shbreaker_err_burst;
    assign o_channel__i_rf_shbreaker_err_period = channel__i_rf_shbreaker_err_period ;
    assign o_channel__i_rf_shbreaker_err_repeat = channel__i_rf_shbreaker_err_repeat;


    assign o_channel__i_rf_update_bitskew = {
        channel__i_rf_update_bitskew_base,
        channel1__i_rf_update_bitskew,
        channel2__i_rf_update_bitskew,
        channel3__i_rf_update_bitskew,
        channel4__i_rf_update_bitskew,
        channel5__i_rf_update_bitskew,
        channel6__i_rf_update_bitskew,
        channel7__i_rf_update_bitskew,
        channel8__i_rf_update_bitskew,
        channel9__i_rf_update_bitskew,
        channel10__i_rf_update_bitskew,
        channel11__i_rf_update_bitskew,
        channel12__i_rf_update_bitskew,
        channel13__i_rf_update_bitskew,
        channel14__i_rf_update_bitskew,
        channel15__i_rf_update_bitskew,
        channel16__i_rf_update_bitskew,
        channel17__i_rf_update_bitskew,
        channel18__i_rf_update_bitskew,
        channel19__i_rf_update_bitskew
    };


    assign o_channel__i_rf_bit_skew_index =channel__i_rf_bit_skew_index ;
    assign o_blksync__i_rf_enable = blksync__i_rf_enable;
    assign o_aligner__i_rf_enable = aligner__i_rf_enable;
    assign o_ptrncheck__i_rf_enable = ptrncheck__i_rf_enable;
    assign o_blksync__i_rf_locked_timer_limit = blksync__i_rf_locked_timer_limit;
    assign o_blksync__i_rf_unlocked_timer_limit = blksync__i_rf_unlocked_timer_limit;
    assign o_blksync__i_rf_sh_invalid_limit = blksync__i_rf_sh_invalid_limit;
    assign o_aligner__i_rf_invalid_am_thr = aligner__i_rf_invalid_am_thr;
    assign o_aligner__i_rf_valid_am_thr = aligner__i_rf_valid_am_thr;
    assign o_aligner__i_rf_am_period = aligner__i_rf_am_period;

    wire [N_LANES-1 : 0] block_lock__rf_cor_sh_lock;

    assign block_lock__rf_cor_sh_lock = {
        block_lock__i_rf_cor_sh_lock_base,
        block_lock1__i_rf_cor_sh_lock,
        block_lock2__i_rf_cor_sh_lock,
        block_lock3__i_rf_cor_sh_lock,
        block_lock4__i_rf_cor_sh_lock,
        block_lock5__i_rf_cor_sh_lock,
        block_lock6__i_rf_cor_sh_lock,
        block_lock7__i_rf_cor_sh_lock,
        block_lock8__i_rf_cor_sh_lock,
        block_lock9__i_rf_cor_sh_lock,
        block_lock10__i_rf_cor_sh_lock,
        block_lock11__i_rf_cor_sh_lock,
        block_lock12__i_rf_cor_sh_lock,
        block_lock13__i_rf_cor_sh_lock,
        block_lock14__i_rf_cor_sh_lock,
        block_lock15__i_rf_cor_sh_lock,
        block_lock16__i_rf_cor_sh_lock,
        block_lock17__i_rf_cor_sh_lock,
        block_lock18__i_rf_cor_sh_lock,
        block_lock19__i_rf_cor_sh_lock
    };

    assign o_blocklock__i_cor_sh_lock = block_lock__rf_cor_sh_lock;

    wire [N_LANES-1 : 0] ber_monitor__rf_cor_hi_ber_bus;

    assign ber_monitor__rf_cor_hi_ber_bus = {
        bermonitor__i_rf_cor_hi_ber_base,
        bermonitor1__i_rf_cor_hi_ber,
        bermonitor2__i_rf_cor_hi_ber,
        bermonitor3__i_rf_cor_hi_ber,
        bermonitor4__i_rf_cor_hi_ber,
        bermonitor5__i_rf_cor_hi_ber,
        bermonitor6__i_rf_cor_hi_ber,
        bermonitor7__i_rf_cor_hi_ber,
        bermonitor8__i_rf_cor_hi_ber,
        bermonitor9__i_rf_cor_hi_ber,
        bermonitor10__i_rf_cor_hi_ber,
        bermonitor11__i_rf_cor_hi_ber,
        bermonitor12__i_rf_cor_hi_ber,
        bermonitor13__i_rf_cor_hi_ber,
        bermonitor14__i_rf_cor_hi_ber,
        bermonitor15__i_rf_cor_hi_ber,
        bermonitor16__i_rf_cor_hi_ber,
        bermonitor17__i_rf_cor_hi_ber,
        bermonitor18__i_rf_cor_hi_ber,
        bermonitor19__i_rf_cor_hi_ber

    };

    assign o_bermonitor__i_rf_cor_hi_ber = ber_monitor__rf_cor_hi_ber_bus;

    wire [N_LANES-1 : 0] aligner__i_cor_bip_error_bus;

    assign aligner__i_cor_bip_error_bus = {
        aligner__i_cor_bip_error_base,
        aligner1__i_cor_bip_error,
        aligner2__i_cor_bip_error,
        aligner3__i_cor_bip_error,
        aligner4__i_cor_bip_error,
        aligner5__i_cor_bip_error,
        aligner6__i_cor_bip_error,
        aligner7__i_cor_bip_error,
        aligner8__i_cor_bip_error,
        aligner9__i_cor_bip_error,
        aligner10__i_cor_bip_error,
        aligner11__i_cor_bip_error,
        aligner12__i_cor_bip_error,
        aligner13__i_cor_bip_error,
        aligner14__i_cor_bip_error,
        aligner15__i_cor_bip_error,
        aligner16__i_cor_bip_error,
        aligner17__i_cor_bip_error,
        aligner18__i_cor_bip_error,
        aligner19__i_cor_bip_error    
    };

    assign o_aligner__i_cor_bip_error = aligner__i_cor_bip_error_bus;

    wire [N_LANES-1 : 0] aligner__i_cor_resync_counter_bus;

    assign aligner__i_cor_resync_counter_bus = {
        aligner__i_cor_resync_counter_base,
        aligner1__i_cor_resync_counter,
        aligner2__i_cor_resync_counter,
        aligner3__i_cor_resync_counter,
        aligner4__i_cor_resync_counter,
        aligner5__i_cor_resync_counter,
        aligner6__i_cor_resync_counter,
        aligner7__i_cor_resync_counter,
        aligner8__i_cor_resync_counter,
        aligner9__i_cor_resync_counter,
        aligner10__i_cor_resync_counter,
        aligner11__i_cor_resync_counter,
        aligner12__i_cor_resync_counter,
        aligner13__i_cor_resync_counter,
        aligner14__i_cor_resync_counter,
        aligner15__i_cor_resync_counter,
        aligner16__i_cor_resync_counter,
        aligner17__i_cor_resync_counter,
        aligner18__i_cor_resync_counter,
        aligner19__i_cor_resync_counter  
    };

    assign o_aligner__i_cor_resync_counters = aligner__i_cor_resync_counter_bus;

    wire [N_LANES-1 : 0] aligner__i_cor_am_lock_bus;

    assign aligner__i_cor_am_lock_bus = {
        aligner__i_cor_am_lock_base,
        aligner1__i_cor_am_lock,
        aligner2__i_cor_am_lock,
        aligner3__i_cor_am_lock,
        aligner4__i_cor_am_lock,
        aligner5__i_cor_am_lock,
        aligner6__i_cor_am_lock,
        aligner7__i_cor_am_lock,
        aligner8__i_cor_am_lock,
        aligner9__i_cor_am_lock,
        aligner10__i_cor_am_lock,
        aligner11__i_cor_am_lock,
        aligner12__i_cor_am_lock,
        aligner13__i_cor_am_lock,
        aligner14__i_cor_am_lock,
        aligner15__i_cor_am_lock,
        aligner16__i_cor_am_lock,
        aligner17__i_cor_am_lock,
        aligner18__i_cor_am_lock,
        aligner19__i_cor_am_lock  
    };

    assign o_aligner__i_cor_am_lock = aligner__i_cor_am_lock_bus;

    wire [N_LANES-1 : 0] aligner__i_cor_lanes_id_bus;

    assign aligner__i_cor_lanes_id_bus = {
        aligner__i_cor_lanes_id_base,
        aligner1__i_cor_lanes_id,
        aligner2__i_cor_lanes_id,
        aligner3__i_cor_lanes_id,
        aligner4__i_cor_lanes_id,
        aligner5__i_cor_lanes_id,
        aligner6__i_cor_lanes_id,
        aligner7__i_cor_lanes_id,
        aligner8__i_cor_lanes_id,
        aligner9__i_cor_lanes_id,
        aligner10__i_cor_lanes_id,
        aligner11__i_cor_lanes_id,
        aligner12__i_cor_lanes_id,
        aligner13__i_cor_lanes_id,
        aligner14__i_cor_lanes_id,
        aligner15__i_cor_lanes_id,
        aligner16__i_cor_lanes_id,
        aligner17__i_cor_lanes_id,
        aligner18__i_cor_lanes_id,
        aligner19__i_cor_lanes_id  
    };

    assign o_aligner__i_cor_lanes_id = aligner__i_cor_lanes_id_bus;

    assign o_clock_comp__i_rf_enable = pcs__i_rf_enable_clock_comp;

    assign o_frame_gen__i_rf_enable = frame_gen__i_rf_enable;
    assign o_encoder__i_rf_enable   = encoder__i_rf_enable;
    assign o_tx_pc__i_rf_enable     = tx_pc__i_rf_enable;
    assign o_aligner__i_rf_compare_mask = aligner__i_rf_am_compare_mask;

endmodule