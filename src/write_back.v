module write_back(input [31:0] alu_output,
                  input clk,
                  input rst,
                  input [31:0] instr_reg_fetch,
                  input [31:0] loaded_value,
                  input [31:0] cntrl_sig_decode,
                  output reg [31:0] instr_reg_fetch);
  
  always @(posedge clk)
    begin
      if (cntrl_sig_decode == 32'hC0F) begin 
        instr_reg_fetch[11:7] = loaded_value;
        
      end
      else instr_reg_fetch[11:7] = alu_output;

    end
endmodule
