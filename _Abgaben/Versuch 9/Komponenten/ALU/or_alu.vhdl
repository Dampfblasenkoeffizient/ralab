-- Paul Riedel
library ieee;
use ieee.std_logic_1164.all;

entity or_alu is generic(DATA_WIDTH_GEN : integer);
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
    );
end or_alu;

architecture or_alu_arch of or_alu is
    begin
        process(pi_opa, pi_opb)
        begin
            po_out <= pi_opa or pi_opb;
        end process;
end architecture or_alu_arch;