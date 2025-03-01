module Register_File(
    input logic clk, rst, WE3,                  // Clock, Reset, Write Enable
    input logic [4:0] A1, A2, A3,               // Address Inputs
    input logic [31:0] WD3,                     // Write Data
    output logic [31:0] RD1, RD2                // Read Data Outputs
);

    logic [31:0] Register [0:31];  // 32 Registers, each 32-bit wide

    // Reset Logic - Reset all registers when rst is active
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < 32; i++) begin
                Register[i] = 32'h00000000;
            end 
        end 
        else if (WE3 && A3 != 5'd0) begin
            Register[A3] <= WD3; 
        end
    end

    // Read Logic
    assign RD1 = (A1 == 5'd0) ? 32'd0 : Register[A1];  
    assign RD2 = (A2 == 5'd0) ? 32'd0 : Register[A2];

endmodule
