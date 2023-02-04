`timescale 1ns/1ns
module register_test; wire [7:0] out; reg [7:0] data; reg load; reg clk; reg rst_; register reg1(out,
                                                                                                 data,
                                                                                                 load,
                                                                                                 clk,
                                                                                                 rst_);
    clock clk1(clk);
    initial
    begin
        $timeformat (-9,1,"ns",9);
        $monitor("time = %t,clk = %b, data = %h , load = %b, out = %h,rst_ = %b",$stime,clk,data,load,out,rst_);
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0);
    end
    
    
    initial begin
        @(negedge clk)
        rst_ = 0;
        data = 0;
        load = 0;
        
        @(negedge clk)
        rst_ = 1;
        @(negedge clk)
        data = 8'h55;
        load = 1;
        @(negedge clk)
        data = 8'hAA;
        load = 1;
        
        @(negedge clk)
        data = 8'hCC;
        load = 0;
        
        @(negedge clk)
        $finish;
    end
    
endmodule
