library IEEE;
use IEEE.std_logic_1164.all;

--entity
entity immExt is
    port (i_S   : in std_logic;
          i_I   : in std_logic_vector(15 downto 0);
          o_E   : out std_logic_vector(31 downto 0));
end immExt;

--architecture
architecture behavior of immExt is
begin

  process(i_S, i_I)
  begin
    if (i_S = '0') then
      o_E <= X"0000" & i_I;
    else
      o_E <= X"FFFF" & i_I;
    end if;
  end process;
  
end behavior;
