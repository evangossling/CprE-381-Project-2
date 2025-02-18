-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


--reg_file

library IEEE;
use IEEE.std_logic_1164.all;



entity reg_file is
	port(	i_CLK	: std_logic;
		i_WRD	: in std_logic_vector(31 downto 0); -- write register data
		i_RST	: in std_logic; -- Reset
		i_WEN	: in std_logic; --write enable
		o_RD1	: out std_logic_vector(31 downto 0); --Register Read data 1
		o_RD2	: out std_logic_vector(31 downto 0); --Register Read data 2
		i_WRW	: in std_logic_vector(4 downto 0); -- write register 
		i_RR1	: in std_logic_vector(4 downto 0); -- Read Register 1
		i_RR2	: in std_logic_vector(4 downto 0)); -- Read Register 2

end reg_file;


architecture structural of reg_file is 

component andg2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;



component Reg_N
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(	i_CLK			: in std_logic;
	i_RST			: in std_logic;
	i_WE			: in std_logic;
	i_D        		: in std_logic_vector(N-1 downto 0);
	o_Q			: out std_logic_vector(N-1 downto 0)); 
end component;


component decoder5_32
   port(i_Decode		: in  std_logic_vector(4  downto 0);
	o_Instruct		: out std_logic_vector(31 downto 0));

end component;


component Mux32t1
   port(i_S	: in std_logic_vector(4 downto 0);
	i_D1	: in std_logic_vector(31 downto 0);
     	i_D2	: in std_logic_vector(31 downto 0);
     	i_D3	: in std_logic_vector(31 downto 0);
     	i_D4	: in std_logic_vector(31 downto 0);
     	i_D5	: in std_logic_vector(31 downto 0);
     	i_D6	: in std_logic_vector(31 downto 0);
     	i_D7	: in std_logic_vector(31 downto 0);
     	i_D8	: in std_logic_vector(31 downto 0);
     	i_D9	: in std_logic_vector(31 downto 0);
     	i_D10	: in std_logic_vector(31 downto 0);
     	i_D11	: in std_logic_vector(31 downto 0);
     	i_D12	: in std_logic_vector(31 downto 0);
     	i_D13	: in std_logic_vector(31 downto 0);
     	i_D14	: in std_logic_vector(31 downto 0);
     	i_D15	: in std_logic_vector(31 downto 0);
     	i_D16	: in std_logic_vector(31 downto 0);
     	i_D17	: in std_logic_vector(31 downto 0);
     	i_D18	: in std_logic_vector(31 downto 0);
     	i_D19	: in std_logic_vector(31 downto 0);
     	i_D20	: in std_logic_vector(31 downto 0);
     	i_D21	: in std_logic_vector(31 downto 0);
     	i_D22	: in std_logic_vector(31 downto 0);
     	i_D23	: in std_logic_vector(31 downto 0);
     	i_D24	: in std_logic_vector(31 downto 0);
     	i_D25	: in std_logic_vector(31 downto 0);
     	i_D26	: in std_logic_vector(31 downto 0);
     	i_D27	: in std_logic_vector(31 downto 0);
     	i_D28	: in std_logic_vector(31 downto 0);
     	i_D29	: in std_logic_vector(31 downto 0);
     	i_D30	: in std_logic_vector(31 downto 0);
     	i_D31	: in std_logic_vector(31 downto 0);
     	i_D32	: in std_logic_vector(31 downto 0);
     	o_O	: out std_logic_vector(31 downto 0));
end component;


type AREG is array (31 downto 0) of std_logic_vector(31 downto 0);

signal s_a : std_logic_vector(31 downto 0);
signal s_b : AREG;



begin 

  g_decoder5_32: decoder5_32
	port MAP(i_Decode	=> i_WRW,
		 o_Instruct	=> s_a);


 registers: for i in 31 downto 0 generate
 begin
 
  g_Reg_N: Reg_N
	port MAP(i_CLK		=> i_CLK,
		i_RST		=> i_RST,	
		i_WE		=> s_a(i) and i_WEN,
		i_D        	=> i_WRD,
		o_Q 		=> s_b(i));

 
  end generate;

 muxgen_1: for i in 31 downto 0 generate
 begin

g_Mux32t1_1: Mux32t1
   port MAP(i_S	=> i_RR1,
	i_D1	=> s_b(0),
     	i_D2	=> s_b(1),
     	i_D3	=> s_b(2),
     	i_D4	=> s_b(3),
     	i_D5	=> s_b(4),
     	i_D6	=> s_b(5),
     	i_D7	=> s_b(6),
     	i_D8	=> s_b(7),
     	i_D9	=> s_b(8),
     	i_D10	=> s_b(9),
     	i_D11	=> s_b(10),
     	i_D12	=> s_b(11),
     	i_D13	=> s_b(12),
     	i_D14	=> s_b(13),
     	i_D15	=> s_b(14),
     	i_D16	=> s_b(15),
     	i_D17	=> s_b(16),
     	i_D18	=> s_b(17),
     	i_D19	=> s_b(18),
     	i_D20	=> s_b(19),
     	i_D21	=> s_b(20),
     	i_D22	=> s_b(21),
     	i_D23	=> s_b(22),
     	i_D24	=> s_b(23),
     	i_D25	=> s_b(24),
     	i_D26	=> s_b(25),
     	i_D27	=> s_b(26),
     	i_D28	=> s_b(27),
     	i_D29	=> s_b(28),
     	i_D30	=> s_b(29),
     	i_D31	=> s_b(30),
     	i_D32	=> s_b(31),
     	o_O	=> o_RD1);


end generate;


muxgen_2: for i in 31 downto 0 generate
 begin

g_Mux32t1_2: Mux32t1
   port MAP(i_S	=> i_RR2,
	i_D1	=> s_b(0),
     	i_D2	=> s_b(1),
     	i_D3	=> s_b(2),
     	i_D4	=> s_b(3),
     	i_D5	=> s_b(4),
     	i_D6	=> s_b(5),
     	i_D7	=> s_b(6),
     	i_D8	=> s_b(7),
     	i_D9	=> s_b(8),
     	i_D10	=> s_b(9),
     	i_D11	=> s_b(10),
     	i_D12	=> s_b(11),
     	i_D13	=> s_b(12),
     	i_D14	=> s_b(13),
     	i_D15	=> s_b(14),
     	i_D16	=> s_b(15),
     	i_D17	=> s_b(16),
     	i_D18	=> s_b(17),
     	i_D19	=> s_b(18),
     	i_D20	=> s_b(19),
     	i_D21	=> s_b(20),
     	i_D22	=> s_b(21),
     	i_D23	=> s_b(22),
     	i_D24	=> s_b(23),
     	i_D25	=> s_b(24),
     	i_D26	=> s_b(25),
     	i_D27	=> s_b(26),
     	i_D28	=> s_b(27),
     	i_D29	=> s_b(28),
     	i_D30	=> s_b(29),
     	i_D31	=> s_b(30),
     	i_D32	=> s_b(31),
     	o_O	=> o_RD2);


end generate;


end structural;
