module PC_Module(
    input logic clk, rst,
    input  logic [31:0]PC,
    output logic [31:0]PC_Next
);

    always_ff @(posedge clk)
    begin
        if(rst == 1'b0)
            PC_Next <= {32{1'b0}};
        else
            PC_Next <= PC;
    end
endmodule