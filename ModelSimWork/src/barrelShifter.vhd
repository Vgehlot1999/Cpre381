library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all; 

entity barrelShifter is
	generic(N: integer := 32);
	port(i_32b  : in std_logic_vector(N-1 downto 0);
	     i_sel  : in std_logic_vector(4 downto 0);
	     i_Func : in std_logic_vector(1 downto 0);
	     o_32b  : out std_logic_vector(N-1 downto 0));

end barrelShifter;

architecture behavior of barrelShifter is





begin
	process (i_32b,i_sel,i_Func) begin
	case i_Func is
		when "00" =>
		o_32b <= std_logic_vector(shift_right(unsigned(i_32b),to_integer(unsigned(i_sel))));
		when "01" =>
		o_32b <= std_logic_vector(shift_left(unsigned(i_32b),to_integer(unsigned(i_sel))));
		when "10" =>
		o_32b <= std_logic_vector(shift_right(signed(i_32b),to_integer(unsigned(i_sel))));
		when others =>
		o_32b <= std_logic_vector(shift_right(signed(i_32b),to_integer(unsigned(i_sel))));
	end case;
	end process;



end behavior;
