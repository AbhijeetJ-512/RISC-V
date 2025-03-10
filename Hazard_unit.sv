module hazard_unit(
    input logic rst, RegWriteM, RegWriteW, 
    input logic [4:0] RD_M, RD_W, RS1_E, RS2_E, 
    output logic [1:0] ForwardAE, ForwardBE
);

assign ForwardAE = (rst == 1'b0) ? 2'b00 :
                   ((RegWriteM == 1'b1) & (RD_M != 5'b00000) & (RD_M == RS1_E)) ? 2'b10 :
                   ((RegWriteW == 1'b1) & (RD_W != 5'b00000) & (RD_W == RS1_E)) ? 2'b01 : 2'b00;

assign ForwardBE = (rst == 1'b0) ? 2'b00 :
                   ((RegWriteM == 1'b1) & (RD_M != 5'b00000) & (RD_M == RS2_E)) ? 2'b10 :
                   ((RegWriteW == 1'b1) & (RD_W != 5'b00000) & (RD_W == RS2_E)) ? 2'b01 : 2'b00;

endmodule
