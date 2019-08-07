`timescale 1ns/100ps

/*
 * <MAX_ERR_PERIOD> : setea en cuanta cantidad maxima de bloques se aplicara el patron de erro, por ejemplo
 *                    si MAX_ERR_BURST = 10 y MAX_ERR_PERIOD = 100, como maximo se romperan 10 bloques cada 100.
 * 
 * CHECK : se podria agregar otra input 'i_mode' la cual seleccionara  si se desea romper bloques de datos, blloques de control,
           alineadores o cualquier bloque.
 *
 */

module bit_breaker
#(
        parameter NB_CODED_BLOCK = 66,
        parameter NB_ERR_MASK    = NB_CODED_BLOCK-2,    //mascara, se romperan los bits cuya posicon en la mascara sea 1
        parameter MAX_ERR_BURST  = 1024,                //cantidad de bloques consecutivos que se romperan
        parameter MAX_ERR_PERIOD = 1024,                //cantidad de bloqus por periodo de error ver NOTAS.
        parameter MAX_ERR_REPEAT = 10,                  //cantidad de veces que se repite el mismo patron de error
        parameter NB_BURST_CNT   = $clog2(MAX_ERR_BURST),
        parameter NB_PERIOD_CNT  = $clog2(MAX_ERR_PERIOD),
        parameter NB_REPEAT_CNT  = $clog2(MAX_ERR_REPEAT)
 )
 (
        input  wire                             i_clock,
        input  wire                             i_reset,
        input  wire                             i_valid,
        input  wire [NB_CODED_BLOCK-1 : 0]      i_data,
        input  wire                             i_rf_update,         //trigger para actualizar los valores de generacion de error
        input  wire [NB_ERR_MASK-1 : 0]         i_rf_error_mask,     // selecciona que bits romper
        input  wire [NB_BURST_CNT-1 : 0]        i_rf_error_burst,    // selecciona cuantos bloques consecutivos romper por periodo
        input  wire [NB_PERIOD_CNT-1 : 0]       i_rf_error_period,   // periodo
        input  wire [NB_REPEAT_CNT-1 : 0]       i_rf_error_repeat,   // cantidad de periodos con el mismo patron de error

        output wire o_data
 );

//Localparams
localparam NB_PAYLOAD = NB_CODED_BLOCK-2;
localparam NB_SH = 2;

//Internal Signals

reg [NB_BURST_CNT-1 : 0]        burst_counter;
reg [NB_PERIOD_CNT-1 : 0]       period_counter;
reg [NB_REPEAT_CNT-1 : 0]       burst_counter;

wire                            bypass;//funcion logica para definir que seleccionar como salida
wire [NB_SH-1 : 0]              sh;
wire [NB_PAYLOAD-1 : 0]         payload;
wire [NB_PAYLOAD-1 : 0]         bit_flip;
wire [NB_PAYLOAD-1 : 0]         masked_payload;
wire [NB_PAYLOAD-1 : 0]         err_payload;


assign sh               = i_data[NB_CODED_BLOCK-1 -: NB_SH];
assign payload          = i_data[NB_CODED_BLOCK-NB_SH-1 : 0];

//Algorithm Begin

//break process
assign bit_flip         = (payload & i_rf_error_mask) ^ i_rf_error_mask;
assign masked_payload   = payload & (~i_rf_error_mask);
assign err_payload      = bit_flip | masked_payload;



//Counters update
always @ (posedge i_clock)
begin
        if (i_reset)
        
        else if (i_rf_update)

        else if (i_valid && /*aca va la condicion que sea segun el contador*/)
end

always @ (posedge i_clock)
begin
        if (i_reset)
        
        else if (i_rf_update)

        else if (i_valid && /*aca va la condicion que sea segun el contador*/)
end


always @ (posedge i_clock)
begin
        if (i_reset)
        
        else if (i_rf_update)

        else if (i_valid && /*aca va la condicion que sea segun el contador*/)
end


endmodule
