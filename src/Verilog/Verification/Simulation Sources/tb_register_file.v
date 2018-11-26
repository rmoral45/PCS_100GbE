module tb_register_file;

parameter                           GPIO_LEN        = 32;
parameter                           OPCODE_LEN      = 9;
parameter                           DATA_LEN        = 22;
parameter                           N_MODULES       = 3;
parameter                           RAM_ADDR_NBIT   = 5;

reg 					   tb_clock	;
reg 					   tb_reset	;					
reg	[GPIO_LEN-1 : 0]	   tb_gpio_in;	
reg [OPCODE_LEN-1 : 0]       counter;
wire [RAM_ADDR_NBIT-1 : 0]  tb_read_address;
wire                        tb_enable_read;
wire                        tb_enable_cgmii;
wire                        tb_enable_encoder;
wire                        tb_enable_bram;
reg [DATA_LEN-1 : 0]       tb_data_test;
/*reg  [RAM_ADDR_NBIT-1 : 0] tb_reg_read_address;
reg                        tb_reg_enable_read;
reg                        tb_reg_enable_cgmii;
reg                        tb_reg_enable_encoder;
reg                        tb_reg_enable_bram;

assign tb_read_address =tb_reg_read_address;
assign tb_enable_read = tb_reg_enable_read;
assign tb_enable_cgmii = tb_reg_enable_cgmii;
assign tb_enable_encoder = tb_reg_enable_encoder;
assign tb_enable_bram = tb_reg_enable_bram;*/

							

initial
begin
	tb_clock 	        = 1'b0;
	counter             = 1'b0; 
	tb_gpio_in          = {GPIO_LEN{1'b0}};
	tb_reset 	        = 1'b0;
	tb_reset 	        = 1'b1;
	tb_reset 	        = 1'b0;
#20   tb_gpio_in = 32'b10000000001111111111111111111111;
//#1000 tb_gpio_in = 32'b10000000100000000000000000000100;		
#100000     $finish;
end

register_file
    #(
    .GPIO_LEN(GPIO_LEN),
    .OPCODE_LEN(OPCODE_LEN),
    .DATA_LEN(DATA_LEN),
    .N_MODULES(N_MODULES),
    .RAM_ADDR_NBIT(RAM_ADDR_NBIT)
    )
u_register_file(
    .i_clock(tb_clock),
    .i_reset(tb_reset),
    .i_gpio_in(tb_gpio_in),
    .o_read_address(tb_read_address),
    .o_enable_read(tb_enable_read),
    .o_enable_cgmii(tb_enable_cgmii),
    .o_enable_encoder(tb_enable_encoder),
    .o_enable_bram(tb_enable_bram),
    .o_data_test()
    );
    
always #1 tb_clock = ~tb_clock;

endmodule