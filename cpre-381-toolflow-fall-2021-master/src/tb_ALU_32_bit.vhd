-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_ALU_32_bit.vhd 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
--use std.env.all;                -- For hierarchical/external signals
use std.textio.all; 


entity tb_ALU_32_bit is
	generic(gCLK_HPER   : time := 50 ns);
end tb_ALU_32_bit;


architecture behavior of tb_ALU_32_bit is

	constant cCLK_PER  : time := gCLK_HPER * 2;

	component ALU_32_bit
   	   port(i_A		: in std_logic_vector(31 downto 0); -- Read data 1 -> i_A
		i_B		: in std_logic_vector(31 downto 0); -- ALUSrc MUX -> i_B
		i_SHAMT		: in std_logic_vector(4 downto 0);
		i_REPLB		: in std_logic_vector(7 downto 0);
		i_ALUOp		: in std_logic_vector(4 downto 0); -- *Work in progess* Control selector: 0000 -> AND, 0001 -> OR, 0010 -> ADD,  0011 -> SUB, 0100 -> stl, 0101 -> XOR, 110 -> NOR
		o_Result	: out std_logic_vector(31 downto 0);
		o_OF		: out std_logic;
		o_Cout		: out std_logic;
		o_Zero		: out std_logic);

	 end component;
   
	signal s_A, s_B, s_Result	: std_logic_vector(31  downto 0);
	signal s_REPLB	: std_logic_vector(7 downto 0);
   	signal s_ALUOp, s_SHAMT			: std_logic_vector(4 downto 0);
	signal s_OF, s_Cout, s_Zero	: std_logic;

begin


	DUT0: ALU_32_bit 
  	port map(i_A		=> s_A,
		 i_B		=> s_B,
		 i_SHAMT	=> s_SHAMT,
		 i_REPLB	=> s_REPLB,
		 i_ALUOp	=> s_ALUOp,
		 o_Result	=> s_Result,
		 o_OF		=> s_OF,
		 o_Cout		=> s_Cout,
		 o_Zero		=> s_Zero);

  	

	P_ALUTB: process
	begin

--zero
	s_A 	<= x"00000000";
	s_B 	<= x"00000000";
	s_ALUOp <= "00000";
	wait for cCLK_PER;

	s_A 	<= x"00000000";
	s_B 	<= x"00000001";
	s_ALUOp <= "00000";
	wait for cCLK_PER;



--add, addi

	s_A 	<= x"0000F001";
	s_B 	<= x"0000F100";
	s_ALUOp <= "00000";
	wait for cCLK_PER;

--add, addi w/ OF

	s_A 	<= x"F000F001";
	s_B 	<= x"1000F100";
	s_ALUOp <= "00000";
	wait for cCLK_PER;

--sub -- 

	s_A 	<= x"0000F201";
	s_B 	<= x"0000F100";
	s_ALUOp <= "00001";
	wait for cCLK_PER;


	s_A 	<= x"1000F201";
	s_B 	<= x"0000F100";
	s_ALUOp <= "00001";
	wait for cCLK_PER;

--addu, addiu

	s_A 	<= x"0000F001";
	s_B 	<= x"0000F100";
	s_ALUOp <= "00010";
	wait for cCLK_PER;


	s_A 	<= x"1000F001";
	s_B 	<= x"1000F100";
	s_ALUOp <= "00010";
	wait for cCLK_PER;

--addu, addiu w/ OF test

	s_A 	<= x"F000F001";
	s_B 	<= x"1000F100";
	s_ALUOp <= "00010";
	wait for cCLK_PER;


--subu

	s_A 	<= x"F000F001";
	s_B 	<= x"1000F10F";
	s_ALUOp <= "00011";
	wait for cCLK_PER;

--srl --
	
	s_A 	<= x"F000F001";
	s_SHAMT <= "00001";
	s_ALUOp <= "00100";
	wait for cCLK_PER;

	s_A 	<= x"F000F001";
	s_SHAMT <= "01000";
	s_ALUOp <= "00100";
	wait for cCLK_PER;


--sll --
	
	s_A 	<= x"F000F001";
	s_SHAMT <= "00001";
	s_ALUOp <= "00101";
	wait for cCLK_PER;

	
	s_A 	<= x"F000F001";
	s_SHAMT <= "01000";
	s_ALUOp <= "00101";
	wait for cCLK_PER;

--sra --
	
	s_A 	<= x"F000F001";
	s_SHAMT <= "00001";
	s_ALUOp <= "00110";
	wait for cCLK_PER;

	s_A 	<= x"F0F0F0F1";
	s_SHAMT <= "01000";
	s_ALUOp <= "00110";
	wait for cCLK_PER;


--and, andi

	s_A 	<= x"00000001";
	s_B 	<= x"1000F101";
	s_ALUOp <= "01000";
	wait for cCLK_PER;

--or, ori

	s_A 	<= x"F000F001";
	s_B 	<= x"1000F10F";
	s_ALUOp <= "01001";
	wait for cCLK_PER;

--nor
	s_A 	<= x"0F00FFFF";
	s_B 	<= x"000FFFFF";
	s_ALUOp <= "01010";
	wait for cCLK_PER;


--xor, xori

	s_A 	<= x"0F00FFFF";
	s_B 	<= x"000FFFFF";
	s_ALUOp <= "01011";
	wait for cCLK_PER;

--slt, slti


	s_A 	<= x"0F00FFFF";
	s_B 	<= x"000FFFFF";
	s_ALUOp <= "01101";
	wait for cCLK_PER;

-- sltu, sltiu

	s_A 	<= x"0000FFFF";
	s_B 	<= x"FFFFFFFF";
	s_ALUOp <= "01111";
	wait for cCLK_PER;



	s_A 	<= x"1000FFFF";
	s_B 	<= x"FFFFFFFF";
	s_ALUOp <= "01111";
	wait for cCLK_PER;


-- repl.qb


	s_REPLB 	<= x"1F";
	s_ALUOp <= "01110";
	wait for cCLK_PER;





	end process;


end behavior;
