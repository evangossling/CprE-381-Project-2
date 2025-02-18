-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Adder_Subtractor_N.vhd 
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 9/1/21 by TZAB::Created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;


entity Adder_Subtractor_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_D0           		: in std_logic_vector(N-1 downto 0);
       i_D1           		: in std_logic_vector(N-1 downto 0);
       i_nAdd_Sub         	: in std_logic;
       o_Sum	      		: out std_logic_vector(N-1 downto 0);
       --o_Cout2			: out std_logic;
       o_Cout         		: out std_logic);
        

end Adder_Subtractor_N;


architecture structural of Adder_Subtractor_N is

   component onescomp
   generic(N : integer := 32); 
   port(i_A          	: in std_logic_vector(N-1 downto 0);
       o_F          	: out std_logic_vector(N-1 downto 0));
  end component;

   component mux2t1_N is
   generic(N : integer := 32);
   port(i_S          : in std_logic;
       i_D0          : in std_logic_vector(N-1 downto 0);
       i_D1          : in std_logic_vector(N-1 downto 0);
       o_O           : out std_logic_vector(N-1 downto 0));
  end component;


  component Adder_N is
  generic(N : integer := 32);
  port(i_D0           : in std_logic_vector(N-1 downto 0);
       i_D1           : in std_logic_vector(N-1 downto 0);
       i_Cin          : in std_logic;
       o_Sum	      : out std_logic_vector(N-1 downto 0);
       o_Cout         : out std_logic);
  end component;



signal s_a, s_b : std_logic_vector(N-1 downto 0);


begin

   g_ones_complementor_N1: onescomp
     port MAP(i_A              => i_D1,
              o_F               => s_a);


  g_mux2t1_N1: mux2t1_N
     port MAP(i_S               => i_nAdd_Sub,
	      i_D0              => i_D1,
	      i_D1              => s_a,
              o_O               => s_b);



  g_Adder_N1: Adder_N
     port MAP(i_D0              => i_D0,
	      i_D1              => s_b,
	      i_Cin             => i_nAdd_Sub,
	      o_Sum             => o_Sum,
              o_Cout            => o_Cout);

--o_Cout2 <= 

  end structural;
