library IEEE;
use IEEE.std_logic_1164.all;

entity Hazard is

port(
	IDEXMemRead : in std_logic;
	IFIDRegRs : in std_logic_vector(4 downto 0);
	IFIDRegRt : in std_logic_vector(4 downto 0);
	IDEXRegRt : in std_logic_vector(4 downto 0);
	Stall : out std_logic;
	i_CLK : in std_logic);
	
	
end Hazard;

architecture mixed of Hazard is
begin

process (i_CLK)
begin
if rising_edge(i_CLK) then
	if IDEXMEMRead = '1' and (IDEXRegRt = IFIDRegRs or IDEXRegRt = IFIDRegRt) then
	Stall <= '1';
	else
	Stall <= '0';
	end if;
end if;

end process;



end mixed;
	