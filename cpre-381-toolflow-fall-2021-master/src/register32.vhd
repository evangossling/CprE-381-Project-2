library IEEE;
use IEEE.std_logic_1164.all;

--use work.AAA_data.f_Data

package AAA_data is
 type f_Data is array (integer range <>) of std_logic_vector(31 downto 0);
end package AAA_data;

library IEEE;
use IEEE.std_logic_1164.all;
use work.AAA_data.f_Data;

entity register32 is
  generic(N : integer := 32);
  port(i_CK            : in std_logic;		
       i_reset         : in std_logic;		
       i_WE            : in std_logic;				--Write Enable
       i_WR            : in std_logic_vector(4 downto 0);	--Write Register
       i_RS            : in std_logic_vector(4 downto 0);	--Read Register S
       i_RT            : in std_logic_vector(4 downto 0);	--Read Register T
       i_WD            : in std_logic_vector(N-1 downto 0);	--Write Data
       o_O0            : out std_logic_vector(N-1 downto 0);
       o_O1            : out std_logic_vector(N-1 downto 0));
  end register32;

architecture structure of register32 is
  
  component mux32t1
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
  end component;
  
  component decoder
    port(i_D   : in std_logic_vector(4 downto 0);
         o_S   : out std_logic_vector(31 downto 0));
  end component;

  component dffg_N
    generic(N : integer := 32);
    port(i_CLK        : in std_logic;    		
         i_RST        : in std_logic;			  
         i_WE         : in std_logic;			  
         i_D          : in std_logic_vector(N-1 downto 0);
         o_Q          : out std_logic_vector(N-1 downto 0));
  end component;

  -- Signal to carry stored weight
  signal m_Data : f_Data(31 downto 0);
  signal zeroReg : std_logic;
  signal s_D        : std_logic_vector(N-1 downto 0);


begin
 
  process(i_WR)
    begin
      if i_WR = "00000" then
        zeroReg <= '0';
      else
	zeroReg <= '1';
      end if;
  end process;
	
  g_decoder0: decoder
    port MAP(i_D   =>   i_WR,
             o_S   =>   s_D);


  G_DFF: for i in 0 to N-1 generate
    DFF_I: dffg_N port map(
             i_CLK   =>   i_CK,
	     i_RST   =>   i_reset,
	     i_WE    =>   s_D(i) and i_WE and zeroReg,
	     i_D     =>   i_WD,
             o_Q     =>   m_Data(i));
  end generate G_DFF;

  g_mux0: mux32t1
    port MAP(i_S0     =>   i_RS(0),
             i_S1     =>   i_RS(1),
             i_S2     =>   i_RS(2),
             i_S3     =>   i_RS(3),
             i_S4     =>   i_RS(4),
             i_D0     =>   m_Data(0),
             i_D1     =>   m_Data(1),
             i_D2     =>   m_Data(2),
             i_D3     =>   m_Data(3),
             i_D4     =>   m_Data(4),
             i_D5     =>   m_Data(5),
             i_D6     =>   m_Data(6),
             i_D7     =>   m_Data(7),
             i_D8     =>   m_Data(8),
             i_D9     =>   m_Data(9),
             i_D10    =>   m_Data(10),
             i_D11    =>   m_Data(11),
             i_D12    =>   m_Data(12),
             i_D13    =>   m_Data(13),
             i_D14    =>   m_Data(14),
             i_D15    =>   m_Data(15),
             i_D16    =>   m_Data(16),
             i_D17    =>   m_Data(17),
             i_D18    =>   m_Data(18),
             i_D19    =>   m_Data(19),
             i_D20    =>   m_Data(20),
             i_D21    =>   m_Data(21),
             i_D22    =>   m_Data(22),
             i_D23    =>   m_Data(23),
             i_D24    =>   m_Data(24),
             i_D25    =>   m_Data(25),
             i_D26    =>   m_Data(26),
             i_D27    =>   m_Data(27),
             i_D28    =>   m_Data(28),
             i_D29    =>   m_Data(29),
             i_D30    =>   m_Data(30),
             i_D31    =>   m_Data(31),
             o_oF     =>   o_O0);

  g_mux1: mux32t1
    port MAP(i_S0     =>   i_RT(0),
             i_S1     =>   i_RT(1),
             i_S2     =>   i_RT(2),
             i_S3     =>   i_RT(3),
             i_S4     =>   i_RT(4),
             i_D0     =>   m_Data(0),
             i_D1     =>   m_Data(1),
             i_D2     =>   m_Data(2),
             i_D3     =>   m_Data(3),
             i_D4     =>   m_Data(4),
             i_D5     =>   m_Data(5),
             i_D6     =>   m_Data(6),
             i_D7     =>   m_Data(7),
             i_D8     =>   m_Data(8),
             i_D9     =>   m_Data(9),
             i_D10    =>   m_Data(10),
             i_D11    =>   m_Data(11),
             i_D12    =>   m_Data(12),
             i_D13    =>   m_Data(13),
             i_D14    =>   m_Data(14),
             i_D15    =>   m_Data(15),
             i_D16    =>   m_Data(16),
             i_D17    =>   m_Data(17),
             i_D18    =>   m_Data(18),
             i_D19    =>   m_Data(19),
             i_D20    =>   m_Data(20),
             i_D21    =>   m_Data(21),
             i_D22    =>   m_Data(22),
             i_D23    =>   m_Data(23),
             i_D24    =>   m_Data(24),
             i_D25    =>   m_Data(25),
             i_D26    =>   m_Data(26),
             i_D27    =>   m_Data(27),
             i_D28    =>   m_Data(28),
             i_D29    =>   m_Data(29),
             i_D30    =>   m_Data(30),
             i_D31    =>   m_Data(31),
             o_oF      =>   o_O1);


end structure;
