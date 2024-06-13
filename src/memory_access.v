module memory_access(
                     input clk,
                     input rst,  //active high reset 
                     input [31:0] next_pc_fetch, // from fetch output
                     input [31:0] alu_output, //from execute stage
                     input [31:0] operand_B, //from decode stage
                     input [31:0] cntrl_sig_deocde, //from control block
                     input branch_condition_execute, 
                     output reg [31:0] loaded_value,
                     output reg [31:0] pc_fetch_mem_access);
//s_type: cntrl_sig_decode = 32'h823;
//l_type: cntrl_sig_decode = 32'hC0F;
  
  always @(posedge clk)
    begin
      if(rst) pc_fetch_mem_access <= 1'd0;
      else begin
        if (branch_condition_execute) pc_fetch_mem_access <= memory[alu_output];
        else pc_fetch_mem_access <= next_pc_getch; 
      end
      
    end
  always @(cntrl_sig_deocde)
    begin
      
      if (cntrl_sig_deocde == 32'h823 ) begin //store
        memory[alu_output] = operand_B;   
      end
      
      else if (cntrl_sig_decode = 32'hC0F) begin  //load
        loaded_value = memory[alu_output];
      end
      
    end
  
endmodule
