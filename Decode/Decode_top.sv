`include "Modules/Control_Unit_Top.sv"
`include "Modules/Register_file.sv"
`include "Modules/Sign_Extend.sv"

module decode_cycle(
    input logic clk, rst, RegWriteW,
    input logic [4:0] RDW,
    input logic [31:0] InstrD, PCD, PCPlusD, ResultW,

    output logic RegWriteE, ALU_SrcE, MemWriteE, ResultSrcE, BranchE,
    output logic  [2:0]ALUControlE,
    output logic [31:0] RD1_E, RD2_E, Imm_Ext_E,
    output logic [4:0] RD_E,
    output logic [31:0] PCE, PCPlusE
);

// Interim Wires
logic RegWriteD, ALU_SrcD, MemWriteD, ResultSrcD, BranchD;
logic [1:0]ImmSrcD;
logic [2:0]ALUControlD;
logic [31:0] RD1_D, RD2_D, Imm_Ext_D;

// Interim Regsiter
logic RegWriteD_r, ALU_SrcD_r, MemWriteD_r, ResultSrcD_r, BranchD_r;
logic [2:0]ALUControlD_r, ImmSrcD_r;
logic [31:0] RD1_D_r, RD2_D_r, Imm_Ext_D_r;
logic [4:0] RD_D_r;
logic [31:0] PCD_r, PCPlusD_r;

// Control Unit
Control_Unit_Top control(
                .Op(InstrD[6:0]),
                .RegWrite(RegWriteD),
                .ImmSrc(ImmSrcD),
                .ALUSrc(ALU_SrcD),
                .MemWrite(MemWriteD),
                .ResultSrc(ResultSrcD),
                .Branch(BranchD),
                .funct3(InstrD[14:12]),
                .funct7(InstrD[31:25]),
                .ALUControl(ALUControlD)
                );

// Register File
Register_File rf(
                .clk(clk),
                .rst(rst),
                .WE3(RegWriteW),
                .WD3(ResultW),
                .A1(InstrD[19:15]),
                .A2(InstrD[24:20]),
                .A3(RDW),
                .RD1(RD1_D),
                .RD2(RD2_D)
                );

Sign_Extend Extension(
                    .In(InstrD),
                    .ImmSrc(ImmSrcD),
                    .Imm_Ext(Imm_Ext_D)
                    );


always_ff @( posedge clk or negedge rst ) begin 

    if(rst == 1'b0) begin
        RegWriteD_r <= 1'b0;
        ALU_SrcD_r <= 1'b0;
        MemWriteD_r <= 1'b0;
        ResultSrcD_r <= 1'b0;
        BranchD_r <= 1'b0;
        ALUControlD_r <= 3'b000;
        RD1_D_r <= 32'h00000000;
        RD2_D_r <= 32'h00000000;
        RD_D_r <= 32'h00000000;
        Imm_Ext_D_r <= 32'h00000000;
        PCD_r <= 32'h00000000;
        PCPlusD_r <= 32'h00000000;
    end
    else begin
        RegWriteD_r <= RegWriteD;
        ALU_SrcD_r <= ALU_SrcD;
        MemWriteD_r <= MemWriteD;
        ResultSrcD_r <=ResultSrcD;
        BranchD_r <= BranchD;
        ALUControlD_r <= ALUControlD;
        RD1_D_r <= RD1_D;
        RD2_D_r <= RD2_D;
        RD_D_r <= InstrD[11:7];
        Imm_Ext_D_r <= Imm_Ext_D;
        PCD_r <= PCD;
        PCPlusD_r <= PCPlusD;
    end
end

assign RegWriteE = RegWriteD_r;
assign ALU_SrcE = ALU_SrcD_r;
assign MemWriteE = MemWriteD_r;
assign ResultSrcE = ResultSrcD_r;
assign BranchE = BranchD_r;
assign JumpE = JumpD_r;
assign ALUControlE = ALUControlD_r;
assign RD1_E = RD1_D_r;
assign RD2_E = RD2_D_r;
assign RD_E = RD_D_r;
assign Imm_Ext_E = Imm_Ext_D_r;
assign PCE = PCD_r;
assign PCPlusE = PCPlusD_r;

endmodule