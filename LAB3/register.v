`timescale 1ns/1ns
module register (out,
                 data,
                 load,
                 clk,
                 rst_);
    output [7:0] out;
    input [7:0] data;
    input load;
    input clk;
    input rst_;
    wire [7:0] n1,n2;

    mux m7(.a(out[7]),.b(data[7]),.out(n1[7]),.sel(load));
    mux m6(.a(out[6]),.b(data[6]),.out(n1[6]),.sel(load));
    mux m5(.a(out[5]),.b(data[5]),.out(n1[5]),.sel(load));
    mux m4(.a(out[4]),.b(data[4]),.out(n1[4]),.sel(load));
    mux m3(.a(out[3]),.b(data[3]),.out(n1[3]),.sel(load));
    mux m2(.a(out[2]),.b(data[2]),.out(n1[2]),.sel(load));
    mux m1(.a(out[1]),.b(data[1]),.out(n1[1]),.sel(load));
    mux m0(.a(out[0]),.b(data[0]),.out(n1[0]),.sel(load));

    dffr d7(.d(n1[7]),.q(out[7]),.clk(clk),.rst_(rst_));
    dffr d6(.d(n1[6]),.q(out[6]),.clk(clk),.rst_(rst_));
    dffr d5(.d(n1[5]),.q(out[5]),.clk(clk),.rst_(rst_));
    dffr d4(.d(n1[4]),.q(out[4]),.clk(clk),.rst_(rst_));
    dffr d3(.d(n1[3]),.q(out[3]),.clk(clk),.rst_(rst_));
    dffr d2(.d(n1[2]),.q(out[2]),.clk(clk),.rst_(rst_));
    dffr d1(.d(n1[1]),.q(out[1]),.clk(clk),.rst_(rst_));
    dffr d0(.d(n1[0]),.q(out[0]),.clk(clk),.rst_(rst_));
    
endmodule
