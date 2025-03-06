`include "ALU_Decoder.sv"
`include "Main_Decoder.sv"

module Control_Unit_Top(

    input logic [6:0]Op,funct7,
    input logic [2:0]funct3,
    output logic RegWrite, ALUSrc, MemWrite, ResultSrc, Branch,
    output logic [1:0]ImmSrc,
    output logic [2:0]ALUControl
);
    logic [1:0]ALUOp;

    Main_Decoder Main_Decoder(
                .Op(Op),
                .RegWrite(RegWrite),
                .ImmSrc(ImmSrc),
                .MemWrite(MemWrite),
                .ResultSrc(ResultSrc),
                .Branch(Branch),
                .ALUSrc(ALUSrc),
                .ALUOp(ALUOp)
    );

    ALU_Decoder ALU_Decoder(
                            .ALUOp(ALUOp),
                            .funct3(funct3),
                            .funct7(funct7),
                            .op(Op),
                            .ALUControl(ALUControl)
    );


endmodule