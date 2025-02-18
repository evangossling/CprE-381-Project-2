-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- sltg32.vhd

library IEEE;
use IEEE.std_logic_1164.all;



entity sltg32 is

  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));

end sltg32;


architecture dataflow of sltg32 is
begin

	Nbit_sltg32: for i in 0 to 31 generate

  	slt_g: PROCESS (i_A(i), i_B(i))
	begin

	if i_A(i) < i_B(i) then
	o_F(i) <= '1';
	else
	o_F(i) <= '0';
	end if;
	
	END PROCESS slt_g;

	end generate;

  
end dataflow;