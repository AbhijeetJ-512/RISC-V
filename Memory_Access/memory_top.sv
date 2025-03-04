`include "Modules/Data_memory.sv"

module memory_cycle(
    // Input 
    input logic clk, rst, RegWriteM, MemWriteM, ResultSrcM,
    input logic [4:0]RD_M,
    input logic [31:0]PCPlus4M, WriteDataM, ALU_ResultM,

    //Output
    output logic RegWriteW, ResultSrcW,
    output logic [31:0] ALU_ResultW, Read_Data_W, PCPlus4W,
    output logic [4:0] RD_W
);

// Interim Wires
logic [31:0] Read_Data_M;

// Registers
logic RegWriteM_r, ResultSrcM_r;
logic [31:0]ALU_ResultM_r,Read_Data_M_r, PCPlus4M_r;
logic [4:0]RD_M_r;

// Modules
// Memory 
Data_Memory dmem(
    .clk(clk),
    .rst(rst),
    .WE(MemWriteM),
    .WD(WriteDataM),
    .A(ALU_ResultM),
    .RD(Read_Data_M)
);

// Memory stage Logic
always_ff @(posedge clk or  negedge rst) begin
    if(rst == 1'b0) begin
        RegWriteM_r <= 1'b0;
        ResultSrcM_r <= 1'b0;
        ALU_ResultM_r <= 32'h00000000;
        Read_Data_M_r <= 32'h00000000;
        PCPlus4M_r <= 32'h00000000;
        RD_M_r <= 5'b00000;
    end
    else begin
        RegWriteM_r <= RegWriteM;
        ResultSrcM_r <= ResultSrcM;
        ALU_ResultM_r <= ALU_ResultM;
        Read_Data_M_r <= Read_Data_M;
        PCPlus4M_r <= PCPlus4M;
        RD_M_r <= RD_M;
    end
end

//Output Assignment

assign RegWriteW = RegWriteM_r;
assign  ResultSrcW = ResultSrcM_r;
assign ALU_ResultW = ALU_ResultM_r;
assign Read_Data_W = Read_Data_M_r;
assign PCPlus4W =  PCPlus4M_r;
assign RD_W = RD_M_r;

endmodule