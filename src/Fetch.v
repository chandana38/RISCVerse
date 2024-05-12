`timescale 1ns / 1ps
module Fetch(clk, rst, pc_select_execute, pc_target_execute, instruction_decode, pc_decode, next_pc_decode);

    // Declare input & outputs
    input clk, rst;
    input pc_select_execute;
    input [31:0] pc_target_execute;
    output [31:0] instruction_decode;
    output [31:0] pc_decode, next_pc_decode;

    // Declaring interim wires
    wire [31:0] pc_fetch, PCF, next_pc_fetch;
    wire [31:0] instruction_fetch;

    // Declaration of Register
    reg [31:0] instruction_fetch_reg;
    reg [31:0] pc_fetch_reg, next_pc_fetch_reg;

    //Program Counter MUX 
    assign pc_fetch = pc_select_execute ? next_pc_fetch : pc_target_execute;

    // Declare PC Counter Register         
    always @(posedge clk)
    begin
        if(rst == 1'b0)
            pc_fetch_reg <= {32{1'b0}};
        else
            pc_fetch_reg <= pc_fetch;
    end
    
    assign PCF = pc_fetch_reg;

    // Declare Instruction Memory
    Instruction_Memory inst_mem(
                .rst(rst),
                .address(PCF),
                .read_data(instruction_fetch)
                );

    assign next_pc_fetch = PCF + 32'h00000004;
    
    // Fetch Cycle Register Logic
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            instruction_fetch_reg <= 32'h00000000;
            pc_fetch_reg <= 32'h00000000;
            next_pc_fetch_reg <= 32'h00000000;
        end
        else begin
            instruction_fetch_reg <= instruction_fetch;
            pc_fetch_reg <= PCF;
            next_pc_fetch_reg <= next_pc_fetch;
        end
    end


    // Assigning Registers Value to the Output port
    assign  instruction_decode = (rst == 1'b0) ? 32'h00000000 : instruction_fetch_reg;
    assign  pc_decode = (rst == 1'b0) ? 32'h00000000 : pc_fetch_reg;
    assign  next_pc_decode = (rst == 1'b0) ? 32'h00000000 : next_pc_fetch_reg;


endmodule


module Instruction_Memory(rst,address,read_data);

  input rst;
  input [31:0]address;
  output [31:0] read_data;

  reg [31:0] mem [1023:0];

  assign read_data = (rst == 1'b0) ? 32'h00000000 : mem[address[31:2]];

endmodule

