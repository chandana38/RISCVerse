module hazard(
    input reset, 
    input m_reg_write_enable, 
    input w_reg_write_enable,
    input [4:0] m_dest_reg, 
    input [4:0] w_dest_reg, 
    input [4:0] rs1_exe, 
    input [4:0] rs2_exe,
    output [1:0] forward_a, 
    output [1:0] forward_b
);

    assign forward_a = (reset == 1'b0) ? 2'b00 : 
                       (m_reg_write_enable && (m_dest_reg != 5'h00) && (m_dest_reg == rs1_exe)) ? 2'b10 :
                       (w_reg_write_enable && (w_dest_reg != 5'h00) && (w_dest_reg == rs1_exe)) ? 2'b01 : 2'b00;
                       
    assign forward_b = (reset == 1'b0) ? 2'b00 : 
                       (m_reg_write_enable && (m_dest_reg != 5'h00) && (m_dest_reg == rs2_exe)) ? 2'b10 :
                       (w_reg_write_enable && (w_dest_reg != 5'h00) && (w_dest_reg == rs2_exe)) ? 2'b01 : 2'b00;

endmodule

