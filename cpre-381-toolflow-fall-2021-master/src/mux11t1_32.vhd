-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux11t1_32.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity mux11t1_32 is

   port(i_0, i_1, i_2, i_3, i_4, i_5, i_6, i_7, i_8, i_9, i_10	: in std_logic_vector(31 downto 0);
   	i_S    							: in std_logic_vector(3 downto 0);
	o_O          						: out std_logic_vector(31 downto 0));

end mux11t1_32;

architecture dataflow of mux11t1_32 is

begin


	with i_S select
	o_O <= 	i_0 when "0000", 
		i_1 when "0001", 
		i_2 when "0010", 
		i_3 when "0011",
		i_4 when "0100",
		i_5 when "0101", 
		i_6 when "0110",
		i_7 when "0111",
		i_8 when "1000",
		i_9 when "1001",
		i_10 when "1010", 
		(others => '0') when others;  

end dataflow;