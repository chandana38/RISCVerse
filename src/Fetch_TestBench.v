`timescale 1ns / 1ps

module Fetch_testbench(

    );
    // 'include "inst_mem.v" 
    //inputs 
    reg clk, rst, pc_select_execute;
    reg [31:0] pc_target_execute;
    
    //outputs
    
    wire [31:0] instruction_decode, pc_decode, next_pc_decode;
    
    Fetch (.clk(clk), 
    .rst(rst), 
    .pc_select_execute(pc_select_execute), 
    .pc_target_execute(pc_target_execute), 
    .instruction_decode(instruction_decode), 
    .pc_decode(pc_decode), 
    .next_pc_decode(next_pc_decode));
    
    
   always begin 
   clk = ~clk;
   #10;
   end
   
    initial begin 
   
   $dumpfile("dump.vcd");
   $dumpvars(0);
   end  
   
   initial  begin 
   rst <= 1'b0;
   #100
   rst <= 1'b1;
   pc_select_execute <= 1'b0;
   pc_target_execute <= 32'h00000000;
   $monitor("Time = %0t, rst = %b, clk = %b, instruction_decode = %h, pc_decode = %h, next_pc_decode = %h", $time, rst, clk, instruction_decode, pc_decode, next_pc_decode);
       
   #100;
   $finish;
   end

endmodule
