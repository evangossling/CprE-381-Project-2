-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- xorg32.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity xorg32 is

  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));

end xorg32;


architecture dataflow of xorg32 is
begin

	Nbit_xorg32: for i in 0 to 31 generate

  	o_F(i) <= i_A(i) xor i_B(i);
	end generate;

  
end dataflow;