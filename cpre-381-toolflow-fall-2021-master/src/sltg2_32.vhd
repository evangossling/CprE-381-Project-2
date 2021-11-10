-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- sltg2_32.vhd

library IEEE;
use IEEE.std_logic_1164.all;



entity sltg2_32 is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));
end sltg2_32;


architecture dataflow of sltg2_32 is

component onescomp is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_A         : in std_logic_vector(N-1 downto 0);
       o_F         : out std_logic_vector(N-1 downto 0));
end component;

component Adder_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_D0           : in std_logic_vector(N-1 downto 0);
       i_D1           : in std_logic_vector(N-1 downto 0);
       i_Cin          : in std_logic;
       o_Sum	      : out std_logic_vector(N-1 downto 0);
       o_Cout         : out std_logic);
end component;

signal iAoncescomp : std_logic_vector(31 downto 0);
signal iBoncescomp : std_logic_vector(31 downto 0);
signal iAtwoscomp : std_logic_vector(31 downto 0);
signal iBtwoscomp : std_logic_vector(31 downto 0);

begin

g_iA_onescomp : onescomp
  port map(
    i_A => i_A,
    o_F => iAoncescomp);

g_iB_onescomp : onescomp
  port map(
    i_A => i_B,
    o_F => iBoncescomp);

g_iA_twoscomp : Adder_N
  port map(i_D0   => iAoncescomp,
           i_D1   => "00000000000000000000000000000001",
           i_Cin  => '0',
           o_Sum  => iAtwoscomp,
           o_Cout => OPEN);

g_iB_twoscomp : Adder_N
  port map(i_D0   => iBoncescomp,
           i_D1   => "00000000000000000000000000000001",
           i_Cin  => '0',
           o_Sum  => iBtwoscomp,
           o_Cout => OPEN);


  	PROCESS (i_A, i_B, iAtwoscomp, iBtwoscomp)
	begin

	if i_A = i_B OR iAtwoscomp = iBtwoscomp then	
	o_F <= "00000000000000000000000000000000";

	elsif i_A(31) = '0' AND i_B(31) = '1' then
	o_F <= "00000000000000000000000000000000";

	elsif i_A(31) = '1' AND i_B(31) = '0' then
	o_F <= "00000000000000000000000000000001";

	elsif i_A(31) = '0' AND i_B(31) = '0' then
	  if i_A < i_B then
	    o_F <= "00000000000000000000000000000001";
	  else
	    o_F <= "00000000000000000000000000000000";
	  end if;

	elsif i_A(31) = '1' AND i_B(31) = '1' then
	  if iAtwoscomp < iBtwoscomp then
	    o_F <= "00000000000000000000000000000000";	--111000 -8	001000 8
	  else						--110000 -16	010000	16
	    o_F <= "00000000000000000000000000000001";
	  end if;

	else
	  o_F <= "00000000000000000000000000000001";
	end if;
	
	END PROCESS;

  
end dataflow;
