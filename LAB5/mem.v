/***************
* 32X8 MEMORY *
***************/

`timescale 1 ns / 1 ns

module mem (data,
            addr,
            read,
            write);
    inout [7:0] data ;
    input [4:0] addr ;
    input read ;
    input write;
    wire [7:0] data;
    reg [7:0] memory [0:31];
    always @(posedge write) begin
        memory[addr] = data;
    end
    
    assign data=read?memory[addr]:8'hZ;

     
endmodule
