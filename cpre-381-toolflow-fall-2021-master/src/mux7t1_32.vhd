-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux7t1_32.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity mux7t1_32 is


   port(i_0, i_1, i_2, i_3, i_4, i_5, i_6, i_7, i_8, i_9, i_10, i_11, i_12, i_13, i_14, i_15, i_16, i_17	: in std_logic_vector(31 downto 0);
   	i_S    													: in std_logic_vector(4 downto 0);
	o_O  													: out std_logic_vector(31 downto 0));


end mux7t1_32;

architecture dataflow of mux7t1_32 is

begin


	with i_S select
	o_O <= 	i_0 when "00000", 
		i_1 when "00001", 
		i_2 when "00010", 
		i_3 when "00011",
		i_4 when "00100",
		i_5 when "00101", 
		i_6 when "00110",
		i_7 when "00111",
		i_8 when "01000",
		i_9 when "01001",
		i_10 when "01010",
		i_11 when "01011",
		i_12 when "11001",
		i_13 when "01101",
		i_14 when "01110",
		i_15 when "01111",
		i_16 when "10000",
		i_17 when "11101", 
		(others => '0') when others;  



end dataflow;
