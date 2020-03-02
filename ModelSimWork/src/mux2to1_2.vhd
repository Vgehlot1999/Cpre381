library IEEE;
use IEEE.std_logic_1164.all;

entity mux2to1_2 is
	generic(N : integer := 32);
	port(i_A : in std_logic_vector(N-1 downto 0);
	     i_B : in std_logic_vector(N-1 downto 0);
	     i_S : in std_logic;
	     o_F : out std_logic_vector(N-1 downto 0));

end mux2to1_2;

architecture structure of mux2to1_2 is

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

	signal not1, and1, and2 : std_logic_vector(N-1 downto 0);

	
	begin 
	    
	    G1: for i in 0 to N-1 generate
		
		invg_1 : invg
			port map(i_A => i_S,
				 o_F => not1(i));

		and_1 : andg2
			port map(i_A => i_A(i),
				 i_B =>not1(i),
				 o_F => and1(i));

		and_2 : andg2
			port map(i_A => i_S,
				 i_B => i_B(i),
				 o_F => and2(i));

		or_1 : org2
			port map(i_A => and1(i),
				 i_B => and2(i),
				 o_F => o_F(i));
	    end generate;

end structure; 