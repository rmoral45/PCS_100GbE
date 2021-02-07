
module rf_read_mux
#(
    parameter NB_ADDR   = ,
    parameter NB_GPIO = 32,
    parameter N_LANES = 20,
    parameter NB_BIP_ERR = ,
    parameter NB_BIP_ERR_BUS = N_LANES * NB_BIR_ERR,
    parameter NB_RESYNC_CNT =,
    parameter NB_RESYNC_CNT_BUS = N_LANES * NB_RESYNC_CNT,
    parameter NB_PTRN_MISMATCH_CNT,
    parameter NB_LANE_ID = 5,
    parameter NB_LANE_ID_BUS = N_LANES * NB_LANE_ID,
    parameter NB_DECODE_ERR
 )
 (
    output wire [NB_GPIO-1 : 0]              o_gpio_data
    input wire  [NB_ADDR-1 : 0]              input_addr,
    input wire  [N_LANES-1 : 0]              bermonitor__o_rf_hi_ber,
    input wire  []                           aligner__o_rf_bip_error_count,
    input wire                               deskewer__o_rf_invalid_skew,
    input wire  [NB_PTRN_MISMATCH_CNT-1 : 0] ptrncheck__o_rf_mismatch_count,
    input wire  [N_LANES-1 : 0]              blksync__o_rf_block_lock,
    input wire  [NB_LANE_ID_BUS-1 : 0]       aligner__o_rf_id,
    input wire  [NB_DECODE_ERR-1  : 0]       decoder__o_rf_error_counter
 );

