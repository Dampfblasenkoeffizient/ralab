-- Laboratory RA solutions/versuch8
-- Sommersemester 25
-- Group Details
-- Lab Date: 02.07.2025
-- 1. Participant First and Last Name: Clara Heilig
-- 2. Participant First and Last Name: Paul Riedel

-- ========================================================================
-- Author:       Marcel Rieß
-- Last updated: 04.06.2025
-- Description:  RUI-Only-RISC-V for an incomplete RV32I implementation, 
--               support only R/I/U-Instructions. 
-- ========================================================================

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use work.constant_package.all;
  use work.types.all;

entity riubs_bp_only_RISC_V is
  port (
    pi_rst         : in    std_logic;
    pi_clk         : in    std_logic;
    pi_instruction : in    memory := (others => (others => '0'));
    po_registersOut : out   registerMemory := (others => (others => '0'));
    po_debugdatamemory : out memory :=(others => (others => '0'))
  );
end entity riubs_bp_only_RISC_V;

architecture structure of riubs_bp_only_RISC_V is

  constant PERIOD                : time                                            := 10 ns;
  constant ADD_FOUR_TO_ADDRESS   : std_logic_vector(WORD_WIDTH - 1 downto 0)       := std_logic_vector(to_signed((4), WORD_WIDTH));
  -- signals
  signal n_clk : std_logic := '0';
  signal flush : std_logic := '0';

  -- PC
  signal pc_data_in, pc_adder_out : std_logic_vector(WORD_WIDTH - 1 downto 0) := (others => '0');
  signal pc_data_out : std_logic_vector(WORD_WIDTH - 1 downto 0) := (others => '0');
  -- Instruction Register
  signal ir_data_in : std_logic_vector(WORD_WIDTH - 1 downto 0) := (others => '0');
  signal ir_data_out : std_logic_vector(WORD_WIDTH - 1 downto 0) := (others => '0');
  -- Decode
  signal funct7 : std_logic_vector(6 downto 0) := (others => '0');
  signal funct3 : std_logic_vector(2 downto 0) := (others => '0');
  signal t, s, d : std_logic_vector(REG_ADR_WIDTH - 1 downto 0) := (others => '0');
  signal opcode : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := (others => '0');
  signal controlWord_in : controlword := control_word_init;
  signal controlWord_decode : controlword := control_word_init;
  signal t_decode, s_decode : std_logic_vector(WORD_WIDTH - 1 downto 0) := (others => '0');
  signal pc_decode, immediate, immediateImm, unsignedImm, jumpImm, branchImm, storeImm : std_logic_vector(WORD_WIDTH - 1 downto 0) := (others => '0');
  -- Execute
  signal controlWord_exec : controlword := control_word_init;
  signal d_execute : std_logic_vector(REG_ADR_WIDTH - 1 downto 0) := (others => '0');
  signal alu_opcode : std_logic_vector(ALU_OPCODE_WIDTH - 1 downto 0) := (others => '0');
  signal t_execute, s_execute : std_logic_vector(WORD_WIDTH - 1 downto 0) := (others => '0');
  signal s_ALUopa, s_ALUopb, opa, opb : std_logic_vector(WORD_WIDTH - 1 downto 0) := (others => '0');
  signal pc_execute, pc_plus4, alu_out, pc_branch : std_logic_vector(WORD_WIDTH - 1 downto 0) := (others => '0');
  signal immediate_exec : std_logic_vector(WORD_WIDTH - 1 downto 0) := (others => '0');
  signal alu_zero, b_sel : std_logic := '0';
  -- mem
  signal controlWord_mem : controlword := control_word_init;
  signal d_mem : std_logic_vector(REG_ADR_WIDTH - 1 downto 0) := (others => '0');
  signal s_aluOutMEM, wb_out_mem, immediate_mem, pc_plus4_mem, pc_branch_mem, t_mem, s_readdataMEM : std_logic_vector (WORD_WIDTH - 1 downto 0) := (others => '0');
  signal b_sel_mem : std_logic := '0';
  -- WB
  signal controlWord_wb : controlword := control_word_init;
  signal d_wb : std_logic_vector(REG_ADR_WIDTH - 1 downto 0) := (others => '0'); 
  signal alu_out_wb, immediate_wb, pc_plus4_wb, wb_mux_out, mem_out_wb : std_logic_vector (WORD_WIDTH - 1 downto 0) := (others => '0'); 

  -- debug

  signal s_byp_rs1_sel, s_byp_rs2_sel : std_logic_vector (1 downto 0) := (others => '0');
  signal s_rs1_AdrID, s_rs2_AdrID, s_dAdrEX, s_dAdrMEM, s_dAdrWB : std_logic_vector (REG_ADR_WIDTH -1 downto 0) := (others => '0');

  signal s_byp_rs1_MEM, s_byp_rs2_MEM : std_logic_vector (WORD_WIDTH -1 downto 0) := (others => '0');

  signal s_byp_rs1_EX, s_byp_rs1_WB, s_byp_rs2_EX, s_byp_rs2_WB : std_logic_vector(WORD_WIDTH -1 downto 0) := (others => '0');

  -- begin solution:
  -- end solution!!
