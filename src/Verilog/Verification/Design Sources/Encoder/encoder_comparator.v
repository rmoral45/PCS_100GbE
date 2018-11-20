//Modulo de verificacion de encoder_comparator

module encoder_comparator
#(
    parameter LEN_CODED_BLOCK = 66,
    parameter LEN_TX_DATA = 64,
    parameter LEN_TX_CTRL = 8
 )
 (
  	input wire 						  	i_clock,
  	input wire 					      	i_reset,
  	input wire  [LEN_TX_DATA-1 : 0]     i_tx_data,
  	input wire  [LEN_TX_CTRL-1 : 0] 	i_tx_ctrl,
  	input wire 					      	i_enable,

  	output wire [3:0]                   o_t_type,
  	output reg  [LEN_CODED_BLOCK-1 : 0] o_tx_coded

 );


//LOCALPARAMS

//CGMII CHARACTERS
localparam [7:0] CGMII_START     = 8'hFB;
localparam [7:0] CGMII_TERMINATE = 8'hFD;
localparam [7:0] CGMII_FSIG      = 8'h5C;
localparam [7:0] CGMII_Q         = 8'h9C;
localparam [7:0] CGMII_IDLE      = 8'h07;
localparam [7:0] CGMII_ERROR     = 8'hFE;
localparam [3:0] ZERO = 4'h0; 

//PCS CHARACTERS 
localparam [6:0] PCS_IDLE  = 7'h00;
localparam [6:0] PCS_ERROR = 7'h1E;
localparam [3:0] PCS_Q     = 4'h0;
localparam [3:0] PCS_FSIG  = 4'hF;
//Sync Headers
localparam [1:0]  DATA_SH 	 = 2'b01;
localparam [1:0]  CTRL_SH 	 = 2'b10;
//BLOCK_TYPE
localparam		 N_BLOCK_TYPE= 13;
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

//Byte positions
localparam BYTE_0 = LEN_TX_DATA-1;
localparam BYTE_1 = LEN_TX_DATA-1-8;
localparam BYTE_2 = LEN_TX_DATA-1-16;
localparam BYTE_3 = LEN_TX_DATA-1-24;
localparam BYTE_4 = LEN_TX_DATA-1-32;
localparam BYTE_5 = LEN_TX_DATA-1-40;
localparam BYTE_6 = LEN_TX_DATA-1-48;
localparam BYTE_7 = LEN_TX_DATA-1-56;


//DECODIFICACION 
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


//INTERNAL SIGNALS

//Signals to encoder FSM

wire D_SIGNAL; // lo recibido en tx_data es bloque de datos
wire C_SIGNAL; // lo recibido en tx_data es bloque de control
wire S_SIGNAL; // lo recibido en tx_data es bloque de start
wire T_SIGNAL; // lo recibido en tx_data es bloque de terminate
wire [3:0] T_TYPE;//concatenacion de las seniales anteriores


//Enables

/*
	comparo el vector TX_C con los formatos correspondientes
	a los distintos tipos de bloque
*/
wire enable_data_block;
wire enable_S_Q_Fsig_block;
wire enable_control_block;
wire enable_t0_block;
wire enable_t1_block;
wire enable_t2_block;
wire enable_t3_block;
wire enable_t4_block;
wire enable_t5_block;
wire enable_t6_block;
wire enable_t7_block;


//payload 
/*
	comparo el payload de los bloques con el payload corrspondiente
	a los distintos tipos de bloque
*/
wire payload_S_block;
wire payload_Q_block;
wire payload_Fsig_block;
wire payload_idle_block;
wire payload_t0_block;
wire payload_t1_block;
wire payload_t2_block;
wire payload_t3_block;
wire payload_t4_block;
wire payload_t5_block;
wire payload_t6_block;
wire payload_t7_block;


