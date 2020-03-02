library IEEE;
use IEEE.std_logic_1164.all;

entity mux2to1 is
	port(i_A : in std_logic;
	     i_B : in std_logic;
	     i_S : in std_logic;
	     o_F : out std_logic);

end mux2to1;

architecture structure of mux2to1 is

	component andg2
		port(i_A : in std_logic;
		     i_B : in std_logic;
		     o_F : out std_logic);
	end component;

	component org2
		port(i_A : in std_logic;
		     i_B : in std_logic;
		     o_F : out std_logic);
	end component;

	component invg
		port(i_A : in std_logic;
		     o_F : out std_logic);
	end component;

	signal not1, and1, and2 : std_logic;

	
	begin 
	
		invg_1 : invg
			port map(i_A => i_S,
				 o_F => not1);

		and_1 : andg2
			port map(i_A => i_A,
				 i_B =>not1,
				 o_F => and1);

		and_2 : andg2
			port map(i_A => i_S,
				 i_B => i_B,
				 o_F => and2);

		or_1 : org2
			port map(i_A => and1,
				 i_B => and2,
				 o_F => o_F);

end structure; 