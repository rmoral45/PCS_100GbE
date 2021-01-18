/*
	Verifica la secuencia de bloques recibidos
*/
module decoder_fsm
#(
    parameter 							LEN_DATA_BLOCK = 64,
    parameter 							LEN_CTRL_BLOCK = 8,
    parameter                           N_STATES = 4,
    parameter                           NB_ERROR_COUNTER = 32
 )
 (
 	input wire  						i_clock,
 	input wire  						i_reset,
 	input wire  						i_enable,
 	input wire 	[N_STATES -1 : 0] 		i_r_type,
 	input wire 	[N_STATES -1 : 0] 		i_r_type_next,
 	input wire  [LEN_DATA_BLOCK-1 : 0] 	i_rx_data,       //recibida desde el bloque comparador/decodificador
 	input wire  [LEN_CTRL_BLOCK-1 : 0] 	i_rx_control,    //recibida desde el bloque comparador/decodificador
 	input wire                          i_valid,
 	output wire	[LEN_DATA_BLOCK-1 : 0] 	o_rx_raw_data,   // solo difiere de lo recibido del comparador si la secuencia es incorrecta
 	output wire	[LEN_CTRL_BLOCK-1 : 0] 	o_rx_raw_control, // solo difiere de lo recibido del comparador si la secuencia es incorrecta
 	output wire                         o_fsm_control
 );

reg [N_STATES -1 : 0]					state,state_next;
reg [LEN_DATA_BLOCK-1 : 0] 				rx_raw_data, rx_raw_data_next;
reg [LEN_CTRL_BLOCK-1 : 0] 				rx_raw_control, rx_raw_control_next;

reg [NB_ERROR_COUNTER-1 : 0] 			error_counter;
wire [NB_ERROR_COUNTER-1 : 0] 			error_counter_next;

//R_TYPE / i_r_type_next
localparam [3:0] TYPE_D  = 4'b1000;
localparam [3:0] TYPE_S  = 4'b0100;
localparam [3:0] TYPE_C  = 4'b0010;
localparam [3:0] TYPE_T  = 4'b0001;
localparam [3:0] TYPE_E  = 4'b0000;
//STATES
localparam [4:0] RX_INIT = 5'b10000;
localparam [4:0] RX_C    = 5'b01000;
localparam [4:0] RX_D    = 5'b00100;
localparam [4:0] RX_T    = 5'b00010;
localparam [4:0] RX_E    = 5'b00001;

assign o_rx_raw_data 	 = rx_raw_data;
assign o_rx_raw_control  = rx_raw_control;
assign o_fsm_control     = (state == RX_T) && state_next == RX_C;

/*

AGREGARR 

localparam [LEN_DATA_BLOCK-1 : 0] LBLOCK_R_DATA = local fault orderer set en clausula 81.2.3    //0x5c00000100000000 ESE ES EL FORMATO DE BLOQUE
localparam [LEN_CTRL_BLOCK-1 : 0] LBLOCK_R_CTRL

*/

localparam [LEN_DATA_BLOCK-1 : 0] EBLOCK_R_DATA = 64'h1E1E1E1E1E1E1E1E;
localparam [LEN_CTRL_BLOCK-1 : 0] EBLOCK_R_CTRL = 8'h1E;

