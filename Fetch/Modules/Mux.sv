module Mux (
    input logic [31:0]a, b,
    input logic s,
    output logic [31:0]f
);
    assign f = (~s) ? a : b ;
    
endmodule

