
`timescale 1ns / 1ps
 
module decode_tb;

// Parameters
parameter data_width = 32;

// Inputs
reg clk = 1;
reg rst = 0;
reg [data_width-1:0] instr_reg_fetch;
reg [data_width-1:0] pc_fetch;
reg [data_width-1:0] npc_fetch;
reg [31:0] cntrl_sig_decode;
reg [3:0] alu_control_decode;
reg [31:0] imm_data_decodel;
reg [31:0] operand_a;
reg [31:0] operand_b;

// Outputs
wire [data_width-1:0] instr_reg_decode;
wire [data_width-1:0] pc_decode;
wire [data_width-1:0] npc_decode;
wire [31:0] cntrl_sig_decode_out;
wire [3:0] alu_control_decode_out;
wire [31:0] imm_data_decode_out;
wire [31:0] operand_A;
wire [31:0] operand_B;

// Instantiate the module under test
decode1#(data_width) d1(clk,rst,instr_reg_fetch,pc_fetch,npc_fetch,cntrl_sig_decode,alu_control_decode,imm_data_decodel,operand_a,operand_b,instr_reg_decode,pc_decode,npc_decode,cntrl_sig_decode_out,alu_control_decode_out,imm_data_decode_out,operand_A,operand_B);
// Clock generation
always #5 clk = ~clk;

// Reset generation
initial begin
    rst = 1;
    #50;
    rst = 0;
end

// Stimulus
initial begin
    // Provide some stimulus here
    // Example: Set values for instr_reg_fetch, pc_fetch, npc_fetch, etc.
    instr_reg_fetch = 32'h12345678;
    pc_fetch = 32'hABCDEF01;
    npc_fetch = 32'hABCDEF05;
    cntrl_sig_decode = 32'h7;
    alu_control_decode = 4'b0001;
    imm_data_decodel = 32'h1234ABCD;
    operand_a = 32'h1;
    operand_b = 32'h2;
    #10
   // Wait for 100 clock cycles
    instr_reg_fetch = 32'h11111111;
    pc_fetch = 32'hABCDEF05;
    npc_fetch = 32'hABCDEF09;
    cntrl_sig_decode = 32'h7;
    alu_control_decode = 4'b0010;
    imm_data_decodel = 32'h1234ABCF;
    operand_a = 32'h33;
    operand_b = 32'h77;
    #10
    // Finish simulation
    $finish;
end

endmodule

