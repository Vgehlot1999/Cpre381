library IEEE;
use IEEE.std_logic_1164.all;

entity ALU32b is 
	generic(N: integer := 32);
	port(i_A      	: in std_logic_vector(N-1 downto 0);
	     i_B      	: in std_logic_vector(N-1 downto 0);
	     i_AddSub 	: in std_logic;
	     i_cIn    	: in std_logic;
	     i_Op     	: in std_logic_vector(2 downto 0);
	     o_OFlow  	: out std_logic;
	     o_cOut   	: out std_logic;
		 i_Unsigned	: in std_logic;
	     o_Res    	: out std_logic_vector(N-1 downto 0));
end ALU32b;

architecture structure of ALU32b is

component invg is
  port(i_A          : in std_logic;
       o_F          : out std_logic);

end component;

component xorg2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component ALU1b is
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

end component;

signal s_cOut : std_logic_vector(N-1 downto 0);
signal s_Set, s_iSet, s_SetInt, s_SetHelp : std_logic;
signal s_UnsignedH : std_logic_vector(1 downto 0);

begin

s_cOut(0) <= i_cIn;


gate1: ALU1b
	port MAP(i_A      => i_A(0),
		 i_B      => i_B(0),
		 i_LT     => s_Set,
		 i_AddSub => i_AddSub,
		 i_cIn    => s_cOut(0),
		 i_Op     => i_Op,
		 o_cOut   => s_cOut(1),
		 o_Res    => o_Res(0));


G: for i in 1 to N-2 generate

gate2: ALU1b
	port MAP(i_A      => i_A(i),
		 i_B      => i_B(i),
		 i_LT     => '0',
		 i_AddSub => i_AddSub,
		 i_cIn    => s_cOut(i),
		 i_Op     => i_Op,
		 o_cOut   => s_cOut(i+1),
		 o_Res    => o_Res(i));

end generate;

gate3: ALU1b
	port MAP(i_A      => i_A(N-1),
		 i_B      => i_B(N-1),
		 i_LT     => '0',
		 i_AddSub => i_AddSub,
		 i_cIn    => s_cOut(N-1),
		 i_Op     => i_Op,
		 o_Set => s_SetInt,
		 o_cOut   => o_cOut,
		 o_OFlow => o_OFlow,
		 o_Res    => o_Res(N-1));
		 
gate4: invg
	port MAP(i_A => s_SetInt,
		 o_F => s_iSet);
			 
gate5: xorg2
	port MAP(i_A => i_A(N-1),
			 i_B => i_B(N-1),
			 o_F => s_SetHelp);
			 
s_UnsignedH <= s_SetHelp & i_Unsigned;
s_Set <= s_iSet when s_UnsignedH = "11" else s_SetInt;

end structure;
		 