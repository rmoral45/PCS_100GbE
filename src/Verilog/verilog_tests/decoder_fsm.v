module decoder_interface
#(
    parameter LEN_RX_DATA = 64,
    parameter LEN_RX_CTRL = 8
 )
 (
 	input wire  i_clock,
 	input wire  i_reset,
 	input wire  i_enable,
 	input wire 	[3 : 0] i_r_type,
 	input wire 	[3 : 0] i_r_type_next
 	input wire  [LEN_RX_DATA-1 : 0] i_rx_raw_data,
 	input wire  [LEN_RX_CTRL-1 : 0] i_rx_raw_control,
 	output wire	[LEN_RX_DATA-1 : 0] o_rx_raw_data,
 	output wire	[LEN_RX_CTRL-1 : 0] o_rx_raw_control,
 );


reg [4:0] state,state_next;
reg [LEN_RX_DATA-1 : 0] rx_raw_data, rx_raw_data_next;
reg [LEN_RX_CTRL-1 : 0] rx_raw_control, rx_raw_control_next;

assign o_rx_raw_data = rx_raw_data;
assign o_rx_raw_control = rx_raw_control;



//R_TYPE / R_TYPE_NEXT
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


/*

AGREGARR 

localparam [LEN_RX_DATA-1 : 0] LBLOCK_R_DATA = local fault orderer set en clausula 81.2.3
localparam [LEN_RX_CTRL-1 : 0] LBLOCK_R_CTRL
localparam [LEN_RX_DATA-1 : 0] EBLOCK_R_DATA
localparam [LEN_RX_CTRL-1 : 0] EBLOCK_R_CTRL

*/




always @ (posedge clock, posedge i_reset)
begin
	

	if(i_reset)
	begin	
		//rx_raw_data <= LBLOCK_R_DATA;  
		//rx_raw_control <= LBLOCK_R_CTRL;
		state_next <= RX_INIT;

	end
	else if(i_enable)
	begin

		rx_raw_data <= rx_raw_data_next;
		rx_raw_control <= rx_raw_control_next;
		state <= state_next;
		
	end

end

always @ *
begin

	state_next = state;
	rx_raw_control_next = {LEN_RX_CTRL{1'b0}};
	rx_raw_data_next = {LEN_RX_DATA{1'b0}};

	case(state)
		
		RX_INIT:
		begin
				if(i_r_type == TYPE_C)
				begin
					state_next = RX_C;
					rx_raw_data_next = i_rx_raw_data;
					rx_raw_control_next = i_rx_raw_control;
				end
				else if(i_r_type == TYPE_S)
				begin
					state_next = RX_D;
					rx_raw_data_next = i_rx_raw_data;
					rx_raw_control_next = i_rx_raw_control;
				end
				else if(i_r_type == TYPE_E || i_r_type == TYPE_D || i_r_type == TYPE_T)
				begin
					state_next = RX_E;
					rx_raw_data_next = EBLOCK_R_DATA;
					rx_raw_ctrl_next = EBLOCK_R_CTRL;
				end
		end

		RX_C:
		begin
				if(i_r_type == TYPE_C)
				begin
					state_next = RX_C;
					rx_raw_data_next = i_rx_raw_data;
					rx_raw_control_next = i_rx_raw_control;
				end
				else if(i_r_type == TYPE_S)
				begin
					state_next = RX_D;
					rx_raw_data_next = i_rx_raw_data;
					rx_raw_control_next = i_rx_raw_control;
				end
				else if(i_r_type == TYPE_E || i_r_type == TYPE_D || i_r_type == TYPE_T)
				begin
					state_next = RX_E;
					rx_raw_data_next = EBLOCK_R_DATA;
					rx_raw_ctrl_next = EBLOCK_R_CTRL;
				end
		end

		RX_D:
		begin
				if(i_r_type == TYPE_D)
				begin
					state_next = RX_D;
					rx_raw_data_next = i_rx_raw_data;
					rx_raw_control_next = i_rx_raw_control;
				end
				else if(i_r_type == TYPE_T && (i_r_type_next == TYPE_S ||  i_r_type_next == TYPE_C))
				begin
					state_next = RX_T;
					rx_raw_data_next = i_rx_raw_data;
					rx_raw_control_next = i_rx_raw_control;
				end
				else if((i_r_type == TYPE_T && (i_r_type_next == TYPE_E || i_r_type_next == TYPE_D || i_r_type_next == TYPE_T)) || (i_r_type == TYPE_E || i_r_type == TYPE_C || i_r_type == TYPE_S))
				begin
					state_next = RX_E;
					rx_raw_data_next = EBLOCK_R_DATA;
					rx_raw_ctrl_next = EBLOCK_R_CTRL;
				end	
		end

		RX_T:
		begin
				if(i_r_type == TYPE_C)
				begin
					state_next = RX_C;
					rx_raw_data_next = i_rx_raw_data;
					rx_raw_control_next = i_rx_raw_control;
				end
				else if(i_r_type == TYPE_S)
				begin
					state_next = RX_D;
					rx_raw_data_next = i_rx_raw_data;
					rx_raw_control_next = i_rx_raw_control;
				end
		end

		RX_E:
		begin
				if(i_r_type == TYPE_C)
				begin
					state_next = RX_C;
					rx_raw_data_next = i_rx_raw_data;
					rx_raw_control_next = i_rx_raw_control;
				end
				else if(i_r_type == TYPE_S)
				begin
					state_next = RX_D;
					rx_raw_data_next = i_rx_raw_data;
					rx_raw_control_next = i_rx_raw_control;
				end
				else if(i_r_type == TYPE_T && (i_r_type_next == TYPE_S || i_r_type_next == TYPE_C))
				begin
					state_next = RX_T;
					rx_raw_data_next = i_rx_raw_data;
					rx_raw_control_next = i_rx_raw_control;
				end
				else if((i_r_type == TYPE_T || (i_r_type_next == TYPE_E || i_r_type_next == TYPE_D || i_r_type_next == TYPE_T)) || (i_r_type == TYPE_E || i_r_type == TYPE_S))
				begin
					state_next = RX_E;
					rx_raw_data_next = EBLOCK_R_DATA;
					rx_raw_ctrl_next = EBLOCK_R_CTRL;
				end
		end
end