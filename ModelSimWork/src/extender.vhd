library IEEE;
use IEEE.std_logic_1164.all;

entity extender is
  generic(N : integer := 32);
  port(i_16b  : in std_logic_vector(15 downto 0); 
       i_sel	 : in std_logic; --1 = signed, 0 = zero
       o_32b  : out std_logic_vector(N-1 downto 0)); 

end extender;

architecture structure of extender is
begin

process(i_sel,i_16b)
begin

if(i_sel = '0') then
	o_32b <= b"0000000000000000" & i_16b;

elsif (i_sel = '1') then
	if(i_16b(15) ='0') then
		o_32b <= b"0000000000000000" & i_16b;
	
	elsif (i_16b(15) ='1') then
		o_32b <= b"1111111111111111" & i_16b;
	
	end if;

end if;

end process;

  
end structure;