
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
    
    output wire                                 o_reorder__i_rf_reset_order
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
            pcs__i_rf_reset <= rf_input_data[0];;
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
            blksync__i_rf_enable <= 1'b0;
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

    assign o_clock_comp__i_rf_enable = pcs__i_rf_enable_clock_comp;

    assign o_frame_gen__i_rf_enable = frame_gen__i_rf_enable;
    assign o_encoder__i_rf_enable   = encoder__i_rf_enable;
    assign o_tx_pc__i_rf_enable     = tx_pc__i_rf_enable;
    assign o_aligner__i_rf_compare_mask = aligner__i_rf_am_compare_mask;

endmodule