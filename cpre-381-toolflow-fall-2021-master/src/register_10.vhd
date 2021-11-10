-------------------------------------------------------------------------
-- Theodore Thayib
-- Iowa State University
-------------------------------------------------------------------------
-- register_10.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: Register
-------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY register_10 IS
    PORT (
        i_CLK : IN STD_LOGIC;
        i_RST : IN STD_LOGIC;
        i_WE : IN STD_LOGIC;
        i_data : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        o_data : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END register_10;

ARCHITECTURE structural OF register_10 IS

    COMPONENT dffg IS
        PORT (
            i_CLK : IN STD_LOGIC;
            i_RST : IN STD_LOGIC;
            i_WE : IN STD_LOGIC;
            i_D : IN STD_LOGIC;
            o_Q : OUT STD_LOGIC);
    END COMPONENT;

BEGIN

    g_reg_bits : FOR i IN 0 TO 9 GENERATE
        REGBITI : dffg
        PORT MAP(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE => i_WE,
            i_D => i_data(i),
            o_Q => o_data(i)
        );
    END GENERATE g_reg_bits;
END structural;