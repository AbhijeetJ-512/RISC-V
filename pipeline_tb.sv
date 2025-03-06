module pipeline_tb();

    logic clk = 0, rst;

    always #50 clk = ~clk;


    initial begin
        rst = 1'b0; 
        #200;
        rst = 1'b1;
        #2000;
        $finish;
    end


    initial begin
        $dumpfile("Dump.vcd");
        $dumpvars(0); 
    end

    pipeline_top dut(
        .clk(clk),
        .rst(rst)
    );

endmodule
