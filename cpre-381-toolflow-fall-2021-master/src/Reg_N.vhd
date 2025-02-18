-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Reg_N
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a N-bit Register
-- using VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 9/1/21 by TZAB::Created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity Reg_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(	i_CLK			: in std_logic;
	i_RST			: in std_logic;
	i_WE			: in std_logic;
	i_D        		: in std_logic_vector(N-1 downto 0);
	o_Q			: out std_logic_vector(N-1 downto 0)); 
end Reg_N;


architecture structural of Reg_N is

  component dffg
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output


  end component;

begin

  

  NBit_Reg_N: for i in N-1 downto 0 generate
	GER1: dffg port map(
		i_CLK	=>  i_CLK,
		i_RST	=>  i_RST,
		i_WE	=>  i_WE,
		i_D	=>  i_D(i),
		o_Q	=>  o_Q(i));
	end generate NBit_Reg_N;

end structural;
		






