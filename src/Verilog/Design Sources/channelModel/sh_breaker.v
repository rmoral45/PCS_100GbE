`timescale  1ns/100ps


module sh_breaker
#(
        parameter NB_CODED_BLOCK = 66,
        parameter NB_ERR_MASK    = NB_CODED_BLOCK-2,    //mascara, se romperan los bits cuya posicon en la mascara sea 1
        parameter MAX_ERR_BURST  = 1024,                //cantidad de bloques consecutivos que se romperan
        parameter MAX_ERR_PERIOD = 1024,                //cantidad de bloqus por periodo de error ver NOTAS.
        parameter MAX_ERR_REPEAT = 10,                  //cantidad de veces que se repite el mismo patron de error
        parameter NB_BURST_CNT   = $clog2(MAX_ERR_BURST),
        parameter NB_PERIOD_CNT  = $clog2(MAX_ERR_PERIOD),
        parameter NB_REPEAT_CNT  = $clog2(MAX_ERR_REPEAT),
        parameter N_MODES        = 4 //USO ONE HOT ENCODING
 )
 (
        input  wire                             i_clock,
        input  wire                             i_reset,
        input  wire                             i_valid,
        input  wire [NB_CODED_BLOCK-1 : 0]      i_data,
        input  wire                             i_aligner_tag,
        input  wire [N_MODES-1 : 0]             i_rf_mode,
        input  wire                             i_rf_update,         //trigger para actualizar los valores de generacion de error
        input  wire [NB_BURST_CNT-1 : 0]        i_rf_error_burst,    // selecciona cuantos bloques consecutivos romper por periodo
        input  wire [NB_PERIOD_CNT-1 : 0]       i_rf_error_period,   // periodo
        input  wire [NB_REPEAT_CNT-1 : 0]       i_rf_error_repeat,   // cantidad de periodos con el mismo patron de error

        output reg  [NB_CODED_BLOCK-1 : 0]      o_data,
        output reg                              o_aligner_tag

 );

//------------------------Localparams----------------------------------//

localparam NB_SH        = 2;
localparam DATA_SH      = 2'b01;
localparam CTRL_SH      = 2'b10;
localparam NB_PAYLOAD   = NB_CODED_BLOCK - NB_SH;
localparam MODE_ALIN    = 4'b0001; //[CHECK]ni deberiamos usarlo aca,en caso de querer hacerlo hacer pasar el alinger tag desde el modulo anterior
localparam MODE_CTRL    = 4'b0010;
localparam MODE_DATA    = 4'b0100;
localparam MODE_ALL     = 4'b1000;


//------------------------Internal signals-----------------------------//

//Error control counters
reg [NB_BURST_CNT-1 : 0]        burst_counter;
reg [NB_PERIOD_CNT-1 : 0]       period_counter;
reg [NB_REPEAT_CNT-1 : 0]       repeat_counter;
reg [N_MODES-1 : 0]             mode;

//Error counters conditions
wire                            burst_on;
wire                            period_on;
wire                            repeat_on;

//sh break
wire [NB_SH-1 : 0]              sh;
wire [NB_PAYLOAD-1 : 0]         payload;
wire [NB_SH-1 : 0]              err_sh;
wire                            sh_type_ctrl;
wire                            sh_type_data;

//PRBS
wire                            static_prbs_enable;
wire                            static_prbs_valid;
wire                            out_prbs;

//-------------------------Algorithm begin-------------------------------//

assign sh               = i_data [NB_CODED_BLOCK-1 -: NB_SH];
assign payload          = i_data [NB_PAYLOAD-1 : 0];
assign sh_type_data     = (sh == DATA_SH) ? 1'b1 : 1'b0;
assign sh_type_ctrl     = (sh == CTRL_SH) ? 1'b1 : 1'b0;

//genero alguno de los dos sh invalidos dependiendo de la salida de la prbs,
// de esta forma se rompen de una forma aleatoria.
assign err_sh           = (out_prbs == 1'b1) ? 2'b11 : 2'b00;

//Output selection
always @ *
begin
        o_aligner_tag   = i_aligner_tag;
        o_data          = i_data;

        case(mode)
        MODE_ALIN:
                if (burst_on && i_aligner_tag)
                        o_data = {err_sh, payload};
        MODE_CTRL:
                if (burst_on && sh_type_ctrl)
                        o_data = {err_sh, payload};
        MODE_DATA :
                if (burst_on && sh_type_data)
                        o_data = {err_sh, payload};
        MODE_ALL :
                if (burst_on)
                        o_data = {err_sh, payload};
        default  :
                o_data = i_data;
        endcase
end

//Control update

always @ (posedge i_clock)
begin
        if (i_reset)
                mode <= MODE_ALL;
        else if (i_rf_update)
                mode <= i_rf_mode;
end

//Burst error counter
always @ (posedge i_clock)
begin
        if (i_reset)
                burst_counter <= {NB_BURST_CNT{1'b0}};
        else if (i_rf_update)
                burst_counter <= i_rf_error_burst;
        else if (repeat_on && !period_on) //si termino el periodo y debo repetir vuelvo a setear el valor
                burst_counter <= i_rf_error_burst;
        else if (i_valid && burst_on)
                burst_counter <= burst_counter - 1'b1;
                        
end
assign burst_on = (burst_counter > {NB_BURST_CNT{1'b0}}) = 1'b1 : 1'b0;

//Period counter
always @ (posedge i_clock)
begin
        if (i_reset)
                period_counter <= {NB_PERIOD_CNT{1'b0}};     
        else if (i_rf_update)
                period_counter <= i_rf_error_period;
        else if (repeat_on && !period_on)
                period_counter <= i_rf_error_period
        else if (i_valid && period_on)
                period_counter <= period_counter - 1'b1;
end
assign period_on = (period_counter > {NB_PERIOD_CNT{1'b0}}) ? 1'b1 : 1'b0;

//Repetition counter
always @ (posedge i_clock)
begin
        if (i_reset)
                repeat_counter <= {NB_REPEAT_CNT{1'b0}};        
        else if (i_rf_update)
                repeat_counter <= i_rf_error_repeat;
        else if ( repeat_on && !period_on && !burst_on)
                repeat_counter <= repeat_counter - 1'b1;
end
assign repeat_on = (repeat_counter > {NB_REPEAT_CNT{1'b0}}) ? 1'b1 : 1'b0;



//----------------------------Instances-------------------------//

assign static_prbs_enable = 1'b1;
assign static_prbs_valid  = 1'b1;

/*
        Setear los parametro HL y LL de modo que la salida de la PRBS sea 1 bit
*/
prbs
#(
        .SEED           (PRBS_SEED),
        .EXP1           (PRBS_EXP1),
        .EXP2           (PRBS_EXP2),
        .N_BITS         (PRBS_NUM),
        .HIGH_LIM       (PRBS_HL),
        .LOW_LIM        (PRBS_LL)
 )
        u_prbs
        (
                .i_clock        (i_clock),
                .i_reset        (i_reset),
                .i_enable       (static_prbs_enable),
                .i_valid        (static_prbs_valid),

                .o_sequence     (out_prbs)
        );

endmodule 