//error counter
always @(posedge i_clock)
begin
    if(i_reset)
        error_counter <= {NB_ERROR_COUNTER{1'b0}};
    else if(i_enable && i_valid)
        error_counter <= error_counter_next;
end

assign error_counter_next = (state_next == RX_E) ? error_counter + 1 : error_counter;

//Update state
always @ (posedge i_clock)
begin
	if(i_reset)
	begin	
		//rx_raw_data <= LBLOCK_R_DATA;  
		//rx_raw_control <= LBLOCK_R_CTRL;
		rx_raw_data <= {LEN_DATA_BLOCK{1'b0}};  
        rx_raw_control <= {LEN_CTRL_BLOCK{1'b0}};
		state <= RX_INIT;

	end
	else if(i_enable && i_valid)
	begin

		rx_raw_data <= rx_raw_data_next;
		rx_raw_control <= rx_raw_control_next;
		state <= state_next;
		
	end

end

always @ *
begin

	state_next 			= state;
	rx_raw_control_next = {LEN_CTRL_BLOCK{1'b0}};
	rx_raw_data_next 	= {LEN_DATA_BLOCK{1'b0}};

	case(state)
		
		RX_INIT:
		begin
				if(i_r_type == TYPE_C)
				begin
					state_next = RX_C;
					rx_raw_data_next = i_rx_data;
					rx_raw_control_next = i_rx_control;

				end
				else if(i_r_type == TYPE_S)
				begin
					state_next = RX_D;
					rx_raw_data_next = i_rx_data;
					rx_raw_control_next = i_rx_control;
				end
				else if(i_r_type == TYPE_E || i_r_type == TYPE_D || i_r_type == TYPE_T)
				begin
					state_next = RX_E;
					rx_raw_data_next = EBLOCK_R_DATA;
					rx_raw_control_next = EBLOCK_R_CTRL;
				end
		end

		RX_C:
		begin
				if(i_r_type == TYPE_C)
				begin
					state_next = RX_C;
					rx_raw_data_next = i_rx_data;
					rx_raw_control_next = i_rx_control;
				end
				else if(i_r_type == TYPE_S)
				begin
					state_next = RX_D;
					rx_raw_data_next = i_rx_data;
					rx_raw_control_next = i_rx_control;
				end
				else if(i_r_type == TYPE_E || i_r_type == TYPE_D || i_r_type == TYPE_T)
				begin
					state_next = RX_E;
					rx_raw_data_next = EBLOCK_R_DATA;
					rx_raw_control_next = EBLOCK_R_CTRL;
				end
		end

		RX_D:
		begin
				if(i_r_type == TYPE_D)
				begin
					state_next = RX_D;
					rx_raw_data_next = i_rx_data;
					rx_raw_control_next = i_rx_control;
				end
				else if(i_r_type == TYPE_T && (i_r_type_next == TYPE_S ||  i_r_type_next == TYPE_C))
				begin
					state_next = RX_T;
					rx_raw_data_next = i_rx_data;
					rx_raw_control_next = i_rx_control;
				end
				else if((i_r_type == TYPE_T && (i_r_type_next == TYPE_E || i_r_type_next == TYPE_D || i_r_type_next == TYPE_T)) || (i_r_type == TYPE_E || i_r_type == TYPE_C || i_r_type == TYPE_S))
				begin
					state_next = RX_E;
					rx_raw_data_next = EBLOCK_R_DATA;
					rx_raw_control_next = EBLOCK_R_CTRL;
				end	
		end

		RX_T:
		begin
				if(i_r_type == TYPE_C)
				begin
					state_next = RX_C;
					rx_raw_data_next = i_rx_data;
					rx_raw_control_next = i_rx_control;
				end
				else if(i_r_type == TYPE_S)
				begin
					state_next = RX_D;
					rx_raw_data_next = i_rx_data;
					rx_raw_control_next = i_rx_control;
				end
		end

		RX_E:
		begin
				if(i_r_type == TYPE_C)
				begin
					state_next = RX_C;
					rx_raw_data_next = i_rx_data;
					rx_raw_control_next = i_rx_control;
				end
				else if(i_r_type == TYPE_S)
				begin
					state_next = RX_D;
					rx_raw_data_next = i_rx_data;
					rx_raw_control_next = i_rx_control;
				end
				else if(i_r_type == TYPE_T && (i_r_type_next == TYPE_S || i_r_type_next == TYPE_C))
				begin
					state_next = RX_T;
					rx_raw_data_next = i_rx_data;
					rx_raw_control_next = i_rx_control;
				end
				else if((i_r_type == TYPE_T || (i_r_type_next == TYPE_E || i_r_type_next == TYPE_D || i_r_type_next == TYPE_T)) || (i_r_type == TYPE_E || i_r_type == TYPE_S))
				begin
					state_next = RX_E;
					rx_raw_data_next = EBLOCK_R_DATA;
					rx_raw_control_next = EBLOCK_R_CTRL;
				end
		end
	endcase
end

endmodule