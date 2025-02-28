module PC_Adder (

    input logic [31:0]a, b,
    output logic [31:0]Sum
);
    assign Sum = a + b;
    
endmodule