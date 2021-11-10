-------------------------------------------------------------------------
-- Tom Zaborowski
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity MIPS_Processor is
  generic(N : integer := 32);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is




  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file 
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated



  signal s_Branch, s_RegDst	 	: std_logic;
  signal s_ALUOp			: std_logic_vector(4 downto 0);
  signal s_ALUA, s_ALUB 		: std_logic_vector(31 downto 0);
  signal s_dummy1, s_dummy2, s_dummy3	: std_logic;
  signal s_branchAndOut, s_Jump, s_JumpReg, s_Jal      : std_logic;
  signal s_MemtoReg	: std_logic_vector(1 downto 0);
  signal s_ALUsrc, s_SignExtend, s_Zero, s_Cout : std_logic;
  signal s_ReadData2, s_ExtendedVal		: std_logic_vector(31 downto 0);
  signal s_signExtendShift, s_PC4, s_JumpALUOut : std_logic_vector(31 downto 0);
  signal s_PC4orBRANCH, s_NextInstFromMux      : std_logic_vector(31 downto 0);
  signal s_instr25t0, s_instrShifted2, s_JumpAddress, s_PC    : std_logic_vector(31 downto 0);


component control
    PORT(opcode     : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
         funct      : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
         RegDst     : OUT STD_LOGIC;
         RegData    : OUT STD_LOGIC;
	 JalReg     : OUT STD_LOGIC;
         Jump       : OUT STD_LOGIC;
         JumpReg    : OUT STD_LOGIC;
         Branch     : OUT STD_LOGIC;
         MemRead    : OUT STD_LOGIC;
         MemtoReg   : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
         ALUOp	    : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
         MemWrite   : OUT STD_LOGIC;
         ALUsrc     : OUT STD_LOGIC;
         RegWrite   : OUT STD_LOGIC;
         SignExtend : OUT STD_LOGIC;
 	 halt 	    : OUT STD_LOGIC);
end component;


component register32 is
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
  end component;

component ALU_32_bit
   port(i_A		: in std_logic_vector(31 downto 0); -- Read data 1 -> i_A
	i_B		: in std_logic_vector(31 downto 0); -- ALUSrc MUX -> i_B
	i_SHAMT		: in std_logic_vector(4 downto 0);
	i_REPLB		: in std_logic_vector(7 downto 0);
	i_ALUOp		: in std_logic_vector(4 downto 0); -- Control selector: 0000 -> AND, 0001 -> OR, 0010 -> ADD,  0011 -> SUB, 0100 -> stl, 0101 -> XOR, 0110 -> NOR, 0111 -> sra, 1000 -> sll, 1001 -> srl, 1010 -> repl.qb 
	o_Result	: out std_logic_vector(31 downto 0);
	o_OF		: out std_logic;
	o_Cout		: out std_logic;
	o_Zero		: out std_logic);
end component;



component extender_16t32
   port(i_D		: in std_logic_vector(15 downto 0);
	i_Signed	: in std_logic;
	o_Q		: out std_logic_vector(31 downto 0));
end component;


component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

component mux2t1_N 
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
end component;

component barrel_shifter 
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_leftRight    : in std_logic;                           --0 (Left)/1(Right)
       i_logArith     : in std_logic;				--0(Log)/1(Arith)
       i_shamt        : in std_logic_vector(4 downto 0);
       i_in	      : in std_logic_vector(N-1 downto 0);
       o_Out          : out std_logic_vector(N-1 downto 0));
end component;

component andg2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component Adder_N
  port(i_D0           : in std_logic_vector(N-1 downto 0);
       i_D1           : in std_logic_vector(N-1 downto 0);
       i_Cin          : in std_logic;
       o_Sum	      : out std_logic_vector(N-1 downto 0);
       o_Cout         : out std_logic);
end component;

