`timescale 1ns/1ns

module counter_test; wire [4:0] cnt; reg [4:0] data; reg clk; reg rst_; reg load; counter c1(cnt,
                                                                                             clk,
                                                                                             data,
                                                                                             rst_,
                                                                                             load);


initial begin
    clk = 0;
    forever begin
        #10 clk = 1'b1;
        #10 clk = 1'b0;
    end
end


initial
begin
    $timeformat (-9,1,"ns",9);
    $monitor("time = %t,data = %h,clk = %b.rst_ = %b,load = %b,cnt = %b",$stime,data,clk,rst_,load,cnt);
    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0);
end



task check;
    input [4:0] checks;
    if (cnt != checks) begin
        $display("AT time %t cnt is %b and should be %b",$time,cnt,checks);
        $display("Test FAILED");
        $finish;
    end
    
endtask

initial
begin
    @(negedge clk)
    //RESET
    {rst_,load,data} = 7'b0_x_xxxxx;
    @(negedge clk)
    check(5'h00);
    
    //LOAD 1D
    @(negedge clk)
    {rst_,load,data} = 7'b1_1_11101;
    @(negedge clk)
    check(5'h1D);
    
    //COUNT +1
    @(negedge clk)
    {rst_,load,data} = 7'b1_0_11101;
    repeat(5) @(negedge clk);
    check(5'h02);
    
    //LOAD 1F
    {rst_,load,data} = 7'b1_1_11111;
    @(negedge clk)
    check(5'h1F);
    //RESET
    {rst_,load,data} = 7'b0_x_xxxxx;
    @(negedge clk)
    check(5'h00);
    
    
    $display("Test PASSED");
    $finish;
    
end
endmodule
