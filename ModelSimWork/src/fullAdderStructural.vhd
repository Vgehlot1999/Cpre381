library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdderStructural is
	
	generic(N : integer := 32);

	port(i_A : in std_logic_vector(N-1 downto 0);
	     i_B : in std_logic_vector(N-1 downto 0);
	     i_C : in std_logic;
	     o_C : out std_logic;
	     sum : out std_logic_vector(N-1 downto 0));

end fullAdderStructural;

architecture structure of fullAdderStructural is

	component fullAdder
		port(i_A : in std_logic;
	             i_B : in std_logic;
	     	     i_C : in std_logic;
	     	     o_C : out std_logic;
	     	     sum : out std_logic);
	end component;

signal c_In : std_logic_vector(N downto 0);

begin
	c_In(0) <= i_C;

	G1: for i in 0 to N-1 generate
	fullAdder_N : fullAdder
		port map(i_A => i_A(i),
			 i_B => i_B(i),
			 i_C => c_In(i),
			 sum => sum(i),
			 o_C => c_In(i + 1));
	end generate;

	o_C <= c_In(N);

end structure;
