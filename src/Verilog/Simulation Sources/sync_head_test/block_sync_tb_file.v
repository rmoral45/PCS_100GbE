`timescale 1ns/100ps


module block_sync_tb_file;

localparam NB_CODED_BLOCK    = 66;
localparam MAX_INDEX_VALUE   = (NB_CODED_BLOCK - 2);
localparam MAX_WINDOW        = 4096;
localparam MAX_INVALID_SH    = (MAX_WINDOW/2);
localparam NB_WINDOW_CNT     = $clog2(MAX_WINDOW);
localparam NB_INVALID_CNT    = $clog2(MAX_INVALID_SH);
localparam NB_INDEX          = $clog2(NB_CODED_BLOCK);

// inputs control signals to tested module
reg tb_i_clock;
reg tb_i_reset;
reg tb_i_valid;
reg tb_i_signal_ok;

//outputs from tested module
wire 						tb_o_block_lock;
wire [NB_CODED_BLOCK-1 : 0] tb_o_data;
wire [NB_INDEX-1 : 0]		tb_search_index;
wire [NB_INDEX-1 : 0]		tb_block_index;



reg tb_enable_files;

reg  [NB_CODED_BLOCK-1 : 0] input_data;
reg  [0 : NB_CODED_BLOCK-1] temp_data;
wire [NB_CODED_BLOCK-1 : 0] output_data;


integer fid_input_data;
integer fid_output_data;
integer fid_output_lock;
integer fid_output_search_index;
integer fid_output_block_index;

integer code_error_data;

integer ptr_data;

initial
begin
	/*
		AGREGAR NOMBRE DE ARCHIVOS EN EL PATH
	*/

	fid_input_data = $fopen("/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/block_sync_tb_files/block-sync-input.txt","r");
	if(fid_input_data == 0)
	begin
		$display("\n\n NO SE PUDO ABRIR ARCHIVO DE INPUT DATA");
		$stop;
	end

	fid_output_data = $fopen("/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/block_sync_tb_files/block-sync-output-verilog.txt","w");
	if (fid_output_data == 0)
	begin
		$display("\n\n NO SE PUDO ABRIR ARCHIVO PARA OUTPUT DATA");
		$stop;
	end

	fid_output_lock =$fopen("/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/block_sync_tb_files/block-lock-flag.txt","w");
	if (fid_output_lock == 0)
	begin
		$display("\n\n NO SE PUDO ABRIR ARCHIVO PARA BLOCK LOCK");
		$stop;
	end
	/*fid_output_search_index =$fopen("/home/diego/fundacion/PPS/src/Python/run/block_sync_tb_files/","w");
	if (fid_output_search_index == 0)
	begin
		$display("\n\n NO SE PUDO ABRIR ARCHIVO PARA SEARCH INDEX");
		$stop;
	end
	fid_output_block_index = $fopen("/home/diego/fundacion/PPS/src/Python/run/block_sync_tb_files/","w");
	if (fid_output_block_index == 0)
	begin
		$display("\n\n NO SE PUDO ABRIR ARCHIVO PARA BLOCK INDEX");
		$stop;
	end*/

	tb_i_clock 		= 0;
	tb_i_reset 		= 1;
	tb_i_signal_ok 	= 0;
	tb_i_valid 		= 0;
	input_data 		= 66'd0;

	#3 tb_enable_files = 1;

	#2 	tb_i_reset = 0;
		tb_i_signal_ok = 1;
		tb_i_valid = 1;
end

always #1 tb_i_clock= ~tb_i_clock;



always @ (posedge tb_i_clock)
begin
	if(tb_enable_files)
	begin

		//LECTURA DE ARCHIVO
		for(ptr_data=0; ptr_data < NB_CODED_BLOCK; ptr_data=ptr_data+1)
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
		/*
			AGREGAR LA ESCRITURA DE LOS ARCHIVOS QUE FALTAN
		*/
		$fwrite(fid_output_data, "%b\n", tb_o_data);                      
        $fwrite(fid_output_lock, "%b\n", tb_o_block_lock);
		

		input_data <= temp_data;

	end

end
 
 block_sync_module#()
 u_block_sync_module(
    .i_clock(tb_i_clock),
    .i_reset(tb_i_reset),
    .i_data(input_data),
    .i_valid(tb_i_valid),
    .i_signal_ok(tb_i_signal_ok),
    .o_data(tb_o_data),
    .o_block_lock(tb_o_block_lock),
    .o_dbg_search_index(tb_search_index),
    .o_dbg_block_index(tb_block_index)
    );


endmodule