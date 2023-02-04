`timescale 1ns/100ps
module counter (cnt,
                clk,
                data,
                rst_,
                load);
    output [4:0] cnt;
    input [4:0] data;
    input clk;
    input rst_;
    input load;
    reg [4:0] cnt;
    always @(posedge clk or negedge rst_) begin
        if (!rst_)
            cnt <= 0;
        else
            if (load)
                cnt <= data;
            else
                cnt <= cnt+1;
    end
endmodule
