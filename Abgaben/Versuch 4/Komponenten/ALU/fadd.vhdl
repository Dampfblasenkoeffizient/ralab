-- Paul Riedel
library ieee;
use ieee.std_logic_1164.all;

entity fadd is 
    port(
        pi_opa       : in  std_logic;
        pi_opb       : in  std_logic;
        pi_cin       : in  std_logic;
        po_out       : out  std_logic;
        po_carry     : out  std_logic
    );
end fadd;

architecture fadd_arch of fadd is
    begin
        po_out <= pi_opa xor pi_opb xor pi_cin;
        po_carry <= (pi_opa and pi_opb) or (pi_opb and pi_cin) or (pi_cin and pi_opa);
end architecture fadd_arch;