/***********************
 * TEST BENCXH FOR ALU *
 ***********************/

`timescale 1 ns / 1 ns

// Define the delay from stimulus to response check
`define  DELAY      80


module control_test; wire rd; wire wr; wire ld_ir; wire ld_ac; wire ld_pc; wire inc_pc; wire halt; wire data_e; wire sel; reg [2:0] opcode; reg zero; reg clk; reg rst_; control ctr(rd,
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
    initial
    begin
        
        $timeformat (-9, 1, " ns", 9);
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0);
    end
    initial begin
        clk = 0;
        forever begin
            #10 clk = 1'b1;
            #10 clk = 1'b0;
        end
    end
    
    // Verify response
    // task check;
    //     input [8:0] checks;
    //     begin
    //         $display("%t %b    %b %b %b %b", $time, opcode, data, accum, out, zero);
    //         if ({zero,out} ! == checks)
    //         begin
    //             $display ( "At time %t: zero is %b and should be %b, out is %b and should be %b",
    //             $time, zero, checks[8], out, checks[7:0] );
    //             $display ("TEST FAILED");
    //             $finish;
    //         end
    //     end
    // endtask
    // Apply stimulus
    initial
    begin
        @(negedge clk)
        //RESET
        rst_ = 0;
        @(negedge clk)
        rst_ = 1;
        
        {opcode,zero} = {3'd0,1'b0}; #(`DELAY) ;
        {opcode,zero} = {3'd1,1'b0}; #(`DELAY) ;
        {opcode,zero} = {3'd2,1'b0}; #(`DELAY) ;
        {opcode,zero} = {3'd3,1'b0}; #(`DELAY) ;
        {opcode,zero} = {3'd4,1'b0}; #(`DELAY) ;
        {opcode,zero} = {3'd5,1'b0}; #(`DELAY) ;
        {opcode,zero} = {3'd6,1'b0}; #(`DELAY) ;
        {opcode,zero} = {3'd7,1'b0}; #(`DELAY) ;
        {opcode,zero} = {3'd0,1'b1}; #(`DELAY) ;
        {opcode,zero} = {3'd0,1'b1}; #(`DELAY) ;
        {opcode,zero} = {3'd2,1'b0}; #(`DELAY) ;
        // $display("TEST PASSED");
        $finish;
    end
    
endmodule
