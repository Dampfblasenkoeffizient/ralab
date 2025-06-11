-- Paul Riedel
library ieee;
use ieee.std_logic_1164.all;

entity and_alu is generic(DATA_WIDTH_GEN : integer);
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
    );
end and_alu;

architecture and_alu_arch of and_alu is
    begin
        process(pi_opa, pi_opb)
        begin
            po_out <= pi_opa and pi_opb;
        end process;
end architecture and_alu_arch;