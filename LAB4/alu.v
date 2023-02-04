`timescale 1ns/100ps
module alu(out,
           zero,
           opcode,
           data,
           accum);
    
    input [7:0] data,accum;
    input [2:0] opcode;
    output zero;
    output [7:0] out;
    reg [7:0] out;
    reg zero;
    parameter PASS0 = 3'b000,
    PASS1 = 3'b001,
    ADD = 3'b010,
    AND = 3'b011,
    XOR = 3'b100,
    PASSD = 3'b101,
    PASS6 = 3'b110,
    PASS7 = 3'b111;
    
    always @(data or  accum or opcode) begin
        case (opcode)
            PASS0:begin
                out = accum;
            end
            PASS1:begin
                out = accum;
            end
            ADD:begin
                out = accum+data;
            end
            AND:begin
                out = accum&data;
            end
            XOR:begin
                out = accum^data;
            end
            PASSD:begin
                out = data;
            end
            PASS6:begin
                out = accum;
            end
            PASS7:begin
                out = accum;
            end
            default:begin
                out = 8'bx;
            end
        endcase
    end
    
    assign zero = accum?0:1;
    
endmodule
    
    