begin


  n_clk <= not pi_clk;
  flush <= b_sel_mem OR pi_rst OR controlWord_mem.PC_SEL;

---********************************************************************
---* program counter adder and pc-register
---********************************************************************
-- begin solution:  

  pc_select_mux : entity work.fourWayMux
  port map(
    pi_sel => (controlWord_mem.PC_SEL & b_sel_mem),
    pi_0 => pc_adder_out,
    pi_1 => pc_branch_mem,
    pi_2 => s_aluOutMEM,
    po => pc_data_in
  );

  pc_adder : entity work.add_alu generic map(WORD_WIDTH)
  port map(
    pi_opa => pc_data_out,
    pi_opb => ADD_FOUR_TO_ADDRESS,
    po_out => pc_adder_out
  );

  pc_register : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_data => pc_data_in,
    po_data => pc_data_out
  );
-- end solution!!


---********************************************************************
---* instruction fetch 
---********************************************************************
-- begin solution:  
  instruction_cache_inst : entity work.instruction_cache generic map(ADR_WIDTH)
  port map(
    pi_adr => pc_data_out,
    pi_clk => n_clk,
    pi_rst => pi_rst,
    pi_instructionCache => pi_instruction,
    po_instruction => ir_data_in
  );
-- end solution!!

---********************************************************************
---* Pipeline-Register (IF -> ID) start
---********************************************************************
-- begin solution:
  instruction_register : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => flush,
    pi_data => ir_data_in,
    po_data => ir_data_out
  );

  IF_register_PC : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => flush,
    pi_data => pc_data_out,
    po_data => pc_decode
  );
-- end solution!!


---********************************************************************
---* decode phase
---********************************************************************
-- begin solution:
  funct7 <= ir_data_out(31 downto 25);
  t <= ir_data_out(24 downto 20);
  s <= ir_data_out(19 downto 15);
  funct3 <= ir_data_out(14 downto 12);
  d <= ir_data_out(11 downto 7);
  opcode <= ir_data_out(6 downto 0);

  s_rs1_AdrID <= s;
  s_byp_rs1_sel <= "01" when (s_rs1_AdrID = s_dAdrEX) else
                   "10" when (s_rs1_AdrID = s_dAdrMEM) else
                   "11" when (s_rs1_AdrID = s_dAdrWB) else
                   "00";

  s_byp_rs1_MEM <= s_readdataMEM when (s_rs1_AdrID = s_dAdrMEM) and (controlWord_mem.MEM_READ = '1')          
                   else s_aluOutMEM;      

  s_rs2_AdrID <= t;
  s_byp_rs2_sel <= "01" when (s_rs2_AdrID = s_dAdrEX) else
                   "10" when (s_rs2_AdrID = s_dAdrMEM) else
                   "11" when (s_rs2_AdrID = s_dAdrWB) else
                   "00";

  s_byp_rs2_MEM <= s_readdataMEM when (s_rs2_AdrID = s_dAdrMEM) and (controlWord_mem.MEM_READ = '1')          
                   else s_aluOutMEM;               

  decoder_inst : entity work.decoder generic map(WORD_WIDTH)
  port map(
    pi_instruction => ir_data_out,
    po_controlWord => controlWord_decode
  );

  signextender_inst : entity work.signExtension
  port map(
    pi_instr => ir_data_out,
    po_immediateImm => immediateImm,
    po_unsignedImm => unsignedImm,
    po_jumpImm => jumpImm,
    po_branchImm => branchImm,
    po_storeImm => storeImm
  );

  immediate <=  immediateImm when opcode = I_INS_OP  or opcode = JALR_INS_OP else
                unsignedImm when opcode = LUI_INS_OP or opcode = AUIPC_INS_OP else
                jumpImm when opcode = JAL_INS_OP else
                branchImm when opcode = B_INS_OP else
                storeImm when opcode = S_INS_OP;


