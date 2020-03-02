library IEEE;
use IEEE.std_logic_1164.all;

entity mergeALU is
  generic(N : integer := 32);
		
  port(	
	i_A     	: in std_logic_vector(N-1 downto 0);
    i_B     	: in std_logic_vector(N-1 downto 0);
	i_sel    	: in std_logic_vector(4 downto 0);
	i_Func   	: in std_logic_vector(1 downto 0); 
    i_AddSub 	: in std_logic; 
    i_Op     	: in std_logic_vector(2 downto 0); 
    o_OFlow  	: out std_logic;
    o_cOut   	: out std_logic;
	i_Unsigned 	: in std_logic;
    i_S      	: in std_logic;
    o_F      	: out std_logic_vector(N-1 downto 0));


end mergeALU;



architecture behavior of mergeALU is

component barrelShifter is
  	generic(N : integer := 32);
		
  	port(i_32b  : in std_logic_vector(N-1 downto 0);
	     i_sel  : in std_logic_vector(4 downto 0);
	     i_Func  : in std_logic_vector(1 downto 0);
	     o_32b  : out std_logic_vector(N-1 downto 0));


end component;




component ALU32b is
  	generic(N : integer := 32);
  	
	port(i_A      : in std_logic_vector(N-1 downto 0);
             i_B      	: in std_logic_vector(N-1 downto 0); 
             i_AddSub 	: in std_logic; 
             i_cIn    	: in std_logic; 
             i_Op     	: in std_logic_vector(2 downto 0); 
             o_OFlow  	: out std_logic;
             o_cOut   	: out std_logic;
			 i_Unsigned : in std_logic;
             o_res    	: out std_logic_vector(N-1 downto 0)); 

end component;




component mux2to1_dataflow is
  	generic(N : integer := 14);
  	
	port(i_A : in std_logic_vector(N-1 downto 0);
             i_B : in std_logic_vector(N-1 downto 0);
             i_S : in std_logic;
             o_F : out std_logic_vector(N-1 downto 0));

end component;

signal s_Out, s_Shift : std_logic_vector(N-1 downto 0);



begin

gate1: ALU32b
	generic map(N => N)
  	port map(i_A      	=> i_A ,
       		 i_B      	=> i_B,
       		 i_AddSub 	=> i_AddSub,
       		 i_cIn    	=> i_AddSub,
       		 i_Op    	=> i_Op,
       		 o_OFlow 	=> o_OFlow,
      		 o_cOut   	=> o_cOut ,
			 i_Unsigned => i_Unsigned,
       		 o_res    	=> s_Out); 

	
gate2: barrelShifter
  	generic map(N=>N)
  	port map(i_32b  => i_B,
		 i_sel  => i_sel,
		 i_Func => i_Func,
		 o_32b  => s_Shift);


gate3: mux2to1_dataflow
	generic map(N=>N)
  	port map(i_A => s_Out,
       	 	 i_B => s_Shift,
       		 i_S => i_S,
       		 o_F => o_F);  

end behavior;