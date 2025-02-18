-------------------------------------------------------------------------
-- Evan Gossling
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- barrel_shifter
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a barrel shifter
-- using VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 9/1/21 by EGOS::Created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity barrel_shifter is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_leftRight    : in std_logic;                           --0 (Left)/1(Right)
       i_logArith     : in std_logic;				--0(Log)/1(Arith)
       i_shamt        : in std_logic_vector(4 downto 0);
       i_in	      : in std_logic_vector(N-1 downto 0);
       o_Out          : out std_logic_vector(N-1 downto 0));
end barrel_shifter;


architecture structural of barrel_shifter is

   component mux2t1 is
   port(i_S          : in std_logic;
       i_D0          : in std_logic;
       i_D1          : in std_logic;
       o_O           : out std_logic);
  end component;

  component mux2t1_N is
    generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
    port(i_S          : in std_logic;
         i_D0         : in std_logic_vector(N-1 downto 0);
         i_D1         : in std_logic_vector(N-1 downto 0);
         o_O          : out std_logic_vector(N-1 downto 0));
  end component;

signal s_ologArith : std_logic;
signal s_rightData : std_logic_vector(N-1 downto 0);
signal s_rDataF    : std_logic_vector(N-1 downto 0);
signal s_dataIn    : std_logic_vector(N-1 downto 0);
signal s_muxOut    : std_logic_vector(N-1 downto 0);
signal s_r0 	   : std_logic_vector(N-1 downto 0);
signal s_r1	   : std_logic_vector(N-1 downto 0);
signal s_r2 	   : std_logic_vector(N-1 downto 0);
signal s_r3 	   : std_logic_vector(N-1 downto 0);

begin

  s_rightData <= i_in(0) & i_in(1) & i_in(2) & i_in(3) & i_in(4) & i_in(5) & i_in(6) & i_in(7) & i_in(8) & i_in(9) & i_in(10) & i_in(11) & i_in(12) & i_in(13) & i_in(14) & i_in(15) & i_in(16) & i_in(17) & i_in(18) & i_in(19) & i_in(20) & i_in(21) & i_in(22) & i_in(23) & i_in(24) & i_in(25) & i_in(26) & i_in(27) & i_in(28) & i_in(29) & i_in(30) & i_in(31);

  g_mux2t1_N0: mux2t1_N
     port MAP(i_S      => i_leftRight,
	      i_D0     => i_in,
	      i_D1     => s_rightData,
              o_O      => s_dataIn);

  g_mux2t1_0: mux2t1
     port MAP(i_S      => i_logArith,
	      i_D0     => '0',
	      i_D1     => i_in(31),
              o_O      => s_oLogArith);

  -- Row 1
  G_NBit_MUX1: for i in 1 to N-1 generate
    MUXI1: mux2t1 port map(
              i_S      => i_shamt(0),      -- All instances share the same select input.
              i_D0     => s_dataIn(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_dataIn(i-1),  -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_r0(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_MUX1;

  g_mux2t1_1: mux2t1
     port MAP(i_S      => i_shamt(0),
	      i_D0     => s_dataIn(0),
	      i_D1     => s_oLogArith,
              o_O      => s_r0(0));

  --Row 2
  G_NBit_MUX2: for i in 2 to N-1 generate
    MUXI2: mux2t1 port map(
              i_S      => i_shamt(1),      -- All instances share the same select input.
              i_D0     => s_r0(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_r0(i-2),  -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_r1(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_MUX2;

  g_mux2t1_2: mux2t1
     port MAP(i_S      => i_shamt(1),
	      i_D0     => s_r0(1),
	      i_D1     => s_oLogArith,
              o_O      => s_r1(1));

  g_mux2t1_3: mux2t1
     port MAP(i_S      => i_shamt(1),
	      i_D0     => s_r0(0),
	      i_D1     => s_oLogArith,
              o_O      => s_r1(0));

  --Row 3
  G_NBit_MUX3: for i in 4 to N-1 generate
    MUXI3: mux2t1 port map(
              i_S      => i_shamt(2),      -- All instances share the same select input.
              i_D0     => s_r1(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_r1(i-4),  -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_r2(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_MUX3;

  G_NBit_MUX4: for i in 1 to 3 generate
    MUXI4: mux2t1 port map(
              i_S      => i_shamt(2),      -- All instances share the same select input.
              i_D0     => s_r1(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_oLogArith,  -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_r2(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_MUX4;

  g_mux2t1_4: mux2t1
     port MAP(i_S      => i_shamt(2),
	      i_D0     => s_r1(0),
	      i_D1     => s_oLogArith,
              o_O      => s_r2(0));

  --Row 4
  G_NBit_MUX5: for i in 8 to N-1 generate
    MUXI5: mux2t1 port map(
              i_S      => i_shamt(3),      -- All instances share the same select input.
              i_D0     => s_r2(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_r2(i-8),  -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_r3(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_MUX5;

  G_NBit_MUX6: for i in 1 to 7 generate
    MUXI6: mux2t1 port map(
              i_S      => i_shamt(3),      -- All instances share the same select input.
              i_D0     => s_r2(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_oLogArith,  -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_r3(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_MUX6;

  g_mux2t1_5: mux2t1
     port MAP(i_S      => i_shamt(3),
	      i_D0     => s_r2(0),
	      i_D1     => s_oLogArith,
              o_O      => s_r3(0));

  --Row 5
  G_NBit_MUX7: for i in 16 to N-1 generate
    MUXI7: mux2t1 port map(
              i_S      => i_shamt(4),      -- All instances share the same select input.
              i_D0     => s_r3(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_r3(i-16),  -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_muxOut(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_MUX7;

  G_NBit_MUX8: for i in 1 to 15 generate
    MUXI8: mux2t1 port map(
              i_S      => i_shamt(4),      -- All instances share the same select input.
              i_D0     => s_r3(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_oLogArith,  -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_muxOut(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_MUX8;

  g_mux2t1_6: mux2t1
     port MAP(i_S      => i_shamt(4),
	      i_D0     => s_r3(0),
	      i_D1     => s_oLogArith,
              o_O      => s_muxOut(0));

  s_rDataF <= s_muxOut(0) & s_muxOut(1) & s_muxOut(2) & s_muxOut(3) & s_muxOut(4) & s_muxOut(5) & s_muxOut(6) & s_muxOut(7) & s_muxOut(8) & s_muxOut(9) & s_muxOut(10) & s_muxOut(11) & s_muxOut(12) & s_muxOut(13) & s_muxOut(14) & s_muxOut(15) & s_muxOut(16) & s_muxOut(17) & s_muxOut(18) & s_muxOut(19) & s_muxOut(20) & s_muxOut(21) & s_muxOut(22) & s_muxOut(23) & s_muxOut(24) & s_muxOut(25) & s_muxOut(26) & s_muxOut(27) & s_muxOut(28) & s_muxOut(29) & s_muxOut(30) & s_muxOut(31);

  g_mux2t1_N1: mux2t1_N
     port MAP(i_S      => i_leftRight,
	      i_D0     => s_muxOut,
	      i_D1     => s_rDataF,
              o_O      => o_Out);
  
end structural;











