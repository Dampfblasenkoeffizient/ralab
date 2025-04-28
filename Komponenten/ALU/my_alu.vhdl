library ieee;
use ieee.std_logic_1164.all;

--use work.constant_package.all;


entity my_alu is generic(
        DATA_WIDTH_GEN : integer := 32; -- Default data width
        ALU_OPCODE_WIDTH : integer := 4  -- Default opcode width
    ); 
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opcode    : in  std_logic_vector(ALU_OPCODE_WIDTH - 1 downto 0);
        po_result       : out std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
    );
end my_alu;

architecture my_alu_arch of my_alu is
    component and_alu
        port(
            pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
            pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
            po_out       : out std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
        );
    end component;
    component or_alu
        port(
            pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
            pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
            po_out       : out std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
        );
    end component;
    component xor_alu
        port(
            pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
            pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
            po_out       : out std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
        );
    end component;

    signal and_result : std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
    signal or_result  : std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
    signal xor_result : std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
    
    begin

    and_alu_inst : and_alu
        port map(
            pi_opa => pi_opa,
            pi_opb => pi_opb,
            po_out => and_result
        );
        
    or_alu_inst : or_alu
        port map(
            pi_opa => pi_opa,
            pi_opb => pi_opb,
            po_out => or_result
        );

    xor_alu_inst : xor_alu
        port map(
            pi_opa => pi_opa,
            pi_opb => pi_opb,
            po_out => xor_result
        );


        process(pi_opa, pi_opb, pi_opcode)
        variable v_opcode : std_logic_vector(ALU_OPCODE_WIDTH - 1 downto 0);
        begin
            v_opcode := pi_opcode(ALU_OPCODE_WIDTH - 1 downto 0);
            case pi_opcode is 
                when AND_ALU_OP => po_result <= and_result;
                when OR_ALU_OP  => po_result <= or_result;
                when XOR_ALU_OP => po_result <= xor_result;
                when others     => po_result <= (others => '0');
            end case;
        end process;
end architecture my_alu_arch;
    