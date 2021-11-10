-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- 3t1mux.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a behavioral 
-- adder operating on integer inputs. 
--
--
-- NOTES: Integer data type is not typically useful when doing hardware
-- design. We use it here for simplicity, but in future labs it will be
-- important to switch to std_logic_vector types and associated math
-- libraries (e.g. signed, unsigned). 


-- 9/1/21 by Evan::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux4t1 is

  port(i_S             : in std_logic_vector(1 downto 0);
       i_D0            : in std_logic;
       i_D1            : in std_logic;
       i_D2            : in std_logic;
       i_D3            : in std_logic;
       o_O             : out std_logic);
  end mux4t1;

architecture dataflow of mux4t1 is
  

begin
 
	
	process (i_S, i_D0, i_D1, i_D2, i_D3) is
	
	begin
		if (i_S = "00") then

			o_O <=  i_D0;
		
		elsif (i_S = "01") then
			
			o_O <=  i_D1;

  		elsif (i_S = "10") then

			o_O <=  i_D2;

		else

			o_O <=  i_D3;

		end if;

	end process;


end dataflow;
