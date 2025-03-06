module Register_File(
    input logic clk, rst, WE3,                  // Clock, Reset, Write Enable
    input logic [4:0] A1, A2, A3,               // Address Inputs
    input logic [31:0] WD3,                     // Write Data
    output logic [31:0] RD1, RD2                // Read Data Outputs
);

    logic [31:0] Register [0:31];  // 32 Registers, each 32-bit wide

    initial begin
        Register[0] = 32'h00000000;
        Register[1] = 32'h00000000;
        Register[2] = 32'h00000000;
        Register[3] = 32'h00000000;
        Register[4] = 32'h00000000;
        Register[5] = 32'h00000000;
        Register[6] = 32'h00000000;
        Register[7] = 32'h00000000;
        Register[8] = 32'h00000000;
        Register[9] = 32'h00000000;
        Register[10] = 32'h00000000;
        Register[11] = 32'h00000000;
        Register[12] = 32'h00000000;
        Register[13] = 32'h00000000;
        Register[14] = 32'h00000000;
        Register[15] = 32'h00000000;
        Register[16] = 32'h00000000;
        Register[17] = 32'h00000000;
        Register[18] = 32'h00000000;
        Register[19] = 32'h00000000;
        Register[20] = 32'h00000000;
        Register[21] = 32'h00000000;
        Register[22] = 32'h00000000;
        Register[23] = 32'h00000000;
        Register[24] = 32'h00000000;
        Register[25] = 32'h00000000;
        Register[26] = 32'h00000000;
        Register[27] = 32'h00000000;
        Register[28] = 32'h00000000;
        Register[29] = 32'h00000000;
        Register[30] = 32'h00000000;
        Register[31] = 32'h00000000;
    end 

    always_ff @ (posedge clk)
    begin
        if(WE3 & (A3 != 5'h00))
            Register[A3] <= WD3;
    end
    

    // Read Logic
    assign RD1 = (A1 == 5'd0) ? 32'd0 : Register[A1];  
    assign RD2 = (A2 == 5'd0) ? 32'd0 : Register[A2];

endmodule
