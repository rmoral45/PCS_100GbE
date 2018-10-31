


module decoder_comparator
#(
    parameter LEN_CODED_BLOCK = 66,
    parameter LEN_RX_DATA = 64,
    parameter LEN_RX_CTRL = 8
 )
 (
    input wire i_clock,
    input wire i_reset,
    input wire  [LEN_CODED_BLOCK-1 : 0] i_rx_coded,
    output wire [LEN_RX_DATA-1 : 0] o_rx_data,
    output wire [LEN_RX_CTRL-1 : 0] o_rx_ctrl,
    output wire [] o_r_type
 );

 /////////// CGMII CHARACTERS /////////////////
 localparam [7:0] CGMII_START     = 8'hFB;
 localparam [7:0] CGMII_TERMINATE = 8'hFD;
 localparam [7:0] CGMII_FSIG      = 8'h5C;
 localparam [7:0] CGMII_Q         = 8'h9C;
 localparam [7:0] CGMII_IDLE      = 8'h07;


 localparam [3:0] ZERO = 4'h0; 
 ///////////   PCS CHARACTERS     /////////////
 localparam [6:0] PCS_IDLE  = 7'h00;
 localparam [6:0] PCS_ERROR = 7'h1E;
 localparam [3:0] PCS_Q     = 4'h0;
 localparam [3:0] PCS_FSIG  = 4'hF;
 //////////    BLOCK_TYPE        /////////////
 localparam [7:0] BTYPE_CTRL  = 8'h1E;
 localparam [7:0] BTYPE_S     = 8'h78;
 localparam [7:0] BTYPE_ORDER = 8'h4B;
 localparam [7:0] BTYPE_T0    = 8'h87;
 localparam [7:0] BTYPE_T1    = 8'h99;
 localparam [7:0] BTYPE_T2    = 8'hAA;
 localparam [7:0] BTYPE_T3    = 8'hB4;
 localparam [7:0] BTYPE_T4    = 8'hCC;
 localparam [7:0] BTYPE_T5    = 8'hD2;
 localparam [7:0] BTYPE_T6    = 8'hE1;
 localparam [7:0] BTYPE_T7    = 8'hFF;
 ///////////////   DECODIFICACION    //////////////////////

 localparam [1:0]  DATA_SH = 2'b01;
 localparam [1:0]  CTRL_SH = 2'b10;
 localparam [12:0] CODED_DATA = 13'b1000000000000;
 localparam [12:0] CODED_S    = 13'b0100000000000;
 localparam [12:0] CODED_Q    = 13'b0010000000000;
 localparam [12:0] CODED_FSIG = 13'b0001000000000;
 localparam [12:0] CODED_IDLE = 13'b0000100000000;
 localparam [12:0] CODED_T0   = 13'b0000010000000;
 localparam [12:0] CODED_T1   = 13'b0000001000000;
 localparam [12:0] CODED_T2   = 13'b0000000100000;
 localparam [12:0] CODED_T3   = 13'b0000000010000;
 localparam [12:0] CODED_T4   = 13'b0000000001000;
 localparam [12:0] CODED_T5   = 13'b0000000000100;
 localparam [12:0] CODED_T6   = 13'b0000000000010;
 localparam [12:0] CODED_T7   = 13'b0000000000001;

// division de bloque de entrada en payload,block_type y sh

wire [1:0] sh;
wire [(LEN_CODED_BLOCK-2)-1 : 0] coded_payload;
wire ctrl_sh;
wire data_sh;

