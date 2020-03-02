-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_misc.all;

entity MIPS_Processor is
  generic(N : integer := 32);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal v0             : std_logic_vector(N-1 downto 0); -- TODO: should be assigned to the output of register 2, used to implement the halt SYSCALL
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. This case happens when the syscall instruction is observed and the V0 register is at 0x0000000A. This signal is active high and should only be asserted after the last register and memory writes before the syscall are guaranteed to be completed.




  component mem is
    	generic(
		ADDR_WIDTH 		: integer;
            	DATA_WIDTH 		: integer);
    	port(
         	clk         		: in std_logic;
          	addr        		: in std_logic_vector((ADDR_WIDTH-1) downto 0);
          	data         		: in std_logic_vector((DATA_WIDTH-1) downto 0);
          	we           		: in std_logic := '1';
          	q            		: out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment

component mux2to1_2 is
	generic(N : integer := 32);
	port(
		i_A 			: in std_logic_vector(N-1 downto 0);
	     	i_B 			: in std_logic_vector(N-1 downto 0);
	     	i_S 			: in std_logic;
		o_F 			: out std_logic_vector(N-1 downto 0));
end component;




component mergeALU is
	generic(N : integer := 32);
  	port(
		i_A      		: in std_logic_vector(N-1 downto 0);
    		i_B      		: in std_logic_vector(N-1 downto 0);
		i_sel    		: in std_logic_vector(4 downto 0);
		i_Func   		: in std_logic_vector(1 downto 0); 
    		i_AddSub 		: in std_logic; 
   	 	i_Op     		: in std_logic_vector(2 downto 0); 
    		o_OFlow  		: out std_logic;
    		o_cOut   		: out std_logic;
		i_Unsigned		: in std_logic; 
    		i_S      		: in std_logic;
    		o_F      		: out std_logic_vector(N-1 downto 0));
end component;




component RegisterFile is
	port(rd    : in std_logic_vector(31 downto 0);
	     sel_d : in std_logic_vector(4 downto 0);
	     sel_s : in std_logic_vector(4 downto 0);
	     sel_t : in std_logic_vector(4 downto 0);
	     en    : in std_logic;
	     i_RST : in std_logic;
	     CLK   : in std_logic;
	     rs    : out std_logic_vector(31 downto 0);
	     rt    : out std_logic_vector(31 downto 0);
	     r2    : out std_logic_vector(31 downto 0));

end component;




component extender is
	generic(N : integer := 32);
  	port(
		i_16b  			: in std_logic_vector(15 downto 0); 
       		i_sel  			: in std_logic;
      		o_32b  			: out std_logic_vector(N-1 downto 0)); 
end component;




component ControlU is
	port
	(
		i_Opcode           	: in std_logic_vector(5 downto 0);    
		i_Funct            	: in std_logic_vector(5 downto 0);
		o_ALUSrc		: out std_logic;
		o_ALUCont		: out std_logic_vector(2 downto 0);
		o_MemtoReg		: out std_logic;
		o_DMemWr		: out std_logic;
		o_RegWr			: out std_logic;
		o_RegDst		: out std_logic;
		o_AddSub		: out std_logic;
		o_ShiftFunct		: out std_logic_vector(1 downto 0);
		o_ALUShiftSel		: out std_logic;
		o_SignedI		: out std_logic;
		o_LinkCont		: out std_logic;
		o_BEQ			: out std_logic;
		o_BNE			: out std_logic;
		o_RegJumpCont		: out std_logic;
		o_JumpCont		: out std_logic;
		o_uLess			: out std_logic;
		o_vControl		: out std_logic;
		o_UpperI		: out std_logic);
end component;   




component Add_Sub is
	generic(N : integer := 32);
  	port(
		i_A 			: in std_logic_vector(N-1 downto 0);
	     	i_B 			: in std_logic_vector(N-1 downto 0);
	     	i_C 			: in std_logic;
	     	res 			: out std_logic_vector(N-1 downto 0);
       	    	o_C 			: out std_logic);
end component;




component nBitReg is
	generic(N : integer := 32);
  	port(
		i_CLK        		: in std_logic; 
       		i_RST        		: in std_logic; 
       		i_WE         		: in std_logic;  
     		i_D          		: in std_logic_vector(N-1 downto 0);     
     		o_Q          		: out std_logic_vector(N-1 downto 0));
end component;




component andg2 is
	port(
		i_A          		: in std_logic;
       		i_B          		: in std_logic;
       		o_F          		: out std_logic);
end component;




component org2 is
 	 port(
		i_A         		: in std_logic;
       		i_B          		: in std_logic;
       		o_F          		: out std_logic);
end component;




component invg is
  	port(
		i_A          		: in std_logic;
       		o_F          		: out std_logic);
end component;

























component IFID is
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

end component;












component IDEX is
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

end component;













component EXMEM is
	generic(N: integer := 32);
	port(i_CLK	: in std_logic;
	     i_RST	: in std_logic;
	     i_Wren	: in std_logic;
	     i_Stall	: in std_logic;
	     
	     i_ALURes	: in std_logic_vector(N-1 downto 0);
	     i_reg	: in std_logic_vector(N-1 downto 0);
	     i_memtoReg	: in std_logic;
	     i_memWren	: in std_logic;
	     i_regWrite	: in std_logic;
	     i_linkCont	: in std_logic;
	     i_wAdd	: in std_logic_vector(4 downto 0);
	     i_ins	: in std_logic_vector(N-1 downto 0);
	     i_jal	: in std_logic_vector(N-1 downto 0);
	     i_WB	: in std_logic;
	     i_M	: in std_logic;
	     i_rs	: in std_logic_vector(4 downto 0);
	     i_rt1	: in std_logic_vector(4 downto 0);
	     i_rt2	: in std_logic_vector(4 downto 0);
	     i_rd	: in std_logic_vector(4 downto 0);
		 i_BLOC : in std_logic_vector(N-1 downto 0);
		 i_shift : in std_logic;
		 o_shift : out std_logic;
		 o_BLOC : out std_logic_vector(N-1 downto 0);
	     o_ALURes	: out std_logic_vector(N-1 downto 0);
	     o_reg 	: out std_logic_vector(N-1 downto 0);
	     o_memtoReg	: out std_logic;
	     o_memWren	: out std_logic;
	     o_regWrite	: out std_logic;
	     o_linkCont	: out std_logic;
	     o_wAdd	: out std_logic_vector(4 downto 0);
	     o_ins	: out std_logic_vector(N-1 downto 0);
	     o_jal	: out std_logic_vector(N-1 downto 0);
	     o_WB	: out std_logic;
	     o_M	: out std_logic;
	     o_rs	: out std_logic_vector(4 downto 0);
	     o_rt1	: out std_logic_vector(4 downto 0);
	     o_rt2	: out std_logic_vector(4 downto 0);
	     o_rd	: out std_logic_vector(4 downto 0));

end component;












component MEMWB is
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

end component;

component ForwardingUnit is
port(
	EXMEMRegWrite : in std_logic;
	EXMEMShift : in std_logic;
	EXMEMRegRd : in std_logic_vector(4 downto 0);
	IDEXBranch : in std_logic;
	IDEXRegRs : in std_logic_vector(4 downto 0);
	IDEXRegRt : in std_logic_vector(4 downto 0);
	IDEXBranchRegRs : in std_logic_vector(4 downto 0);
	IDEXBranchRegRt : in std_logic_vector(4 downto 0);
	MEMWBRegWrite : in std_logic;
	MEMWBRegRd : in std_logic_vector(4 downto 0);
	MEMWBShift : in std_logic;
	BranchA : out std_logic_vector(1 downto 0);
	BranchB : out std_logic_vector(1 downto 0);
	ForwardA : out std_logic_vector(1 downto 0);
	ForwardB : out std_logic_vector(1 downto 0));
end component;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--***************************************************************************************************************************************************************************************--
--***************************************************************************************************************************************************************************************--
--***************************************************************************************************************************************************************************************--
--***************************************************************************************************************************************************************************************--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

signal s_SignedI, s_RegDst, s_RegWrite, s_ALUSrc, s_UpperI, s_AddSub, s_ALUShiftSel, s_MemWr, s_MemtoReg, s_vControl, s_ULess, s_linkCont, s_ALUZero, s_ALUnZero, s_BEQ, s_BNE, s_branch, s_BEQAnd, s_BNEAnd, s_RACont, s_jCont: std_logic;
signal s_JumpLinkTwo,s_Reg1, s_Reg2, s_Mux1, s_Mux2, s_Imm, s_D, s_oInt, s_qInt,forwardInALUA, forwardInALUB, s_PCIn, s_Instr, s_JumpLink, s_JumpLinkData, s_jumpInst, s_nextInst, s_LS, s_BLoc, s_PC1, s_PC2, s_PCMux: std_logic_vector(N-1 downto 0);
signal s_ShiftCont: std_logic_vector(1 downto 0);
signal s_ALUCont: std_logic_vector(2 downto 0);

signal s_regWrAddress, s_Shift, s_vShift, s_JumpLinkAddress: std_logic_vector(4 downto 0);


--IFID
signal s_ins1, s_nIns, s_JALAddOut1 : std_logic_vector(N-1 downto 0);

--IDEX
signal ms2, wbs2, exs2, alusrcs2, ulesss2, upImms2, vs2, branchEqus2, branchNotEqus2, raControls2, jumpControls2, memToRegs2, memWrites2, addSubs2, aluShiftSelects2, RegWrites2, linkcontrols2: std_logic;
signal regout1s2, regout2s2, JumpInstructionLocations2, nIns2, immediates2, s_ins2, JALAddOut2: std_logic_vector(N-1 downto 0);
signal sVal2, rss2, rds2, rt1s2, rt2s2, jalAddress2: std_logic_vector(4 downto 0);
signal sCont2, forwardA, forwardB : std_logic_vector(1 downto 0);
signal aluOp2: std_logic_vector(2 downto 0);

--EXMEM
signal ms3, wbs3, memToRegs3, memWrites3, RegWrites3, aluShiftSelects3,linkcontrols3 : std_logic;
signal rss3, rds3, rt1s3, rt2s3, jalAddresss3: std_logic_vector(4 downto 0);
signal regout3, alures3, s_ins3, JALAddOut3, s_BLocDel: std_logic_vector(N-1 downto 0);

--MEMWB
signal JumpLinkAddress4: std_logic_vector(4 downto 0);
signal wbs4, memToRegs4, RegWrite4, linkcont4, memwbshift : std_logic;
signal memreads4, alures4, s_ins4, JALAddOut4: std_logic_vector(N-1 downto 0);


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--***************************************************************************************************************************************************************************************--
--***************************************************************************************************************************************************************************************--
--***************************************************************************************************************************************************************************************--
--***************************************************************************************************************************************************************************************--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;

	
gate1: nBitReg
	generic MAP(N => 32)
	port MAP(
		i_CLK 		=> iCLK,
		i_RST 		=> iRST,
		i_WE  		=> '1',
		i_D		=> s_PCIn,
		o_Q 		=> s_NextInstAddr);

gate2: Add_Sub
	generic MAP(N => 32)
	port MAP(
		i_A 		=> s_NextInstAddr,
		i_B 		=> x"00000004",
		i_C		=> '0',
		res 		=> s_JumpLink);

s_JumpLinkTwo <= s_JumpLink or x"00400000";

gate3: Add_Sub
	generic MAP(N => N)
	port MAP(
		i_A 		=> s_NextInstAddr,
		i_B 		=> x"00000004",
		i_C		=> '0',
		res 		=> s_nextInst);

IMem: mem
    	generic map(
		ADDR_WIDTH 	=> 10,
                DATA_WIDTH 	=> N)
    	port map(
		clk  		=> iCLK,
            	addr 		=> s_IMemAddr(11 downto 2),
             	data 		=> iInstExt,
             	we   		=> iInstLd,
             	q    		=> s_Inst);

s_Instr <= s_Inst;

s_Halt <='1' when (s_ins4(31 downto 26) = "000000") and (s_ins4(5 downto 0) = "001100") and (v0 = "00000000000000000000000000001010") else '0';


----------------------------------------------------------------------------------------------


gate20: IFID
	generic map (N => N)
	port map(i_CLK	=> iCLK,
	     i_RST	=> iRST,
	     i_Wren	=> '1',
	     i_Stall	=> '0',
	     
	     i_ins	=> s_Instr,
	     i_pc1 	=> s_nextInst,
	     i_pc2	=> s_JumpLinkTwo,
	     o_ins	=> s_ins1,
	     o_pc1 	=> s_nIns,
	     o_pc2	=> s_JALAddOut1);


----------------------------------------------------------------------------------------------







forward: ForwardingUnit
	port MAP(
		EXMEMRegWrite => RegWrites3,
		EXMemShift => aluShiftSelects3,
		EXMemRegRd => jaladdresss3,
		IDEXRegRs => rss2,
		IDEXRegRt => rt1s2,
		IDEXBranch => '1',
		IDEXBranchRegRs => "00000",
		IDEXBranchRegRt => "00000",
		MEMWBRegWrite => RegWrite4,
		MEMWBRegRd => JumpLinkAddress4,
		MEMWBShift => memwbshift,
		ForwardA => forwardA,
		ForwardB => forwardB
		
	);

gate4: ControlU
	port MAP(
		i_Opcode	=> s_ins1(31 downto 26),        	
		i_Funct       	=> s_ins1(5 downto 0),
		o_ALUSrc	=> s_ALUSrc,
		o_ALUCont	=> s_ALUCont,	
		o_MemtoReg	=> s_MemtoReg,
		o_DMemWr	=> s_MemWr,
		o_RegWr		=> s_RegWrite,
		o_RegDst	=> s_RegDst,
		o_AddSub 	=> s_AddSub,
		o_ShiftFunct	=> s_ShiftCont,
		o_ALUShiftSel	=> s_ALUShiftSel,
		o_SignedI	=> s_SignedI,
		o_LinkCont	=> s_LinkCont,
		o_BEQ		=> s_BEQ,
		o_BNE		=> s_BNE,
		o_RegJumpCont	=> s_RACont,
		o_JumpCont	=> s_jCont,
		o_uLess		=> s_ULess,	
		o_vControl	=> s_vControl,
		o_UpperI	=> s_UpperI);

gate5: mux2to1_2
	generic MAP(N => 5)
	port MAP(
		i_A 		=> s_ins1(20 downto 16),
		i_B 		=> s_ins1(15 downto 11),
		i_S 		=> s_RegDst,
		o_F 		=> s_regWrAddress);

gate6: mux2to1_2
	generic MAP(N => 32)
	port MAP(
		i_A 		=> s_D,
		i_B 		=> JALAddOut4,--s_JumpLinkTwo,
		i_S 		=> linkcont4,--s_LinkCont,
		o_F 		=> s_JumpLinkData);
 
gate7: mux2to1_2
	generic MAP(N => 5)
	port MAP(
		i_A 		=> s_regWrAddress,
		i_B 		=> "11111",
		i_S 		=> s_LinkCont,
		o_F 		=> s_JumpLinkAddress);

gate8: extender
	generic MAP(N => 32)
  	port MAP(
		i_16b  		=> s_ins1(15 downto 0),	
       		i_sel  		=> s_SignedI,
      		o_32b  		=> s_Imm);









s_JumpInst 	<= s_nIns(31 downto 28) & s_ins1(25 downto 0) & "00";
s_LS 		<= s_Imm(29 downto 0) & "00";











gate9: Add_Sub
	generic MAP(N => 32)
	port MAP(
		i_A 		=> s_nIns,
		i_B 		=> s_LS,
		i_C		=> '0',
		res 		=> s_BLoc);

gate10: registerFile
	port MAP(
		rd    		=> s_JumpLinkData,
	     	sel_d 		=> JumpLinkAddress4,
	     	sel_s 		=> s_ins1(25 downto 21),
	     	sel_t 		=> s_ins1(20 downto 16),
	     	en    		=> RegWrite4,
	    	i_RST 		=> iRST,	
	     	CLK   		=> iCLK,	
	     	rs    		=> s_Reg1,
		rt    		=> s_Reg2,
		r2 		=> v0);

s_RegWr		<= RegWrite4;
s_RegWrAddr 	<= JumpLinkAddress4;
s_RegWrData 	<= s_JumpLinkData;












--s_oInt <= s_Reg1 xor s_Reg2;

s_ALUZero <= or_reduce(s_oInt);














s_ALUnZero <= not s_ALUZero;
s_BEQAnd <= branchEqus2 and s_ALUnZero;
s_BNEAnd <= branchNotEqus2 and s_ALUZero;
s_branch <= s_BNEAnd or s_BEQAnd;

gate16: mux2to1_2
	generic MAP(N => 32)
	port MAP(
		i_A 		=> s_nextInst,
		i_B 		=> s_BLocDel,
		i_S 		=> s_branch,
		o_F 		=> s_PC1);


gate17: mux2to1_2
	generic MAP(N => 32)
	port MAP(
		i_A 		=> s_PC1,
		i_B 		=> s_Reg1,
		i_S 		=> s_RACont,
		o_F 		=> s_PC2);


gate18: mux2to1_2
	generic MAP(N => 32)
	port MAP(
		i_A 		=> s_PC2,
		i_B 		=> s_JumpInst,
		i_S 		=> s_jCont,
		o_F 		=> s_PCIn);








--------------------------------------------------------------------------



gate21: IDEX
	generic map(N => N)
	port map(i_CLK	=> iCLK,
	     i_RST	=> iRST,
	     i_Wren	=> '1',
	     i_Stall	=> '0',
	     
	     i_reg1	=> s_Reg1,
	     i_reg2 	=> s_Reg2,
	     i_pcJump	=> s_JumpInst,
	     i_pc	=> s_nIns,
	     i_imm	=> s_Imm,
	     i_sVal	=> s_ins1(10 downto 6),
	     i_ALUSRC	=> s_ALUsrc,
	     i_UpperI	=> s_UpperI,
	     i_VCont	=> s_vControl,
	     i_BNE	=> s_BNE,
	     i_BEQ	=> s_BEQ,
	     i_regJump	=> s_RACont,
	     i_jump	=> s_jCont,
	     i_memtoReg	=> s_memtoReg,
	     i_memWren	=> s_memWr,
	     i_sCont	=> s_ShiftCont,
	     i_AddSub	=> s_AddSub,
	     i_ALUShift	=> s_ALUShiftSel,
	     i_regWrite	=> s_RegWrite,
	     i_ALUCont	=> s_ALUCont,
	     i_uLess	=> s_ULess,
	     i_linkCont	=> s_LinkCont,
	     i_wAdd	=> s_JumpLinkAddress,
	     i_ins	=> s_ins1,
	     i_jal	=> s_JALAddOut1,
	     i_WB	=> '0',
	     i_M	=> '0',
	     i_EX	=> '0',
	     i_rs	=> s_ins1(25 downto 21),
	     i_rt1	=> s_ins1(20 downto 16),
	     i_rt2	=> s_ins1(10 downto 6),
	     i_rd	=> s_ins1(10 downto 6),

	     o_reg1	=> regout1s2,
	     o_reg2 	=> regout2s2,
	     o_pcJump	=> JumpInstructionLocations2,
	     o_pc	=> nIns2,
	     o_imm	=> immediates2,
	     o_sVal	=> sVal2,
	     o_ALUSRC	=> alusrcs2,
	     o_UpperI	=> upImms2,
	     o_VCont	=> vs2,
	     o_BNE	=> branchNotEqus2,
	     o_BEQ	=> branchEqus2,
	     o_regJump	=> raControls2,
	     o_jump	=> jumpControls2,
	     o_memtoReg	=> memtoRegs2,
	     o_memWren	=> memWrites2,
	     o_sCont	=> sCont2,
	     o_AddSub	=> addSubs2,
	     o_ALUShift	=> aluShiftSelects2,
	     o_regWrite	=> RegWrites2,
	     o_ALUCont	=> aluOp2,
	     o_uLess	=> ulesss2,
	     o_linkCont	=> linkcontrols2,
	     o_wAdd	=> jaladdress2,
	     o_ins	=> s_ins2,
	     o_jal	=> JALAddOut2,
	     o_WB	=> wbs2,
	     o_M	=> ms2,
	     o_EX	=> exs2,
	     o_rs	=> rss2,
	     o_rt1	=> rt1s2,
	     o_rt2	=> rt2s2,
	     o_rd	=> rds2);




--------------------------------------------------------------------------


gate11: mux2to1_2
	generic MAP(N => 32)
	port MAP(
		i_A 		=> regOut2s2,
		i_B 		=> immediates2,
		i_S 		=> alusrcs2,
		o_F 		=> s_Mux1);

gate12: mux2to1_2
	generic MAP(N => 32)
	port MAP(
		i_A 		=> regOut1s2,
		i_B 		=> s_Mux1,
		i_S 		=> upImms2,
		o_F 		=> s_Mux2);

gate13: mux2to1_2
	generic MAP(N => 5)
	port MAP(
		i_A 		=> sVal2,
		i_B 		=> s_Mux2(4 downto 0),
		i_S 		=> vs2,
		o_F 		=> s_vShift);

gate14: mux2to1_2
	generic MAP(N => 5)
	port MAP(
		i_A 		=> s_vShift,
		i_B 		=> "10000",
		i_S 		=> upImms2,
		o_F 		=> s_Shift);

forwardInALUA <= s_Mux2 when ForwardA = "00" else
	s_RegWrData when ForwardA = "01" else
	alures3 when ForwardA = "10" else
	s_Mux2;
forwardInALUB <= s_Mux1 when ForwardB = "00" else
	s_RegWrData when ForwardB = "01" else
	alures3 when ForwardB = "10" else
	s_Mux2;	
	
	
gate15: mergeALU
	generic MAP(N => 32)
  	port MAP(
		i_A      	=>  forwardInALUA,	
    		i_B      	=> forwardInALUB,	
		i_sel    	=> s_Shift,	
		i_Func   	=> sCont2,	
    		i_AddSub 	=> addSubs2,
   	 	i_Op     	=> aluOp2,
		i_Unsigned	=> ulesss2,
    		i_S      	=> aluShiftSelects2,
    		o_F      	=> s_oInt);


s_DMemAddr <= s_oInt;
oALUOut <= s_oInt;
s_DMemData <= regOut2s2;
s_DMemWr <= memWrites2;

-------------------------------------------------------------------------

gate22: EXMEM
	generic map(N => N)
	port map(i_CLK	=> iCLK,
	     i_RST	=> iRST,
	     i_Wren	=> '1',
	     i_Stall	=> '0',
	     
	     i_ALURes	=> s_oInt,
	     i_reg	=> regOut2s2,
	     i_memtoReg	=> memtoRegs2,
	     i_memWren	=> memWrites2,
	     i_regWrite	=> RegWrites2,
	     i_linkCont	=> linkcontrols2,
	     i_wAdd	=> jaladdress2,
	     i_ins	=> s_ins2,
	     i_jal	=> JALAddOut2,
	     i_WB	=> wbs2,
	     i_M	=> ms2,
	     i_rs	=> rss2,
	     i_rt1	=> rt1s2,
	     i_rt2	=> rt2s2,
	     i_rd	=> rds2,
		 i_BLOC => s_BLoc,
		 i_shift => aluShiftSelects2,
		 o_shift => aluShiftSelects3,
		 o_BLOC => s_BLocDel,
	     o_ALURes	=> alures3,
	     o_reg 	=> regOut3,
	     o_memtoReg	=> memtoRegs3,
	     o_memWren	=> memWrites3,
	     o_regWrite	=> RegWrites3,
	     o_linkCont	=> linkcontrols3,
	     o_wAdd	=> jaladdresss3,
	     o_ins	=> s_ins3,
	     o_jal	=> JALAddOut3,
	     o_WB	=> wbs3,
	     o_M	=> ms3,
	     o_rs	=> rss3,
	     o_rt1	=> rt1s3,
	     o_rt2	=> rt2s3,
	     o_rd	=> rds3);

---------------------------------------------------------------------------









  DMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => alures3(11 downto 2),
             data => regOut3,
             we   => memWrites3,
             q    => s_DMemOut);

  


  s_qInt <= s_DMemOut;






