`timescale 1ns/100ps

/*
 * <MAX_ERR_PERIOD> : setea en cuanta cantidad maxima de bloques se aplicara el patron de erro, por ejemplo
 *                    si MAX_ERR_BURST = 10 y MAX_ERR_PERIOD = 100, como maximo se romperan 10 bloques cada 100.
 *
 */

module payload_breaker
#(
        parameter NB_CODED_BLOCK = 66,
        parameter NB_ERR_MASK    = NB_CODED_BLOCK-2,    //mascara, se romperan los bits cuya posicon en la mascara sea 1
        parameter MAX_ERR_BURST  = 1024,                //cantidad de bloques consecutivos que se romperan
        parameter MAX_ERR_PERIOD = 1024,                //cantidad de bloqus por periodo de error ver NOTAS.
        parameter MAX_ERR_REPEAT = 10,                  //cantidad de veces que se repite el mismo patron de error
        parameter NB_BURST_CNT   = $clog2(MAX_ERR_BURST),
        parameter NB_PERIOD_CNT  = $clog2(MAX_ERR_PERIOD),
        parameter NB_REPEAT_CNT  = $clog2(MAX_ERR_REPEAT),
        parameter N_MODES        = 4
 )
 (
        input  wire                             i_clock,
        input  wire                             i_reset,
        input  wire                             i_valid,
        input  wire                             i_aligner_tag,       //indica que el bloque es un alineador
        input  wire [NB_CODED_BLOCK-1 : 0]      i_data,
        input  wire [N_MODES-1 : 0]             i_rf_mode,           //ver NOTAS
        input  wire                             i_rf_update,         //trigger para actualizar los valores de generacion de error
        input  wire [NB_ERR_MASK-1 : 0]         i_rf_error_mask,     // selecciona que bits romper
        input  wire [NB_BURST_CNT-1 : 0]        i_rf_error_burst,    // selecciona cuantos bloques consecutivos romper por periodo
        input  wire [NB_PERIOD_CNT-1 : 0]       i_rf_error_period,   // periodo
        input  wire [NB_REPEAT_CNT-1 : 0]       i_rf_error_repeat,   // cantidad de periodos con el mismo patron de error

        output reg  [NB_CODED_BLOCK-1 : 0]      o_data,
        output reg                              o_aligner_tag
 );

//Localparams
localparam NB_PAYLOAD = NB_CODED_BLOCK-2;
localparam NB_SH = 2;
localparam MODE_ALIN = 4'b0001;
localparam MODE_CTRL = 4'b0010;
localparam MODE_DATA = 4'b0100;
localparam MODE_ALL  = 4'b1000;

//------------------------------Internal Signals-----------------------------------

//Error control counters
reg [NB_BURST_CNT-1 : 0]        burst_counter;
reg [NB_PERIOD_CNT-1 : 0]       period_counter;
reg [NB_REPEAT_CNT-1 : 0]       repeat_counter;

//Data
wire                            bypass;//funcion logica para definir que seleccionar como salida
wire [NB_SH-1 : 0]              sh;
wire [NB_PAYLOAD-1 : 0]         payload;
wire [NB_PAYLOAD-1 : 0]         bit_flip;
wire [NB_PAYLOAD-1 : 0]         masked_payload;
wire [NB_PAYLOAD-1 : 0]         err_payload;

//Error counters conditions
wire                            burst_on;
wire                            period_on;
wire                            repeat_on;
wire                            expected_block;

//sh type
wire                            sh_ctrl_type;
wire                            sh_data_type;

//-----------------------------Algorithm Begin-------------------------------------


assign sh               = i_data[NB_CODED_BLOCK-1 -: NB_SH];
assign payload          = i_data[NB_CODED_BLOCK-NB_SH-1 : 0];

//[CHECK] verificar sh type en el estandar
assign sh_ctrl_type = (sh == 2'b10);
assign sh_data_type = (sh == 2'b01);

assign expected_block = ((i_rf_mode == MODE_ALIN) & i_aligner_tag) |
                        ((i_rf_mode == MODE_CTRL) & sh_ctrl_type)  |
                        ((i_rf_mode == MODE_DATA) & sh_data_type)  |
                         (i_rf_mode == MODE_ALL);

//break process
assign bit_flip         = (payload & i_rf_error_mask) ^ i_rf_error_mask;
assign masked_payload   = payload & (~i_rf_error_mask);
assign err_payload      = bit_flip | masked_payload;


//Data out assigment
always @ *
begin
        o_data = i_data; //DEFINIR OUT DATA
                case (i_rf_mode)
                MODE_ALIN :
                        if (burst_on && i_aligner_tag && !i_rf_update)
                                o_data = {sh , err_payload}; 
                MODE_CTRL :
                        if (burst_on && sh_ctrl_type  && !i_rf_update)
                                o_data = {sh, err_payload};
                MODE_DATA :
                        if (burst_on && sh_data_type  && !i_rf_update)
                                o_data = {sh, err_payload};
                MODE_ALL :
                        if (burst_on && !i_rf_update)
                                o_data = {sh, err_payload};
                default  :
                        o_data = i_data;
                endcase
end

/*

        [CHECK] Esto puede llegar a tener algun comportamiento medio raro cuando el burst y el perior sean iguales
                o cosas asi. Revisar !!!

        [CHECK] Ver que se va a senializar con i_valid, si necesitamos solo para senializar datos nuevos o algo mas
*/


//Counters update

//Burst error counter
always @ (posedge i_clock)
begin
        if (i_reset)
                burst_counter <= {NB_BURST_CNT{1'b0}};
        else if (i_rf_update)
                burst_counter <= i_rf_error_burst;
        else if (repeat_on && !period_on && i_valid) //si termino el periodo y debo repetir vuelvo a setear el valor
                burst_counter <= i_rf_error_burst;
        else if (expected_block && burst_on && i_valid)
                burst_counter <= burst_counter - 1'b1;
                        
end
assign burst_on = (burst_counter > {NB_BURST_CNT{1'b0}}) ? 1'b1 : 1'b0;

//Period counter
always @ (posedge i_clock)
begin
        if (i_reset)
                period_counter <= {NB_PERIOD_CNT{1'b0}};     
        else if (i_rf_update)
                period_counter <= i_rf_error_period;
        else if (repeat_on && !period_on && i_valid)
                period_counter <= i_rf_error_period;
        else if (period_on && i_valid)
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

endmodule
