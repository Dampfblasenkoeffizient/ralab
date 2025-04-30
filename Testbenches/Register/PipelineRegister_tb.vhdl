-- by Paul Riedel

library ieee;
use ieee.std_logic_1164.all;

entity PipelineRegister_tb is 
    type IntArray is array (0 to 4) of integer; -- Array of 8 integers
end PipelineRegister_tb;


architecture behavior of PipelineRegister_tb is
    constant REGISTERWIDTH_PRESETS : IntArray := (5,6,8,16,32);


    begin
    test_register : for i in 0 to 4 generate
        signal s_clk, s_rst : std_logic;
        signal s_i_data, s_o_data : std_logic_vector (REGISTERWIDTH_PRESETS(i) - 1 downto 0);
        constant s_zero : std_logic_vector (REGISTERWIDTH_PRESETS(i) - 1 downto 0) := (others => '0');
        begin
    
            variable_testr : entity work.PipelineRegister generic map(REGISTERWIDTH_PRESETS(i)) port map (s_clk, s_rst, s_i_data, s_o_data);

            process
            begin
                report "test " & integer'image(REGISTERWIDTH_PRESETS(i)) & "bit pipeline register start";

                -- initialize
                s_i_data <= s_zero;
                s_rst <= '1';
                s_clk <= '1';
                wait for 20 ns;

                s_rst <= '0';
                s_clk <= '0';
                wait for 20 ns;

                -- load all zeros

                s_i_data <= (others => '0');
                s_clk <= '1';
                wait for 20 ns;
                assert s_o_data = s_i_data
                report "Register output with width " & integer'image(REGISTERWIDTH_PRESETS(i)) & "does not match input"
                severity error;
                s_clk <= '0';

                wait for 20 ns;

                -- load all 1

                s_i_data <= (others => '1');
                s_clk <= '1';
                wait for 20 ns;
                assert s_o_data = s_i_data
                report "Register output with width " & integer'image(REGISTERWIDTH_PRESETS(i)) & "does not match input"
                severity error;

                s_rst <= '1';
                wait for 20 ns;
                assert s_o_data = s_zero
                report "Register output with width " & integer'image(REGISTERWIDTH_PRESETS(i)) & "does not reset"
                severity error;

                
                s_clk <= '0';
                wait for 20 ns;
                s_clk <= '1';
                wait for 20 ns;
                assert s_o_data = s_zero
                report "Register output with width " & integer'image(REGISTERWIDTH_PRESETS(i)) & "does not stay reset"
                severity error;
                -- test completed

                report "test done";
                wait; 
            end process;
        end generate;

end behavior;    