component dffg_N is
    port (i_CLK        : in std_logic;    			     -- Clock input
          i_RST        : in std_logic;			     -- Reset input
          i_WE         : in std_logic;			     -- Write enable input
          i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
          o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
end component;

component mux4t1_32 
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic_vector(1 downto 0);
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       i_D2         : in std_logic_vector(N-1 downto 0);
       i_D3         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
end component;

begin

  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
    iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  g_reset_mux : mux2t1_N
    PORT MAP(i_S  => iRST,
             i_D0 => s_NextInstFromMux,
             i_D1 => "00000000010000000000000000000000",
             o_O  => s_PC);

  g_pc_reg : dffg_N
    PORT MAP(i_CLK => iCLK, 
             i_RST => '0', 
	     i_WE  => '1', 
	     i_D   => s_PC, 
	     o_Q   => s_NextInstAddr);


  g_pc_plus_4 : Adder_N
    PORT MAP(i_D0   => s_NextInstAddr, 
             i_D1   => "00000000000000000000000000000100", 
             i_Cin  => '0', 
             o_Sum  => s_PC4, 
             o_Cout => OPEN);


  control_N1: control
    PORT MAP(opcode 	=> s_Inst(31 downto 26),
             funct 	=> s_Inst(5 downto 0),
             RegDst 	=> s_RegDst,
             RegData 	=> s_dummy1, --??
	     JalReg 	=> s_Jal,
             Jump 	=> s_Jump,
	     JumpReg 	=> s_JumpReg,
             Branch  	=> s_Branch,
             MemRead 	=> s_dummy1, 
             MemtoReg 	=> s_MemtoReg,
             ALUOp 	=> s_ALUOp,
             MemWrite 	=> s_DMemWr, --
             ALUsrc	=> s_ALUsrc, 
             RegWrite 	=> s_RegWr,
             SignExtend => s_SignExtend,
	     halt 	=> s_Halt);

   register32_N1: register32
	port MAP(i_CK		=>  iCLK,
		 i_reset 	=>  iRST,
		 i_WE		=>  s_RegWr,
		 i_WR		=>  s_RegWrAddr,
		 i_RS		=>  s_Inst(25 downto 21),
		 i_RT		=>  s_Inst(20 downto 16),
		 i_WD		=>  s_RegWrData,
		 o_O0		=>  s_ALUA,
		 o_O1		=>  s_ReadData2);


  s_DMemData <= s_ReadData2;


  extender_16t32_D2_N1: extender_16t32
    port MAP(i_D	=>  s_Inst(15 downto 0),
	     i_Signed 	=>  s_SignExtend,
	     o_Q	=>  s_ExtendedVal);


  ALU_32_bit_N1: ALU_32_bit
    port MAP(i_A        =>  s_ALUA,
       	     i_B        =>  s_ALUB,
	     i_SHAMT	=>  s_Inst(10 downto 6),
	     i_REPLB    =>  s_Inst(23 downto 16),
             i_ALUOp    =>  s_ALUOp,
             o_Result	=>  s_DMemAddr,
             o_OF	=>  s_Ovfl,
             o_Cout	=>  s_Cout, 
             o_Zero     =>  s_Zero);


  oALUOut <= s_DMemAddr;

  mux2t1_N_N2: mux2t1_N -- for B input for ALU *32bit*
    generic map(N => 32)
    port MAP(i_S   => s_ALUsrc,        
      	     i_D0  => s_ReadData2, 
       	     i_D1  => s_ExtendedVal, 
       	     o_O   => s_ALUB);

   mux4t1_32_N1: mux4t1_32 -- for write register for reg file *5bit*
       generic map(N => 5)
       port MAP(i_S  	=> s_Jal & s_RegDst,        
       		i_D0    => s_Inst(20 downto 16), 
       		i_D1    => s_Inst(15 downto 11), 
       		i_D2    => "11111",
       		i_D3    => s_Inst(15 downto 11), 	
       		o_O     => s_RegWrAddr);

   mux4t1_32_N2: mux4t1_32 -- for memory to register file
       generic map(N => 32)
       port MAP(i_S  	=> s_MemtoReg,        
       		i_D0    => s_DMemAddr, 
       		i_D1    => s_DMemOut,
       		i_D2    => s_PC4,
       		i_D3    => x"00000000",	
       		o_O     => s_RegWrData);

  andg2_1 : andg2 --for bne
    port MAP(i_A   =>  s_Branch,
             i_B   =>  s_Zero,
	     o_F   =>  s_branchAndOut);

  s_instr25t0 <= "000000" & s_Inst(25 downto 0);

  g_shift_instr : barrel_shifter
    PORT MAP(i_leftRight => '0' ,
	     i_logArith  => '0', 
	     i_shamt     => "00010", 
	     i_in 	 => s_instr25t0, 
	     o_Out 	 => s_instrShifted2);

--shift sign extend left 2
  g_shift_sign_extend : barrel_shifter
    port MAP(i_leftRight => '0',
      	     i_logArith  => '0',
  	     i_shamt     => "00010",
    	     i_in	 => s_ExtendedVal,
  	     o_Out       => s_signExtendShift);

--adder to add PC+4 with shift 2 sign extend = Jump PC
  g_adder_N_1 : Adder_N
    port MAP(i_D0   => s_PC4,
       	     i_D1   => s_signExtendShift,
   	     i_Cin  => '0',
  	     o_Sum  => s_JumpALUOut,
  	     o_Cout => OPEN);

--mux to choose 0:PC+4 or 1:Jump PC (s_branchAndOut is select) (JPC)
  mux2t1_N_N4: mux2t1_N
    generic map(N => 32)
    port MAP(i_S  => s_branchAndOut,        
             i_D0 => s_PC4, 
       	     i_D1 => s_JumpALUOut, 
       	     o_O  => s_PC4orBRANCH);

  s_JumpAddress <= s_PC4(31 downto 28) & s_instrShifted2(27 downto 0);

--mux to choose 1:addr2 and 0:JPC with Jump as select
    g_mux_jump : mux4t1_32 -- mux to go into pc
      generic map(N => 32)
      PORT MAP(i_S => s_JumpReg & s_Jump, 
               i_D0 => s_PC4orBRANCH, 
               i_D1 => s_JumpAddress,
	       i_D2 => x"00000000",
               i_D3 => s_ALUA, 
               o_O => s_NextInstFromMux);




end structure;

