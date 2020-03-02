library IEEE;
use IEEE.std_logic_1164.all;

entity MEMWB is
	generic(N: integer := 32);
	port(i_CLK	: in std_logic;
	     i_RST	: in std_logic;
	     i_Wren	: in std_logic;
	     i_Stall	: in std_logic;
	     
	     i_ALURes	: in std_logic_vector(N-1 downto 0);
	     i_memRead	: in std_logic_vector(N-1 downto 0);
	     i_memtoReg	: in std_logic;
	     i_regWrite	: in std_logic;
	     i_linkCont	: in std_logic;
	     i_wAdd	: in std_logic_vector(4 downto 0);
	     i_ins	: in std_logic_vector(N-1 downto 0);
	     i_jal	: in std_logic_vector(N-1 downto 0);
	     i_WB	: in std_logic;
		i_shift : in std_logic;
		 o_shift : out std_logic;
	     o_ALURes	: out std_logic_vector(N-1 downto 0);
	     o_memRead	: out std_logic_vector(N-1 downto 0);
	     o_memtoReg	: out std_logic;
	     o_regWrite	: out std_logic;
	     o_linkCont	: out std_logic;
	     o_wAdd	: out std_logic_vector(4 downto 0);
	     o_ins	: out std_logic_vector(N-1 downto 0);
	     o_jal	: out std_logic_vector(N-1 downto 0);
	     o_WB	: out std_logic);

end MEMWB;

architecture behavior of MEMWB is

component StallReg
	generic(N : integer := 32);
  	port(i_CLK	: in std_logic;   
       	     i_RST   	: in std_logic;    
             i_Wren  	: in std_logic;    
       	     i_Stall 	: in std_logic;
       	     i_D      	: in std_logic_vector(N-1 downto 0);    
             o_Q     	: out std_logic_vector(N-1 downto 0));  

end component;



component SingleStallReg 
	generic(N: integer := 32);
	port(i_CLK	: in std_logic;
	     i_RST	: in std_logic;
	     i_Wren	: in std_logic;
	     i_Stall	: in std_logic;
	     i_D	: in std_logic;
	     o_Q	: out std_logic);

end component;

begin

	shiftGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_shift,
			 o_Q 		=> o_shift);

	ALUResGate: StallReg
		generic map(N => N)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_ALURes,
			 o_Q 		=> o_ALURes);

	memReadGate: StallReg
		generic map(N => N)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_memRead,
			 o_Q 		=> o_memRead);

	memtoRegGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_memtoReg,
			 o_Q 		=> o_memtoReg);

	regWriteGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_regWrite,
			 o_Q 		=> o_regWrite);
	
	linkContGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_linkCont,
			 o_Q 		=> o_linkCont);

	wAddGate: StallReg
		generic map(N => 5)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_wAdd,
			 o_Q 		=> o_wAdd);

	insGate: StallReg
		generic map(N => N)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_ins,
			 o_Q 		=> o_ins);

	jalGate: StallReg
		generic map(N => N)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_jal,
			 o_Q 		=> o_jal);

	WBGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_WB,
			 o_Q 		=> o_WB);

end behavior;


