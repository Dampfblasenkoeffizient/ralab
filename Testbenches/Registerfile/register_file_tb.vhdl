-- Laboratory RA solutions/versuch2
-- Sommersemester 25
-- Group Details
-- Lab Date:
-- 1. Participant First and Last Name: 
-- 2. Participant First and Last Name:

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;
    use work.constant_package.all;

entity register_file_tb is
end entity register_file_tb;

architecture behavior of register_file_tb is
    type int_vec is array (1 downto 0) of integer;
    constant WORD_WIDTH_PRESETS : int_vec := (16,32);
    constant ADDRESS_WIDTH : integer := 4;

begin

    test_instances : for i in 0 to 1 generate
        signal v_clk, v_rst, v_writeEnable : std_logic;
        signal v_readRegAddr1, v_readRegAddr2, v_writeRegAddr : std_logic_vector ((ADDRESS_WIDTH -1) downto 0);
        signal v_writeRegData, v_out_readRegData1, v_out_readRegData2 : std_logic_vector (WORD_WIDTH_PRESETS(i) - 1 downto 0);
        begin
            register_file_inst : entity work.register_file generic map(WORD_WIDTH_PRESETS(i), ADDRESS_WIDTH) port map(
                v_clk, 
                v_rst, 
                v_writeEnable, 
                v_writeRegData, 
                v_readRegAddr1, 
                v_readRegAddr2, 
                v_writeRegAddr,
                v_out_readRegData1, 
                v_out_readRegData2
                );
            process
                variable v_test_value1 : std_logic_vector(WORD_WIDTH_PRESETS(i) - 1 downto 0) := (5 downto 0 => '1', others => '0');
                variable v_test_value2 : std_logic_vector(WORD_WIDTH_PRESETS(i) - 1 downto 0) := (7 downto 0 => '1', others => '0');
                variable v_zeros : std_logic_vector(WORD_WIDTH_PRESETS(i) - 1 downto 0) := (others => '0');
            begin
            -- init

                report "starting test";

                v_clk <= '0';
                v_rst <= '1';
                v_writeEnable <= '1';
                wait for 1 ns;

            -- load test values

                v_writeRegAddr <= "0010";
                v_writeRegData <= v_test_value1;
                v_clk <= '1';
                wait for 1 ns;
                v_clk <= '0';
                wait for 1 ns;
                v_writeRegAddr <= "0011";
                v_writeRegData <= v_test_value2;
                v_clk <= '1';
                wait for 1 ns;
                v_clk <= '0';
                v_writeEnable <= '0';
                wait for 1 ns;

            -- test output values

                v_readRegAddr1 <= "0010";
                v_readRegAddr2 <= "0011";
                v_clk <= '1';    
                wait for 1 ns;
                assert v_out_readRegData1 = v_test_value1 and v_out_readRegData2 = v_test_value2
                report "test values where not retrieved correctly"
                severity error;
                v_clk <= '0';
                wait for 1 ns;

            -- test same address access

                v_readRegAddr1 <= "0010";
                v_readRegAddr2 <= "0010";
                v_clk <= '1';    
                wait for 1 ns;
                assert v_out_readRegData1 = v_test_value1 and v_out_readRegData2 = v_test_value1
                report "test values where not retrieved correctly when read addresses are the same"
                severity error;
                v_clk <= '0';
                wait for 1 ns;

            -- test reset

                v_rst <= '1';    
                wait for 1 ns;
                assert v_out_readRegData1 = v_zeros and v_out_readRegData2 = v_zeros
                report "reset does not work"
                severity error;

            -- test write without write enable

                v_writeRegAddr <= "0010";
                v_writeRegData <= v_test_value1;
                v_clk <= '1';
                wait for 1 ns;
                v_clk <= '0'; 
                v_readRegAddr1 <= "0010";
                wait for 1 ns;
                v_clk <= '1';
                assert v_out_readRegData1 = v_zeros
                report "write works without write enable"
                severity error;   

                report "test finished";
                wait;

            end process;
    end generate;

end architecture behavior;