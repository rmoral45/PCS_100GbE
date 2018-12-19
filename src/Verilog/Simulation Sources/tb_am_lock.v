`timescale 1ns/100ps



module tb_am_lock;

localparam NB_BLOCK   = 66;
localparam N_BLOCKS   = 10;
localparam N_ALIGNER  = 20;
localparam NB_LANE_ID = $clog2(N_ALIGNER);

reg clock,reset,enable,valid,block_lock;
reg tb_enable_files;
reg [4:0] max_inv_am;

reg [NB_BLOCK-1 : 0] input_data;
reg [0 : NB_BLOCK-1] temp_data;

wire [NB_BLOCK-1 : 0] output_data;
wire [NB_LANE_ID-1 : 0] output_lane_id;
wire flag_am_lock, flag_resync, flag_sol;


integer fid_input_data;
integer fid_output_data;
integer fid_output_lock;

integer code_error_data;

integer ptr_data;


initial
begin

	fid_input_data = $fopen("/home/diego/fundacion/PPS/src/Python/am_lock_tb_files/am-lock-input-file.txt","r");
	if(fid_input_data == 0)
	begin
		$display("\n\n NO SE PUDO ABRIR ARCHIVO DE INPUT DATA");
		$stop;
	end
	fid_output_data = $fopen("/home/diego/fundacion/PPS/src/Python/am_lock_tb_files/am-lock-output-file.txt","w");
	if(fid_output_data==0)
	begin
		$display("\n\n La salida de datos no pudo ser abierta");
		$stop;
	end
	fid_output_lock =$fopen("/home/diego/fundacion/PPS/src/Python/am_lock_tb_files/am-lock-flag-file.txt","w");
	if(fid_output_lock==0)
	begin
		$display("\n\n La salida de control no pudo ser abierta");
		$stop;
	end


	clock = 0;
	reset = 1;
	enable = 0;
	valid = 0;
	block_lock = 0;
	input_data = 66'd0;
	max_inv_am = 4;
	#3 tb_enable_files = 1;
	#2 	reset = 0;
		enable = 1;
		valid = 1;
		block_lock = 1;
end

always #1 clock= ~clock;


always @ (posedge clock)
begin
	if(tb_enable_files)
	begin

		//LECTURA DE ARCHIVO
		for(ptr_data=0; ptr_data < NB_BLOCK; ptr_data=ptr_data+1)
		begin
			code_error_data <= $fscanf(fid_input_data, "%b\n", temp_data[ptr_data]);
			if(code_error_data != 1)
			begin
				$display("Tx-Data: El caracter leido no es valido..");
               	$stop;
			end
		end
		//FIN LECTURA ARCHIVO


		//ESCRITURA
		$fwrite(fid_output_data, "%b\n", output_data);                      
        $fwrite(fid_output_lock, "%b\n", flag_am_lock);
		

		input_data <= temp_data;

	end

end





am_lock_module
#( 
	.LEN_CODED_BLOCK(NB_BLOCK),
	.N_BLOCKS(N_BLOCKS)
 )
	u_am_lock
	(
		.i_clock(clock),
		.i_reset(reset),
		.i_enable(enable),
		.i_valid(valid),
		.i_block_lock(block_lock),
		.i_data(input_data),

		.o_data(output_data),
		.o_lane_id(output_lane_id),
		.o_am_lock(flag_am_lock),
		.o_resync(flag_resync),
		.o_start_of_lane(flag_sol)
	);



endmodule