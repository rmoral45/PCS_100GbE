`timescale 1ns/100ps


/*
 * Definicion nombre OPCODES : <top_level>_<registro>_<accion>
 *
 *
 */
module register_file
#(
        NB_RF_DATA = , //FIXME
        NB_RF_OPCODE = , //FIXME
 )
 (
        input  wire                             i_clock,
        input  wire                             i_reset,
        input  wire [NB_RF_OPCODE-1 : 0]        i_opcode,
        input  wire [NB_RF_DATA-1 : 0]          i_data,
        output wire [NB_RF_DATA-1 : 0]          o_data
 );

/*------------------- Localparameters ------------------*/


/*-------------- OPCODES -----------------*/

/*------ MDIO ------*/
localparam [NB_RF_OPCODE-1 : 0]  PCS_CONTROL_RD         = 'd1000;
localparam [NB_RF_OPCODE-1 : 0]  PCS_STATUS_RD          = 'd1001;
localparam [NB_RF_OPCODE-1 : 0]  PCS_HI_BER_RD          = 'd1002;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BLOCK_LOCK_RD      = 'd1003;
localparam [NB_RF_OPCODE-1 : 0]  PCS_ALIGN_LOCK_RD      = 'd1004;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_0_RD   = 'd1005;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_1_RD   = 'd1006;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_2_RD   = 'd1007;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_3_RD   = 'd1008;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_4_RD   = 'd1009;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_5_RD   = 'd1010;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_6_RD   = 'd1011;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_7_RD   = 'd1012;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_8_RD   = 'd1013;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_9_RD   = 'd1014;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_10_RD  = 'd1015;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_11_RD  = 'd1016;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_12_RD  = 'd1017;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_13_RD  = 'd1018;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_14_RD  = 'd1019;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_15_RD  = 'd1020;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_16_RD  = 'd1021;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_17_RD  = 'd1022;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_18_RD  = 'd1023;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_LANE_19_RD  = 'd1024;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BERCNT_COMMON_RD   = 'd1025;
localparam [NB_RF_OPCODE-1 : 0]  PCS_ERR_BLOCKS_RD      = 'd1026;
localparam [NB_RF_OPCODE-1 : 0]  PCS_TEST_PATTRN_ERR_RD = 'd1027;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_0_RD      = 'd1028;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_1_RD      = 'd1029;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_2_RD      = 'd1030;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_3_RD      = 'd1031;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_4_RD      = 'd1032;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_5_RD      = 'd1033;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_6_RD      = 'd1034;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_7_RD      = 'd1035;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_8_RD      = 'd1036;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_9_RD      = 'd1037;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_10_RD     = 'd1038;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_11_RD     = 'd1039;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_12_RD     = 'd1040;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_13_RD     = 'd1041;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_14_RD     = 'd1042;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_15_RD     = 'd1043;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_16_RD     = 'd1044;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_17_RD     = 'd1045;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_18_RD     = 'd1046;
localparam [NB_RF_OPCODE-1 : 0]  PCS_LANE_MAP_19_RD     = 'd1047;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_0_RD   = 'd1048;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_1_RD   = 'd1049;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_2_RD   = 'd1050;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_3_RD   = 'd1051;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_4_RD   = 'd1052;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_5_RD   = 'd1053;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_6_RD   = 'd1054;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_7_RD   = 'd1055;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_8_RD   = 'd1056;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_9_RD   = 'd1057;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_10_RD  = 'd1058;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_11_RD  = 'd1059;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_12_RD  = 'd1060;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_13_RD  = 'd1061;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_14_RD  = 'd1062;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_15_RD  = 'd1063;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_16_RD  = 'd1064;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_17_RD  = 'd1065;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_18_RD  = 'd1066;
localparam [NB_RF_OPCODE-1 : 0]  PCS_BIPERR_LANE_19_RD  = 'd1067;


/*------ CUSTOM ------*/

localparam [NB_RF_OPCODE-1 : 0]  FCHK_ = ;
localparam [NB_RF_OPCODE-1 : 0]  FCHK_ = ;
localparam [NB_RF_OPCODE-1 : 0]  FCHK_ = ;
localparam [NB_RF_OPCODE-1 : 0]  FCHK_ = ;
localparam [NB_RF_OPCODE-1 : 0]  FCHK_ = ;

localparam [NB_RF_OPCODE-1 : 0]  BLKSYNC_INVALID_SH_LIM_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  BLKSYNC_LOCKED_WINDOW_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  BLKSYNC_UNLOCKED_WINDOW_WR= ;

localparam [NB_RF_OPCODE-1 : 0]  ALIGNER_INVALID_THR_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  ALIGNER_VALID_THR_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  ALIGNER_COMP_MASK_WR= ;

localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_0 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_1 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_2 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_3 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_4 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_5 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_6 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_7 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_8 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_9 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_10 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_11 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_12 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_13 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_14 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_15 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_16 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_17 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_18 = ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_BITSKEW_LANE_19 = ;

/* SH Breaker config */
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_0= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_1= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_2= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_3= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_4= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_5= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_6= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_7= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_8= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_9= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_10= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_11= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_12= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_13= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_14= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_15= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_16= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_17= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_18= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHMODE_LANE_19= ;

localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_0_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_1_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_2_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_3_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_4_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_5_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_6_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_7_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_8_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_9_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_10_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_11_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_12_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_13_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_14_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_15_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_16_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_17_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_18_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHBURST_LANE_19_WR= ;

localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_0_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_1_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_2_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_3_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_4_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_5_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_6_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_7_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_8_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_9_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_10_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_11_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_12_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_13_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_14_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_15_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_16_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_17_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_18_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHPERIOD_LANE_19_WR= ;

localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_0_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_1_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_2_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_3_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_4_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_5_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_6_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_7_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_8_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_9_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_10_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_11_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_12_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_13_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_14_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_15_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_16_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_17_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_18_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SHREPEAT_LANE_19_WR= ;

/*--- Payload ---*/

localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_0= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_1= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_2= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_3= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_4= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_5= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_6= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_7= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_8= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_9= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_10= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_11= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_12= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_13= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_14= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_15= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_16= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_17= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_18= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLMODE_LANE_19= ;

localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_0_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_1_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_2_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_3_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_4_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_5_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_6_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_7_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_8_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_9_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_10_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_11_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_12_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_13_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_14_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_15_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_16_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_17_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_18_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLBURST_LANE_19_WR= ;

localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_0_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_1_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_2_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_3_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_4_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_5_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_6_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_7_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_8_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_9_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_10_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_11_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_12_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_13_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_14_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_15_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_16_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_17_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_18_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLPERIOD_LANE_19_WR= ;

localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_0_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_1_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_2_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_3_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_4_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_5_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_6_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_7_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_8_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_9_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_10_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_11_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_12_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_13_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_14_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_15_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_16_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_17_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_18_WR= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_PLREPEAT_LANE_19_WR= ;

/*--- Skew config ---*/
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_0= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_1= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_2= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_3= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_4= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_5= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_6= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_7= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_8= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_9= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_10= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_11= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_12= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_13= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_14= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_15= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_16= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_17= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_18= ;
localparam [NB_RF_OPCODE-1 : 0]  CHANNEL_SKEW_LANE_19= ;

endmodule
