`timescale 1ns/100ps


module tb_am_module;

localparam NB_CODED_BLOCK = 66;
localparam N_ALIGNER = 20;
localparam NB_LANE_ID = $clog2(N_ALIGNER);
localparam N_BLOCKS = 10;
localparam MAX_INV_AM = 8;
localparam NB_INV_AM  = $clog2(MAX_INV_AM);
localparam MAX_VAL_AM = 20;
localparam NB_VAL_AM = $clog2(MAX_VAL_AM);
localparam SIM_BLOCKS = N_BLOCKS*10;
localparam NB_ERROR_COUNTER = 64;
localparam [NB_CODED_BLOCK-1 : 0] SIM_AM = 66'h2_F5_07_09_00_0A_F8_F6_FF; //alineador lane 4



reg tb_clock, tb_reset, tb_enable, tb_valid, tb_block_lock;

reg [63 : 0] tb_clock_counter;

reg [NB_CODED_BLOCK-1 : 0]      tb_i_data;
reg [NB_CODED_BLOCK-1 : 0]      tb_input_vector [SIM_BLOCKS-1 : 0]; 
reg [NB_INV_AM-1 : 0]           tb_invalid_am_thr;
reg [NB_VAL_AM-1 : 0]           tb_valid_am_thr;
reg                             tb_am_insert;

wire [NB_CODED_BLOCK-1 : 0]     tb_o_data;
wire [NB_CODED_BLOCK-1 : 0]     tb_TX_data;
wire [NB_LANE_ID-1 : 0]         tb_o_lane_id;
wire [NB_ERROR_COUNTER-1 : 0]   tb_o_error_counter;
wire tb_o_am_lock, tb_o_resync, tb_o_start_of_lane;


initial
begin
        tb_clock                = 0;
        tb_reset                = 1;
        tb_enable               = 0;
        tb_valid                = 0;
        tb_block_lock           = 0;
        tb_i_data               = 66'd0;
        tb_invalid_am_thr       = 3;
        tb_valid_am_thr         = 5;

        tb_clock_counter = {64{1'b0}};
        
        #10
                tb_reset        = 0;
                tb_enable       = 1;
                tb_valid        = 1;
                tb_block_lock   = 1;
      
       
        
end

always #1 tb_clock = ~tb_clock;
/*
        Modificar este always para generar la flag de am insert y datos de entrada random
*/
always @ (posedge tb_clock)
begin
        tb_clock_counter <= tb_clock_counter + 1'b1;
        tb_i_data <= {2'b01,$random,$random};

                
        if ((tb_clock_counter%N_BLOCKS) == 0 && (tb_clock_counter < N_BLOCKS*10))
                tb_am_insert <= 1;
        else
                tb_am_insert <= 0;
                
end

am_insertion
#(
        .NB_CODED_BLOCK(NB_CODED_BLOCK),
        .AM_ENCODING_LOW(), //Seleccionar algun alineador
        .AM_ENCODING_HIGH() //idem
 )
u_am_insert
        (
                .i_clock                (tb_clock),
                .i_reset                (tb_reset),
                .i_enable               (tb_enable),
                .i_am_insert            (tb_am_insert), 
                .i_data                 (tb_i_data),
                .o_data                 (tb_TX_data)
        );

am_lock_module
#(
        .NB_CODED_BLOCK(NB_CODED_BLOCK),
        .N_ALIGNER(N_ALIGNER),
        .N_BLOCKS(N_BLOCKS),
        .MAX_INV_AM(MAX_INV_AM),
        .MAX_VAL_AM(MAX_VAL_AM)
 )
 u_am_mod
        (
                .i_clock                (tb_clock),
                .i_reset                (tb_reset),
                .i_enable               (tb_enable),
                .i_valid                (tb_valid),
                .i_block_lock           (tb_block_lock),
                .i_data                 (tb_TX_data),
                .i_invalid_am_thr       (tb_invalid_am_thr),
                .i_valid_am_thr         (tb_valid_am_thr),

                .o_data                 (tb_o_data),
                .o_lane_id              (tb_o_lane_id),
                .o_error_counter        (tb_o_error_counter),
                .o_am_lock              (tb_o_am_lock),
                .o_resync               (tb_o_resync),
                .o_start_of_lane        (tb_o_start_of_lane)
        );


endmodule
