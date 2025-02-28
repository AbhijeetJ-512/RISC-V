`include "Modules/PC.sv"
`include "Modules/Instruction_Memory.sv"
`include "Modules/Mux.sv"
`include "Modules/PC_Adder.sv"

module fetch_cycle(

    input logic clk, rst,
    input logic PCSrcE,
    input logic [31:0]PCTargetE,
    output logic [31:0]InstrD,
    output logic [31:0] PCD, PCPlus4D 
);

//Interm wires
logic [31:0]PCF, PC_F, PCPlus4F;

//Registers

logic [31:0] InstrF_reg;
logic [31:0] PCF_reg, PCPlus4F_reg;


//PC Mux
Mux PC_MUX(.a(PCPlus4F),
           .b(PCTargetE),
           .s(PCSrcE),
           .f(PC_F)
           );

//Program Counter
PC_Module Program_Counter(.clk(clk),
                          .rst(rst),
                          .PC(PC_F),
                          .PC_Next(PCF)
                          );

//Instruction_Memory
Instruction_Memory IMEM(.rst(rst),
                        .A(PCF),
                        .RD(InstrF)
                        );

//PC Adder
PC_Adder PC_adder(.a(PCF),
                  .b(32'h00000004),
                  .Sum(PCPlus4F)
                  );

always_ff @(posedge clk or negedge rst) begin 
    if(rst == 1'b0 ) begin
        InstrF_reg <= 32'h00000000;
        PCF_reg <= 32'h00000000;
        PCPlus4F_reg <= 32'h00000000;
    end
    else begin
        InstrF_reg <= InstrF;
        PCF_reg <= PCF;
        PCPlus4F_reg <= PCPlus4F;
    end
end

// Assigning Registers to output Port

assign InstrD = (rst == 1'b0) ? 32'h00000000 : InstrF_reg;
assign PCD = (rst == 1'b0) ? 32'h00000000 : PCF_reg;
assign PCPlus4D = (rst == 1'b0) ? 32'h00000000 : PCPlus4F_reg;

endmodule