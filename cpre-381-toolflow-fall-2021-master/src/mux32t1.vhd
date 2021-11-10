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

entity mux32t1 is
  generic(N : integer := 32);
  port(i_S0            : in std_logic;
       i_S1            : in std_logic;
       i_S2            : in std_logic;
       i_S3            : in std_logic;
       i_S4            : in std_logic;
       i_D0            : in std_logic_vector(N-1 downto 0);
       i_D1            : in std_logic_vector(N-1 downto 0);
       i_D2            : in std_logic_vector(N-1 downto 0);
       i_D3            : in std_logic_vector(N-1 downto 0);
       i_D4            : in std_logic_vector(N-1 downto 0);
       i_D5            : in std_logic_vector(N-1 downto 0);
       i_D6            : in std_logic_vector(N-1 downto 0);
       i_D7            : in std_logic_vector(N-1 downto 0);
       i_D8            : in std_logic_vector(N-1 downto 0);
       i_D9            : in std_logic_vector(N-1 downto 0);
       i_D10           : in std_logic_vector(N-1 downto 0);
       i_D11           : in std_logic_vector(N-1 downto 0);
       i_D12           : in std_logic_vector(N-1 downto 0);
       i_D13           : in std_logic_vector(N-1 downto 0);
       i_D14           : in std_logic_vector(N-1 downto 0);
       i_D15           : in std_logic_vector(N-1 downto 0);
       i_D16           : in std_logic_vector(N-1 downto 0);
       i_D17           : in std_logic_vector(N-1 downto 0);
       i_D18           : in std_logic_vector(N-1 downto 0);
       i_D19           : in std_logic_vector(N-1 downto 0);
       i_D20           : in std_logic_vector(N-1 downto 0);
       i_D21           : in std_logic_vector(N-1 downto 0);
       i_D22           : in std_logic_vector(N-1 downto 0);
       i_D23           : in std_logic_vector(N-1 downto 0);
       i_D24           : in std_logic_vector(N-1 downto 0);
       i_D25           : in std_logic_vector(N-1 downto 0);
       i_D26           : in std_logic_vector(N-1 downto 0);
       i_D27           : in std_logic_vector(N-1 downto 0);
       i_D28           : in std_logic_vector(N-1 downto 0);
       i_D29           : in std_logic_vector(N-1 downto 0);
       i_D30           : in std_logic_vector(N-1 downto 0);
       i_D31           : in std_logic_vector(N-1 downto 0);
       o_oF            : out std_logic_vector(N-1 downto 0));
  end mux32t1;

architecture structure of mux32t1 is
  
  component mux2t1_N
    generic(N : integer := 32);
    port(i_S          : in std_logic;
         i_D0         : in std_logic_vector(N-1 downto 0);
         i_D1         : in std_logic_vector(N-1 downto 0);
         o_O          : out std_logic_vector(N-1 downto 0));
  end component;


  -- Signal to carry stored weight
  signal s_R11        : std_logic_vector(N-1 downto 0);
  signal s_R12        : std_logic_vector(N-1 downto 0);
  signal s_R13        : std_logic_vector(N-1 downto 0);
  signal s_R14        : std_logic_vector(N-1 downto 0);
  signal s_R15        : std_logic_vector(N-1 downto 0);
  signal s_R16        : std_logic_vector(N-1 downto 0);
  signal s_R17        : std_logic_vector(N-1 downto 0);
  signal s_R18        : std_logic_vector(N-1 downto 0);
  signal s_R19        : std_logic_vector(N-1 downto 0);
  signal s_R110       : std_logic_vector(N-1 downto 0);
  signal s_R111       : std_logic_vector(N-1 downto 0);
  signal s_R112       : std_logic_vector(N-1 downto 0);
  signal s_R113       : std_logic_vector(N-1 downto 0);
  signal s_R114       : std_logic_vector(N-1 downto 0);
  signal s_R115       : std_logic_vector(N-1 downto 0);
  signal s_R116       : std_logic_vector(N-1 downto 0);
  signal s_R21        : std_logic_vector(N-1 downto 0);
  signal s_R22        : std_logic_vector(N-1 downto 0);
  signal s_R23        : std_logic_vector(N-1 downto 0);
  signal s_R24        : std_logic_vector(N-1 downto 0);
  signal s_R25        : std_logic_vector(N-1 downto 0);
  signal s_R26        : std_logic_vector(N-1 downto 0);
  signal s_R27        : std_logic_vector(N-1 downto 0);
  signal s_R28        : std_logic_vector(N-1 downto 0);
  signal s_R31        : std_logic_vector(N-1 downto 0);
  signal s_R32        : std_logic_vector(N-1 downto 0);
  signal s_R33        : std_logic_vector(N-1 downto 0);
  signal s_R34        : std_logic_vector(N-1 downto 0);
  signal s_R41        : std_logic_vector(N-1 downto 0);
  signal s_R42        : std_logic_vector(N-1 downto 0);

