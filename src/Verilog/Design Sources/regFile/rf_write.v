
module rf_write
#(
    parameter NB_ADDR = , //slice of GPIOmused for addr
    parameter NB_I_DATA = , //slice of GPIO used for data
    parameter NB_GPIO = 32,
    parameter N_LANES = 20
 )   
(
    input wire                  i_clock,
    input wire                  i_reset,
    input wire [NB_GPIO-1 : 0]  i_gpio_data,

    output wire o_pcs__i_rf_reset,
    output wire o_pcs__i_rf_loopback,
    output wire o_pcs__i_rf_idle_pattern_mode,
    output wire o_pcs__i_rf_enable_tx_am_insertion ,
    output wire o_scrambler__i_rf_enable ,
    output wire o_scrambler__i_rf_bypass,
    output wire o_deskew__i_rf_enable,
    output wire o_reorder__i_rf_enable,
    output wire o_reorder__i_rf_reset_order,
    output wire o_descrambler__i_rf_enable,
    output wire o_descrambler__i_rf_bypass,
    output wire o_decoder__i_rf_enable,
    output wire [N_LANES-1 : 0] o_channel__i_rf_update_payload,
    output wire []o_channel__i_rf_payload_mode, //FIXME add width
    output wire o_channel__i_rf_payload_err_mask,//FIXME add width
    output wire o_channel__i_rf_payload_err_burst,//FIXME add width
    output wire o_channel__i_rf_payload_err_period,//FIXME add width
    output wire o_channel__i_rf_payload_err_repeat,//FIXME add width
    output wire [N_LANES-1 : 0] o_channel__i_rf_update_shbreaker,
    output wire o_channel__i_rf_shbreaker_mode,//FIXME add width
    output wire o_channel__i_rf_shbreaker_err_mask, //FIXME add width
    output wire o_channel__i_rf_shbreaker_err_burst, //FIXME add width
    output wire o_channel__i_rf_shbreaker_err_period,//FIXME add width
    output wire o_channel__i_rf_shbreaker_err_repeat,//FIXME add width
    output wire [N_LANES-1 : 0]o_channel__i_rf_update_bitskew,
    output wire o_channel__i_rf_bit_skew_index,//FIXME add width
    output wire o_blksync__i_rf_enable,
    output wire o_aligner__i_rf_enable,
    output wire o_deskewer__i_rf_enable,
    output wire o_reorder__i_rf_enable,
    output wire o_ptrncheck__i_rf_enable,
    output wire o_blksync__i_rf_locked_timer_limit,//FIXME add width
    output wire o_blksync__i_rf_unlocked_timer_limit,//FIXME add width
    output wire o_blksync__i_rf_sh_invalid_limit,//FIXME add width
    output wire o_aligner__i_rf_invalid_am_thr,//FIXME add width
    output wire o_aligner__i_rf_valid_am_thr,//FIXME add width
    output wire o_aligner__i_rf_am_period,//FIXME add width
    output wire [N_LANES-1 : 0]o_bermonitor__i_rf_cor_hi_ber,
    output wire [N_LANES-1 : 0]o_aligner__i_cor_bip_error
);

    //REGISTER DECLARATION INCLUDE
    `include "./wr_reg_decl.v"

    //REGISTER ADDRESS INCLUDE
    `include "./reg_addr_decl.v"

    
    //REGISTER LOGIC
    always @ (posedge i_clock) begin
        if (i_reset)
            pcs__i_rf_reset <= 1'b0;
        else if ((input_addr == PCS__I_RF_RESET) && input_enable)   
            pcs__i_rf_reset <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            pcs__i_rf_loopback <= 1'b0;
        else if ((input_addr == PCS__I_RF_LOOPBACK) && input_enable)   
            pcs__i_rf_loopback <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            pcs__i_rf_idle_pattern_mode <= 1'b0;
        else if ((input_addr == PCS__I_RF_IDLE_PATTERN_MODE) && input_enable)   
            pcs__i_rf_idle_pattern_mode <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            pcs__i_rf_enable_tx_am_insertion <= 1'b1;
        else if ((input_addr == PCS__I_RF_ENABLE_TX_AM_INSERTION) && input_enable)   
            pcs__i_rf_enable_tx_am_insertion <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            scrambler__i_rf_enable <= 1'b1;
        else if ((input_addr == SCRAMBLER__I_RF_ENABLE) && input_enable)   
            scrambler__i_rf_enable <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            scrambler__i_rf_bypass <= 1'b0;
        else if ((input_addr == SCRAMBLER__I_RF_BYPASS) && input_enable)   
            scrambler__i_rf_bypass <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            deskew__i_rf_enable <= 1'b1;
        else if ((input_addr == DESKEW__I_RF_ENABLE) && input_enable)   
            deskew__i_rf_enable <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            reorder__i_rf_enable <= 1'b1;
        else if ((input_addr == REORDER__I_RF_ENABLE) && input_enable)   
            reorder__i_rf_enable <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            reorder__i_rf_reset_order <= 1'b0;
        else if ((input_addr == REORDER__I_RF_RESET_ORDER) && input_enable)   
            reorder__i_rf_reset_order <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            descrambler__i_rf_enable <= 1'b1;
        else if ((input_addr == DESCRAMBLER__I_RF_ENABLE) && input_enable)   
            descrambler__i_rf_enable <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            descrambler__i_rf_bypass <= 1'b0;
        else if ((input_addr == DESCRAMBLER__I_RF_BYPASS) && input_enable)   
            descrambler__i_rf_bypass <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            decoder__i_rf_enable <= 1'b1;
        else if ((input_addr == DECODER__I_RF_ENABLE) && input_enable)   
            decoder__i_rf_enable <= input_data[0];
     end


     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_update_payload_base <= 1'b0;
        else if ((input_addr == CHANNEL__I_RF_UPDATE_PAYLOAD_BASE) && input_enable)   
            channel__i_rf_update_payload_base <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel1__i_rf_update_payload <= 1'b0 ;
        else if ((input_addr == CHANNEL1__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel1__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel2__i_rf_update_payload <= 1'b0 ;
        else if ((input_addr == CHANNEL2__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel2__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel3__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL3__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel3__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel4__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL4__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel4__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel5__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL5__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel5__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel6__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL6__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel6__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel7__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL7__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel7__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel8__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL8__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel8__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel9__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL9__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel9__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel10__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL10__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel10__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel11__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL11__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel11__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel12__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL12__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel12__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel13__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL13__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel13__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel14__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL14__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel14__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel15__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL15__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel15__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel16__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL16__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel16__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel17__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL17__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel17__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel18__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL18__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel18__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel19__i_rf_update_payload <= 1'b0;
        else if ((input_addr == CHANNEL19__I_RF_UPDATE_PAYLOAD) && input_enable)   
            channel19__i_rf_update_payload <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_payload_mode <= //FIXME set default;
        else if ((input_addr == CHANNEL__I_RF_PAYLOAD_MODE) && input_enable)   
            channel__i_rf_payload_mode <= input_data[:]; //FIXME set nbits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_payload_err_mask <= ; //FIXME set default
        else if ((input_addr == CHANNEL__I_RF_PAYLOAD_ERR_MASK) && input_enable)   
            channel__i_rf_payload_err_mask <= input_data; //FIXME set nbits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_payload_err_burst <= 0;
        else if ((input_addr == CHANNEL__I_RF_PAYLOAD_ERR_BURST) && input_enable)   
            channel__i_rf_payload_err_burst <= input_data[]; //fixme set nbits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_payload_err_period <= 0;
        else if ((input_addr == CHANNEL__I_RF_PAYLOAD_ERR_PERIOD) && input_enable)   
            channel__i_rf_payload_err_period <= input_data; //FIXME set n bits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_payload_err_repeat <= 0;
        else if ((input_addr == CHANNEL__I_RF_PAYLOAD_ERR_REPEAT) && input_enable)   
            channel__i_rf_payload_err_repeat <= input_data; //fixme set nbits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_update_shbreaker_base <= 1'b0;
        else if ((input_addr == CHANNEL__I_RF_UPDATE_SHBREAKER_BASE) && input_enable)   
            channel__i_rf_update_shbreaker_base <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel1__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL1__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel1__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel2__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL2__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel2__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel3__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL3__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel3__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel4__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL4__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel4__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel5__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL5__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel5__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel6__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL6__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel6__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel7__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL7__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel7__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel8__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL8__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel8__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel9__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL9__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel9__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel10__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL10__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel10__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel11__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL11__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel11__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel12__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL12__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel12__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel13__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL13__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel13__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel14__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL14__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel14__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel15__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL15__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel15__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel16__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL16__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel16__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel17__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL17__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel17__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel18__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL18__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel18__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel19__i_rf_update_shbreaker <= 1'b0;
        else if ((input_addr == CHANNEL19__I_RF_UPDATE_SHBREAKER) && input_enable)   
            channel19__i_rf_update_shbreaker <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_shbreaker_mode <= ; //FIXME add default
        else if ((input_addr == CHANNEL__I_RF_SHBREAKER_MODE) && input_enable)   
            channel__i_rf_shbreaker_mode <= input_data; //fixme select n bits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_shbreaker_err_mask <= ; //FIXME add default
        else if ((input_addr == CHANNEL__I_RF_SHBREAKER_ERR_MASK) && input_enable)   
            channel__i_rf_shbreaker_err_mask <= input_data; //FIXME select n bits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_shbreaker_err_burst <= 0;
        else if ((input_addr == CHANNEL__I_RF_SHBREAKER_ERR_BURST) && input_enable)   
            channel__i_rf_shbreaker_err_burst <= input_data; //FIXME select n bits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_shbreaker_err_period <= 0;
        else if ((input_addr == CHANNEL__I_RF_SHBREAKER_ERR_PERIOD) && input_enable)   
            channel__i_rf_shbreaker_err_period <= input_data; //FIXME select nbits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_shbreaker_err_repeat <= 0;
        else if ((input_addr == CHANNEL__I_RF_SHBREAKER_ERR_REPEAT) && input_enable)   
            channel__i_rf_shbreaker_err_repeat <= input_data;//FIXME slect nbits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_update_bitskew_base <= 1'b0;
        else if ((input_addr == CHANNEL__I_RF_UPDATE_BITSKEW_BASE) && input_enable)   
            channel__i_rf_update_bitskew_base <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel1__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL1__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel1__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel2__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL2__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel2__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel3__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL3__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel3__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel4__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL4__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel4__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel5__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL5__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel5__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel6__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL6__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel6__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel7__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL7__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel7__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel8__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL8__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel8__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel9__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL9__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel9__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel10__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL10__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel10__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel11__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL11__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel11__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel12__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL12__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel12__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel13__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL13__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel13__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel14__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL14__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel14__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel15__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL15__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel15__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel16__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL16__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel16__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel17__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL17__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel17__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel18__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL18__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel18__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel19__i_rf_update_bitskew <= 1'b0;
        else if ((input_addr == CHANNEL19__I_RF_UPDATE_BITSKEW) && input_enable)   
            channel19__i_rf_update_bitskew <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            channel__i_rf_bit_skew_index <= 0;
        else if ((input_addr == CHANNEL__I_RF_BIT_SKEW_INDEX) && input_enable)   
            channel__i_rf_bit_skew_index <= input_data; //FIXME select n bikts
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            blksync__i_rf_enable <= 1'b1;
        else if ((input_addr == BLKSYNC__I_RF_ENABLE) && input_enable)   
            blksync__i_rf_enable <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner__i_rf_enable <= 1'b1;
        else if ((input_addr == ALIGNER__I_RF_ENABLE) && input_enable)   
            aligner__i_rf_enable <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            deskewer__i_rf_enable <= 1'b1;
        else if ((input_addr == DESKEWER__I_RF_ENABLE) && input_enable)   
            deskewer__i_rf_enable <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            reorder__i_rf_enable <= 1'b1;
        else if ((input_addr == REORDER__I_RF_ENABLE) && input_enable)   
            reorder__i_rf_enable <= input_data[0];
     end


     always @ (posedge i_clock) begin
        if (i_reset)
            ptrncheck__i_rf_enable <= 1'b0;
        else if ((input_addr == PTRNCHECK__I_RF_ENABLE) && input_enable)   
            ptrncheck__i_rf_enable <= input_data[0];
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            blksync__i_rf_locked_timer_limit <= ; //FIXME review default
        else if ((input_addr == BLKSYNC__I_RF_LOCKED_TIMER_LIMIT) && input_enable)   
            blksync__i_rf_locked_timer_limit <= input_data; //FIXMER slect nbits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            blksync__i_rf_unlocked_timer_limit <= ; //FIXME set default
        else if ((input_addr == BLKSYNC__I_RF_UNLOCKED_TIMER_LIMIT) && input_enable)   
            blksync__i_rf_unlocked_timer_limit <= input_data; //FIXME select nbits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            blksync__i_rf_sh_invalid_limit <= ; //FIXME set default
        else if ((input_addr == BLKSYNC__I_RF_SH_INVALID_LIMIT) && input_enable)   
            blksync__i_rf_sh_invalid_limit <= input_data; //FIXME se;ect nbits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner__i_rf_invalid_am_thr <= ; //FIXME set default
        else if ((input_addr == ALIGNER__I_RF_INVALID_AM_THR) && input_enable)   
            aligner__i_rf_invalid_am_thr <= input_data; //FIXME se;lect nbits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner__i_rf_valid_am_thr <= ; //FIXME set defalt
        else if ((input_addr == ALIGNER__I_RF_VALID_AM_THR) && input_enable)   
            aligner__i_rf_valid_am_thr <= input_data; //FIXME select nbits
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner__i_rf_am_period <= ; //FIXME set default
        else if ((input_addr == ALIGNER__I_RF_AM_PERIOD) && input_enable)   
            aligner__i_rf_am_period <= input_data; //FIXME select nbits
     end


     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor__i_rf_cor_hi_ber_base <= 1'b0;
        else if ((input_addr == BERMONITOR__I_RF_COR_HI_BER_BASE) && input_enable)   
            bermonitor__i_rf_cor_hi_ber_base <= 1'b1;
        else
            bermonitor__i_rf_cor_hi_ber_base <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor1__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR1__I_RF_COR_HI_BER) && input_enable)   
            bermonitor1__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor1__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor2__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR2__I_RF_COR_HI_BER) && input_enable)   
            bermonitor2__i_rf_cor_hi_ber <= 1'b1;
        else 
            bermonitor2__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor3__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR3__I_RF_COR_HI_BER) && input_enable)   
            bermonitor3__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor3__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor4__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR4__I_RF_COR_HI_BER) && input_enable)   
            bermonitor4__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor4__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor5__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR5__I_RF_COR_HI_BER) && input_enable)   
            bermonitor5__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor5__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor6__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR6__I_RF_COR_HI_BER) && input_enable)   
            bermonitor6__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor6__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor7__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR7__I_RF_COR_HI_BER) && input_enable)   
            bermonitor7__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor7__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor8__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR8__I_RF_COR_HI_BER) && input_enable)   
            bermonitor8__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor8__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor9__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR9__I_RF_COR_HI_BER) && input_enable)   
            bermonitor9__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor9__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor10__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR10__I_RF_COR_HI_BER) && input_enable)   
            bermonitor10__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor10__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor11__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR11__I_RF_COR_HI_BER) && input_enable)   
            bermonitor11__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor11__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor12__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR12__I_RF_COR_HI_BER) && input_enable)   
            bermonitor12__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor12__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor13__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR13__I_RF_COR_HI_BER) && input_enable)   
            bermonitor13__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor13__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor14__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR14__I_RF_COR_HI_BER) && input_enable)   
            bermonitor14__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor14__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor15__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR15__I_RF_COR_HI_BER) && input_enable)   
            bermonitor15__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor15__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor16__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR16__I_RF_COR_HI_BER) && input_enable)   
            bermonitor16__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor16__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor17__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR17__I_RF_COR_HI_BER) && input_enable)   
            bermonitor17__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor17__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor18__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR18__I_RF_COR_HI_BER) && input_enable)   
            bermonitor18__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor18__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            bermonitor19__i_rf_cor_hi_ber <= 1'b0;
        else if ((input_addr == BERMONITOR19__I_RF_COR_HI_BER) && input_enable)   
            bermonitor19__i_rf_cor_hi_ber <= 1'b1;
        else
            bermonitor19__i_rf_cor_hi_ber <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner__i_cor_bip_error_base <= 1'b0;
        else if ((input_addr == ALIGNER__I_COR_BIP_ERROR_BASE) && input_enable)   
            aligner__i_cor_bip_error_base <= 1'b1;
        else
            aligner__i_cor_bip_error_base <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner1__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER1__I_COR_BIP_ERROR) && input_enable)   
            aligner1__i_cor_bip_error <= 1'b1;
        else
            aligner1__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner2__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER2__I_COR_BIP_ERROR) && input_enable)   
            aligner2__i_cor_bip_error <= 1'b1;
        else
            aligner2__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner3__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER3__I_COR_BIP_ERROR) && input_enable)   
            aligner3__i_cor_bip_error <= 1'b1;
        else
            aligner3__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner4__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER4__I_COR_BIP_ERROR) && input_enable)   
            aligner4__i_cor_bip_error <= 1'b1;
        else
            aligner4__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner5__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER5__I_COR_BIP_ERROR) && input_enable)   
            aligner5__i_cor_bip_error <= 1'b1;
        else
            aligner5__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner6__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER6__I_COR_BIP_ERROR) && input_enable)   
            aligner6__i_cor_bip_error <= 1'b1;
        else
            aligner6__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner7__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER7__I_COR_BIP_ERROR) && input_enable)   
            aligner7__i_cor_bip_error <= 1'b1;
        else
            aligner7__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner8__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER8__I_COR_BIP_ERROR) && input_enable)   
            aligner8__i_cor_bip_error <= 1'b1;
        else
            aligner8__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner9__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER9__I_COR_BIP_ERROR) && input_enable)   
            aligner9__i_cor_bip_error <= 1'b1;
        else
            aligner9__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner10__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER10__I_COR_BIP_ERROR) && input_enable)   
            aligner10__i_cor_bip_error <= 1'b1;
        else
            aligner10__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner11__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER11__I_COR_BIP_ERROR) && input_enable)   
            aligner11__i_cor_bip_error <= 1'b1;
        else
            aligner11__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner12__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER12__I_COR_BIP_ERROR) && input_enable)   
            aligner12__i_cor_bip_error <= 1'b1;
        else
            aligner12__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner13__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER13__I_COR_BIP_ERROR) && input_enable)   
            aligner13__i_cor_bip_error <= 1'b1;
        else
            aligner13__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner14__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER14__I_COR_BIP_ERROR) && input_enable)   
            aligner14__i_cor_bip_error <= 1'b1;
        else
            aligner14__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner15__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER15__I_COR_BIP_ERROR) && input_enable)   
            aligner15__i_cor_bip_error <= 1'b1;
        else
            aligner15__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner16__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER16__I_COR_BIP_ERROR) && input_enable)   
            aligner16__i_cor_bip_error <= 1'b1;
        else
            aligner16__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner17__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER17__I_COR_BIP_ERROR) && input_enable)   
            aligner17__i_cor_bip_error <= 1'b1;
        else
            aligner17__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner18__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER18__I_COR_BIP_ERROR) && input_enable)   
            aligner18__i_cor_bip_error <= 1'b1;
        else
            aligner18__i_cor_bip_error <= 1'b0;
     end

     always @ (posedge i_clock) begin
        if (i_reset)
            aligner19__i_cor_bip_error <= 1'b0;
        else if ((input_addr == ALIGNER19__I_COR_BIP_ERROR) && input_enable)   
            aligner19__i_cor_bip_error <= 1'b1;
        else
            aligner19__i_cor_bip_error <= 1'b0;
     end

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

    channel__i_rf_update_payload_base, channel1__i_rf_update_payload,
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
    assign o_channel__i_rf_shbreaker_err_mask = channel__i_rf_shbreaker_err_mask;
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
    assign o_deskewer__i_rf_enable = deskewer__i_rf_enable;
    assign o_reorder__i_rf_enable = reorder__i_rf_enable;
    assign o_ptrncheck__i_rf_enable = ptrncheck__i_rf_enable;
    assign o_blksync__i_rf_locked_timer_limit = blksync__i_rf_locked_timer_limit;
    assign o_blksync__i_rf_unlocked_timer_limit = blksync__i_rf_unlocked_timer_limit;
    assign o_blksync__i_rf_sh_invalid_limit = blksync__i_rf_sh_invalid_limit;
    assign o_aligner__i_rf_invalid_am_thr = aligner__i_rf_invalid_am_thr;
    assign o_aligner__i_rf_valid_am_thr = aligner__i_rf_valid_am_thr;
    assign o_aligner__i_rf_am_period = aligner__i_rf_am_period;

    assign o_bermonitor__i_rf_cor_hi_ber = {
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

    assign o_aligner__i_cor_bip_error = {
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


endmodule