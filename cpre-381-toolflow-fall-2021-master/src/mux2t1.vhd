-------------------------------------------------------------------------
-- Evan Gossling
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- 2t1mux.vhd
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

entity mux2t1 is

  port(i_S             : in std_logic;
       i_D0            : in std_logic;
       i_D1            : in std_logic;
       o_O             : out std_logic);
  end mux2t1;

architecture structure of mux2t1 is
  
  component andg2
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;

  component org2
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;

  component invg
    port(i_A          : in std_logic;
         o_F          : out std_logic);
  end component;


  -- Signal to carry stored weight
  signal s_A1         : std_logic;
  signal s_A2         : std_logic;
  signal s_N1         : std_logic;

begin
 
  g_not1: invg
    port MAP(i_A    => i_S,
	     o_F    => s_N1);

  g_and1: andg2
    port MAP(i_A    => i_D0,
             i_B    => s_N1,
             o_F    => s_A1);

  g_and2: andg2
    port MAP(i_A    => i_S,
             i_B    => i_D1,
             o_F    => s_A2);

  g_or1: org2
    port MAP(i_A    => s_A1,
             i_B    => s_A2,
             o_F    => o_O);

end structure;