///// REG ADDR INCLUDE
`include "./reg_addr_decl.v"

reg [NB_O_DATA-1 : 0] rf_o_data_d;
reg [NB_O_DATA-1 : 0] rf_o_data_muxed;

always @ (posedge i_clock)begin
    if (i_reset)
        rf_o_data_d <= {NB_O_DATA{1'b0}};
    else
        rf_o_data_d <= rf_o_data_muxed;
end

always @ (*) begin
    case (input_addr)

        BERMONITOR__O_RF_HI_BER_BASE :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[19];    
        end                           

        BERMONITOR1__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[18];    
        end                           

        BERMONITOR2__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[17];    
        end                           

        BERMONITOR3__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[16];    
        end                           

        BERMONITOR4__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[15];   
        end                           

        BERMONITOR5__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[14];   
        end                           

        BERMONITOR6__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[13];    
        end                           

        BERMONITOR7__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[12];    
        end                           

        BERMONITOR8__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[11];    
        end                           

        BERMONITOR9__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[10];    
        end                           

        BERMONITOR10__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[9];  
        end                           

        BERMONITOR11__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[8];   
        end                           

        BERMONITOR12__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[7];   
        end                           

        BERMONITOR13__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[6];  
        end                           

        BERMONITOR14__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[5];   
        end                           

        BERMONITOR15__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[4]; 
        end                           

        BERMONITOR16__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[3]; 
        end                           

        BERMONITOR17__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[2]; 
        end                           

        BERMONITOR18__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[1];
        end                           

        BERMONITOR19__O_RF_HI_BER :                    
        begin                         
         rf_o_data_muxed = bermonitor__o_rf_hi_ber[0]; 
        end                           

        ALIGNER__O_RF_BIP_ERROR_COUNT_BASE :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(0*NB_BIP_ERR) -: NB_BIP_ERR];    
        end                           

        ALIGNER1__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(1*NB_BIP_ERR) -: NB_BIP_ERR];   
        end                           

        ALIGNER2__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(2*NB_BIP_ERR) -: NB_BIP_ERR];   
        end                           

        ALIGNER3__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(3*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER4__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(4*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER5__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(5*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER6__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(6*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER7__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(7*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER8__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(8*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER9__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(9*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER10__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(10*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER11__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(11*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER12__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(12*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER13__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(13*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER14__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(14*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER15__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(15*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER16__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(16*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER17__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(17*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER18__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(18*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER19__O_RF_BIP_ERROR_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_bip_error_count[NB_BIP_ERR_BUS-(19*NB_BIP_ERR) -: NB_BIP_ERR];
        end                           

        ALIGNER__O_RF_RESYNC_COUNT_BASE :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(0*NB_RESYNC_CNT) -: NB_RESYNC_CNT];  
        end                           

        ALIGNER1__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(1*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER2__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(2*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER3__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(3*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER4__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(4*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER5__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(5*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER6__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(6*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER7__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(7*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER8__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(8*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER9__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(9*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER10__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(10*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER11__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(11*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER12__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(12*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER13__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(13*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER14__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(14*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER15__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(15*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER16__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(16*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER17__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(17*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER18__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(18*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER19__O_RF_RESYNC_COUNT :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_resync_count[NB_RESYNC_CNT_BUS-(19*NB_RESYNC_CNT) -: NB_RESYNC_CNT];
        end                           

        ALIGNER__O_RF_AM_LOCK_BASE :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[19];
        end                           

        ALIGNER1__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[18];   
        end                           

        ALIGNER2__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[17];    
        end                           

        ALIGNER3__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[16];  
        end                           

        ALIGNER4__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[15];
        end                           

        ALIGNER5__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[14];  
        end                           

        ALIGNER6__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[13];
        end                           

        ALIGNER7__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[12];  
        end                           

        ALIGNER8__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[11]; 
        end                           

        ALIGNER9__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[10];  
        end                           

        ALIGNER10__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[9]; 
        end                           

        ALIGNER11__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[8];
        end                           

        ALIGNER12__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[7];
        end                           

        ALIGNER13__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[6];
        end                           

        ALIGNER14__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[5]; 
        end                           

        ALIGNER15__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[4];
        end                           

        ALIGNER16__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[3];
        end                           

        ALIGNER17__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[2];
        end                           

        ALIGNER18__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[1];
        end                           

        ALIGNER19__O_RF_AM_LOCK :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_am_lock[0];
        end                           

        DESKEWER__O_RF_INVALID_SKEW :                    
        begin                         
         rf_o_data_muxed = deskewer__o_rf_invalid_skew; 
        end                           

        PTRNCHECK__O_RF_MISMATCH_COUNT :                    
        begin                         
         rf_o_data_muxed = ptrncheck__o_rf_mismatch_count;    
        end                           

        BLKSYNC__O_RF_BLOCK_LOCK_BASE :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[19];    
        end                           

        BLKSYNC1__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[18];    
        end                           

        BLKSYNC2__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[17];  
        end                           

        BLKSYNC3__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[16];
        end                           

        BLKSYNC4__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[15];
        end                           

        BLKSYNC5__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[14];
        end                           

        BLKSYNC6__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[13];
        end                           

        BLKSYNC7__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[12];
        end                           

        BLKSYNC8__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[11];
        end                           

        BLKSYNC9__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[10];
        end                           

        BLKSYNC10__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[9];
        end                           

        BLKSYNC11__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[8];
        end                           

        BLKSYNC12__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[7];
        end                           

        BLKSYNC13__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[6];
        end                           

        BLKSYNC14__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[5];
        end                           

        BLKSYNC15__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[4];
        end                           

        BLKSYNC16__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[3];
        end                           

        BLKSYNC17__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[2]; 
        end                           

        BLKSYNC18__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[1];
        end                           

        BLKSYNC19__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksync__o_rf_block_lock[0];
        end                           

        ALIGNER__O_RF_ID_BASE :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];   
        end                           

        ALIGNER1__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];    
        end                           

        ALIGNER2__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];    
        end                           

        ALIGNER3__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];    
        end                           

        ALIGNER4__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];   
        end                           

        ALIGNER5__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];    
        end                           

        ALIGNER6__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner6__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER7__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner7__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER8__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner8__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER9__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner9__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER10__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner10__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER11__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner11__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER12__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner12__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER13__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner13__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER14__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner14__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER15__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner15__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER16__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner16__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER17__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner17__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER18__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner18__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER19__O_RF_ID :                    
        begin                         
         rf_o_data_muxed = aligner19__o_rf_id[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        BLKSYNCS__O_RF_BLOCK_LOCK :                    
        begin                         
         rf_o_data_muxed = blksyncs__o_rf_block_lock[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNERS__O_RF_ALIGN_LOCK :                    
        begin                         
         rf_o_data_muxed = aligners__o_rf_align_lock[NB_LANE_ID_BUS-(*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER__O_RF_LANE_ID_BASE :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(0*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER1__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(1*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER2__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(2*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER3__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(3*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER4__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(4*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER5__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(5*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER6__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(6*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER7__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(7*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER8__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(8*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER9__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(9*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER10__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(10*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER11__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(11*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER12__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(12*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER13__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(13*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER14__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(14*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER15__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(15*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER16__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(16*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER17__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(17*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER18__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(18*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        ALIGNER19__O_RF_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_rf_lane_id[NB_LANE_ID_BUS-(19*NB_LANE_ID) -: NB_LANE_ID];
        end                           

        //FIXME maybe unused
        /*ALIGNER__O_COR_LANE_ID :                    
        begin                         
         rf_o_data_muxed = aligner__o_cor_lane_id    
        end     */                      

                      
        DECODER__O_RF_ERROR_COUNTER :                    
        begin                         
         rf_o_data_muxed = decoder__o_rf_error_counter; 
        end

        default :                          
            rf_o_data_muxed = {3NB_O_DATA{1'b0}};                
    endcase
end

endmodule

