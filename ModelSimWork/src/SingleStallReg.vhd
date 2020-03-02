library IEEE;
use IEEE.std_logic_1164.all;

entity SingleStallReg is 
	generic(N: integer := 32);
	port(i_CLK	: in std_logic;
	     i_RST	: in std_logic;
	     i_Wren	: in std_logic;
	     i_Stall	: in std_logic;
	     i_D	: in std_logic;
	     o_Q	: out std_logic);

end SingleStallReg;

architecture behavior of SingleStallReg is

	component dff1 is
		port(i_CLK        : in std_logic;     -- Clock input
       		     i_RST        : in std_logic;     -- Reset input
       		     i_WE         : in std_logic;     -- Write enable input
       		     i_D          : in std_logic;     -- Data value input
       		     o_Q          : out std_logic);   -- Data value output

	end component;




	component andg2 is
  		port(i_A          : in std_logic;
       		     i_B          : in std_logic;
       		     o_F          : out std_logic);

	end component;




	component invg is
  		port(i_A          : in std_logic;
       		     o_F          : out std_logic);

	end component;

	signal s_invS, s_andg : std_logic;
	
	begin
	
		gate1: invg
			port map(i_A 	=> i_Stall,
			 	 o_F 	=> s_invS);

		gate2: andg2
			port map(i_A	=> s_invS,
				 i_B	=> i_CLK,
				 o_F	=> s_andg);

		gate3: dff1
			port map(i_CLK	=> s_andg,
				 i_RST	=> i_RST,
				 i_WE => i_Wren,
				 i_D	=> i_D,
				 o_Q	=> o_Q);

end behavior;
 