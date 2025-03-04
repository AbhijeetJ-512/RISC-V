module Data_Memory(

    input logic clk, rst, WE,
    input logic [31:0]A, WD,
    output logic [31:0] RD
);
    logic [31:0] mem [1023:0];

    always_ff @ (posedge clk)
    begin
        if(WE)
            mem[A] <= WD;
    end

    assign RD = (~rst) ? 32'd0 : mem[A];

    initial begin
        mem[0] = 32'h00000000;
    end


endmodule