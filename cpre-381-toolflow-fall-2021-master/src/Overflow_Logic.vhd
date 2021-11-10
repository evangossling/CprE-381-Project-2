-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Overflow_Logic.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity Overflow_Logic is

  port(i_Cout          	: in std_logic;
       i_MSB1		: in std_logic;
       i_MSB2		: in std_logic;
       i_MSB3R		: in std_logic;
       i_Signed		: in std_logic;
       i_onoff		: in std_logic;
       o_oF          	: out std_logic);

end Overflow_Logic;


architecture dataflow of Overflow_Logic is 





signal s_Out, s_Xorcheck : std_logic;

begin
--o_oF <= (i_A31 AND i_B31 AND NOT i_Result31) OR ( NOT i_A31 AND NOT i_B31 AND i_Result31);
	
	process (i_onoff, i_Cout, s_Out, i_MSB1, i_MSB2, i_MSB3R, i_Signed)
	begin
		--if i_onoff = '0' AND i_MSB1 = '0' AND i_MSB2 = '0' then

			--s_Out <= i_Cout XOR i_Signed;
		--else
			--s_Out <= '0';
	
		
		--end if;


		s_Xorcheck <= i_MSB2 XOR i_Signed;
	
		if (i_onoff = '0' AND i_MSB1 = '0' AND s_Xorcheck = '0' AND i_MSB3R = '1') OR (i_onoff = '0' AND i_MSB1 = '1' AND s_Xorcheck = '1' AND i_MSB3R = '0') then

			s_Out <= '1';
		
	
		else
	
			s_Out <= '0';
	
		
		end if;
	
	

	


	end process;
	
	


	o_OF <= s_Out;



end dataflow;

