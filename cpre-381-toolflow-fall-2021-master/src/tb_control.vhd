-------------------------------------------------------------------------
-- Theodore Thayib 
-- 
-- Iowa State University
-------------------------------------------------------------------------
-- tb_control.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the control.vhd
-------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_textio.ALL; -- For logic types I/O
LIBRARY std;
USE std.env.ALL; -- For hierarchical/external signals
USE std.textio.ALL; -- For basic I/O

ENTITY tb_control IS
    GENERIC (gCLK_HPER : TIME := 10 ns);
END tb_control;

ARCHITECTURE mixed OF tb_control IS

    CONSTANT cCLK_PER : TIME := gCLK_HPER * 2;

    COMPONENT control IS
        PORT (
        opcode     : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        funct      : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        RegDst     : OUT STD_LOGIC;
        RegData    : OUT STD_LOGIC;
	JalReg     : OUT STD_LOGIC;
        Jump       : OUT STD_LOGIC;
	JumpReg    : OUT STD_LOGIC;
        Branch     : OUT STD_LOGIC;
        MemRead    : OUT STD_LOGIC;
        MemtoReg   : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        ALUOp      : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        MemWrite   : OUT STD_LOGIC;
        ALUsrc     : OUT STD_LOGIC;
        RegWrite   : OUT STD_LOGIC;
        SignExtend : OUT STD_LOGIC;
	halt       : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL CLK, reset : STD_LOGIC := '0';

    
	SIGNAL s_opcode : STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL s_funct : STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL s_RegDst : STD_LOGIC;
	SIGNAL s_RegData : STD_LOGIC;
	SIGNAL s_JalReg : STD_LOGIC;
	SIGNAL s_Jump : STD_LOGIC;
	SIGNAL s_JumpReg : STD_LOGIC;
	SIGNAL s_Branch : STD_LOGIC;
	SIGNAL s_MemRead : STD_LOGIC;
	SIGNAL s_MemtoReg : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL s_ALUOp : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL s_MemWrite : STD_LOGIC;
	SIGNAL s_ALUsrc : STD_LOGIC;
	SIGNAL s_RegWrite : STD_LOGIC;
	SIGNAL s_SignExtend : STD_LOGIC;
	SIGNAL s_halt : STD_LOGIC;

BEGIN

    -- Component to be tested
    DUT0 : control
    PORT MAP(
		opcode => s_opcode,
		funct => s_funct,
		RegDst => s_RegDst,
		RegData => s_RegData,
		JalReg => s_JalReg,
		Jump => s_Jump,
		JumpReg => s_JumpReg,
		Branch => s_Branch,
		MemRead => s_MemRead,
		MemtoReg => s_MemtoReg,
		ALUOp => s_ALUOp,
		MemWrite => s_MemWrite,
		ALUsrc => s_ALUsrc,
		RegWrite => s_RegWrite,
		SignExtend => s_SignExtend,
		halt => s_halt
    );

    -- Clock
    P_CLK : PROCESS
    BEGIN
        CLK <= '1'; 
        WAIT FOR gCLK_HPER; 
        CLK <= '0'; 
        WAIT FOR gCLK_HPER; 
    END PROCESS;

    -- Reset
    P_RST : PROCESS
    BEGIN
        reset <= '0';
        WAIT FOR gCLK_HPER/2;
        reset <= '1';
        WAIT FOR gCLK_HPER * 2;
        reset <= '0';
        WAIT;
    END PROCESS;

    -- Test Cases
    P_TEST_CASES : PROCESS
    BEGIN
        WAIT FOR cCLK_PER/2;
		
		-----------------------------------------------
        --------------------R type---------------------
        -----------------------------------------------
        s_opcode <= "000000";

        -- sll
        s_funct <= "000000";
        WAIT FOR cCLK_PER;

        -- srl
        s_funct <= "000010";
        WAIT FOR cCLK_PER;

        -- sra
        s_funct <= "000011";
        WAIT FOR cCLK_PER;

        -- jr
        s_funct <= "001000";
        WAIT FOR cCLK_PER;

        -- add
        s_funct <= "100000";
        WAIT FOR cCLK_PER;

        -- addu
        s_funct <= "100001";
        WAIT FOR cCLK_PER;

        -- sub
        s_funct <= "100010";
        WAIT FOR cCLK_PER;

        -- subu
        s_funct <= "100011";
        WAIT FOR cCLK_PER;

        -- and
        s_funct <= "100100";
        WAIT FOR cCLK_PER;

        -- or
        s_funct <= "100101";
        WAIT FOR cCLK_PER;

        -- xor
        s_funct <= "100110";
        WAIT FOR cCLK_PER;

        -- nor
        s_funct <= "100111";
        WAIT FOR cCLK_PER;

        -- slt
        s_funct <= "101010";
	WAIT FOR cCLK_PER;

        -- sltu
        s_funct <= "101011";
        WAIT FOR cCLK_PER;

        -- repl.qb
        s_funct <= "010010";

        WAIT FOR cCLK_PER;

        -----------------------------------------------
        --------------------J type---------------------
        -----------------------------------------------
        s_funct <= "000000";

        -- j
        s_opcode <= "000010";
        WAIT FOR cCLK_PER;

        -- jal
        s_opcode <= "000011";
        WAIT FOR cCLK_PER;

        -----------------------------------------------
        --------------------I type---------------------
        -----------------------------------------------
        s_funct <= "000000";

        -- beq
        s_opcode <= "000100";
        WAIT FOR cCLK_PER;

        -- bne
        s_opcode <= "000101";
        WAIT FOR cCLK_PER;

        -- addi
        s_opcode <= "001000";
        WAIT FOR cCLK_PER;

        -- addiu
        s_opcode <= "001001";
        WAIT FOR cCLK_PER;

        -- slti
        s_opcode <= "001010";
        WAIT FOR cCLK_PER;

        -- slti
        s_opcode <= "001011";
        WAIT FOR cCLK_PER;

        -- andi
        s_opcode <= "001100";
        WAIT FOR cCLK_PER;

        -- ori
        s_opcode <= "001101";
        WAIT FOR cCLK_PER;

        -- xori
        s_opcode <= "001110";
        WAIT FOR cCLK_PER;

        -- lui
        s_opcode <= "001111";
        WAIT FOR cCLK_PER;

        -- lw
        s_opcode <= "100011";
        WAIT FOR cCLK_PER;

        -- sw
        s_opcode <= "101011";
        WAIT FOR cCLK_PER;

        WAIT;
    END PROCESS;
END mixed;