----------------------------------------------------------------------------




gate23: MEMWB
	generic map(N => N)
	port map(i_CLK	=> iCLK,
	     i_RST	=> iRST,
	     i_Wren	=> '1',
	     i_Stall	=> '0',
	     
	     i_ALURes	=> alures3,
	     i_memRead	=> s_qInt,
	     i_memtoReg	=> memtoRegs3,
	     i_regWrite	=> RegWrites3,
	     i_linkCont	=> linkcontrols3,
	     i_wAdd	=> jaladdresss3,
	     i_ins	=> s_ins3,
	     i_jal	=> JALAddOut3,
	     i_WB	=> wbs3,
		 i_Shift => aluShiftSelects3,
		 o_Shift => memwbshift,
	     o_ALURes	=> alures4,
	     o_memRead	=> memreads4,
	     o_memtoReg	=> memtoRegs4,
	     o_regWrite	=> RegWrite4,
	     o_linkCont	=> linkcont4,
	     o_wAdd	=> JumpLinkAddress4,
	     o_ins	=> s_ins4,
	     o_jal	=> JALAddOut4,
	     o_WB	=> wbs4);





----------------------------------------------------------------------------

 


gate19: mux2to1_2
	generic MAP(N => 32)
	port MAP(
		i_A 		=> alures4,
		i_B 		=> memreads4,
		i_S 		=> memtoRegs4,
		o_F 		=> s_D);

--s_Inst <= s_ins4;

end structure;
