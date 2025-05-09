-- Laboratory RA solutions/versuch3
-- Sommersemester 25
-- Group Details
-- Lab Date:
-- 1. Participant First and Last Name: 
-- 2. Participant First and Last Name:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Constant_package.all;
use work.types.all;

entity decoder is
    generic (
        G_WORD_WIDTH : integer := 32
    );
    port(
        pi_clk : in std_logic;
        pi_instruction : in std_logic_vector(G_WORD_WIDTH - 1 downto 0);
        po_controlWord : out controlword := control_word_init
    );
end entity decoder;

architecture arc of decoder is
    begin
        process(pi_instruction, pi_clk)
            variable opcode : std_logic_vector(OPCODE_WIDTH - 1 downto 0);
            variable funct3 : std_logic_vector(2 downto 0);
            variable funct7 : std_logic_vector(6 downto 0);
        begin
            if rising_edge(pi_clk) then
                opcode := pi_instruction(6 downto 0);
                funct3 := pi_instruction(14 downto 12);
                funct7 := pi_instruction(31 downto 25);

                -- decoding the opcode component of the incomming instruction

                case opcode is
                    when R_INS_OP => 
                        -- register operations (r_type) set the alu_opcode based on the operation (func3) and the selector bit (func7(1))
                        -- the immediate select bit of the alu input mux is cleared since both inputs are registers
                        po_controlWord.ALU_OP <= funct7(5) & funct3;
                        po_controlWord.I_IMM_SEL <= '0';
                    when I_INS_OP =>
                        
                    when L_INS_OP =>
                        
                    when S_INS_OP =>
                        
                    when B_INS_OP =>
                        
                    when JAL_INS_OP =>
                        
                    when JALR_INS_OP =>
                        
                    when LUI_INS_OP =>
                        
                    when AUIPC_INS_OP =>

                    when others =>
                        po_controlWord <= control_word_init;
                end case;
            end if;
        end process;
end architecture;