module clock(clk);
output clk;
reg clk_r;
initial begin
    clk_r = 0;
    forever begin
        #10 clk_r = 1'b1;
        #10 clk_r = 1'b0;
    end
end
assign clk=clk_r;
endmodule