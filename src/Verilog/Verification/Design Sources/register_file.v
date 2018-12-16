module register_file
    #(
    parameter                           NB_GPIOS       = 32,
    parameter                           NB_OPCODE      = 9,
    parameter                           NB_DATA        = 22,
    parameter                           N_MODULES      = 3,
    parameter                           RAM_DEPTH      = 1024,
    parameter                           NB_ADDR_RAM    = $clog2(RAM_DEPTH),
    parameter                           LEN_DATA_BLOCK = 64,
    parameter                           LEN_CTRL_BLOCK = 8
    )
    (
    input wire                          i_clock, // connected in top
    input wire                          i_reset, // connected in top
    input wire  [NB_GPIOS-1 : 0]        i_gpio_in, // connected in top
    input wire  [LEN_DATA_BLOCK-1 : 0]  i_decoder_data,// connected in top
    input wire  [LEN_CTRL_BLOCK-1 : 0]  i_decoder_ctrl,// connected in top


    output reg  [NB_GPIOS-1 : 0]        o_gpio_out, // connected in top
    output reg  [NB_ADDR_RAM-1 : 0]     o_read_address, // connected in top
    output reg                          o_reset,
    output wire                         o_enable_read, // connected in top
    output wire                         o_enable_encoder,// connected in top
    output wire                         o_enable_scrambler,// connected in top
    output wire                         o_enable_descrambler,// connected in top
    output wire                         o_enable_decoder,// connected in top
    output wire                         o_enable_bram, // connected in top
    output wire                         o_invalid_opcode, // connected in top
    output reg [NB_OPCODE-1 : 0]        o_opcode 			// connected in top
    );

//OPCODES
localparam                              OP_ENABLE           = 9'd0;
localparam                              OP_READ_MEM_ENB     = 9'd1;
localparam                              OP_READ_ADDR        = 9'd2;
localparam                              OP_READ_DATA_LOW    = 9'd3;
localparam                              OP_READ_DATA_HIGH   = 9'd4;
localparam                              OP_READ_CTRL        = 9'd5;
localparam                              OP_RESET            = 9'd6;



//ENABLE POSITIONS
localparam                              ENCODER_ENB_BIT     = 0;
localparam                              SCRAMBLER_ENB_BIT   = 1;
localparam                              DESCRAMBLER_ENB_BIT = 2;
localparam                              DECODER_ENB_BIT     = 3;
localparam                              BRAM_ENB_BIT        = 4;

  
wire                                     enable          = i_gpio_in[NB_GPIOS-1];               //Enable del RF en bit mas significativo
wire            [NB_OPCODE-1 : 0]        opcode          = i_gpio_in[NB_GPIOS-2 -: NB_OPCODE];                       
wire            [NB_DATA-1 : 0]          data            = i_gpio_in[NB_DATA-1 : 0];

reg                                      enable_read;
reg             [N_MODULES-1 : 0]        enable_reg;
reg                                      invalid_opcode;

assign          o_enable_encoder                        = enable_reg[ENCODER_ENB_BIT];
assign          o_enable_scrambler                      = enable_reg[SCRAMBLER_ENB_BIT];
assign          o_enable_descrambler                    = enable_reg[DESCRAMBLER_ENB_BIT];
assign          o_enable_decoder                        = enable_reg[DECODER_ENB_BIT];
assign          o_enable_bram                           = enable_reg[BRAM_ENB_BIT];
assign          o_enable_read                           = enable_read;
assign          o_invalid_opcode                        = invalid_opcode;

always@(posedge i_clock)
begin
    if (i_reset) 
    begin
        enable_reg <= {N_MODULES{1'b0}};
        invalid_opcode <= 0;
        o_opcode <= 0;
        enable_read <= 0;
    end
    else 
    begin
        if (enable) 
            begin
            o_opcode <= opcode;
            case (opcode)      
                OP_ENABLE:
                begin
                    enable_reg <= i_gpio_in[0 +: N_MODULES];
                end
                OP_READ_MEM_ENB:
                begin
                    enable_read <= 1;
                end
                OP_READ_ADDR :
                begin
                    o_read_address <= data[0 +: NB_ADDR_RAM];
                end
                OP_READ_DATA_LOW :
                begin
                    o_gpio_out <= i_decoder_data[0 +: (LEN_DATA_BLOCK/2)];
                end
                OP_READ_DATA_HIGH :
                begin
                    o_gpio_out <= i_decoder_data[(LEN_DATA_BLOCK/2) +: (LEN_DATA_BLOCK/2)];
                end
                OP_READ_CTRL :
                begin
                    o_gpio_out <= {{24{1'b0}},i_decoder_ctrl};
                end
                OP_RESET:
                begin
                    o_reset <= data[0];
                end
                default:
                begin
                    enable_reg     <= enable_reg;
                    enable_read    <= enable_read;
                    o_read_address <= o_read_address;
                    o_gpio_out     <= o_gpio_out; 
                    invalid_opcode <= 1;
                end
            endcase
        end
    end
end

endmodule