//type
/*
	A cada uno de estos wires les asigno el resultado de la AND de todas
	las comparaciones necesarias para que un bloque sea de tipo X.
	Ej: para que sea IDLE se debe cumplir (TXC=0xff y TXD={8{CGMII_IDLE}})
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
wire [N_BLOCK_TYPE-1:0] deco_type;  // de tamanio igual a la suma de todos los type_


//caracteres mapeados 

/*
	registros para realizar el mapeo y validacion de los caracteres del payload,
	necesito tenerlos por que los bloques terminate tienen cualquier combinacion 
	de IDLES y ERROR luego del caracter /T/
*/

reg [7:0] valid_char;  

reg [7:0] in_char_0;
reg [7:0] in_char_1;
reg [7:0] in_char_2;
reg [7:0] in_char_3;
reg [7:0] in_char_4;
reg [7:0] in_char_5;
reg [7:0] in_char_6;
reg [7:0] in_char_7;

// caracteres mapeados
reg [6:0] pcs_char_0;
reg [6:0] pcs_char_1;
reg [6:0] pcs_char_2;
reg [6:0] pcs_char_3;
reg [6:0] pcs_char_4;
reg [6:0] pcs_char_5;
reg [6:0] pcs_char_6;
reg [6:0] pcs_char_7;


//Update input
reg [LEN_TX_DATA-1 : 0] tx_data;
reg [LEN_TX_CTRL-1 : 0] tx_ctrl;

