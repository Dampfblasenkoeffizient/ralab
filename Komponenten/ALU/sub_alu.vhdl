library ieee;
use ieee.std_logic_1164.all;

entity sub_alu is generic(DATA_WIDTH_GEN : integer);
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_carry     : out  std_logic
    );
end sub_alu;
 
architecture sub_alu_arch of sub_alu is
    signal s_carry : std_logic_vector(DATA_WIDTH_GEN downto 0);
    signal s_nopb : std_logic_vector(DATA_WIDTH_GEN -1 downto 0);
    begin
        s_carry(0) <= '1';
        sub_net : for i in 0 to DATA_WIDTH_GEN - 1 generate
            s_nopb <= not(pi_opb);
            subber : entity work.fadd port map (pi_opa(i), s_nopb(i), s_carry(i), po_out(i), s_carry(i + 1));
        end generate;
        po_carry <= s_carry(DATA_WIDTH_GEN);
end architecture sub_alu_arch;
