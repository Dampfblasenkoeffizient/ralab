-- Paul Riedel
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sra_alu is generic(DATA_WIDTH_GEN : integer);
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
    );
end sra_alu;
 
architecture sra_alu_arch of sra_alu is
    begin
        process(pi_opa, pi_opb)
        variable v_opb : integer;
        variable v_sign : std_logic;
        begin
            v_opb := to_integer(unsigned(pi_opb));
            v_sign := pi_opa(DATA_WIDTH_GEN - 1);
            for i in 0 to DATA_WIDTH_GEN - 2 loop
                if i > DATA_WIDTH_GEN - v_opb - 2 then
                    po_out(i) <= v_sign;
                else
                    po_out(i) <= pi_opa(i + v_opb);
                end if;
            end loop;
            po_out(DATA_WIDTH_GEN - 1) <= v_sign;
        end process;
end architecture sra_alu_arch;