-- end solution!!


---********************************************************************
---* Pipeline-Register (ID -> EX) 
---********************************************************************
-- begin solution: 
  execute_register_cw : entity work.ControlWordRegister
  port map(
    pi_clk => pi_clk,
    pi_rst => flush,
    pi_controlWord => controlWord_decode,
    po_controlWord => controlWord_exec
  );

  execute_register_d : entity work.PipelineRegister generic map(REG_ADR_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => flush,
    pi_data => d,
    po_data => d_execute
  );

  execute_register_t_alu : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => flush,
    pi_data => t_decode,
    po_data => t_execute
  );

  execute_register_s_alu : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => flush,
    pi_data => s_decode,
    po_data => s_execute
  );

  execute_register_immediateImm : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => flush,
    pi_data => immediate,
    po_data => immediate_exec
  );

  execute_register_pc : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => flush,
    pi_data => pc_decode,
    po_data => pc_execute
  );
-- end solution!!


---********************************************************************
---* execute phase
---********************************************************************
 -- begin solution:
  execute_pcp4_adder : entity work.add_alu generic map(WORD_WIDTH)
  port map(
    pi_opa => pc_execute,
    pi_opb => ADD_FOUR_TO_ADDRESS,
    po_out => pc_plus4
  );

  branch_address_adder : entity work.add_alu generic map(WORD_WIDTH)
  port map(
    pi_opa => immediate_exec,
    pi_opb => pc_execute,
    po_out => pc_branch
  );

  mux_alu_oba : entity work.gen_mux generic map(WORD_WIDTH)
  port map(
    pi_sel => controlWord_exec.A_SEL,
    pi_first => s_execute,
    pi_second => pc_execute,
    po_res => opa
  );

  mux_alu_opb : entity work.gen_mux generic map(WORD_WIDTH)
  port map(
    pi_sel => controlWord_exec.I_IMM_SEL,
    pi_first => t_execute,
    pi_second => immediate_exec,
    po_res => opb
  );

  FW_rs1_mux : entity work.fourWayMux generic map(WORD_WIDTH)
  port map(
    pi_sel => s_byp_rs1_sel,
    pi_0 => opa,
    pi_1 => s_byp_rs1_EX,
    pi_2 => s_byp_rs1_MEM,
    pi_3 => s_byp_rs1_WB,
    po => s_ALUopa
  );

  FW_rs2_mux : entity work.fourWayMux generic map(WORD_WIDTH)
  port map(
    pi_sel => s_byp_rs2_sel,
    pi_0 => opb,
    pi_1 => s_byp_rs2_EX,
    pi_2 => s_byp_rs2_MEM,
    pi_3 => s_byp_rs2_WB,
    po => s_ALUopb
  );

  alu : entity work.my_alu generic map(WORD_WIDTH, ALU_OPCODE_WIDTH)
  port map(
    pi_opa => s_ALUopa,
    pi_opb => s_ALUopb,
    pi_opcode => controlWord_exec.ALU_OP,
    po_result => alu_out,
    po_zero => alu_zero
  );
  b_sel <= controlWord_exec.IS_BRANCH AND (alu_zero XOR controlWord_exec.CMP_RESULT);
 -- end solution!!

