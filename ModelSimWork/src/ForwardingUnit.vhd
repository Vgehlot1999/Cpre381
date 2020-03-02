library IEEE;
use IEEE.std_logic_1164.all;

entity ForwardingUnit is

port(
	EXMEMRegWrite : in std_logic;
	EXMEMShift : in std_logic;
	EXMEMRegRd : in std_logic_vector(4 downto 0);
	IDEXBranch : in std_logic;
	IDEXRegRs : in std_logic_vector(4 downto 0);
	IDEXRegRt : in std_logic_vector(4 downto 0);
	IDEXBranchRegRs : in std_logic_vector(4 downto 0);
	IDEXBranchRegRt : in std_logic_vector(4 downto 0);
	MEMWBRegWrite : in std_logic;
	MEMWBRegRd : in std_logic_vector(4 downto 0);
	MEMWBShift : in std_logic;
	BranchA : out std_logic_vector(1 downto 0);
	BranchB : out std_logic_vector(1 downto 0);
	ForwardA : out std_logic_vector(1 downto 0);
	ForwardB : out std_logic_vector(1 downto 0));
end ForwardingUnit;

architecture Dataflow of ForwardingUnit is
begin
process (EXMEMRegWrite, EXMEMShift, EXMEMRegRd, IDEXBranch, IDEXRegRs, IDEXRegRt, IDEXBranchRegRs, IDEXBranchRegRt, MEMWBRegWrite, MEMWBRegRd, MEMWBShift)
begin
if EXMEMRegWrite = '1' and EXMEMRegRd > "00000" and EXMEMRegRd = IDEXRegRt and EXMEMShift = '1' then
	ForwardA <= "10";
elsif EXMEMRegWrite = '1' and EXMEMRegRd > "00000" and EXMEMRegRd = IDEXRegRs then
	ForwardA <= "10";
elsif MEMWBRegWrite = '1' and MEMWBRegRd > "00000" and MEMWBRegRd = IDEXRegRt and MEMWBShift = '1' then
	ForwardA <= "01";
elsif MEMWBRegWrite = '1' and MEMWBRegRd > "00000" and MEMWBRegRd = IDEXRegRs then
	ForwardA <= "01";
else
	ForwardA <= "00";
end if;

if EXMEMRegWrite = '1' and EXMEMRegRd > "00000" and EXMEMRegRd = IDEXRegRt and EXMEMShift = '0' then
	ForwardB <= "10";
elsif MEMWBRegWrite = '1' and MEMWBRegRd > "00000" and MEMWBRegRd = IDEXRegRt and MEMWBShift = '0' then
	ForwardB <= "01";
else
	ForwardB <= "00";
end if;

end process;
end Dataflow;