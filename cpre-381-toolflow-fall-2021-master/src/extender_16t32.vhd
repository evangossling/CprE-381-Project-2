-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------




-- extender_16t32


library IEEE;
use IEEE.std_logic_1164.all;


entity extender_16t32 is
   port(i_D		: in std_logic_vector(15 downto 0);
	i_Signed	: in std_logic;
	o_Q		: out std_logic_vector(31 downto 0));

	
end extender_16t32;

architecture dataflow of extender_16t32 is


signal s_extend : std_logic;


begin


  s_extend <= ('0' and not i_Signed) or (i_D(15) and i_Signed);




Highend_extender_16t32: for i in 31 downto 16 generate
   begin
	o_Q(i) <= s_extend;
   end generate Highend_extender_16t32;

Lowend_extender_16t32: for i in 15 downto 0 generate
   begin
	o_Q(i) <= i_D(i);
   end generate Lowend_extender_16t32;



end dataflow;

