// `include "../Modules/Mux.sv"  // UnComment when using testbench only on this code

module write_back_cycle(
    input logic clk, rst, ResultSrcW,
    input logic [31:0] ALU_ResultW, Read_Data_W, PCPlus4W,

    output logic [31:0] ResultW
);

Mux Mux_results(
    .a(ALU_ResultW),
    .b(Read_Data_W),
    .s(ResultSrcW),
    .f(ResultW)
);

endmodule