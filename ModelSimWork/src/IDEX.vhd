library IEEE;
use IEEE.std_logic_1164.all;

entity IDEX is
	generic(N: integer := 32);
	port(i_CLK	: in std_logic;
	     i_RST	: in std_logic;
	     i_Wren	: in std_logic;
	     i_Stall	: in std_logic;
	     
	     i_reg1	: in std_logic_vector(N-1 downto 0);
	     i_reg2 	: in std_logic_vector(N-1 downto 0);
	     i_pcJump	: in std_logic_vector(N-1 downto 0);
	     i_pc	: in std_logic_vector(N-1 downto 0);
	     i_imm	: in std_logic_vector(N-1 downto 0);
	     i_sVal	: in std_logic_vector(4 downto 0);
	     i_ALUSRC	: in std_logic;
	     i_UpperI	: in std_logic;
	     i_VCont	: in std_logic;
	     i_BNE	: in std_logic;
	     i_BEQ	: in std_logic;
	     i_regJump	: in std_logic;
	     i_jump	: in std_logic;
	     i_memtoReg	: in std_logic;
	     i_memWren	: in std_logic;
	     i_sCont	: in std_logic_vector(1 downto 0);
	     i_AddSub	: in std_logic;
	     i_ALUShift	: in std_logic;
	     i_regWrite	: in std_logic;
	     i_ALUCont	: in std_logic_vector(2 downto 0);
	     i_uLess	: in std_logic;
	     i_linkCont	: in std_logic;
	     i_wAdd	: in std_logic_vector(4 downto 0);
	     i_ins	: in std_logic_vector(N-1 downto 0);
	     i_jal	: in std_logic_vector(N-1 downto 0);
	     i_WB	: in std_logic;
	     i_M	: in std_logic;
	     i_EX	: in std_logic;
	     i_rs	: in std_logic_vector(4 downto 0);
	     i_rt1	: in std_logic_vector(4 downto 0);
	     i_rt2	: in std_logic_vector(4 downto 0);
	     i_rd	: in std_logic_vector(4 downto 0);

	     o_reg1	: out std_logic_vector(N-1 downto 0);
	     o_reg2 	: out std_logic_vector(N-1 downto 0);
	     o_pcJump	: out std_logic_vector(N-1 downto 0);
	     o_pc	: out std_logic_vector(N-1 downto 0);
	     o_imm	: out std_logic_vector(N-1 downto 0);
	     o_sVal	: out std_logic_vector(4 downto 0);
	     o_ALUSRC	: out std_logic;
	     o_UpperI	: out std_logic;
	     o_VCont	: out std_logic;
	     o_BNE	: out std_logic;
	     o_BEQ	: out std_logic;
	     o_regJump	: out std_logic;
	     o_jump	: out std_logic;
	     o_memtoReg	: out std_logic;
	     o_memWren	: out std_logic;
	     o_sCont	: out std_logic_vector(1 downto 0);
	     o_AddSub	: out std_logic;
	     o_ALUShift	: out std_logic;
	     o_regWrite	: out std_logic;
	     o_ALUCont	: out std_logic_vector(2 downto 0);
	     o_uLess	: out std_logic;
	     o_linkCont	: out std_logic;
	     o_wAdd	: out std_logic_vector(4 downto 0);
	     o_ins	: out std_logic_vector(N-1 downto 0);
	     o_jal	: out std_logic_vector(N-1 downto 0);
	     o_WB	: out std_logic;
	     o_M	: out std_logic;
	     o_EX	: out std_logic;
	     o_rs	: out std_logic_vector(4 downto 0);
	     o_rt1	: out std_logic_vector(4 downto 0);
	     o_rt2	: out std_logic_vector(4 downto 0);
	     o_rd	: out std_logic_vector(4 downto 0));

end IDEX;

architecture behavior of IDEX is

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

	reg1Gate: StallReg
		generic map(N => N)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_reg1,
			 o_Q 		=> o_reg1);

	reg2Gate: StallReg
		generic map(N => N)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_reg2,
			 o_Q 		=> o_reg2);

	pcJumpGate: StallReg
		generic map(N => N)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_pcJump,
			 o_Q 		=> o_pcJump);

	pcGate: StallReg
		generic map(N => N)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_pc,
			 o_Q 		=> o_pc);

	immGate: StallReg
		generic map(N => N)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_imm,
			 o_Q 		=> o_imm);

	sValGate: StallReg
		generic map(N => 5)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_sVal,
			 o_Q 		=> o_sVal);

	ALUSRCGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_alusrc,
			 o_Q 		=> o_alusrc);

	UpperIGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_UpperI,
			 o_Q 		=> o_UpperI);

	VContGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_VCont,
			 o_Q 		=> o_VCont);
	
	BNEGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_BNE,
			 o_Q 		=> o_BNE);

	BEQGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_BEQ,
			 o_Q 		=> o_BEQ);

	regJumpGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_regJump,
			 o_Q 		=> o_regJump);

	jumpGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_jump,
			 o_Q 		=> o_jump);

	memtoRegGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_memtoReg,
			 o_Q 		=> o_memtoReg);

		
	memWrenGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_memWren,
			 o_Q 		=> o_memWren);

	sContGate: StallReg
		generic map(N => 2)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_sCont,
			 o_Q 		=> o_sCont);

	AddSubGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_AddSub,
			 o_Q 		=> o_AddSub);

	ALUShiftGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_ALUShift,
			 o_Q 		=> o_ALUShift);

	regWriteGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_regWrite,
			 o_Q 		=> o_regWrite);

	ALUContGate: StallReg
		generic map(N => 3)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_ALUCont,
			 o_Q 		=> o_ALUCont);

	uLessGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_uLess,
			 o_Q 		=> o_uLess);

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

	MGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_M,
			 o_Q 		=> o_M);

	EXGate: SingleStallReg
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_EX,
			 o_Q 		=> o_EX);

	rsGate: StallReg
		generic map(N => 5)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_rs,
			 o_Q 		=> o_rs);

	rt1Gate: StallReg
		generic map(N => 5)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_rt1,
			 o_Q 		=> o_rt1);

	rt2Gate: StallReg
		generic map(N => 5)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_rt2,
			 o_Q 		=> o_rt2);

	rdGate: StallReg
		generic map(N => 5)
		port map(i_CLK		=> i_CLK,
			 i_RST 		=> i_RST,
			 i_Wren		=> i_Wren,
			 i_Stall	=> i_Stall,
			 i_D 		=> i_rd,
			 o_Q 		=> o_rd);

end behavior;

