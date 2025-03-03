`include "Modules/ALU.sv"
`include "Modules/PC_Adder.sv"
`include "Modules/Mux.sv"

module exceute_cycle(
    input logic clk, rst, RegWriteE, ALU_SrcE, MemWriteE, ResultSrcE, BranchE,
    input logic  [2:0]ALUControlE,
    input logic [31:0] RD1_E, RD2_E, Imm_Ext_E,
    input logic [4:0] RD_E,
    input logic [31:0] PCE, PCPlusE,

    output logic [31:0]PCTargetE,  
    output logic PCSrcE,
    output logic RegWriteM, MemWriteM, ResultSrcM,
    output logic [4:0]RD_M,
    output logic [31:0]PCPlusM, WriteDataM, ALU_ResultM
);

// Interim Wires
logic [31:0]SrcBE;
logic [31:0]ResultE;
logic ZeroE;

// Register 
logic RegWriteE_r, MemWriteE_r, ResultSrcE_r;
logic [4:0]RD_E_r;
logic [31:0]PCPlusE_r, RD2_E_r, ResultE_r;

// Modules
// ALU Src Mux
Mux alu_mux(
    .a(RD2_E),
    .b(Imm_Ext_E),
    .s(ALU_SrcE),
    .f(SrcBE)
);

// ALU
ALU alu(
    .A(RD1_E),
    .B(SrcBE),
    .ALUControl(ALUControlE),
    .Carry(),
    .OverFlow(),
    .Zero(ZeroE),
    .Negative()
);

// Adder
PC_Adder branch_adder(
    .a(PCE),
    .b(Imm_Ext_E),
    .c(PCTargetE)
);

// Register Logic
always_ff @( posedge clk or negedge rst ) begin 
    if(rst == 1'b0) begin
        RegWriteE_r <= 1'b0;
        MemWriteE_r <= 1'b0; 
        ResultSrcE_r <= 1'b0;
        RD_E_r <= 5'b00000;
        PCPlusE_r <= 32'h00000000;
        RD2_E_r <= 32'h00000000;
        ResultE_r <= 32'h00000000;
    end    
    else begin
        RegWriteE_r <= RegWriteE;
        MemWriteE_r <= MemWriteE; 
        ResultSrcE_r <= ResultSrcE;
        RD_E_r <= RD_E;
        PCPlusE_r <= PCPlusE;
        RD2_E_r <= RD2_E;
        ResultE_r <= ResultE;
    end
end

// Output Assignment
assign PCSrcE = ZeroE & BranchE;
assign RegWriteM = RegWriteE_r;
assign MemWriteM = MemWriteE_r;
assign ResultSrcM = ResultSrcE_r;
assign RD_M = RD_E_r;
assign PCPlusM = PCPlusE_r;
assign WriteDataM = RD2_E_r;
assign ALU_ResultM = ResultE_r;



endmodule