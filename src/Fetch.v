`timescale 1ns / 1ps
module Fetch(
    input clk, rst,
    input pc_select_execute,
    input [31:0] pc_target_execute,
    output reg [31:0] instruction_fetch,
    output reg [31:0] pc_fetch, next_pc_fetch
);

    reg [31:0] instr_mem [1023:0];

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            instruction_fetch <= 32'h0;
            pc_fetch <= 32'h0;
            next_pc_fetch <= 32'h0;
        end else begin
            if (pc_select_execute == 0) begin
                pc_fetch <= next_pc_fetch;
                next_pc_fetch <= next_pc_fetch + 4;
            end else begin
                pc_fetch <= pc_target_execute;
                next_pc_fetch <= pc_fetch + 4;
            end
            instruction_fetch <= instr_mem[pc_fetch];
        end
    end

endmodule


module Instruction_Memory(rst,address,read_data);

  input rst;
  input [31:0]address;
  output [31:0] read_data;

  reg [31:0] mem [1023:0];

  assign read_data = (rst == 1'b0) ? 32'h00000000 : mem[address[31:2]];

endmodule

