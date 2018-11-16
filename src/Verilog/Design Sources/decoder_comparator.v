/*

   Este bloque se encarga de realizar:
    -comparaciones necesarias de RX_CODED (bloque recibido codificado)
   	 para determinar el tipo de bloque recibido.
   	-Mapear caracteres de PCS(100GBASE-R) a caracteres CGMII.<tabla 82-1 pag 157 standard>
   	-Realizar decoding 66/64b
   	-Aplicar funcion R_TYPE.<pag 168 estandar> 
*/


module decoder_comparator
#(
    parameter LEN_CODED_BLOCK = 66,
    parameter LEN_RX_DATA = 64,
    parameter LEN_RX_CTRL = 8
 )
 (
    input wire 							i_clock,
    input wire 							i_reset,
    input wire  [LEN_CODED_BLOCK-1 : 0] i_rx_coded,
    input wire 							i_enable,
    output reg  [LEN_RX_DATA-1 : 0] 	o_rx_data,
    output reg  [LEN_RX_CTRL-1 : 0] 	o_rx_ctrl,
    output wire [3:0] 					o_r_type
 );

 //LOCALPARAMS

 /////////// CGMII CHARACTERS /////////////////
 localparam LEN_CGMII_CHAR = 8;
 localparam LEN_PCS_CHAR   = 7;

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

 /////////////////  SyncHeaders  /////////////////
 
 localparam DATA_SH = 2'b01;
 localparam CTRL_SH = 2'b10;


 /////////// character positions /////////////

 localparam CHAR_0 = LEN_CODED_BLOCK-3-8; // 66bits-1(65) - 2(sh) -8(blocktype)  = 55(es el primer bit del caracter 0)
 localparam CHAR_1 = LEN_CODED_BLOCK-3-8-7;
 localparam CHAR_2 = LEN_CODED_BLOCK-3-8-14;
 localparam CHAR_3 = LEN_CODED_BLOCK-3-8-21;
 localparam CHAR_4 = LEN_CODED_BLOCK-3-8-28;
 localparam CHAR_5 = LEN_CODED_BLOCK-3-8-35;
 localparam CHAR_6 = LEN_CODED_BLOCK-3-8-42;
 localparam CHAR_7 = LEN_CODED_BLOCK-3-8-49;


 ////////// byte positions ///////////////////


localparam BYTE_0 = LEN_CODED_BLOCK-3; // resto 3 para empezar en la posicion 63
localparam BYTE_1 = LEN_CODED_BLOCK-3-8;
localparam BYTE_2 = LEN_CODED_BLOCK-3-16;
localparam BYTE_3 = LEN_CODED_BLOCK-3-24;
localparam BYTE_4 = LEN_CODED_BLOCK-3-32;
localparam BYTE_5 = LEN_CODED_BLOCK-3-40;
localparam BYTE_6 = LEN_CODED_BLOCK-3-48;
localparam BYTE_7 = LEN_CODED_BLOCK-3-56;


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

 ///////////////    RX_CTRL    /////////////////
 /*
 	se definen los bits de control a enviar a CGMII
 	dependiendo del tipo de bloque decodificado
 */

 localparam [7:0] RX_CTRL_DATA  = 8'b 0000_0000;
 localparam [7:0] RX_CTRL_IDLE  = 8'b 1111_1111;
 localparam [7:0] RX_CTRL_ERROR = 8'b 1111_1111;
 localparam [7:0] RX_CTRL_START = 8'b 1000_0000;
 localparam [7:0] RX_CTRL_ORDER = 8'b 1000_0000;
 localparam [7:0] RX_CTRL_T0    = 8'b 1111_1111;
 localparam [7:0] RX_CTRL_T1    = 8'b 0111_1111;
 localparam [7:0] RX_CTRL_T2    = 8'b 0011_1111;
 localparam [7:0] RX_CTRL_T3    = 8'b 0001_1111;
 localparam [7:0] RX_CTRL_T4    = 8'b 0000_1111;
 localparam [7:0] RX_CTRL_T5    = 8'b 0000_0111;
 localparam [7:0] RX_CTRL_T6    = 8'b 0000_0011;
 localparam [7:0] RX_CTRL_T7    = 8'b 0000_0001;
 

 ///////////////   DECODIFICACION    ///////////

 
 localparam [12:0] RAW_DATA = 13'b1000000000000;
 localparam [12:0] RAW_S    = 13'b0100000000000;
 localparam [12:0] RAW_Q    = 13'b0010000000000;
 localparam [12:0] RAW_FSIG = 13'b0001000000000;
 localparam [12:0] RAW_IDLE = 13'b0000100000000;
 localparam [12:0] RAW_T0   = 13'b0000010000000;
 localparam [12:0] RAW_T1   = 13'b0000001000000;
 localparam [12:0] RAW_T2   = 13'b0000000100000;
 localparam [12:0] RAW_T3   = 13'b0000000010000;
 localparam [12:0] RAW_T4   = 13'b0000000001000;
 localparam [12:0] RAW_T5   = 13'b0000000000100;
 localparam [12:0] RAW_T6   = 13'b0000000000010;
 localparam [12:0] RAW_T7   = 13'b0000000000001;


