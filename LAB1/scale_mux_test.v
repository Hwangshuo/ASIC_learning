`define width 8
`timescale 1ns/1ns

module mux_test; reg [`width:1] a, b; wire [`width:1] out; reg sel; scale_mux #(`width)
                                                                               m1 (.out(out),
                                                                                .sel(sel),
                                                                                .b(b),
                                                                                .a(a));
    
    initial begin
        $monitor($stime,"sel = %b a = %b b = %b out = %b",sel,a,b,out);
        $dumpvars(2,mux_test);
        
        sel    = 0;b    = {`width{1'b0}};
        a      = {`width{1'b1}};
        #5 sel = 0;b = {`width{1'b1}}; a = {`width{1'b0}};
        #5 sel = 1;b = {`width{1'b0}}; a = {`width{1'b1}};
        #5 sel = 1;b = {`width{1'b1}}; a = {`width{1'b0}};
        #5 $finish;
    end
endmodule
