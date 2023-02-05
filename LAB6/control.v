/**************
 * CONTROLLER *
 **************/
`timescale 1 ns / 1 ns
`define  HLT  3'b000
`define  SKZ  3'b001
`define  ADD  3'b010
`define  AND  3'b011
`define  XOR  3'b100
`define  LDA  3'b101
`define  STO  3'b110
`define  JMP  3'b111
module control (rd,
                wr,
                ld_ir,
                ld_ac,
                ld_pc,
                inc_pc,
                halt,
                data_e,
                sel,
                opcode,
                zero,
                clk,
                rst_);
    
    output rd;
    output wr;
    output ld_ir;
    output ld_ac;
    output ld_pc;
    output inc_pc;
    output halt;
    output data_e;
    output sel;
    input [2:0] opcode;
    input  zero;
    input  clk;
    input  rst_;
    
    reg  rd;
    reg  wr;
    reg  ld_ir;
    reg  ld_ac;
    reg  ld_pc;
    reg  inc_pc;
    reg  halt;
    reg  data_e;
    reg  sel;
    reg [2:0] nexstate;
    reg [2:0] state;
    reg [2:0] opcode_r;
    reg alu_op;
    
    always @ (posedge clk or negedge rst_)
        if (!rst_)
            state <= 3'b000;
        else
            state <= nexstate;
    
    
    always @(*)
    begin
        case(state)
            0:nexstate = 1;
            1:nexstate = 2;
            2:begin
                nexstate = 3;
                opcode_r = opcode;
            end
            3:nexstate = 4;
            4:nexstate = 5;
            5:nexstate = 6;
            6:nexstate = 7;
            7:nexstate = 0;
        endcase
    end
    
    
    always @ (opcode_r or state or zero)
        begin:blk
        alu_op = opcode_r == `ADD||opcode_r == `AND||opcode_r == `XOR||opcode_r == `LDA;
    
    end
    
    always @(posedge clk or negedge rst_)
    begin
        if (!rst_)
        begin
            rd       <= 0;
            wr       <= 0;
            ld_ir    <= 0;
            ld_ac    <= 0;
            ld_pc    <= 0;
            inc_pc   <= 0;
            halt     <= 0;
            data_e   <= 0;
            sel      <= 0;
            nexstate <= 0;
            state    <= 0;
        end
        else
            case(nexstate)
                1:begin
                    sel    <= 1;
                    rd     <= 0;
                    inc_pc <= 0;
                    ld_pc  <= 0;
                    data_e <= 0;
                    ld_ac  <= 0;
                    wr     <= 0;
                end
                2:begin
                    sel <= 1;
                    rd  <= 1;
                end
                3:begin
                    sel   <= 1;
                    rd    <= 1;
                    ld_ir <= 1;
                end
                4:begin
                    sel   <= 1;
                    rd    <= 1;
                    ld_ir <= 1;
                end
                5:begin
                    sel    <= 0;
                    rd     <= 0;
                    ld_ir  <= 0;
                    inc_pc <= 1;
                    halt   <= `HLT;
                end
                6:begin
                    inc_pc <= 0;
                    halt   <= 0;
                    rd     <= alu_op;
                end
                7:begin
                    inc_pc <= `SKZ&zero;
                    ld_pc  <= `JMP;
                    data_e <= !alu_op;
                end
                0:begin
                    ld_ac <= alu_op;
                    wr    <= `STO;
                end
            endcase
    end
endmodule
