`timescale 1ns/100ps



module tb_idle_insert_file;

localparam NB_DATA  = 64;
localparam NB_CTRL  = 8;
localparam N_LANES  = 20;
localparam N_BLOCKS = 100;

reg clock, reset, enable, in_valid; //control inputs
reg tb_enable_files;

reg [NB_DATA-1 : 0] tb_input_data;
reg [NB_CTRL-1 : 0] tb_input_ctrl;
reg [0 : NB_DATA-1] temp_in_data ;
reg [0 : NB_CTRL-1] temp_in_ctrl ;

wire [NB_DATA-1 : 0] tb_output_data,tb_insert_data ;
wire [NB_CTRL-1 : 0] tb_output_ctrl,tb_insert_ctrl ;

wire am_flag,out_valid,out_am_flag;


integer fid_input_data;
integer fid_input_ctrl;

integer fid_output_data;
integer fid_output_ctrl;
integer fid_output_flag;

integer code_error_data;
integer code_error_ctrl;

integer ptr_data;
integer ptr_ctrl;


initial
begin

	fid_input_data = $fopen("/home/dj/fundacion/PPS/src/Python/file_generator/idle-deletion-input-data.txt","r");
	if(fid_input_data==0)
	begin
		$display("\n\n La entrada de datos no pudo ser abierta");
		$stop;
	end

	fid_input_ctrl = $fopen("/home/dj/fundacion/PPS/src/Python/file_generator/idle-deletion-input-ctrl.txt","r");
	if(fid_input_ctrl==0)
	begin
		$display("\n\n La entrada de control no pudo ser abierta");
		$stop;
	end

	fid_output_data = $fopen("/home/dj/fundacion/PPS/src/Python/file_generator/verilog-output-data.txt","w");
	if(fid_output_data==0)
	begin
		$display("\n\n La salida de datos no pudo ser abierta");
		$stop;
	end

	fid_output_ctrl = $fopen("/home/dj/fundacion/PPS/src/Python/file_generator/verilog-output-ctrl.txt","w");
	if(fid_output_ctrl==0)
	begin
		$display("\n\n La salida de control no pudo ser abierta");
		$stop;
	end
	fid_output_flag = $fopen("/home/dj/fundacion/PPS/src/Python/file_generator/verilog-output-flag.txt","w");
	if(fid_output_flag==0)
	begin
		$display("\n\n La salida de control no pudo ser abierta");
		$stop;
	end

	clock    		= 0;
	reset    		= 1;
	enable   		= 0;
	in_valid 		= 0;
	tb_enable_files = 0;
    #3 tb_enable_files = 1;
	#2 	reset  			= 0;
		enable 			= 1;
		in_valid 		= 1;
		tb_enable_files = 1;

end

always #1 clock = ~clock;


always @(posedge clock)
begin
	if(tb_enable_files)
	begin

		//LECTURA DE ARCHIVO
		for(ptr_data=0; ptr_data < NB_DATA; ptr_data=ptr_data+1)
		begin
			code_error_data <= $fscanf(fid_input_data, "%b\n", temp_in_data[ptr_data]);
			if(code_error_data != 1)
			begin
				$display("Tx-Data: El caracter leido no es valido..");
               	$stop;
			end
		end
		for(ptr_ctrl=0; ptr_ctrl < NB_CTRL; ptr_ctrl=ptr_ctrl+1)
		begin
			code_error_ctrl <= $fscanf(fid_input_ctrl, "%b\n", temp_in_ctrl[ptr_ctrl]);
			if(code_error_ctrl != 1)
			begin
				$display("Tx-Ctrl: El caracter leido no es valido..");
               	$stop;
			end
		end
		//FIN LECTURA ARCHIVO


		//ESCRITURA
		$fwrite(fid_output_data, "%b\n", tb_output_data);                      
        $fwrite(fid_output_ctrl, "%b\n", tb_output_ctrl);
        $fwrite(fid_output_flag, "%b\n", am_flag);
		

		tb_input_data <= temp_in_data;
		tb_input_ctrl <= temp_in_ctrl;

	end
end


idle_insertion_top
#(
	.LEN_TX_DATA(NB_DATA),
	.LEN_TX_CTRL(NB_CTRL),
	.N_IDLE(N_LANES),
	.N_BLOCKS(N_BLOCKS),
	.N_LANES(N_LANES)
 )
	u_idle_insertion_top
	(
		.i_clock 	(clock),
		.i_reset 	(reset),
		.i_enable 	(enable),
		.i_valid 	(in_valid),
		.i_tx_data	(tb_input_data),
		.i_tx_ctrl	(tb_input_ctrl),

		.o_tx_data	(tb_insert_data),
		.o_tx_ctrl	(tb_insert_ctrl),
		.o_am_flag	(am_flag),
		.o_valid 	(out_valid)
	);


encoder_interface
#(
	.LEN_TX_DATA(NB_DATA),
	.LEN_TX_CTRL(NB_CTRL)
 )
	u_encoder_interface
	(
		.i_valid 	(out_valid),
		.i_am_flag	(am_flag),
		.i_tx_data	(tb_insert_data),
		.i_tx_ctrl	(tb_insert_ctrl),

		.o_am_flag	(out_am_flag),
		.o_tx_data	(tb_output_data),
		.o_tx_ctrl	(tb_output_ctrl)
	);


endmodule