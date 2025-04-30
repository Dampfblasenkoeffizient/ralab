library ieee;
use ieee.std_logic_1164.all;

entity gen_mux_tb is 
    type IntArray is array (0 to 4) of integer; -- Array of 8 integers
end;

architecture behavior of gen_mux_tb is
        constant REGISTERWIDTH_PRESETS : IntArray := (5,6,8,16,32);


    begin
    test_mux : for i in 0 to 4 generate
        signal s_sel : std_logic;
        signal s_first, s_second, s_res : std_logic_vector (REGISTERWIDTH_PRESETS(i) - 1 downto 0);
        begin
    
            variable_testr : entity work.gen_mux generic map(REGISTERWIDTH_PRESETS(i)) port map (s_sel, s_first, s_second, s_res);

            process
            begin
                report "test " & integer'image(REGISTERWIDTH_PRESETS(i)) & "bit 2to1 mux start";

                s_sel <= '0';
                s_first <= (others => '0');
                s_second <= (others => '1');
                wait for 20 ns;
                assert (s_res = s_first) and not(s_res = s_second)
                report "Mux output with width " & integer'image(REGISTERWIDTH_PRESETS(i)) & "does not match input1"
                severity error;

                wait for 20 ns;

                s_sel <= '1';
                s_first <= (others => '0');
                s_second <= (others => '1');
                wait for 20 ns;
                assert (s_res = s_second) and not(s_res = s_first)
                report "Mux output with width " & integer'image(REGISTERWIDTH_PRESETS(i)) & "does not match inpu21"
                severity error;

                report "test " & integer'image(REGISTERWIDTH_PRESETS(i)) & "bit 2to1 mux finished successfully";
                wait; 
            end process;
        end generate;

end behavior;   