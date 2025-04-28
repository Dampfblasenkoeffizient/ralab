entity and_alu_op is
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_out     : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
    )
end and_alu_op;

architecture and_alu_op_arch of and_alu_op is
    begin
        process(pi_opa, pi_opb)
        begin
            po_out <= pi_opa and pi_opb;
        end process;
end architecture and_alu_op_arch;