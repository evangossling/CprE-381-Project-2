-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Adder_N
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a N-bit adder
-- using VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 9/1/21 by TZAB::Created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Adder_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_D0           : in std_logic_vector(N-1 downto 0);
       i_D1           : in std_logic_vector(N-1 downto 0);
       i_Cin          : in std_logic;
       o_Sum	      : out std_logic_vector(N-1 downto 0);
       o_Cout         : out std_logic);

end Adder_N;


architecture behv of Adder_N is


   	signal s_a:		std_logic_vector(N downto 0);
   


begin

 	s_a 	<= ('0' & i_D0)+('0'& i_D1) + i_Cin;
	o_Sum  	<= s_a(N-1 downto 0);
	o_Cout	<= s_a(N);
	


 

end behv;












