library IEEE;
use IEEE.std_logic_1164.all;

entity Add_Sub is
	generic(N : integer := 32);
  	port(i_A : in std_logic_vector(N-1 downto 0);
	     i_B : in std_logic_vector(N-1 downto 0);
	     i_C : in std_logic;
	     res : out std_logic_vector(N-1 downto 0);
       	     o_C : out std_logic);

end Add_Sub;

architecture structure of Add_Sub is


component one_comp_Structure
 
	 port(i_A : in std_logic_vector(N-1 downto 0);
       	      o_F : out std_logic_vector(N-1 downto 0));

end component;


component mux2to1_2
  	
	port(i_A  : in std_logic_vector(N-1 downto 0);
	     i_B  : in std_logic_vector(N-1 downto 0);
	     i_S  : in std_logic;
             o_F  : out std_logic_vector(N-1 downto 0));

end component;


component fullAdderStructural
  	
	port(i_A : in std_logic_vector(N-1 downto 0);
	     i_B : in std_logic_vector(N-1 downto 0);
	     i_C : in std_logic;
             o_C : out std_logic;
             sum : out std_logic_vector(N-1 downto 0));

end component;


signal inv_B, mux : std_logic_vector(N-1 downto 0);


begin

part1: one_comp_Structure
 	
	port map(i_A => i_B,
  	  	 o_F => inv_B);

part2: mux2to1_2
 	
	port map(i_A => i_B,
	   	 i_B => inv_B,
	   	 i_S => i_C,
  	   	 o_F => mux);

part3: fullAdderStructural
  	
	port map(i_A => i_A,
           	 i_B => mux,
           	 i_C => i_C,
           	 o_C => o_C,
		 sum => res);
	
end structure;