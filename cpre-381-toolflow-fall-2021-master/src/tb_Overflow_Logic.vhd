-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_Overflow_Logic.vhd 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
--use std.env.all;                -- For hierarchical/external signals
use std.textio.all; 


entity tb_Overflow_Logic is
	generic(gCLK_HPER   : time := 50 ns);
end tb_Overflow_Logic;

architecture behavior of tb_Overflow_Logic is

	constant cCLK_PER  : time := gCLK_HPER * 2;
	

	component Overflow_Logic
		port(	i_Cout          	: in std_logic;
			i_Signed		: in std_logic;
       			--i_ALUOp		: in std_logic_vector(3 downto 0);
       			o_oF          		: out std_logic);


	end component;
	
	signal s_Cout, s_Signed, s_oF	: std_logic;

begin
	
	DUT0: Overflow_Logic 
  	port map(	i_Cout      	=> s_Cout,
			i_Signed	=> s_Signed,
       			--i_ALUOp		: in std_logic_vector(3 downto 0);
       			o_oF       	=> s_oF);


	P_OF: process
	begin
	

	s_Signed <= '0';
	s_Cout	 <= '0';

	wait for cCLK_PER;



	s_Signed <= '1';
	s_Cout	 <= '0';

	wait for cCLK_PER;

	end process;
end behavior;










	