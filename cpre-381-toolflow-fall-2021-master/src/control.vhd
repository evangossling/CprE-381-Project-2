-------------------------------------------------------------------------
-- Theodore Thayib
-- 
-- Iowa State University
-------------------------------------------------------------------------
-- control.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file describes control logic
-------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY control IS
    PORT (
        opcode : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        funct : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        RegDst : OUT STD_LOGIC;
        RegData : OUT STD_LOGIC;
	JalReg : OUT STD_LOGIC;
        Jump : OUT STD_LOGIC;
	JumpReg : OUT STD_LOGIC;
        Branch : OUT STD_LOGIC;
        MemRead : OUT STD_LOGIC;
        MemtoReg : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        ALUOp : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        MemWrite : OUT STD_LOGIC;
        ALUsrc : OUT STD_LOGIC;
        RegWrite : OUT STD_LOGIC;
        SignExtend : OUT STD_LOGIC;
	halt : OUT STD_LOGIC
    );
END control;

ARCHITECTURE structural OF control IS

    component mux2t1_N is
    generic(N : integer := 32);
    port(i_S          : IN std_logic;
         i_D0         : IN std_logic_vector(N-1 downto 0);
         i_D1         : IN std_logic_vector(N-1 downto 0);
         o_O          : OUT std_logic_vector(N-1 downto 0));
	end component;

    component mux2t1 is
	port(i_S          : IN std_logic;
		i_D0          : IN std_logic;
		i_D1          : IN std_logic;
		o_O           : OUT std_logic);
	  end component;

    SIGNAL s_rtype : STD_LOGIC;
    SIGNAL s_aluop_r : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_aluop_i : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_alusrc_r : STD_LOGIC;
    SIGNAL s_alusrc_i : STD_LOGIC;
    SIGNAL s_alusrcb_i : STD_LOGIC;
    SIGNAL s_alusrcb_r : STD_LOGIC;
    SIGNAL s_halt : STD_LOGIC;
    SIGNAL s_jumpR : STD_LOGIC;
    SIGNAL s_jump : STD_LOGIC;
    SIGNAL s_jal : STD_LOGIC;
    SIGNAL s_RegWrTemp1 : STD_LOGIC;
    SIGNAL s_RegWrTemp2 : STD_LOGIC;

BEGIN
    s_rtype <= (NOT (opcode(5) OR opcode(4) OR opcode(3) OR opcode(2) OR opcode(1) OR opcode(0))) OR ((NOT opcode(5)) AND opcode(4) AND opcode(3) AND opcode(2) AND opcode(1) AND opcode(0));

    WITH funct SELECT
    s_aluop_r <= "00000" WHEN "100000", -- add
    "00010" WHEN "100001", -- addu
    "00001" WHEN "100010", -- sub
    "00011" WHEN "100011", -- subu
    "00100" WHEN "000010", -- srl
    "00101" WHEN "000000", -- sll
    "00110" WHEN "000011", -- sra
    "01000" WHEN "100100", -- and
    "01001" WHEN "100101", -- or
    "01011" WHEN "100110", -- xor 
    "01010" WHEN "100111", -- nor
    "01101" WHEN "101010", -- slt
    "01111" WHEN "101011", -- sltu
    "01110" when "010010", -- repl.qb
    "00000" WHEN OTHERS;

    WITH opcode SELECT
    s_aluop_i <= "00000" WHEN "001000", -- addi
    "00010" WHEN "001001", -- addiu
    "01000" WHEN "001100", -- andi
    "01001" WHEN "001101", -- ori
    "01011" WHEN "001110", -- xori
    "01101" WHEN "001010", -- slti
    "01111" WHEN "001011", -- sltiu
    "11001" WHEN "000100", -- beq
    "11101" WHEN "000101", -- bne
    "00111" when "001111", -- lui
    "00000" WHEN OTHERS;
	
	with opcode select
	s_halt <= '1' when "010100",
	'0' when others;
	
	halt <= s_halt;

    g_mux_aluop : mux2t1_N 
        generic map(N => 5)
        PORT MAP(i_S  => s_rtype, 
                 i_D0 => s_aluop_i, 
                 i_D1 => s_aluop_r, 
                 o_O  => ALUOp);

    RegDst <= s_rtype; -- All R-type

    s_jumpR <= s_rtype AND (NOT funct(5) AND (NOT funct(4)) AND funct(3) AND (NOT funct(2)) AND (NOT funct(1)) AND (NOT funct(0))); -- jr
    
    WITH opcode SELECT
    s_jump <= '1' WHEN "000010", -- j
    '1' WHEN "000011", -- jal
    '0' WHEN OTHERS;

    Jump <= s_jump OR s_jumpR; -- j-type

    JumpReg <= s_jumpR; -- jr

    WITH opcode SELECT
    s_jal <= '1' WHEN "000011",  --jal
    '0' WHEN OTHERS;

    JalReg <= s_jal;

    RegData <= s_jal;
    
    WITH opcode SELECT
    Branch <= '1' WHEN "000100", -- beq
    '1' WHEN "000101", -- bne
    '0' WHEN OTHERS;

    WITH opcode SELECT
    MemRead <= '1' WHEN "100011", -- lw
    '0' WHEN OTHERS;

    WITH opcode SELECT
    MemtoReg <= "01" WHEN "100011", -- lw
    "10" WHEN "000011", -- jal
    "00" WHEN OTHERS;

    WITH opcode SELECT
    MemWrite <= '1' WHEN "101011", -- sw
    '0' WHEN OTHERS;

    WITH funct(5 DOWNTO 2) SELECT
    s_alusrcb_r <= '0' WHEN "0000", -- shift
    '0' WHEN OTHERS;

    WITH opcode SELECT
    s_alusrcb_i <= '1' WHEN "001000", -- addi
    '1' WHEN "001001", -- addiu
    '1' WHEN "001010", -- slti
    '1' WHEN "001100", -- andi
    '1' WHEN "001101", -- ori
    '1' WHEN "001011", -- sltiu
    '1' WHEN "001110", -- xori
    '1' WHEN "001111", -- lui
    '1' WHEN "100011", -- lw
    '1' WHEN "101011", -- sw
    '0' WHEN OTHERS;

    g_mux_alusrc : mux2t1 
      PORT MAP(i_S => s_rtype, 
              i_D0 => s_alusrcb_i, 
              i_D1 => s_alusrcb_r, 
               o_O => ALUsrc);

    WITH opcode SELECT
    s_RegWrTemp1 <= '1' WHEN "000000", -- R-type
    '1' WHEN "001000", -- addi
    '1' WHEN "001001", -- addiu
    '1' WHEN "001010", -- slti
    '1' WHEN "001100", -- andi
    '1' WHEN "001101", -- ori
    '1' WHEN "001011", -- sltiu
    '1' WHEN "001110", -- xori
    '1' WHEN "001111", -- lui
    '1' WHEN "100011", -- lw
    '1' WHEN "000011", -- jal
    '1' when "011111", -- repl.qb
    '0' WHEN OTHERS;

    WITH s_jumpR SELECT
    s_RegWrTemp2 <= '0' WHEN '1',
    '1' WHEN OTHERS;

process(s_jumpR, s_RegWrTemp1, s_RegWrTemp2)
begin
    if s_jumpR = '1' then
	RegWrite <= s_RegWrTemp2;
    else
	RegWrite <= s_RegWrTemp1;
    end if;
end process;

    WITH opcode SELECT
    SignExtend <= '0' WHEN "001100", -- andi
    '0' WHEN "001101", -- ori
    '0' WHEN "001110", -- xori
    '1' WHEN OTHERS;
END structural;