---********************************************************************
---* Pipeline-Register (EX -> MEM) 
---********************************************************************
-- begin solution:
  mem_register_cw : entity work.ControlWordRegister
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_controlWord => controlWord_exec,
    po_controlWord => controlWord_mem
  );

  mem_register_d : entity work.PipelineRegister generic map(REG_ADR_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_data => d_execute,
    po_data => d_mem
  );

  mem_register_wb_out : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_data => wb_mux_out,
    po_data => wb_out_mem
  );

  mem_register_alu_out : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_data => alu_out,
    po_data => s_aluOutMEM
  );

  mem_register_immediate : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_data => immediate_exec,
    po_data => immediate_mem
  );

  mem_register_pc_plus4 : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_data => pc_plus4,
    po_data => pc_plus4_mem
  );  

  mem_register_pc_branch : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_data => pc_branch,
    po_data => pc_branch_mem
  ); 

  mem_register_b_sel : entity work.PipelineBitRegister
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_data => b_sel,
    po_data => b_sel_mem
  ); 

  mem_register_t : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_data => t_execute,
    po_data => t_mem
  ); 

-- end solution!!

---********************************************************************
---* memory phase
---********************************************************************

  main_memory : entity work.data_memory generic map(ADR_WIDTH)
    port map(
      pi_adr => s_aluOutMEM,
      pi_clk => n_clk,
      pi_rst => pi_rst,
      pi_ctrmem => controlWord_mem.MEM_CTR,
      pi_write => controlWord_mem.MEM_WRITE,
      pi_read => controlWord_mem.MEM_READ,
      pi_writedata => t_mem,
      po_readdata => s_readdataMEM,
      po_debugdatamemory => po_debugdatamemory
    );

---********************************************************************
---* Pipeline-Register (MEM -> WB) 
---********************************************************************
 -- begin solution:
  wb_register_cw : entity work.ControlWordRegister
  port map(
    pi_rst => pi_rst,
    pi_clk => pi_clk,
    pi_controlWord => controlWord_mem,
    po_controlWord => controlWord_wb
  );

  wb_register_d : entity work.PipelineRegister generic map(REG_ADR_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_data => d_mem,
    po_data => d_wb
  );

  wb_register_alu_out : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_data => s_aluOutMEM,
    po_data => alu_out_wb
  );

  wb_register_immediate : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_data => immediate_mem,
    po_data => immediate_wb
  );

  wb_register_pc_plus4 : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_data => pc_plus4_mem,
    po_data => pc_plus4_wb
  );  
    
  wb_register_mem_out : entity work.PipelineRegister generic map(WORD_WIDTH)
  port map(
    pi_clk => pi_clk,
    pi_rst => pi_rst,
    pi_data => s_readdataMEM,
    po_data => mem_out_wb
  );  
-- end solution!!

---********************************************************************
---* write back phase
---********************************************************************

  wb_mux : entity work.fourWayMux
    port map(
    pi_sel => controlWord_wb.WB_SEL,
    pi_0 => alu_out_wb,
    pi_1 => immediate_wb,
    pi_2 => pc_plus4_wb,
    pi_3 => mem_out_wb,

    po => wb_mux_out
  );

---********************************************************************
---* register file (negative clock)
---********************************************************************
-- begin solution:
  reg_file : entity work.register_file generic map(WORD_WIDTH, REG_ADR_WIDTH)
  port map(
    pi_clk => n_clk,
    pi_rst => pi_rst,
    pi_writeEnable => controlWord_wb.REG_WRITE,
    pi_writeRegData => wb_mux_out,
    pi_readRegAddr1 => s,
    pi_readRegAddr2 => t,
    pi_writeRegAddr => d_wb,
    po_readRegData1 => s_decode,
    po_readRegData2 => t_decode,
    po_registerOut => po_registersOut
  );
    -- end solution!!
---********************************************************************
---********************************************************************    

end architecture;