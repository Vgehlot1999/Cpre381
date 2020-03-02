library IEEE;
use IEEE.std_logic_1164.all;

entity Decoder5_32 is
	
	port (i_A : in std_logic_vector(4 downto 0);
	      o_B : out std_logic_vector(31 downto 0));

end Decoder5_32;

architecture behavior of Decoder5_32 is 
	
begin

proc : process(i_A) is
	begin
		case(i_A) is
		when "00000" => o_B <=x"00000001";
		when "00001" => o_B <=x"00000002";
		when "00010" => o_B <=x"00000004";
		when "00011" => o_B <=x"00000008";
		when "00100" => o_B <=x"00000010";
		when "00101" => o_B <=x"00000020";
		when "00110" => o_B <=x"00000040";
		when "00111" => o_B <=x"00000080";
		when "01000" => o_B <=x"00000100";
		when "01001" => o_B <=x"00000200";
		when "01010" => o_B <=x"00000400";
		when "01011" => o_B <=x"00000800";
		when "01100" => o_B <=x"00001000";
		when "01101" => o_B <=x"00002000";
		when "01110" => o_B <=x"00004000";
		when "01111" => o_B <=x"00008000";
		when "10000" => o_B <=x"00010000";
		when "10001" => o_B <=x"00020000";
		when "10010" => o_B <=x"00040000";
		when "10011" => o_B <=x"00080000";
		when "10100" => o_B <=x"00100000";
		when "10101" => o_B <=x"00200000";
		when "10110" => o_B <=x"00400000";
		when "10111" => o_B <=x"00800000";
		when "11000" => o_B <=x"01000000";
		when "11001" => o_B <=x"02000000";
		when "11010" => o_B <=x"04000000";
		when "11011" => o_B <=x"08000000";
		when "11100" => o_B <=x"10000000";
		when "11101" => o_B <=x"20000000";
		when "11110" => o_B <=x"40000000";
		when "11111" => o_B <=x"80000000";
		when others  => o_B <=x"00000000";
		end case;
	end process proc;
end behavior;	