begin
 
  g_mux1: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D0,
             i_D1  =>   i_D1,
             o_O   =>   s_R11);

  g_mux2: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D2,
             i_D1  =>   i_D3,
             o_O   =>   s_R12);

  g_mux3: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D4,
             i_D1  =>   i_D5,
             o_O   =>   s_R13);

  g_mux4: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D6,
             i_D1  =>   i_D7,
             o_O   =>   s_R14);

  g_mux5: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D8,
             i_D1  =>   i_D9,
             o_O   =>   s_R15);

  g_mux6: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D10,
             i_D1  =>   i_D11,
             o_O   =>   s_R16);

  g_mux7: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D12,
             i_D1  =>   i_D13,
             o_O   =>   s_R17);

  g_mux8: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D14,
             i_D1  =>   i_D15,
             o_O   =>   s_R18);

  g_mux9: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D16,
             i_D1  =>   i_D17,
             o_O   =>   s_R19);

  g_mux10: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D18,
             i_D1  =>   i_D19,
             o_O   =>   s_R110);

  g_mux11: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D20,
             i_D1  =>   i_D21,
             o_O   =>   s_R111);

  g_mux12: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D22,
             i_D1  =>   i_D23,
             o_O   =>   s_R112);

  g_mux13: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D24,
             i_D1  =>   i_D25,
             o_O   =>   s_R113);

  g_mux14: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D26,
             i_D1  =>   i_D27,
             o_O   =>   s_R114);

  g_mux15: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D28,
             i_D1  =>   i_D29,
             o_O   =>   s_R115);

  g_mux16: mux2t1_N
    port MAP(i_S   =>   i_S0,
             i_D0  =>   i_D30,
             i_D1  =>   i_D31,
             o_O   =>   s_R116);

  g_mux17: mux2t1_N
    port MAP(i_S   =>   i_S1,
             i_D0  =>   s_R11,
             i_D1  =>   s_R12,
             o_O   =>   s_R21);

  g_mux18: mux2t1_N
    port MAP(i_S   =>   i_S1,
             i_D0  =>   s_R13,
             i_D1  =>   s_R14,
             o_O   =>   s_R22);

  g_mux19: mux2t1_N
    port MAP(i_S   =>   i_S1,
             i_D0  =>   s_R15,
             i_D1  =>   s_R16,
             o_O   =>   s_R23);

  g_mux20: mux2t1_N
    port MAP(i_S   =>   i_S1,
             i_D0  =>   s_R17,
             i_D1  =>   s_R18,
             o_O   =>   s_R24);

  g_mux21: mux2t1_N
    port MAP(i_S   =>   i_S1,
             i_D0  =>   s_R19,
             i_D1  =>   s_R110,
             o_O   =>   s_R25);

  g_mux22: mux2t1_N
    port MAP(i_S   =>   i_S1,
             i_D0  =>   s_R111,
             i_D1  =>   s_R112,
             o_O   =>   s_R26);

  g_mux23: mux2t1_N
    port MAP(i_S   =>   i_S1,
             i_D0  =>   s_R113,
             i_D1  =>   s_R114,
             o_O   =>   s_R27);

  g_mux24: mux2t1_N
    port MAP(i_S   =>   i_S1,
             i_D0  =>   s_R115,
             i_D1  =>   s_R116,
             o_O   =>   s_R28);

  g_mux25: mux2t1_N
    port MAP(i_S   =>   i_S2,
             i_D0  =>   s_R21,
             i_D1  =>   s_R22,
             o_O   =>   s_R31);

  g_mux26: mux2t1_N
    port MAP(i_S   =>   i_S2,
             i_D0  =>   s_R23,
             i_D1  =>   s_R24,
             o_O   =>   s_R32);

  g_mux27: mux2t1_N
    port MAP(i_S   =>   i_S2,
             i_D0  =>   s_R25,
             i_D1  =>   s_R26,
             o_O   =>   s_R33);

  g_mux28: mux2t1_N
    port MAP(i_S   =>   i_S2,
             i_D0  =>   s_R27,
             i_D1  =>   s_R28,
             o_O   =>   s_R34);

  g_mux29: mux2t1_N
    port MAP(i_S   =>   i_S3,
             i_D0  =>   s_R31,
             i_D1  =>   s_R32,
             o_O   =>   s_R41);

  g_mux30: mux2t1_N
    port MAP(i_S   =>   i_S3,
             i_D0  =>   s_R33,
             i_D1  =>   s_R34,
             o_O   =>   s_R42);

  g_mux31: mux2t1_N
    port MAP(i_S   =>   i_S4,
             i_D0  =>   s_R41,
             i_D1  =>   s_R42,
             o_O   =>   o_oF);


end structure;