always @(posedge i_clock)
begin

	if(i_reset)
	begin
		tx_data    <= {LEN_TX_DATA{1'b0}};
		tx_ctrl    <= {LEN_TX_CTRL{1'b0}}; 
	end
	else if(i_enable)
	begin
		tx_data    <= i_tx_data;
		tx_ctrl    <= i_tx_ctrl;
	end

end



//Enable check
/*
 comparacion de la senial tx_ctrl con las distintas posibilidades
 correspondientes a cada tipo de bloque
*/
assign enable_data_block =      (tx_ctrl == 8'h00) ? 1'b1 : 1'b0;
assign enable_S_Q_Fsig_block =  (tx_ctrl == 8'h80) ? 1'b1 : 1'b0;
assign enable_control_block =   (tx_ctrl == 8'hff) ? 1'b1 : 1'b0;
assign enable_t0_block =        (tx_ctrl == 8'hff) ? 1'b1 : 1'b0;  
assign enable_t1_block =        (tx_ctrl == 8'h7f) ? 1'b1 : 1'b0;
assign enable_t2_block =        (tx_ctrl == 8'h3f) ? 1'b1 : 1'b0;
assign enable_t3_block =        (tx_ctrl == 8'h1f) ? 1'b1 : 1'b0;
assign enable_t4_block =        (tx_ctrl == 8'h0f) ? 1'b1 : 1'b0;
assign enable_t5_block =        (tx_ctrl == 8'h07) ? 1'b1 : 1'b0;
assign enable_t6_block =        (tx_ctrl == 8'h03) ? 1'b1 : 1'b0;
assign enable_t7_block =        (tx_ctrl == 8'h01) ? 1'b1 : 1'b0;

//Payload check
/*
comparacion de 64 bits recibidos con los distintos formatos de bloque
*/
assign payload_S_block = 
	(tx_data[BYTE_0 -: 8]==CGMII_START)? 1'b1:1'b0;

assign payload_Q_block = 
	(tx_data[BYTE_0 -: 8]==CGMII_Q)    ? 1'b1 : 1'b0;

assign payload_Fsig_block = 
	(tx_data[BYTE_0 -: 8]==CGMII_FSIG) ? 1'b1 : 1'b0;

assign payload_idle_block = 
	( tx_data == {8{CGMII_IDLE}} )     ? 1'b1 : 1'b0;


assign payload_t0_block = 
	((tx_data[BYTE_0 -: 8] == CGMII_TERMINATE) && (& valid_char[6:0])) ? 1'b1 : 1'b0;

assign payload_t1_block = 
	((tx_data[BYTE_1 -: 8] == CGMII_TERMINATE) && (& valid_char[5:0])) ? 1'b1 : 1'b0;

assign payload_t2_block = 
	((tx_data[BYTE_2 -: 8] == CGMII_TERMINATE) && (& valid_char[4:0])) ? 1'b1 : 1'b0;

assign payload_t3_block = 
	((tx_data[BYTE_3 -: 8] == CGMII_TERMINATE) && (& valid_char[3:0])) ? 1'b1 : 1'b0;

assign payload_t4_block = 
	((tx_data[BYTE_4 -: 8] == CGMII_TERMINATE) && (& valid_char[2:0])) ? 1'b1 : 1'b0;

assign payload_t5_block = 
	((tx_data[BYTE_5 -: 8] == CGMII_TERMINATE) && (& valid_char[1:0])) ? 1'b1 : 1'b0;

assign payload_t6_block = 
	((tx_data[BYTE_6 -: 8] == CGMII_TERMINATE) && (& valid_char[0]))   ? 1'b1 : 1'b0;

assign payload_t7_block = 
	 (tx_data[BYTE_7 -: 8] == CGMII_TERMINATE) 						   ? 1'b1 : 1'b0;


//Type check    
/*
 determino el formato de bloque recibido utilizando la comparacion de tx_ctrl
 con el payload correspondiente a cada una de ellas
*/
assign type_data =  enable_data_block;
assign type_S    = (enable_S_Q_Fsig_block & payload_S_block);
assign type_Q    = (enable_S_Q_Fsig_block & payload_Q_block);
assign type_Fsig = (enable_S_Q_Fsig_block & payload_Fsig_block);
assign type_idle = (enable_control_block  & payload_idle_block);

assign type_t0   = (enable_t0_block 	  & payload_t0_block);
assign type_t1   = (enable_t1_block 	  & payload_t1_block);
assign type_t2   = (enable_t2_block 	  & payload_t2_block);
assign type_t3   = (enable_t3_block 	  & payload_t3_block);
assign type_t4   = (enable_t4_block 	  & payload_t4_block);
assign type_t5   = (enable_t5_block 	  & payload_t5_block);
assign type_t6   = (enable_t6_block 	  & payload_t6_block);
assign type_t7   = (enable_t7_block 	  & payload_t7_block);

assign deco_type = { type_data,type_S,type_Q,type_Fsig,type_idle ,
type_t0,type_t1,type_t2,type_t3,type_t4,type_t5,type_t6, type_t7 };


//FSM signal assigment
/*
  Equivalente a funcion T_TYPE definida en el estandar.
*/
assign D_SIGNAL = type_data;

assign C_SIGNAL = (type_Q | type_Fsig | type_idle );

assign S_SIGNAL = type_S;

assign T_SIGNAL = 
(type_t0 | type_t1 |type_t2 | type_t3 | type_t4 | type_t5 | type_t6 | type_t7);

assign T_TYPE = {D_SIGNAL,S_SIGNAL,C_SIGNAL,T_SIGNAL};




//Mapeo de caracteres de CGMII a PCS

/*
 valid_char :
 	en cada posicion seteo 1'b1 si el caracter respectivo es IDLE o ERROR,
    valid[7] se corrsponde al caracter de mas a la izquierda segun la tabla del estandar,
    es decir, el caracter 0
*/

always @ *
begin
	in_char_0 = tx_data[BYTE_0 -: 8];
	in_char_1 = tx_data[BYTE_1 -: 8];
	in_char_2 = tx_data[BYTE_2 -: 8];
	in_char_3 = tx_data[BYTE_3 -: 8];
	in_char_4 = tx_data[BYTE_4 -: 8];
	in_char_5 = tx_data[BYTE_5 -: 8];
	in_char_6 = tx_data[BYTE_6 -: 8];
	in_char_7 = tx_data[BYTE_7 -: 8];
	cgmii_to_pcs_char(in_char_0,valid_char[7],pcs_char_0);
	cgmii_to_pcs_char(in_char_1,valid_char[6],pcs_char_1);
	cgmii_to_pcs_char(in_char_2,valid_char[5],pcs_char_2);
	cgmii_to_pcs_char(in_char_3,valid_char[4],pcs_char_3);
	cgmii_to_pcs_char(in_char_4,valid_char[3],pcs_char_4);
	cgmii_to_pcs_char(in_char_5,valid_char[2],pcs_char_5);
	cgmii_to_pcs_char(in_char_6,valid_char[1],pcs_char_6);
	cgmii_to_pcs_char(in_char_7,valid_char[0],pcs_char_7);


end





//Port assigment

assign o_t_type = T_TYPE;

always @ *
begin
   
    case(deco_type)
        CODED_DATA : o_tx_coded = {DATA_SH,tx_data};

        CODED_S :    o_tx_coded = {CTRL_SH,BTYPE_S,tx_data[55:0]};
        
        CODED_Q :    o_tx_coded = {CTRL_SH,BTYPE_ORDER,tx_data[55-:24],PCS_Q,{7{ZERO}}};

        CODED_FSIG : o_tx_coded = {CTRL_SH,BTYPE_ORDER,tx_data[55-:24],PCS_FSIG,{7{ZERO}}};

        CODED_IDLE : o_tx_coded = {CTRL_SH,BTYPE_CTRL,{8{PCS_IDLE}} };

        CODED_T0 :   o_tx_coded = 
        	{CTRL_SH,BTYPE_T0,{7{1'b0}},{pcs_char_1,pcs_char_2,pcs_char_3,pcs_char_4,pcs_char_5,pcs_char_6,pcs_char_7} }; 

        CODED_T1 :   o_tx_coded = 
        	{CTRL_SH,BTYPE_T1,tx_data[63-:8] ,{6{1'b0}},{pcs_char_2,pcs_char_3,pcs_char_4,pcs_char_5,pcs_char_6,pcs_char_7} };

        CODED_T2 :   o_tx_coded = 
        	{CTRL_SH,BTYPE_T2,tx_data[63-:16],{5{1'b0}},{pcs_char_3,pcs_char_4,pcs_char_5,pcs_char_6,pcs_char_7} };

        CODED_T3 :   o_tx_coded = 
        	{CTRL_SH,BTYPE_T3,tx_data[63-:24],{4{1'b0}},{pcs_char_4,pcs_char_5,pcs_char_6,pcs_char_7} };

        CODED_T4 :   o_tx_coded = 
        	{CTRL_SH,BTYPE_T4,tx_data[63-:32],{3{1'b0}},{pcs_char_5,pcs_char_6,pcs_char_7} };

        CODED_T5 :   o_tx_coded = 
        	{CTRL_SH,BTYPE_T5,tx_data[63-:40],{2{1'b0}},{pcs_char_6,pcs_char_7} };

        CODED_T6 :   o_tx_coded = 
        	{CTRL_SH,BTYPE_T6,tx_data[63-:48],{1'b0},{pcs_char_7} };

        CODED_T7 :   o_tx_coded = 
        	{CTRL_SH,BTYPE_T7,tx_data[63-:56]};

        default  :   o_tx_coded = {CTRL_SH,BTYPE_CTRL,{8{PCS_ERROR}}};


    endcase

    


end

//Task para realizar mapeo de caracteres
task automatic cgmii_to_pcs_char;
localparam [7:0] CGMII_IDLE   = 8'h07;
localparam [7:0] CGMII_ERROR  = 8'hFE;
localparam [6:0] PCS_IDLE     = 7'h00;
localparam [6:0] PCS_ERROR    = 7'h1E;


input  [7:0] char_in;
output		 valid_out;
output [6:0] char_out; 

begin
	if(char_in == CGMII_IDLE)
	begin
		char_out = PCS_IDLE;
		valid_out = 1'b1;
	end
	else if (char_in == CGMII_ERROR) 
	begin
		char_out = PCS_ERROR;
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
