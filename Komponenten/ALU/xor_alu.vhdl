library ieee;
use ieee.std_logic_1164.all;
use work.constant_package.all;

entity xor_alu is
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
    );
end xor_alu;
 
architecture xor_alu_arch of xor_alu is
    begin
        process(pi_opa, pi_opb)
        begin
            po_out <= pi_opa xor pi_opb;
        end process;
end architecture xor_alu_arch;