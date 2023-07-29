
module rf_read_mux
#(
    parameter NB_ADDR   = 9,
    parameter NB_GPIO = 32,
    parameter NB_O_DATA = 22,
    parameter N_LANES = 20,
    parameter NB_BIP_ERR = 8,
    parameter NB_BIP_ERR_BUS = N_LANES * NB_BIP_ERR,
    parameter NB_RESYNC_CNT = 8,
    parameter NB_RESYNC_CNT_BUS = N_LANES * NB_RESYNC_CNT,
    parameter NB_PTRN_MISMATCH_CNT = 16,
    parameter NB_LANE_ID = 5,
    parameter NB_LANE_ID_BUS = N_LANES * NB_LANE_ID,
    parameter NB_DECODE_ERR_COUNTER = 16,
    parameter NB_DATA_CHECKER_ERROR_COUNTER = 16
 )
 (
    output wire [NB_GPIO-1                          : 0]    o_gpio_data,
    input wire                                              i_clock,
    input wire                                              i_reset,
    input wire  [NB_ADDR-1                          : 0]    input_addr,
    input wire                                              bermonitor__o_rf_hi_ber,
    input wire  [NB_BIP_ERR_BUS-1                   : 0]    aligner__o_rf_bip_error_count,
    input wire  [N_LANES-1                          : 0]    aligner__o_rf_am_lock,
    input wire  [NB_RESYNC_CNT_BUS-1                : 0]    aligner__o_rf_am_resync_counters,
    input wire                                              deskewer__o_rf_deskew_done,
    input wire  [NB_PTRN_MISMATCH_CNT-1             : 0]    ptrncheck__o_rf_mismatch_count,
    input wire  [N_LANES-1                          : 0]    blksync__o_rf_block_lock,
    input wire  [NB_LANE_ID_BUS-1                   : 0]    aligner__o_rf_id,
    input wire  [NB_DECODE_ERR_COUNTER-1            : 0]    decoder__o_rf_error_counter,
    input wire  [NB_DATA_CHECKER_ERROR_COUNTER-1    : 0]    frame_data_checker__o_rf_error_counter,
    input wire                                              frame_data_checker__o_rf_lock
 );

