`timescale 1ns/100ps

/*
 * Los datos de entrada vienen con el siguiente formato : {OP_CODE, ENABLE_BIT, PAYLOAD}
 * OP_CODE : 
 *
 *
 * Sequencia de escritura hacia rf  : OP -> WRDATALOW -> WRDATAMID -> WRDATAHIGH -> REQDONE
 * Sequencia de lectura hacia rf    : RDDATALOW -> RDDATAMID -> RDDATAHIGH 
 */


module rf_interface
#(
        parameter   NB_GPIO       = 32,
        parameter   NB_RF_DATA    = ,//FIXME
        parameter   NB_RF_OPCODE  = 10,
 )
 (
        input wire                       i_clock,
        input wire                       i_reset,
        input wire  [NB_GPIO-1 : 0]      i_micro_data,
        input wire  [NB_RF_DATA-1 : 0]   i_rf_data,

        output wire [NB_GPIO-1 : 0]      o_micro_data,
        output wire [NB_RF_DATA-1 : 0]   o_rf_data,
        output wire                      o_rf_enable
 );


/*----------------- Local Parameters ------------------*/

localparam NB_MICRO_OPCODE  = 5;
localparam NB_ENB           = 1;
localparam NB_PAYLOAD       = NB_GPIO - NB_ENB - NB_MICRO_OPCODE;

localparam [NB_MICRO_OPCODE-1 : 0] IF_OPCODE_OPREQ   = 1;
localparam [NB_MICRO_OPCODE-1 : 0] IF_OPCODE_WRLOW   = 2;
localparam [NB_MICRO_OPCODE-1 : 0] IF_OPCODE_WRMID   = 3;
localparam [NB_MICRO_OPCODE-1 : 0] IF_OPCODE_WRHIG   = 4;
localparam [NB_MICRO_OPCODE-1 : 0] IF_OPCODE_RDLOW   = 5;
localparam [NB_MICRO_OPCODE-1 : 0] IF_OPCODE_RDMID   = 6;
localparam [NB_MICRO_OPCODE-1 : 0] IF_OPCODE_RDHIG   = 7;
localparam [NB_MICRO_OPCODE-1 : 0] IF_OPCODE_REQDONE = 8;

/*---------------- Internal Signals -------------------*/

wire [NB_MICRO_OPCODE-1 : 0]    micro_opcode;
wire [NB_PAYLOAD-1 : 0]         micro_payload;
wire                            micro_enable;
wire                            rf_enable;

reg [NB_RF_OPCODE-1 : 0]        rf_opcode;
reg [NB_RF_DATA-1 : 0]          rf_write_data;
reg [NB_GPIO-1 : 0]             rf_read_data;
reg                             rf_update_signal;
reg                             rf_update_signal_delay;

/*--------------- Algorithm Begin  --------------------*/

assign micro_opcode  = i_data[NB_GPIO-1 -: NB_MICRO_OPCODE];
assign micro_enable  = i_data[NB_GPIO-1-NB_MICRO_OPCODE];
assign micro_payload = i_data[0 +: NB_PAYLOAD];

/*-------- Write Logic --------*/

//update if-to-rf-opcode
always @ (posedge i_clock)
begin
        if (i_reset)
                rf_opcode <= {NB_RF_OPCODE{1'b0}};

        else if (micro_enable && (micro_opcode == IF_OPCODE_OPREQ))
                rf_opcode <= micro_payload;
end

//update if-to-rf-data
always @ (posedge i_clock)
begin
        if (i_reset)
                rf_write_data <= {NB_RF_DATA{1'b0}};

        else if (micro_enable && (micro_opcode == IF_OPCODE_WRLOW))
                rf_write_data[0 +: NB_PAYLOAD] <= micro_payload;

        else if (micro_enable && (micro_opcode == IF_OPCODE_WRMID))
                rf_write_data[NB_PAYLOAD +: NB_PAYLOAD] <= micro_payload;

        else if (micro_enable && (micro_opcode == IF_OPCODE_WRHIG))
                rf_write_data[NB_PAYLOAD*2 +: NB_PAYLOAD] <= micro_payload;
end

//senal de fin de request pulse for rf
always @ (posedge i_clock)
begin
        if (i_reset)
                rf_update_signal <= 0;

        else if (micro_enable && (micro_opcode == IF_OPCODE_REQDONE))
                rf_update_signal <= 1;
        else
                rf_update_signal <= 0;
end

// detector de flanco
always @ (posedge i_clock)
begin
        if (i_reset)
                rf_update_signal_delay <= 0;
        else
                rf_update_signal_delay <= rf_update_signal;

end
assign rf_enable = (rf_signal_delay == 1'b0 && rf_update_signal == 1'b1) ? 1'b1 : 1'b0;



/*-------- Read Logic --------*/

always @ (posedge i_clock)
begin
        if (i_reset)
                rf_read_data <= {NB_GPIO{1'b0}};

        else if (micro_enable && (micro_opcode == IF_OPCODE_RDLOW))
                rf_read_data <= i_rf_data[0 +: NB_GPIO];

        else if (micro_enable && (micro_opcode == IF_OPCODE_RDMID))
                rf_read_data <= i_rf_data[NB_GPIO +: NB_GPIO];

        else if (micro_enable && (micro_opcode == IF_OPCODE_RDHIG))
                /* La lectura la hago de a multiplos de 32,a diferencia de la escritura que es multiplos de 26
                   por lo tanto al leer la parte mas significativa debo rellevar con 0's*/
                rf_read_data <= {{(NB_RF_DATA - NB_GPIO*2){1'b0}} ,i_rf_data[NB_GPIO*2 +: NB_RF_DATA]}; 
end

endmodule