//Update state
reg [LEN_CODED_BLOCK-1 : 0] rx_coded;

always @ (posedge  i_clock)
begin
	if(i_reset)        rx_coded <= {LEN_CODED_BLOCK{1'b0}};
	else if (i_enable) rx_coded <= i_rx_coded;
end



// Division de bloque de entrada en payload,block_type y sh

wire [1:0] sh;
wire [7:0] rx_block_type; 
wire [LEN_CODED_BLOCK-11 : 0] rx_payload;
wire ctrl_sh;
wire data_sh;

assign sh            = rx_coded [LEN_CODED_BLOCK-1 -: 2]; // bits 65-64
assign rx_block_type   = rx_coded [LEN_CODED_BLOCK-3 -: 8]; // bits 63-56(primer octeto)
assign rx_payload = rx_coded [LEN_CODED_BLOCK-11 : 0]; // bits 55-0
assign ctrl_sh = (sh == CTRL_SH) ? 1'b1 : 1'b0;
assign data_sh = (sh == DATA_SH) ? 1'b1 : 1'b0;


reg [7:0] byte_0;
reg [7:0] byte_1;
reg [7:0] byte_2;
reg [7:0] byte_3;
reg [7:0] byte_4;
reg [7:0] byte_5;
reg [7:0] byte_6;
reg [7:0] byte_7;

always @ *
begin
	byte_0 = rx_coded [BYTE_0 -: 8]; // D0
	byte_1 = rx_coded [BYTE_1 -: 8]; // D1
	byte_2 = rx_coded [BYTE_2 -: 8]; // D2
	byte_3 = rx_coded [BYTE_3 -: 8]; 
	byte_4 = rx_coded [BYTE_4 -: 8];
	byte_5 = rx_coded [BYTE_5 -: 8];
	byte_6 = rx_coded [BYTE_6 -: 8];
	byte_7 = rx_coded [BYTE_7 -: 8]; // D7
end


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


assign block_type_data    = data_sh;
assign block_type_control = (ctrl_sh && (rx_block_type == BTYPE_CTRL)) ? 1'b1 : 1'b0;
assign block_type_start   = (ctrl_sh && (rx_block_type == BTYPE_S))    ? 1'b1 : 1'b0;
assign block_type_Q_Fsig  = (ctrl_sh && (rx_block_type == BTYPE_ORDER))? 1'b1 : 1'b0;
assign block_type_t0      = (ctrl_sh && (rx_block_type == BTYPE_T0))   ? 1'b1 : 1'b0;
assign block_type_t1      = (ctrl_sh && (rx_block_type == BTYPE_T1))   ? 1'b1 : 1'b0;
assign block_type_t2      = (ctrl_sh && (rx_block_type == BTYPE_T2))   ? 1'b1 : 1'b0;
assign block_type_t3      = (ctrl_sh && (rx_block_type == BTYPE_T3))   ? 1'b1 : 1'b0;
assign block_type_t4      = (ctrl_sh && (rx_block_type == BTYPE_T4))   ? 1'b1 : 1'b0;
assign block_type_t5      = (ctrl_sh && (rx_block_type == BTYPE_T5))   ? 1'b1 : 1'b0;
assign block_type_t6      = (ctrl_sh && (rx_block_type == BTYPE_T6))   ? 1'b1 : 1'b0;
assign block_type_t7      = (ctrl_sh && (rx_block_type == BTYPE_T7))   ? 1'b1 : 1'b0;


///////////////////  mapeo de caracteres  //////////////////////
/*
 
 valid_char :
 	en cada posicion seteo 1'b1 si el caracter respectivo es IDLE o ERROR,
    valid[7] se corrsponde al caracter de mas a la izquierda segun la tabla del estandar,
    es decir, el caracter 0, valid[6] al caracter 1 y asi sucesivamente

*/

reg [7:0] valid; 


// caracteres de payload (RX_CODED)
reg [6:0] in_char_0;
reg [6:0] in_char_1;
reg [6:0] in_char_2;
reg [6:0] in_char_3;
reg [6:0] in_char_4;
reg [6:0] in_char_5;
reg [6:0] in_char_6;
reg [6:0] in_char_7;


reg [7:0] cgmii_char_0;
reg [7:0] cgmii_char_1;
reg [7:0] cgmii_char_2;
reg [7:0] cgmii_char_3;
reg [7:0] cgmii_char_4;
reg [7:0] cgmii_char_5;
reg [7:0] cgmii_char_6;
reg [7:0] cgmii_char_7;

always @ *
begin
	in_char_0 = rx_coded[CHAR_0 -: 7];
	in_char_1 = rx_coded[CHAR_1 -: 7];
	in_char_2 = rx_coded[CHAR_2 -: 7];
	in_char_3 = rx_coded[CHAR_3 -: 7];
	in_char_4 = rx_coded[CHAR_4 -: 7];
	in_char_5 = rx_coded[CHAR_5 -: 7];
	in_char_6 = rx_coded[CHAR_6 -: 7];
	in_char_7 = rx_coded[CHAR_7 -: 7];

	pcs_to_cgmii_char(in_char_0,valid[7],cgmii_char_0);
	pcs_to_cgmii_char(in_char_1,valid[6],cgmii_char_1);
	pcs_to_cgmii_char(in_char_2,valid[5],cgmii_char_2);
	pcs_to_cgmii_char(in_char_3,valid[4],cgmii_char_3);
	pcs_to_cgmii_char(in_char_4,valid[3],cgmii_char_4);
	pcs_to_cgmii_char(in_char_5,valid[2],cgmii_char_5);
	pcs_to_cgmii_char(in_char_6,valid[1],cgmii_char_6);
	pcs_to_cgmii_char(in_char_7,valid[0],cgmii_char_7);
end


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


assign payload_idle_block = (rx_payload       == {8{PCS_IDLE}})    ? 1'b1 : 1'b0 ;
//assign payload_start_block;solo block type se checkea
assign payload_Q_block    = (rx_payload[31:0] == {8{ZERO}})        ? 1'b1 : 1'b0 ;

assign payload_Fsig_block = (rx_payload[31:0] == {4'hf,{7{ZERO}}}) ? 1'b1 : 1'b0 ;

assign payload_t0_block   =  &(valid[6:0]);
assign payload_t1_block   =  &(valid[5:0]); 
assign payload_t2_block   =  &(valid[4:0]);
assign payload_t3_block   =  &(valid[3:0]);
assign payload_t4_block   =  &(valid[2:0]);
assign payload_t5_block   =  &(valid[1:0]);
assign payload_t6_block   =  &(valid[0]);
assign payload_t7_block   =  block_type_t7; //solo se checkea el tipo de bloque(asignacion redundante,para mantener el estilo nomas)

////////////////////////////  block format check  /////////////////////////
/*
	verifico que los bloques tengan tanto block type como payload valido
*/
wire type_data;
wire type_S;
wire type_Q;
wire type_Fsig;
wire type_idle;
wire type_t0;
wire type_t1;
wire type_t2;
wire type_t3;
wire type_t4;
wire type_t5;
wire type_t6;
wire type_t7;
wire [12:0] deco_type;  // de tamanio igual a la suma de todos los type_

assign type_data = block_type_data; //solo se checkea el sh (asignacion redundante,para mantener el estilo nomas)
assign type_S    = block_type_start; //solo se checkea el block type (asignacion redundante,para mantener el estilo nomas)
assign type_Q    = (block_type_Q_Fsig  & payload_Q_block);
assign type_Fsig = (block_type_Q_Fsig  & payload_Fsig_block);
assign type_idle = (block_type_control & payload_idle_block);
assign type_t0   = (block_type_t0 & payload_t0_block);
assign type_t1   = (block_type_t1 & payload_t1_block);
assign type_t2   = (block_type_t2 & payload_t2_block);
assign type_t3   = (block_type_t3 & payload_t3_block);
assign type_t4   = (block_type_t4 & payload_t4_block);
assign type_t5   = (block_type_t5 & payload_t5_block);
assign type_t6   = (block_type_t6 & payload_t6_block);
assign type_t7   = (block_type_t7 & payload_t7_block);

assign deco_type = { type_data,type_S,type_Q,type_Fsig,type_idle ,
type_t0,type_t1,type_t2,type_t3,type_t4,type_t5,type_t6, type_t7 };



///////////////////   SIGNALS TO FSM  //////////////////////////

wire       D_SIGNAL;
wire       S_SIGNAL;
wire       C_SIGNAL;
wire       T_SIGNAL;
wire [3:0] R_TYPE;

assign D_SIGNAL = type_data; //solo se checkea el sh (asignacion redundante,para mantener el estilo nomas)
assign S_SIGNAL = type_S;   //solo se checkea block_type (asignacion redundante,para mantener el estilo nomas)
/*
	PREG A RAMIRO LOPEZ:

	el estandar dice que hay que chekear solo el block type de los ordered(0x4b) no especifica el caracter
	0x0 o 0xf ,pero deberia ser asi supongo
*/
assign C_SIGNAL = (type_Q | type_Fsig | type_idle );

assign T_SIGNAL = (type_t0 | type_t1 |type_t2 | type_t3 | type_t4 | type_t5 | type_t6 | type_t7);

assign R_TYPE = {D_SIGNAL,S_SIGNAL,C_SIGNAL,T_SIGNAL};//si R_TYPE es 4'b0000 implica error


//PORT ASSIGMENTS   

assign o_r_type = R_TYPE;


always @ *
begin
	case(deco_type)
		RAW_DATA :
		begin
			o_rx_data = {byte_0,byte_1,byte_2,byte_3,byte_4,byte_5,byte_6,byte_7}; //todo el bloque excepto sh
			o_rx_ctrl = RX_CTRL_DATA;
		end
		RAW_S :
		begin
			o_rx_data = {CGMII_START,byte_1,byte_2,byte_3,byte_4,byte_5,byte_6,byte_7};
			o_rx_ctrl =  RX_CTRL_START;
		end
		RAW_Q :
		begin
			o_rx_data = {CGMII_Q,byte_1,byte_2,byte_3,byte_4,byte_5,byte_6,byte_7};
			o_rx_ctrl =  RX_CTRL_ORDER;
		end
		RAW_FSIG :
		begin
			o_rx_data = {CGMII_FSIG,byte_1,byte_2,byte_3,byte_4,byte_5,byte_6,byte_7};
			o_rx_ctrl =  RX_CTRL_ORDER;
		end
		RAW_IDLE :
		begin
			o_rx_data = {8{CGMII_IDLE}};
			o_rx_ctrl = RX_CTRL_IDLE;
		end
		RAW_T0 :
		begin
			o_rx_data = 
			{CGMII_TERMINATE,cgmii_char_1,cgmii_char_2,cgmii_char_3,cgmii_char_4,cgmii_char_5,cgmii_char_6,cgmii_char_7};
			o_rx_ctrl = RX_CTRL_T0;
		end
		RAW_T1 :
		begin
			o_rx_data = 
			{byte_0,CGMII_TERMINATE,cgmii_char_2,cgmii_char_3,cgmii_char_4,cgmii_char_5,cgmii_char_6,cgmii_char_7};
		  //{  D0 ,       /T/     , /I/ o /E/  , /I/ o /E/  ,  /I/ o /E/ ,  /I/ o /E/ , /I/ o /E/  , /I/ o /E/  }
			o_rx_ctrl = RX_CTRL_T1;
		end
		RAW_T2 :
		begin
			o_rx_data = 
			{byte_0,byte_1,CGMII_TERMINATE,cgmii_char_3,cgmii_char_4,cgmii_char_5,cgmii_char_6,cgmii_char_7};
		  //{   D0 ,  D1  ,      /T/      , /I/ o /E/  , /I/ o /E/  ,  /I/ o /E/ ,  /I/ o /E/ , /I/ o /E/  }

			o_rx_ctrl = RX_CTRL_T2;
		end
		RAW_T3 :
		begin
			o_rx_data = 
			{byte_0,byte_1,byte_2,CGMII_TERMINATE,cgmii_char_4,cgmii_char_5,cgmii_char_6,cgmii_char_7};
			o_rx_ctrl = RX_CTRL_T3;
		end
		RAW_T4 :
		begin
			o_rx_data = 
			{byte_0,byte_1,byte_2,byte_3,CGMII_TERMINATE,cgmii_char_5,cgmii_char_6,cgmii_char_7};
			o_rx_ctrl = RX_CTRL_T4;
		end
		RAW_T5 :
		begin
			o_rx_data = 
			{byte_0,byte_1,byte_2,byte_3,byte_4,CGMII_TERMINATE,cgmii_char_6,cgmii_char_7};
			o_rx_ctrl = RX_CTRL_T5;
		end
		RAW_T6 :
		begin
			o_rx_data = 
			{byte_0,byte_1,byte_2,byte_3,byte_4,byte_5,CGMII_TERMINATE,cgmii_char_7};
			o_rx_ctrl = RX_CTRL_T6;
		end
		RAW_T7 :
		begin
			o_rx_data = 
			{byte_0,byte_1,byte_2,byte_3,byte_4,byte_5,byte_6,CGMII_TERMINATE};
			o_rx_ctrl = RX_CTRL_T7;
		end
	endcase
end





//////////////////////////////////////////////////////////////////////////////




task automatic pcs_to_cgmii_char;
localparam [7:0] CGMII_IDLE   = 8'h07;
localparam [7:0] CGMII_ERROR  = 8'hFE;
localparam [6:0] PCS_IDLE     = 7'h00;
localparam [6:0] PCS_ERROR    = 7'h1E;


input  [6:0] char_in;     //pcs_char
output		 valid_out;  // bit indicando caracter valido
output [7:0] char_out;  //cgmii_char(mapeo de caracter de tipo PCS a tipo CGMII)

begin
	if(char_in == PCS_IDLE)
	begin
		char_out = CGMII_IDLE;
		valid_out = 1'b1;
	end
	else if (char_in == PCS_ERROR) 
	begin
		char_out = CGMII_ERROR;
		valid_out = 1'b1;
	end
	else 
	begin
		char_out = 7'hFF; // seteo algun valor que no sirva por defecto
		valid_out = 1'b0;
	end
end
endtask

endmodule
