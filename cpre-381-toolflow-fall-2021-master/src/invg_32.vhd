-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- invg_32.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity invg_32 is

  port(i_A          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));

end invg_32;


architecture dataflow of invg_32 is
begin

	Nbit_invg_32: for i in 0 to 31 generate

  	o_F(i) <= not i_A(i);
	end generate;

  end dataflow;