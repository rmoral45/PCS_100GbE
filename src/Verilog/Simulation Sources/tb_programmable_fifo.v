`timescale 1ns/100ps

module tb_programmable_fifo;

localparam NB_DATA = 20;
localparam FIFO_DEPTH = 20;
localparam NB_ADDR = $clog2(FIFO_DEPTH);
localparam path_i_data = "/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/skew_tb_files/fifos-input.txt";
localparam path_i_wr_enb = "/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/skew_tb_files/fifo-wr-enb.txt";
localparam path_i_rd_enb = "/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/skew_tb_files/fifo-rd-enb.txt";
localparam path_i_rd_addr = "/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/skew_tb_files/fifos-output.txt";

reg tb_clock;
reg tb_reset;
reg tb_valid;
reg tb_wr_enable;
reg tb_rd_enable;
reg tb_enable_files;
reg [NB_ADDR-1 : 0] tb_wr_addr;
reg [NB_ADDR-1 : 0] tb_rd_addr;
reg                 tb_rd_enb;
reg [NB_DATA-1 : 0] tb_i_data;

reg [NB_ADDR-1 : 0] temp_wr_addr;
reg [NB_ADDR-1 : 0] temp_rd_addr;
reg                 temp_rd_enb;
reg [NB_DATA-1 : 0] temp_i_data;

wire [NB_DATA-1 : 0] tb_o_data;

integer fid_input_data;
integer fid_input_wr_enb;
integer fid_input_rd_enb;
integer fid_input_rd_addr;
integer ptr_data;
integer ptr_wr_addr;
integer ptr_rd_enb;
integer ptr_rd_addr;
integer code_error_data;
integer code_error_wr;
integer code_error_rd_enb;
integer code_error_rd_addr;

initial begin

        fid_input_data = $fopen(path_i_data, "r");
        if(fid_input_data == 0)
        begin
            $display("NO SE PUDO ABRIR EL ARCHIVO PARA I_DATA");
            $stop;
        end

        fid_input_wr_enb = $fopen(path_i_wr_enb, "r");
        if(fid_input_wr_enb == 0)
        begin
            $display("NO SE PUDO ABRIR EL ARCHIVO PARA I_WR_ADDR");
            $stop;
        end

        fid_input_rd_enb = $fopen(path_i_rd_enb, "r");
        if(fid_input_rd_enb == 0)
        begin
            $display("NO SE PUDO ABRIR EL ARCHIVO PARA I_RD_ENB");
            $stop;
        end
        
        fid_input_rd_addr = $fopen(path_i_rd_addr, "r");
        if(fid_input_rd_addr == 0)
        begin
            $display("NO SE PUDO ABRIR EL ARCHIVO PARA I_RD_ADDR");
            $stop;
        end
        
        tb_valid = 1;
        tb_reset = 1;
        tb_clock = 0;
        tb_enable_files = 0;
#10     tb_reset = 0;
        tb_enable_files = 1;
        tb_wr_enable = 1;
        tb_rd_enable = 0;
end

always #2 tb_clock = ~tb_clock;

always @ (posedge tb_clock)
begin
    
    if(tb_enable_files)
    begin
        
        for(ptr_data = 0; ptr_data < NB_DATA; ptr_data = ptr_data + 1)
        begin
            code_error_data <= $fscanf(fid_input_data, "%b\n", temp_i_data);
            if(code_error_data != 1)
            begin
                $display("I_DATA: CARACTER NO VALIDO");
                $stop;
            end
        end

        for(ptr_wr_addr = 0; ptr_wr_addr < NB_ADDR; ptr_wr_addr = ptr_wr_addr + 1)
        begin
            code_error_wr <= $fscanf(fid_input_wr_enb, "%b\n", temp_wr_addr);
            if(code_error_data != 1)
            begin
                $display("WR_ADDR: CARACTER NO VALIDO");
                $stop;
            end
        end

        for(ptr_rd_enb = 0; ptr_rd_enb < 2; ptr_rd_enb = ptr_rd_enb + 1)
        begin
            code_error_rd_enb <= $fscanf(fid_input_rd_enb, "%b\n", temp_rd_enb);
            if(code_error_rd_enb != 1)
            begin
                $display("RD_ADDR: CARACTER NO VALIDO");
                $stop;
            end
        end

        for(ptr_rd_addr = 0; ptr_rd_addr < NB_ADDR; ptr_rd_addr = ptr_rd_addr + 1)
        begin
            code_error_rd_addr <= $fscanf(fid_input_rd_addr, "%b\n", temp_rd_addr);
            if(code_error_rd_addr != 1)
            begin
                $display("RD_ADDR: CARACTER NO VALIDO");
                $stop;
            end
        end

        tb_i_data <= temp_i_data;
        tb_wr_addr <= temp_wr_addr;
        tb_rd_enb <= temp_rd_enb;
        tb_rd_addr <= temp_rd_addr;

    end 
end

prog_fifo_top
#()
u_prog_fifo_top
    (
    .i_clock(tb_clock),
    .i_reset(tb_reset),
    .i_valid(tb_valid),
    .i_write_enb(tb_wr_enable),
    .i_read_enb(tb_rd_enable),
    .i_data(tb_i_data),
    .i_write_addr(tb_wr_addr),
    .i_read_addr(tb_rd_addr),
    .o_data(tb_o_data)
    );

endmodule
