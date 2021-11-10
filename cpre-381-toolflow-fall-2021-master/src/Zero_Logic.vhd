-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Zero_Logic.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity Zero_Logic is

  port(i_D          	: in std_logic_vector(31 downto 0);
       i_S		: in std_logic;
       o_Zero          	: out std_logic);

end Zero_Logic;


architecture dataflow of Zero_Logic is 

begin

  process ( i_D, i_S)
    begin

--      if i_S = '1' then
--        with i_D select
--	  o_Zero <= '1' when "00000000000000000000000000000000",
--	  '0' when others;
--      else
--        with i_D select
--	  o_Zero <= '0' when "00000000000000000000000000000000",
--	  '1' when others;
--      end if;



      if i_S = '0' then	--beq
	if i_D = "00000000000000000000000000000000" then
	  o_Zero <= '1';
	else
	  o_Zero <= '0';
	end if;
      else		--bne
	if i_D = "00000000000000000000000000000000" then
	  o_Zero <= '0';
	else
	  o_Zero <= '1';
	end if;
      end if;



--      if i_S = '1' and i_D = "00000000000000000000000000000000" then
--        o_Zero <= '1';
--      elsif i_S = '1' and i_D = NOT("00000000000000000000000000000000") then
--        o_Zero <= '0';
--      elsif i_S = '0' and i_D = "00000000000000000000000000000000" then
--        o_Zero <= '0';
--      else
--	o_Zero <= '1';
--      end if;


  end process;
	
end dataflow;

