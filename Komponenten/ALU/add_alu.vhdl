library ieee;
use ieee.std_logic_1164.all;

entity add_alu is generic(DATA_WIDTH_GEN : integer);
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_carry     : out  std_logic
    );
end add_alu;
 
architecture add_alu_arch of add_alu is

    signal s_carry : std_logic_vector(DATA_WIDTH_GEN downto 0);
    begin
        s_carry(0) <= '0';
        add_net : for i in 0 to DATA_WIDTH_GEN - 1 generate
           adder : entity work.fadd port map (pi_opa(i), pi_opb(i), s_carry(i), po_out(i), s_carry(i + 1));
        end generate;
        po_carry <= s_carry(DATA_WIDTH_GEN);
end architecture add_alu_arch;
