-- Clara Heilig
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
--use work.constant_package.all;
--use work.types_package.all

-- adr_width auf 16 statt 32. oder wollen die generic?

entity Single_Port_RAM is
    generic(
        word_width : integer := 16;
        adr_width : integer := 32
    );
    port(
        pi_clk : in std_logic;
        pi_rst : in std_logic;
        pi_add : in std_logic_vector (0 to adr_width -1); 
        pi_we : in std_logic;
        pi_data : in std_logic_vector(word_width -1 downto 0);
        po_data : out std_logic_vector(word_width -1 downto 0)
    );
end entity;    

architecture behavior of Single_Port_RAM is
    type memory is array (0 to 2 ** adr_width - 1) of std_logic_vector (WORD_WIDTH -1 downto 0);
    signal regs : memory := (others => (others => '0'));
    
    begin
        process(pi_clk, pi_rst, pi_we)
            begin 
            if pi_rst = '1' then 
                    regs <= (others => (others => '0'));
            else 
                if rising_edge(pi_clk) then 
                po_data <= regs (to_integer(unsigned(pi_add)));
                    if pi_we = '1' then 
                        regs(to_integer(unsigned(pi_add))) <= pi_data;
                        po_data <= pi_data;
                    end if;            
                end if;            
            end if; 
        end process;
    
end behavior;