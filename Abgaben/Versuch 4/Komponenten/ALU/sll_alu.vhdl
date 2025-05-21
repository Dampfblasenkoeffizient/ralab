-- Paul Riedel
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sll_alu is generic(DATA_WIDTH_GEN : integer);
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
    );
end sll_alu;
 
architecture sll_alu_arch of sll_alu is
    begin
        process(pi_opa, pi_opb)
        variable v_opb : integer;
        begin
            v_opb := to_integer(unsigned(pi_opb));
            for i in 0 to DATA_WIDTH_GEN - 1 loop
                if i < v_opb then
                    po_out(i) <= '0';
                else
                    po_out(i) <= pi_opa(i - v_opb);
                end if;
            end loop;
        end process;
end architecture sll_alu_arch;