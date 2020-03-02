library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.register_array_typev2.all;

entity ALU1b is 
	port(i_A      : in std_logic;
	     i_B      : in std_logic;
	     i_LT     : in std_logic;
	     i_AddSub : in std_logic;
	     i_cIn    : in std_logic;
	     i_Op     : in std_logic_vector(2 downto 0);
	     o_Set    : out std_logic;
	     o_OFlow  : out std_logic;
	     o_cOut   : out std_logic;
	     o_Res    : out std_logic);
end ALU1b;


architecture structure of ALU1b is

component invg is
  	port(i_A          : in std_logic;
       	     o_F          : out std_logic);

end component;


component andg2 is
  	port(i_A          : in std_logic;
       	     i_B          : in std_logic;
             o_F          : out std_logic);

end component;


component org2 is
  	port(i_A          : in std_logic;
             i_B          : in std_logic;
             o_F          : out std_logic);

end component;


component xorg2 is
  	port(i_A          : in std_logic;
             i_B          : in std_logic;
             o_F          : out std_logic);

end component;


component mux2to1 is
	port(i_A : in std_logic;
	     i_B : in std_logic;
	     i_S : in std_logic;
	     o_F : out std_logic);

end component;


component fullAdder is
	port(i_A : in std_logic;
	     i_B : in std_logic;
	     i_C : in std_logic;
	     o_C : out std_logic;
	     sum : out std_logic);

end component;


component mux8to1 is
 	port(i_A  : in registerArray;
             i_B  : in std_logic_vector(2 downto 0);
             o_C  : out std_logic);

end component;


signal s_Mux, s_And, s_Or, s_Xor, s_Nand, s_Nor, s_Mux8, s_Adder, s_AddC, s_LT : std_logic;
signal REG : registerArray;


begin

gate1: invg
	port MAP(i_A => i_B,
		 o_F => s_Mux);


gate2: andg2
	port MAP(i_A => i_A,
		 i_B => i_B,
		 o_F => s_And);


gate3: org2
	port MAP(i_A => i_A,
		 i_B => i_B,
		 o_F => s_Or);


gate4: xorg2
	port MAP(i_A => i_A,
		 i_B => i_B,
		 o_F => s_Xor);


gate5: invg
	port MAP(i_A => s_And,
		 o_F => s_Nand);


gate6: invg
	port MAP(i_A => s_Or,
		 o_F => s_Nor);


gate7: mux2to1
	port MAP(i_A => i_B,
	     	 i_B => s_Mux,
	     	 i_S => i_AddSub,
	    	 o_F => s_Mux8);


gate8: fullAdder
	port MAP(i_A => i_A,
       		 i_B => s_Mux8,
       		 i_C => i_cIn,
       		 o_C => s_AddC,
       		 sum => s_Adder);
	

REG <= (s_And, s_Or, s_Nand, s_Nor, s_Xor, s_Adder, i_LT, '0');


gate9: mux8to1
	port MAP(i_A => REG,
		 i_B => i_Op,
		 o_C => o_Res);


gate10: xorg2
	port MAP(i_A => s_AddC,
		 i_B => i_cIn,
		 o_F => s_LT);


gate11: org2
	port MAP(i_A => s_Adder,
		 i_B => s_LT,
		 o_F => o_Set);

o_OFlow <= s_LT;
o_cOut <= s_AddC;

end structure;
		 
	