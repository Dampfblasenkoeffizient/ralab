library ieee;
use ieee.std_logic_1164.all;

entity PipelineRegister_tb is 
    type IntArray is array (0 to 4) of integer; -- Array of 8 integers
end PipelineRegister_tb;


architecture behavior of PipelineRegister_tb is
    constant REGISTERWIDTH_PRESETS : IntArray := (5,6,8,16,32);


    begin
    test_register : for i in 0 to 4 generate
        signal v_clk, v_rst : std_logic;
        signal v_i_data, v_o_data : std_logic_vector (REGISTERWIDTH_PRESETS(i) - 1 downto 0);
        begin
    
            variable_testr : entity work.PipelineRegister generic map(REGISTERWIDTH_PRESETS(i)) port map (v_clk, v_rst, v_i_data, v_o_data);

            process
            begin
                report "test " & integer'image(REGISTERWIDTH_PRESETS(i)) & "bit pipeline register start";
                v_rst <= '1';
                v_clk <= '1';
                wait for 20 ns;

                v_rst <= '0';
                v_clk <= '0';
                wait for 20 ns;

                v_i_data <= (others => '0');
                v_clk <= '1';
                wait for 20 ns;
                assert v_o_data = v_i_data
                report "Register output with width " & integer'image(REGISTERWIDTH_PRESETS(i)) & "does not match input";
                v_clk <= '0';

                wait for 20 ns;

                v_i_data <= (others => '0');
                v_clk <= '1';
                wait for 20 ns;
                assert v_o_data = v_i_data
                report "Register output with width " & integer'image(REGISTERWIDTH_PRESETS(i)) & "does not match input";

                report "test " & integer'image(REGISTERWIDTH_PRESETS(i)) & "bit pipeline register success";
                wait; 
            end process;
        end generate;

end behavior;    