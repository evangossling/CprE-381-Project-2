-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- ALU_32_bit.vhd 

library IEEE;
use IEEE.std_logic_1164.all;


entity ALU_32_bit is
   port(i_A		: in std_logic_vector(31 downto 0); -- Read data 1 -> i_A
	i_B		: in std_logic_vector(31 downto 0); -- ALUSrc MUX -> i_B
        i_SHAMT		: in std_logic_vector(4 downto 0);
	i_REPLB		: in std_logic_vector(7 downto 0);
	i_ALUOp		: in std_logic_vector(4 downto 0); -- *Work in progess* Control selector: 0000 -> AND, 0001 -> OR, 0010 -> ADD,  0011 -> SUB, 0100 -> stl, 0101 -> XOR, 0110 -> NOR, 0111 -> sra, 1000 -> sll, 1001 -> srl, 1010 -> repl.qb 
	o_Result	: out std_logic_vector(31 downto 0);
	o_OF		: out std_logic;
	o_Cout		: out std_logic;
	o_Zero		: out std_logic);
end ALU_32_bit;

architecture structural of ALU_32_bit is

component Overflow_Logic is
  port(i_Cout          	: in std_logic;
       i_MSB1		: in std_logic;
       i_MSB2		: in std_logic;
       i_MSB3R		: in std_logic;
       i_Signed		: in std_logic;
       i_onoff		: in std_logic;
       o_oF          	: out std_logic);

end component;

component Zero_Logic is
  port(i_D          	: std_logic_vector(31 downto 0);
       i_S		: std_logic;
       o_Zero          	: out std_logic);
end component;


component andg2_32 is
  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));
end component;

component andg32_3 is
  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       i_C          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));


end component;


component invg_32 is
  port(i_A          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));
end component;



component org2_32 is
  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));
end component;


component Adder_Subtractor_N is
  port(i_D0           		: in std_logic_vector(31 downto 0);
       i_D1           		: in std_logic_vector(31 downto 0);
       i_nAdd_Sub         	: in std_logic;
       o_Sum	      		: out std_logic_vector(31 downto 0);
       o_Cout         		: out std_logic);
end component;


component sltg2_32 is
  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));
end component;


component xorg2_32 is
  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));
end component;




component norg2_32 is
  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));
end component;

component barrel_shifter is
  port(i_leftRight    : in std_logic;
       i_logArith     : in std_logic;				--0(Log)/1(Arith)
       i_shamt        : in std_logic_vector(4 downto 0);
       i_in	      : in std_logic_vector(31 downto 0);
       o_Out          : out std_logic_vector(31 downto 0));
end component;


component repl_qb is
  port(
       i_B          : in std_logic_vector(7 downto 0);
       o_F 	    : out std_logic_vector(31 downto 0));
end component;

component mux2t1_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
end component;


-- will need to expand for barrel shifter and repl.qb
component mux7t1_32 is

port(i_0, i_1, i_2, i_3, i_4, i_5, i_6, i_7, i_8, i_9, i_10, i_11, i_12, i_13, i_14, i_15, i_16, i_17	: in std_logic_vector(31 downto 0);
   	i_S    												: in std_logic_vector(4 downto 0);
	o_O  												: out std_logic_vector(31 downto 0));
       							

end component;


signal s_output, s_a, s_b, s_c, s_d, s_e, s_f, s_g, s_h, s_i, s_j, s_dummy, s_of1, s_of2, s_of3, s_of4, s_of5	: std_logic_vector(31 downto 0);
signal s_0  	: std_logic_vector(4 downto 0);
signal s_Cout1, s_flip	: std_logic;


begin

-- Level 1 Operations
s_h <= x"00000000";


g_Adder_Subtractor_N1: Adder_Subtractor_N
port map(i_D0		=> i_A,
	 i_D1		=> i_B,
	 i_nAdd_Sub	=> i_ALUOp(0),
	 o_Sum		=> s_a,
	 o_Cout		=> s_Cout1);


s_0 <= i_B(4 downto 0);


--sll 00101
g_barrel_shifter_N1 : barrel_shifter port map(
		 i_leftRight   => NOT i_ALUOp(0),
       	 	 i_logArith    => i_ALUOp(1),
       	 	 i_shamt       => i_SHAMT, 
       	 	 i_in	       => i_B,	
       	 	 o_Out         => s_b);

--lui barrelshifter
g_barrel_shifter_N2 : barrel_shifter port map(
		 i_leftRight   => '0',
       	 	 i_logArith    => '0',
       	 	 i_shamt       => "10000", 
       	 	 i_in	       => i_B,	
       	 	 o_Out         => s_i);



g_andg2_32_N1 : andg2_32
port map(i_A 	=> i_A,
	 i_B	=> i_B,
	 o_F	=> s_c);


g_org2_32_N1 : org2_32
port map(i_A 	=> i_A,
	 i_B	=> i_B,
	 o_F	=> s_d);




g_xorg2_32_N1 : xorg2_32
port map(i_A 	=> i_A,
	 i_B	=> i_B,
	 o_F	=> s_f);


g_norg2_32_N1 : norg2_32
port map(i_A 	=> i_A,
	 i_B	=> i_B,
	 o_F	=> s_e);


o_Cout <= s_Cout1;


g_sltg2_32_N1 : sltg2_32
port map(i_A 	=> i_A,
	 i_B	=> i_B,
	 o_F	=> s_g);










g_repl_qb_N1 : repl_qb
port map(
	 i_B	=> i_REPLB,
	 o_F	=> s_j); -- wait on control for this



-- Level 2 Overflow content 






g_Overflow_Logic_N1 : Overflow_Logic
port map(i_Cout		=> s_Cout1,
	 i_MSB1 	=> i_A(31),
	 i_MSB2		=> i_B(31),
	 i_MSB3R	=> s_output(31),
       	 i_Signed	=> i_ALUOp(0),
	 i_onoff	=> i_ALUOp(1),
     	 o_oF          	=> o_OF);






-- Level 3 Mux 


g_mux7t1_32_N1 : mux7t1_32
port map(i_0	=> s_a,
	 i_1 	=> s_a,
	 i_2 	=> s_a,
	 i_3 	=> s_a,
	 i_4 	=> s_b,
	 i_5 	=> s_b,
	 i_6	=> s_b,
	 i_7	=> s_i,
	 i_8	=> s_c,
	 i_9	=> s_d,
	 i_10	=> s_e,
	 i_11	=> s_f,
	 i_12	=> s_a,
	 i_13	=> s_g,
	 i_14	=> s_j,
	 i_15	=> s_g,
	 i_16	=> s_h,
	 i_17	=> s_a,
   	 i_S    => i_ALUOp,
	 o_O 	=> s_output);




-- Level 4 Zero

 o_Result <= s_output;

g_Zero_Logic_N1 : Zero_Logic 
port map (i_D      => s_output,
	  i_S	   => i_ALUOp(2),    		
       	  o_Zero   => o_Zero);





end structural;

