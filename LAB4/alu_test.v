/***********************
* TEST BENCXH FOR ALU *
***********************/

`timescale 1 ns / 1 ns

// Define the delay from stimulus to response check
`define  DELAY      20


module alu_test; wire [7:0] out; reg [7:0] data; reg [7:0] accum; reg [2:0] opcode; integer i; parameter PASS0 = 3'b000, PASS1 = 3'b001, ADD = 3'b010, AND = 3'b011, XOR = 3'b100, PASSD = 3'b101, PASS6 = 3'b110, PASS7 = 3'b111; alu alu1 (.out(out), .zero(zero), .opcode(opcode), .data(data), .accum(accum));
    // Monitor signals
    initial
    begin
        $display ("<------------ INPUTS ------------><-OUTPUTS->");
        $display ("  TIME    OPCODE DATA IN  ACCUM IN ALU OUT  ZERO BIT");
        $display ("--------- ------ -------- -------- -------- --------");
        $timeformat (-9, 1, " ns", 9);
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0);
    end
    // Verify response
    task check;
        input [8:0] checks;
        begin
            $display("%t %b    %b %b %b %b", $time, opcode, data, accum, out, zero);
            if ({zero,out} !== checks)
            begin
                $display ( "At time %t: zero is %b and should be %b, out is %b and should be %b",
                $time, zero, checks[8], out, checks[7:0] );
                $display ("TEST FAILED");
                $finish;
            end
        end
    endtask
    // Apply stimulus
    initial
    begin
        {opcode,accum,data} = {PASS0,8'h00,8'hFF}; #(`DELAY) check({1'b1,accum});
        {opcode,accum,data} = {PASS0,8'h55,8'hFF}; #(`DELAY) check({1'b0,accum});
        {opcode,accum,data} = {PASS1,8'h55,8'hFF}; #(`DELAY) check({1'b0,accum});
        {opcode,accum,data} = {PASS1,8'hCC,8'hFF}; #(`DELAY) check({1'b0,accum});
        {opcode,accum,data} = {ADD  ,8'h33,8'hAA}; #(`DELAY) check({1'b0,accum+data});
        {opcode,accum,data} = {AND  ,8'h0F,8'h33}; #(`DELAY) check({1'b0,accum&data});
        {opcode,accum,data} = {XOR  ,8'hF0,8'h55}; #(`DELAY) check({1'b0,accum^data});
        {opcode,accum,data} = {PASSD,8'h00,8'hAA}; #(`DELAY) check({1'b1,data});
        {opcode,accum,data} = {PASSD,8'h00,8'hCC}; #(`DELAY) check({1'b1,data});
        {opcode,accum,data} = {PASS6,8'hFF,8'hF0}; #(`DELAY) check({1'b0,accum});
        {opcode,accum,data} = {PASS7,8'hCC,8'h0F}; #(`DELAY) check({1'b0,accum});
        $display("TEST PASSED");
        $finish;
    end
    
endmodule