///// REG ADDR INCLUDE
`include "./reg_addr_decl.v"

reg [NB_O_DATA-1 : 0] rf_o_data_d;
reg [NB_O_DATA-1 : 0] rf_o_data_muxed;

assign  o_gpio_data = rf_o_data_d;

always @ (posedge i_clock)begin
    if (i_reset)
        rf_o_data_d <= {NB_O_DATA{1'b0}};
    else
        rf_o_data_d <= rf_o_data_muxed;
end

always @ (*) begin
    rf_o_data_muxed = {NB_O_DATA{1'b1}};
    
    
    case (input_addr)

        BLKSYNC__O_RF_BLOCK_LOCK_BASE :                    
        begin                         
        rf_o_data_muxed = blksync__o_rf_block_lock;    
        end         

        BERMONITOR__O_RF_HI_BER_BASE :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber;    
        end 

        ALIGNER__O_RF_AM_LOCK_BASE :                    
        begin                         
        rf_o_data_muxed = aligner__o_rf_am_lock;
        end
        
        DESKEWER__O_RF_INVALID_SKEW :                    
        begin                         
        rf_o_data_muxed = deskewer__o_rf_deskew_done; 
        end 

        DECODER__O_RF_ERROR_COUNTER :                    
        begin                         
        rf_o_data_muxed = decoder__o_rf_error_counter; 
        end

        ALIGNER__O_RF_BIP_ERROR_COUNT_BASE :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(0*NB_BIP_ERR)  -1-: NB_BIP_ERR];    
        end                           

        ALIGNER1__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(1*NB_BIP_ERR)  -1-: NB_BIP_ERR];   
        end                           

        ALIGNER2__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(2*NB_BIP_ERR)  -1-: NB_BIP_ERR];   
        end                           

        ALIGNER3__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(3*NB_BIP_ERR)  -1-: NB_BIP_ERR];
        end                           

        ALIGNER4__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(4*NB_BIP_ERR)  -1-: NB_BIP_ERR];
        end                           

        ALIGNER5__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(5*NB_BIP_ERR)  -1-: NB_BIP_ERR];
        end                           

        ALIGNER6__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(6*NB_BIP_ERR)  -1-: NB_BIP_ERR];
        end                           

        ALIGNER7__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(7*NB_BIP_ERR)  -1-: NB_BIP_ERR];
        end                           

        ALIGNER8__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(8*NB_BIP_ERR)  -1-: NB_BIP_ERR];
        end                           

        ALIGNER9__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(9*NB_BIP_ERR)  -1-: NB_BIP_ERR];
        end                           

        ALIGNER10__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(10*NB_BIP_ERR) -1 -: NB_BIP_ERR];
        end                           

        ALIGNER11__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(11*NB_BIP_ERR) -1 -: NB_BIP_ERR];
        end                           

        ALIGNER12__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(12*NB_BIP_ERR) -1 -: NB_BIP_ERR];
        end                           

        ALIGNER13__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(13*NB_BIP_ERR) -1 -: NB_BIP_ERR];
        end                           

        ALIGNER14__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(14*NB_BIP_ERR) -1 -: NB_BIP_ERR];
        end                           

        ALIGNER15__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(15*NB_BIP_ERR) -1 -: NB_BIP_ERR];
        end                           

        ALIGNER16__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(16*NB_BIP_ERR) -1 -: NB_BIP_ERR];
        end                           

        ALIGNER17__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(17*NB_BIP_ERR) -1 -: NB_BIP_ERR];
        end                           

        ALIGNER18__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(18*NB_BIP_ERR) -1 -: NB_BIP_ERR];
        end                           

        ALIGNER19__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(19*NB_BIP_ERR) -1 -: NB_BIP_ERR];
        end

        ALIGNER__O_RF_RESYNC_COUNT_BASE :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(0*NB_RESYNC_CNT)  -1-: NB_RESYNC_CNT];  
        end                           

        ALIGNER1__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(1*NB_RESYNC_CNT)  -1-: NB_RESYNC_CNT];
        end                           

        ALIGNER2__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(2*NB_RESYNC_CNT)  -1-: NB_RESYNC_CNT];
        end                           

        ALIGNER3__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(3*NB_RESYNC_CNT)  -1-: NB_RESYNC_CNT];
        end                           

        ALIGNER4__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(4*NB_RESYNC_CNT)  -1-: NB_RESYNC_CNT];
        end                           

        ALIGNER5__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(5*NB_RESYNC_CNT)  -1-: NB_RESYNC_CNT];
        end                           

        ALIGNER6__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(6*NB_RESYNC_CNT)  -1-: NB_RESYNC_CNT];
        end                           

        ALIGNER7__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(7*NB_RESYNC_CNT)  -1-: NB_RESYNC_CNT];
        end                           

        ALIGNER8__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(8*NB_RESYNC_CNT)  -1-: NB_RESYNC_CNT];
        end                           

        ALIGNER9__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(9*NB_RESYNC_CNT)  -1-: NB_RESYNC_CNT];
        end                           

        ALIGNER10__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(10*NB_RESYNC_CNT) -1 -: NB_RESYNC_CNT];
        end                           

        ALIGNER11__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(11*NB_RESYNC_CNT) -1 -: NB_RESYNC_CNT];
        end                           

        ALIGNER12__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(12*NB_RESYNC_CNT) -1 -: NB_RESYNC_CNT];
        end                           

        ALIGNER13__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(13*NB_RESYNC_CNT) -1 -: NB_RESYNC_CNT];
        end                           

        ALIGNER14__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(14*NB_RESYNC_CNT) -1 -: NB_RESYNC_CNT];
        end                           

        ALIGNER15__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(15*NB_RESYNC_CNT) -1 -: NB_RESYNC_CNT];
        end                           

        ALIGNER16__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(16*NB_RESYNC_CNT) -1 -: NB_RESYNC_CNT];
        end                           

        ALIGNER17__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(17*NB_RESYNC_CNT) -1 -: NB_RESYNC_CNT];
        end                           

        ALIGNER18__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(18*NB_RESYNC_CNT) -1 -: NB_RESYNC_CNT];
        end                           

        ALIGNER19__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_resync_counters[NB_RESYNC_CNT_BUS-(19*NB_RESYNC_CNT) -1 -: NB_RESYNC_CNT];
        end        


        ALIGNER__O_RF_ID_BASE :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(0*NB_LANE_ID)  -1-: NB_LANE_ID];   
        end                           

        ALIGNER1__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(1*NB_LANE_ID)  -1-: NB_LANE_ID];    
        end                           

        ALIGNER2__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(2*NB_LANE_ID)  -1-: NB_LANE_ID];    
        end                           

        ALIGNER3__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(3*NB_LANE_ID)  -1-: NB_LANE_ID];    
        end                           

        ALIGNER4__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(4*NB_LANE_ID)  -1-: NB_LANE_ID];   
        end                           

        ALIGNER5__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(5*NB_LANE_ID)  -1-: NB_LANE_ID];    
        end                           

        ALIGNER6__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(6*NB_LANE_ID)  -1-: NB_LANE_ID];
        end                           

        ALIGNER7__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(7*NB_LANE_ID)  -1-: NB_LANE_ID];
        end                           

        ALIGNER8__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(8*NB_LANE_ID)  -1-: NB_LANE_ID];
        end                           

        ALIGNER9__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(9*NB_LANE_ID)  -1-: NB_LANE_ID];
        end                           

        ALIGNER10__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(10*NB_LANE_ID) -1 -: NB_LANE_ID];
        end                           

        ALIGNER11__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(11*NB_LANE_ID) -1 -: NB_LANE_ID];
        end                           

        ALIGNER12__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(12*NB_LANE_ID) -1 -: NB_LANE_ID];
        end                           

        ALIGNER13__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(13*NB_LANE_ID) -1 -: NB_LANE_ID];
        end                           

        ALIGNER14__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(14*NB_LANE_ID) -1 -: NB_LANE_ID];
        end                           

        ALIGNER15__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(15*NB_LANE_ID) -1 -: NB_LANE_ID];
        end                           

        ALIGNER16__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(16*NB_LANE_ID) -1 -: NB_LANE_ID];
        end                           

        ALIGNER17__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(17*NB_LANE_ID) -1 -: NB_LANE_ID];
        end                           

        ALIGNER18__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(18*NB_LANE_ID) -1 -: NB_LANE_ID];
        end                           

        ALIGNER19__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(19*NB_LANE_ID) -1 -: NB_LANE_ID];
        end

        PTRNCHECK__O_RF_MISMATCH_COUNT :                    
        begin                         
         rf_o_data_muxed = ptrncheck__o_rf_mismatch_count;
        end        

        FRAME_DATA_CHECKER__O_RF_ERROR_COUNTER :                    
        begin                         
         rf_o_data_muxed = frame_data_checker__o_rf_error_counter;
        end  

        FRAME_DATA_CHECKER__O_RF_LOCK :                    
        begin                         
         rf_o_data_muxed = frame_data_checker__o_rf_lock;
        end  

        default :                          
            rf_o_data_muxed = {23'b0,input_addr};                
    endcase
end

endmodule

