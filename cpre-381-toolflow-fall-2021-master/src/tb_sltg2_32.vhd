-------------------------------------------------------------------------
-- Evan Gossling
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_barrel_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the barrel_shifter unit.
--              
-- 09/07/2021 by EGOS::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_sltg2_32 is
  generic(gCLK_HPER   : time := 10 ns; 
          N : integer := 32);   -- Generic for half of the clock cycle period
end tb_sltg2_32;

architecture mixed of tb_sltg2_32 is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component sltg2_32 is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

-- TODO: change input and output signals as needed.
signal s_iA    : std_logic_vector(N-1 downto 0);
signal s_iB    : std_logic_vector(N-1 downto 0);
signal s_oF    : std_logic_vector(N-1 downto 0);

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: sltg2_32
  port map(
            i_A  =>  s_iA,
            i_B  =>  s_iB,
            o_F  =>  s_oF);
              --You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html

  
  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

  -- This process resets the sequential components of the design.
  -- It is held to be 1 across both the negative and positive edges of the clock
  -- so it works regardless of whether the design uses synchronous (pos or neg edge)
  -- or asynchronous resets.
  P_RST: process
  begin
  	reset <= '0';   
    wait for gCLK_HPER/2;
	reset <= '1';
    wait for gCLK_HPER*2;
	reset <= '0';
	wait;
  end process;  
  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges

    -- Test case 1: A < B = 0
    s_iA  <= "01111111111111110000000000000000";
    s_iB  <= "00000000000000000001000000000000";
    wait for gCLK_HPER*2;

    -- Test case 1: A < B = 1
    s_iA  <= "00000000000000110000000000000000";
    s_iB  <= "01110000000000000001000000000000";
    wait for gCLK_HPER*2;

    -- Test case 1: A < B = 1
    s_iA  <= "11111111111111110000000000000000";
    s_iB  <= "00000000000000000001000000000000";
    wait for gCLK_HPER*2;

    -- Test case 1: A < B = 1
    s_iA  <= "11111111111111111111111101100100";
    s_iB  <= "11111111111111111111111101101010";
    wait for gCLK_HPER*2;

    -- Test case 1: A < B = 0
    s_iA  <= "01111111111111110000000000000000";
    s_iB  <= "11111111111111111111111101101010";
    wait for gCLK_HPER*2;

  end process;

end mixed;
