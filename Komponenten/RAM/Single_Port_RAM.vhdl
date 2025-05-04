-- Clara Heilig
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constant_package.all;



entity Single_Port_RAM is
    port(
        pi_clk : in std_logic;
        pi_rst : in std_logic;
        pi_add : in std_logic_vector (reg_adr_width -1 downto 0);
        pi_we : in std_logic;
        pi_data : in std_logic_vector(word_width -1 downto 0);
        po_data : out std_logic_vector(word_width -1 downto 0)
    );
end entity;    

architecture behavior of Single_Port_RAM is
    type memory is array (0 to 3) of std_logic_vector (7 downto 0);
    signal regs : memory := (others => (others => '0'));
    
    begin
        process(pi_clk, pi_rst, pi_we)
        variable add : integer := integer(unsigned(pi_add));

            begin 
            if pi_rst = '1' then 
                    regs <= (others => (others => '0'));
            else 
                if rising_edge(pi_clk) then 
                    if pi_we = '1' then 
                        regs(add) <= pi_data;
                    end if;            
                end if;            
            end if; 
            po_data <= regs (add);
        end process;
    
end behavior;