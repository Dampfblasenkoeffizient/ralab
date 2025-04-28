library ieee;
use ieee.std_logic_1164.all;

entity srl_alu is generic(DATA_WIDTH_GEN : integer);
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
    );
end srl_alu;
 
architecture srl_alu_arch of srl_alu is
    begin
        process(pi_opa, pi_opb)
        begin
            for i in 0 to DATA_WIDTH_GEN - 1 loop
                if i > DATA_WIDTH_GEN - pi_opb then
                    po_out(i) <= 0;
                else
                    po_out(i) <= pi_opa(i +  pi_opb);
                end if;
            end loop;
        end process;
end architecture srl_alu_arch;