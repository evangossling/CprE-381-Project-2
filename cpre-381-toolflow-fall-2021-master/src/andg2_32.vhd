-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- andg2_32.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity andg2_32 is

  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));

end andg2_32;


architecture dataflow of andg2_32 is
begin

	Nbit_andg2_32: for i in 0 to 31 generate

  	o_F(i) <= i_A(i) and i_B(i);
	end generate;

  
end dataflow;