assign sh            = i_rx_coded [LEN_CODED_BLOCK-1 -: 2]; // bits 65-64
assign coded_btype   = i_rx_coded [LEN_CODED_BLOCK-3 -: 8]; // bits 63-56
assign coded_payload = i_rx_coded [LEN_CODED_BLOCK-11 : 0]; // bits 55-0
assign ctrl_sh = (sh == 2'b10) ? 1'b1 : 1'b0;
assign data_sh = (sh == 2'b01) ? 1'b1 : 1'b0;
///////////////////////////////////////////////////

////////////////  block type check  ///////////////

wire block_type_data;
wire block_type_control ;
wire block_type_start ;
wire block_type_Q_Fsig ;
wire block_type_t0 ;
wire block_type_t1 ;
wire block_type_t2 ;
wire block_type_t3 ;
wire block_type_t4 ;
wire block_type_t5 ;
wire block_type_t6 ;
wire block_type_t7 ;


assign block_type_data = data_sh;
assign block_type_control = (ctrl_sh && (coded_btype == BTYPE_CTRL)) ? 1'b1 : 1'b0;
assign block_type_start   = (ctrl_sh && (coded_btype == BTYPE_S))    ? 1'b1 : 1'b0;
assign block_type_Q_Fsig  = (ctrl_sh && (coded_btype == BTYPE_ORDER))? 1'b1 : 1'b0;
assign block_type_t0      = (ctrl_sh && (coded_btype == BTYPE_T0))   ? 1'b1 : 1'b0;
assign block_type_t1      = (ctrl_sh && (coded_btype == BTYPE_T1))   ? 1'b1 : 1'b0;
assign block_type_t2      = (ctrl_sh && (coded_btype == BTYPE_T2))   ? 1'b1 : 1'b0;
assign block_type_t3      = (ctrl_sh && (coded_btype == BTYPE_T3))   ? 1'b1 : 1'b0;
assign block_type_t4      = (ctrl_sh && (coded_btype == BTYPE_T4))   ? 1'b1 : 1'b0;
assign block_type_t5      = (ctrl_sh && (coded_btype == BTYPE_T5))   ? 1'b1 : 1'b0;
assign block_type_t6      = (ctrl_sh && (coded_btype == BTYPE_T6))   ? 1'b1 : 1'b0;
assign block_type_t7      = (ctrl_sh && (coded_btype == BTYPE_T7))   ? 1'b1 : 1'b0;

////////////////////////////////////////////////////


///////////////   payload check   /////////////////

/*
verificar si debo checkear payload de caracteres de error o
si por defecto considero error
wire payload_error_block
*/
wire payload_idle_block;
wire payload_start_block;
wire payload_Q_block;
wire payload_Fsig_block;
wire payload_t0_block;
wire payload_t1_block;
wire payload_t2_block;
wire payload_t3_block;
wire payload_t4_block;
wire payload_t5_block;
wire payload_t6_block;
wire payload_t7_block;


assign payload_idle_block = (coded_payload == {8{PCS_IDLE}}) ? 1'b1 : 1'b0 ;
//assign payload_start_block;solo block type se checkea
assign payload_Q_block = (coded_payload[31:0] == {8{ZERO}}) ? 1'b1 : 1'b0 ;
assign payload_Fsig_block =(coded_payload[31:0] == {4'hf,{7{ZERO}}}) ? 1'b1 : 1'b0 ;
assign payload_t0_block = &(valid[6:0]);
assign payload_t1_block; 
assign payload_t2_block;
assign payload_t3_block;
assign payload_t4_block;
assign payload_t5_block;
assign payload_t6_block;
assign payload_t7_block;


wire [7:0] char_1_valid = ((i_rx_coded[6:0] == PCS_IDLE) ? CGMII_IDLE :
(i_rx_coded[6:0]) == PCS_ERROR ) ? CGMII_ERROR :

















map_char(byte1,valid[0]);



task map_char
input [6 : 0] pcs_char
output valid
output [LEN_CGMII_CHAR-1 : 0] cgmii_char
begin
    if(pcs_char == PCS_IDLE)
    begin
        cgmii_char = CGMII_IDLE;
        valid = 1;
    end
    else if(pcs_char == PCS_ERROR)
    begin
        cgmii_char = CGMII_ERROR;
        valid = 1;
    end
    else
    begin
        cgmii_char = 8'00;
        valid = 0;
    end
end

endtask

endmodule