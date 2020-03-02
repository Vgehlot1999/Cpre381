library IEEE;
use IEEE.std_logic_1164.all;

entity IFID is
	generic(N: integer := 32);
	port(i_CLK	: in std_logic;
	     i_RST	: in std_logic;
	     i_Wren	: in std_logic;
	     i_Stall	: in std_logic;
	     
	     i_ins	: in std_logic_vector(N-1 downto 0);
	     i_pc1 	: in std_logic_vector(N-1 downto 0);
	     i_pc2	: in std_logic_vector(N-1 downto 0);
	     o_ins	: out std_logic_vector(N-1 downto 0);
	     o_pc1 	: out std_logic_vector(N-1 downto 0);
	     o_pc2	: out std_logic_vector(N-1 downto 0));

end IFID;

architecture behavior of IFID is
	
component StallReg is
	generic(N : integer := 32);
  	port(i_CLK	: in std_logic;   
       	     i_RST   	: in std_logic;    
             i_Wren  	: in std_logic;    
       	     i_Stall 	: in std_logic;
       	     i_D      	: in std_logic_vector(N-1 downto 0);    
             o_Q     	: out std_logic_vector(N-1 downto 0)); 

end component;


begin
	
	insGate: StallReg
		generic map(N => N)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_ins,
			 o_Q 		=> o_ins);
	
	pc1Gate: StallReg
		generic map(N => N)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_pc1,
			 o_Q 		=> o_pc1);

	pc2Gate: StallReg
		generic map(N => N)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_pc2,
			 o_Q 		=> o_pc2);

end behavior;