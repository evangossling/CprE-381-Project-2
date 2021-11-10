-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- repl_qb.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity repl_qb is
  port(
       i_B          : in std_logic_vector(7 downto 0);
       o_F 	    : out std_logic_vector(31 downto 0));
	
end repl_qb;

architecture dataflow of repl_qb is




begin

	o_F <=  i_B & i_B & i_B & i_B;  


end dataflow;
