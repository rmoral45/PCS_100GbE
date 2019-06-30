`timescale 1ns/100ps


module tb_am_module_v2;

//Module params
localparam NB_CODED_BLOCK = 66;
localparam N_ALIGNER = 20;
localparam NB_LANE_ID = $clog2(N_ALIGNER);
localparam N_BLOCKS = 10;
localparam MAX_INV_AM = 8;
localparam NB_INV_AM  = $clog2(MAX_INV_AM);
localparam MAX_VAL_AM = 20;
localparam NB_VAL_AM = $clog2(MAX_VAL_AM);
localparam NB_ERROR_COUNTER = 64;

//Sim params
localparam SIM_BLOCKS = N_BLOCKS*10; //numero de bloques a simular
localparam [NB_CODED_BLOCK-1 : 0] SIM_AM = 66'h2_F5_07_09_00_0A_F8_F6_FF; //alineador lane 4

// tipos de test

localparam LOCK_STRAIGHT        = 0;
localparam LOCK_RESYNC          = 1;
localparam LOCK_NO_RESYNC       = 2;

//parametros de simulacion
localparam TEST_TYPE                    = LOCK_NO_RESYNC;
localparam MAX_CLOCK_RISING_CNT = 100000;
localparam NB_CLK_CNT                   = $clog2(MAX_CLOCK_RISING_CNT);

//LOCK_RESYNC
localparam AM_PHASE   = 3; //por ej si se deberia recibir am valido en tiempo t, en STAGE_1 y STAGE_2 
                                                  // se recibiran en t+AM_PHASE

localparam LR_STAGE_0_LL = 0; //inicio intervalo de tiempo en el que obtengo LOCKED
localparam LR_STAGE_0_HL = N_BLOCKS*MAX_VAL_AM;     //fin intervalo 

localparam LR_STAGE_1_LL = LR_STAGE_0_HL + AM_PHASE;  //inicio intervalo en que los am empiezan a llegar en disitntos momentos
localparam LR_STAGE_1_HL = LR_STAGE_1_LL + (N_BLOCKS*MAX_INV_AM*20);//fin intervalo

//LOCK_NO_RESYNC
localparam LNR_STAGE_0_LL = 150; //random
localparam LNR_STAGE_0_HL = LNR_STAGE_0_LL + (N_BLOCKS*MAX_VAL_AM*2);

localparam LNR_STAGE_1_LL = LNR_STAGE_0_HL;
localparam LNR_STAGE_1_HL = LNR_STAGE_1_LL + (N_BLOCKS*MAX_INV_AM);

localparam LNR_STAGE_2_LL = LNR_STAGE_1_HL;
localparam LNR_STAGE_2_HL = LNR_STAGE_1_HL + (N_BLOCKS*MAX_VAL_AM*3);

//Sim control regs
reg                     simulation_start;
reg [NB_CLK_CNT-1 : 0]  sim_clock_counter;

//Module I/O
reg tb_clock, tb_reset, tb_enable, tb_valid, tb_block_lock;
wire [NB_CODED_BLOCK-1 : 0]     tb_input_data;
reg [NB_CODED_BLOCK-1 : 0]      tb_input_vector [SIM_BLOCKS-1 : 0]; 
reg [NB_INV_AM-1 : 0]           tb_invalid_am_thr;
reg [NB_VAL_AM-1 : 0]           tb_valid_am_thr;


wire [NB_CODED_BLOCK-1 : 0]     tb_o_data;
wire [NB_LANE_ID-1 : 0]         tb_o_lane_id;
wire [NB_ERROR_COUNTER-1 : 0]   tb_o_error_counter;
wire tb_o_am_lock, tb_o_resync, tb_o_start_of_lane;


initial
begin
        //Module initial params/conditions
        tb_clock                = 0;
        tb_reset                = 1;
        tb_enable               = 0;
        tb_valid                = 0;
        tb_block_lock           = 0;
        tb_invalid_am_thr       = 3;
        tb_valid_am_thr         = 5;

        //Sim initial conditions
        
        #10
                tb_reset        = 0;
                tb_enable       = 1;
        #10
                tb_valid         = 1;
                simulation_start = 1;
        #20
                tb_block_lock = 1;
      
       
        
end

always #1 tb_clock = ~tb_clock;



/*
        Input block generation based on TEST_TYPE selected
*/
integer i;
generate //START_GENERATE

if (TEST_TYPE == LOCK_STRAIGHT)
begin : gen_AM_VALID_LOCK_STRAIGHT

    reg [NB_CODED_BLOCK-1 : 0] tb_gen_blocks [MAX_CLOCK_RISING_CNT-1 : 0];
    always @ (posedge tb_clock)
    begin
        for( i = 0; i < MAX_CLOCK_RISING_CNT; i = i+1)
        begin
                if ((i % N_BLOCKS) == 0)
                        tb_gen_blocks[i] = SIM_AM;
                else
                        tb_gen_blocks[i] = {2'b01,$random,$random};
                
        end
    end
    assign tb_input_data = tb_gen_blocks[sim_clock_counter];

end//end_gen_AM_VALID_LOCK_STRAIGHT

else if (TEST_TYPE == LOCK_RESYNC)
begin : gen_AM_VALID_LOCK_RESYNC
    
    reg [NB_CODED_BLOCK-1 : 0] tb_gen_blocks [MAX_CLOCK_RISING_CNT-1 : 0];
    always @ (posedge tb_clock)
    begin

        for( i = LR_STAGE_0_LL; i < LR_STAGE_0_HL; i = i+1)
        begin
                if ((i % N_BLOCKS) == 0)
                        tb_gen_blocks[i] = SIM_AM;
                else
                        tb_gen_blocks[i] = {2'b01,$random,$random};

        end

        for( i = LR_STAGE_1_LL; i < LR_STAGE_1_HL; i = i+1)
        begin
                if ((i % N_BLOCKS) == AM_PHASE)
                        tb_gen_blocks[i] = SIM_AM;
                else
                        tb_gen_blocks[i] = {2'b01,$random,$random};
        end
    end
    assign tb_input_data = tb_gen_blocks[sim_clock_counter];

end//end_gen_AM_VALID_LOCK_RESYNC

else if (TEST_TYPE == LOCK_NO_RESYNC)
begin : gen_AM_VALID_LOCK_NO_RESYNC
    
    reg [NB_CODED_BLOCK-1 : 0] tb_gen_blocks [MAX_CLOCK_RISING_CNT-1 : 0];
    always @ (posedge tb_clock)
    begin
        
        for( i = 0; i < LNR_STAGE_0_LL; i = i+1)
        begin
                        tb_gen_blocks[i] = {2'b01,$random,$random};
        end


        for( i = LNR_STAGE_0_LL; i < LNR_STAGE_0_HL; i = i+1)
        begin
                if ((i % N_BLOCKS) == 0)
                        tb_gen_blocks[i] = SIM_AM;
                else
                        tb_gen_blocks[i] = {2'b01,$random,$random};
        end

        for( i = LNR_STAGE_1_LL; i < LNR_STAGE_1_HL; i = i+1)
        begin
                tb_gen_blocks[i] = {2'b01,$random,$random};
        end


        for( i = LNR_STAGE_2_LL; i < LNR_STAGE_2_HL; i = i+1)
        begin
                if ((i % N_BLOCKS) == 0)
                        tb_gen_blocks[i] = SIM_AM; 
                else
                        tb_gen_blocks[i] = {2'b01,$random,$random};

        end

    end
    assign tb_input_data = tb_gen_blocks[sim_clock_counter];

end//end_gen_AM_VALID_LOCK_NO_RESYNC

else
begin : gen_TEST_TYPE_UNDEFINED

    reg [NB_CODED_BLOCK-1 : 0] tb_gen_blocks [MAX_CLOCK_RISING_CNT-1 : 0];
    always @ (posedge tb_clock)
    begin
        for (i = 0; i < MAX_CLOCK_RISING_CNT; i= i+1)
                tb_gen_blocks[i] = {NB_CODED_BLOCK{1'b0}}; 
    end 
    assign tb_input_data = tb_gen_blocks[sim_clock_counter];

end // end_gen_TEST_TYPE_UNDEFINED

endgenerate //END_GENERATE


always @( posedge tb_clock )
begin
    if (tb_reset)
        sim_clock_counter <= 0 ; 
    else if ( simulation_start )
        sim_clock_counter <= sim_clock_counter + 1'b1;
end

                

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
                .i_data                 (tb_input_data),
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
