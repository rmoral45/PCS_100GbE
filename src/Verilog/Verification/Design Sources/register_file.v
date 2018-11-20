module register_file
    #(
        parameter                           GPIO_LEN            = 32,
        parameter                           OPCODE_LEN          = 16,
        parameter                           DATA_LEN            = 15,
        parameter                           LEN_CODED_BLOCK     = 66,
        parameter                           LEN_TX_DATA         = 64,
        parameter                           LEN_TX_CTRL         = 8,
        parameter                           RAM_WIDTH_ENCODER   = 66,
        parameter                           RAM_WIDTH_TYPE      = 4,
        parameter                           RAM_ADDR_NBIT       = 5
    )
    (
        input wire                          i_clock,
        input wire                          i_reset,
        input wire  [GPIO_LEN-1 : 0]        i_gpio_in,


        //output reg  [GPIO_LEN-1 : 0]        o_gpio_out,

        output reg  [RAM_ADDR_NBIT-1 : 0]   o_read_address,
        output wire                         o_enable_encoder,
        output wire                         o_enable_bram_encoder,
        output wire                         o_enable_bram_type
    );


    //--------------------------------------------------------------------------------LOCALPARAMS
    localparam                  ENABLE_ENCODER  = 16'h0001;
    
    //--------------------------------------------------------------------------------SIGNALS
    wire                        enable          = i_gpio_in[GPIO_LEN-1]              ;               //Enable en bit mas significativo
    wire    [OPCODE_LEN-1 : 0]  opcode          = i_gpio_in[GPIO_LEN-2 -: OPCODE_LEN];                       
    wire    [DATA_LEN-1 : 0]    data            = i_gpio_in[DATA_LEN-1 : 0]          ;
    
    //--------------------------------------------------------------------------------REGISTERS
    //reg     [DATA_LEN-1 : 0]    data_reg  ;      

    reg     [LEN_TX_DATA-1 : 0] tx_data            ;                  
    reg     [LEN_TX_CTRL-1 : 0] tx_ctrl            ;

    always@(posedge i_clock)
    begin
        if (i_reset) begin

            //data_reg <= {DATA_LEN{1'b0}};
            tx_data  <= {LEN_TX_DATA{1'b0}};
            tx_ctrl  <= {LEN_TX_CTRL{1'b0}};

        end
        else 
        begin
            if (enable) 
            begin
                case (opcode)

                    ENABLE_ENCODER:
                    begin
                        tx_ctrl                 = 64'hFEFEFEFEFEFEFEFE;
                        tx_data                 = 8'hFE;
                        o_enable_encoder        = 1'b1;
                        o_enable_bram_type      = 1'b1;
                        o_enable_bram_encoder   = 1'b1;
                    end
                                  
                endcase
            end
        end
    end

endmodule