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




module data_memory #(
    parameter data_width = 32,
    parameter addr_width = 32
)(
    input clk,
    input rst,
    input mem_en,
    input rd_wr,
    input [addr_width-1:0] read_addr,
    input [addr_width-1:0] write_addr,
    input [data_width-1:0] write_data,
    output reg [data_width-1:0] read_data
);

  reg [7:0] data_mem [16383:0];
    integer i;

    always @(*)
    begin
        if (!rst)
        begin
            for (i = 0; i < 16384; i = i + 1)
                data_mem[i] = 8'h0;
            read_data = 32'h0;
        end
        else if (mem_en && rd_wr)
        begin
          read_data = {data_mem[read_addr+3], data_mem[read_addr+2], data_mem[read_addr+1], data_mem[read_addr]};
        end
    end

    always @(posedge clk or negedge rst)
    begin
        if (!rst)
        begin
            // Handle synchronous reset if necessary
        end
        else if (mem_en && !rd_wr)
        begin
            data_mem[write_addr]     <= write_data[7:0];
            data_mem[write_addr + 1] <= write_data[15:8];
            data_mem[write_addr + 2] <= write_data[23:16];
            data_mem[write_addr + 3] <= write_data[31:24];
        end
    end

endmodule
