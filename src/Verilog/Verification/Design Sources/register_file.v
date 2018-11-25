module register_file
    #(
    parameter                           GPIO_LEN        = 32,
    parameter                           OPCODE_LEN      = 9,
    parameter                           DATA_LEN        = 20,
    parameter                           N_MODULES       = 3
    )
    (
    input wire                          i_clock,
    input wire                          i_reset,
    input wire  [GPIO_LEN-1 : 0]        i_gpio_in,

    //output reg  [GPIO_LEN-1 : 0]        o_gpio_out,
    //output reg  [RAM_ADDR_NBIT-1 : 0]   o_read_address,
    //output wire                         o_read_enb,
    output wire                         o_enable_cgmii,
    output wire                         o_enable_encoder,
    output wire                         o_enable_bram
    );

localparam                              OP_ENABLE       = 9'h001;
localparam                              CGMII_ENB_BIT   = 0;
localparam                              ENCODER_ENB_BIT = 1;
localparam                              BRAM_ENB_BIT    = 2;
  
wire                                    enable          = i_gpio_in[GPIO_LEN-1];               //Enable del RF en bit mas significativo
wire            [OPCODE_LEN-1 : 0]      opcode          = i_gpio_in[GPIO_LEN-2 -: OPCODE_LEN];                       
wire            [DATA_LEN-1 : 0]        data            = i_gpio_in[DATA_LEN-1 : 0];

reg             [N_MODULES-1 : 0]       enable_reg;
//reg           [DATA_LEN-1 : 0]        data_reg  ;


assign          o_enable_cgmii                          = enable_reg[CGMII_ENB_BIT];
assign          o_enable_encoder                        = enable_reg[ENCODER_ENB_BIT];
assign          o_enable_bram                           = enable_reg[BRAM_ENB_BIT];

always@(posedge i_clock)
begin
    if (i_reset) begin
        //data_reg <= {DATA_LEN{1'b0}}; 
        enable_reg <= {N_MODULES{1'b0}};
    end
    else 
    begin
        if (enable) 
            begin
            case (opcode)
                OP_ENABLE:
                begin

                enable_reg <= i_gpio_in[0 +: N_MODULES];
                
                end
                                  
            endcase
        end
    end
end

endmodule