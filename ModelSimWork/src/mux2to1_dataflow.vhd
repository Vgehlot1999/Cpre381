library IEEE;
use IEEE.std_logic_1164.all;

entity mux2to1_dataflow is 
	generic(N : integer := 32);
	port(i_A : in std_logic_vector(N-1 downto 0);
	     i_B : in std_logic_vector(N-1 downto 0);
	     i_S : in std_logic;
	     o_F : out std_logic_vector(N-1 downto 0));

end mux2to1_dataflow;

architecture dataflow of mux2to1_dataflow is
	signal sel, not1, and1, and2 : std_logic_vector(N-1 downto 0);

begin
	G1 : for i in 0 to N-1 generate
		sel(i) <= i_S;
	end generate;
	not1 <= not sel;
	and1 <= i_A and not1;
	and2 <= i_B and sel;
	o_F <= and1 or and2;

end dataflow;