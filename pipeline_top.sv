`include "Fetch/Fetch_top.sv"
`include "Decode/Decode_top.sv"
`include "Execute/Execute_top.sv"
`include "Memory_Access/memory_top.sv"
`include "Write_Back/write_back_top.sv"
`include "Hazard_unit.sv"

module pipeline_top(
    input logic clk, rst
);

// Declaration of Interim Wires
logic PCSrcE, RegWriteW, RegWriteE, ALU_SrcE, MemWriteE, ResultSrcE, BranchE, RegWriteM, MemWriteM, ResultSrcM, ResultSrcW;
logic [1:0] ForwardAE, ForwardBE;
logic  [2:0]ALUControlE;
logic [4:0] RDW, RD_E, RD_M, RS1_E, RS2_E;
logic [31:0]PCTargetE, InstrD, PCD, PCPlus4D, ResultW, RD1_E, RD2_E, Imm_Ext_E, PCE, PCPlus4E, PCPlus4M, WriteDataM, ALU_ResultM, ALU_ResultW, Read_Data_W, PCPlus4W;

fetch_cycle Fetch(
    .clk(clk),
    .rst(rst),
    .PCSrcE(PCSrcE),
    .PCTargetE(PCTargetE),
    .InstrD(InstrD),
    .PCD(PCD),
    .PCPlus4D(PCPlus4D)
);

decode_cycle Decode(
    .clk(clk),
    .rst(rst),
    .RegWriteW(RegWriteW),
    .RDW(RDW),
    .InstrD(InstrD),
    .PCD(PCD),
    .PCPlus4D(PCPlus4D),
    .ResultW(ResultW),
    .RegWriteE(RegWriteE),
    .ALU_SrcE(ALU_SrcE), 
    .MemWriteE(MemWriteE), 
    .ResultSrcE(ResultSrcE), 
    .BranchE(BranchE),
    .ALUControlE(ALUControlE),
    .RD1_E(RD1_E),
    .RD2_E(RD2_E),
    .RD_E(RD_E),
    .Imm_Ext_E(Imm_Ext_E),
    .PCE(PCE),
    .PCPlus4E(PCPlus4E),
    .RS1_E(RS1_E),
    .RS2_E(RS2_E)
);

exceute_cycle execute(
    .clk(clk), 
    .rst(rst), 
    .RegWriteE(RegWriteE), 
    .ALU_SrcE(ALU_SrcE), 
    .MemWriteE(MemWriteE), 
    .ResultSrcE(ResultSrcE), 
    .BranchE(BranchE),
    .ALUControlE(ALUControlE),
    .RD1_E(RD1_E), 
    .RD2_E(RD2_E), 
    .Imm_Ext_E(Imm_Ext_E),
    .RD_E(RD_E),
    .PCE(PCE), 
    .PCPlus4E(PCPlus4E),
    .PCTargetE(PCTargetE),  
    .PCSrcE(PCSrcE),
    .RegWriteM(RegWriteM), 
    .MemWriteM(MemWriteM), 
    .ResultSrcM(ResultSrcM),
    .RD_M(RD_M),
    .PCPlus4M(PCPlus4M), 
    .WriteDataM(WriteDataM), 
    .ALU_ResultM(ALU_ResultM),
    .ResultW(ResultW),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE)
);

memory_cycle memory_access(
    .clk(clk), 
    .rst(rst), 
    .RegWriteM(RegWriteM), 
    .MemWriteM(MemWriteM), 
    .ResultSrcM(ResultSrcM),
    .RD_M(RD_M),
    .PCPlus4M(PCPlus4M), 
    .WriteDataM(WriteDataM), 
    .ALU_ResultM(ALU_ResultM),
    .RegWriteW(RegWriteW), 
    .ResultSrcW(ResultSrcW),
    .ALU_ResultW(ALU_ResultW), 
    .Read_Data_W(Read_Data_W), 
    .PCPlus4W(PCPlus4W),
    .RD_W(RDW)
);

write_back_cycle write_back(
    .clk(clk), 
    .rst(rst), 
    .ResultSrcW(ResultSrcW),
    .ALU_ResultW(ALU_ResultW), 
    .Read_Data_W(Read_Data_W), 
    .PCPlus4W(PCPlus4W),
    .ResultW(ResultW)
);

hazard_unit Forwarding(
    .rst(rst), 
    .RegWriteM(RegWriteM), 
    .RegWriteW(RegWriteW), 
    .RD_M(RD_M), 
    .RD_W(RDW), 
    .RS1_E(RS1_E), 
    .RS2_E(RS2_E), 
    .ForwardAE(ForwardAE), 
    .ForwardBE(ForwardBE)
);

endmodule