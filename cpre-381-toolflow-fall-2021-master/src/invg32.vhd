-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- invg32.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity invg32 is

  port(i_A          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));

end invg32;


architecture dataflow of invg32 is
begin

	Nbit_invg32: for i in 0 to 31 generate

  	o_F(i) <= not i_A(i);
	end generate;

  end dataflow;