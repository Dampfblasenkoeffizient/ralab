library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constant_package.all;

entity sltu_alu is generic(DATA_WIDTH_GEN : integer);
    port(
        pi_opa : in std_logic_vector(DATA_WIDTH_GEN -1 downto 0);
        pi_opb : in std_logic_vector(DATA_WIDTH_GEN -1 downto 0);
        po_op : out std_logic_vector(DATA_WIDTH_GEN -1 downto 0)
    );
end entity;    

architecture behav of sltu_alu is
begin
    po_op <= 
        resize(signed(1, DATA_WIDTH_GEN)) when to_integer(unsigned(pi_opa)) < to_integer(unsigned(pi_opb))
        else resize(signed(0, DATA_WIDTH_GEN));
end behav;    