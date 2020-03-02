library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder is

	port(i_A : in std_logic;
	     i_B : in std_logic;
	     i_C : in std_logic;
	     o_C : out std_logic;
	     sum : out std_logic);

end fullAdder;

architecture structure of fullAdder is

component org2 is
	port(i_A : in std_logic;
	     i_B : in std_logic;
	     o_F : out std_logic);
end component;

component xorg2 is
	port(i_A : in std_logic;
	     i_B : in std_logic;
	     o_F : out std_logic);
end component;

component andg2 is
	port(i_A : in std_logic;
	     i_B : in std_logic;
	     o_F : out std_logic);
end component;

signal s_XOR, s_AND1, s_AND2 : std_logic;

begin

gate1 : xorg2
	port map(i_A => i_A,
		 i_B => i_B,
		 o_F => s_XOR);

gate2 : xorg2
	port map(i_A => s_XOR,
		 i_B => i_C,
		 o_F => sum);

gate3 : andg2
	port map(i_A => i_C,
		 i_B => s_XOR,
		 o_F => s_AND1);

gate4 : andg2
	port map(i_A => i_B,
		 i_B => i_A,
		 o_F => s_AND2);

gate5 : org2
	port map(i_A => s_AND1,
		 i_B => s_AND2,
		 o_F => o_C);

end structure;
		