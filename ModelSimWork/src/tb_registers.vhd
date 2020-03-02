library IEEE;
use IEEE.std_logic_1164.all;

entity tb_registers is
	generic
	(
		N : integer := 32;
		gCLK_HPER : time := 50 ns
	);
end tb_registers;

architecture behavior of tb_registers is

constant cCLK_PER  : time := gCLK_HPER * 2;

component IFID
	port
	(
		i_CLK         : in std_logic;     
       		i_RST         : in std_logic;    
       		i_Wren          : in std_logic;    
       		i_Stall       : in std_logic;
	
		i_ins 		: in std_logic_vector(N-1 downto 0);
		o_ins 		: out std_logic_vector(N-1 downto 0);

		i_pc1         : in std_logic_vector(N-1 downto 0);
		o_pc1         : out std_logic_vector(N-1 downto 0);

		i_pc2         : in std_logic_vector(N-1 downto 0);
		o_pc2         : out std_logic_vector(N-1 downto 0)
	);	
end component;

component IDEX
	port
	(
		i_CLK              : in std_logic;     
       		i_RST              : in std_logic;    
       		i_Wren             : in std_logic;    
       		i_Stall            : in std_logic;

		i_reg1             : in std_logic_vector(N-1 downto 0);
		o_reg1             : out std_logic_vector(N-1 downto 0);
		i_reg2             : in std_logic_vector(N-1 downto 0);
		o_reg2             : out std_logic_vector(N-1 downto 0);
		i_pcJump           : in std_logic_vector(N-1 downto 0);
		o_pcJump           : out std_logic_vector(N-1 downto 0);
		i_pc               : in std_logic_vector(N-1 downto 0);
		o_pc               : out std_logic_vector(N-1 downto 0);
		i_imm              : in std_logic_vector(N-1 downto 0);
		o_imm              : out std_logic_vector(N-1 downto 0);
		i_sVal  	   : in std_logic_vector(4 downto 0);
		o_sVal		   : out std_logic_vector(4 downto 0);
		i_ALUSRC           : in std_logic;
		o_ALUSRC           : out std_logic;
		i_UpperI	   : in std_logic;
		o_UpperI      	   : out std_logic;
		i_VCont       	   : in std_logic;
		o_VCont        	   : out std_logic;
		i_BEQ		   : in std_logic;
		o_BEQ		   : out std_logic;
		i_BNE		   : in std_logic;
		o_BNE		   : out std_logic;
		i_regJump          : in std_logic;
		o_regJump          : out std_logic;
		i_jump             : in std_logic;
		o_jump             : out std_logic;
		i_memtoReg         : in std_logic;
		o_memtoReg         : out std_logic;
		i_memWren	   : in std_logic;
		o_memWren	   : out std_logic;
		i_sCont		   : in std_logic_vector(1 downto 0);
		o_sCont	           : out std_logic_vector(1 downto 0);
		i_AddSub     : in std_logic;
		o_AddSub     : out std_logic;
		i_ALUShift : in std_logic;
		o_ALUShift : out std_logic;
		i_regWrite         : in std_logic;
		o_regWrite         : out std_logic;
		i_ALUCont      : in std_logic_vector(2 downto 0);
		o_ALUCont       : out std_logic_vector(2 downto 0);

		i_uLess : in std_logic;
		o_uLess : out std_logic;


		i_linkCont : in std_logic;
		o_linkCont : out std_logic;

		i_wAdd : in std_logic_vector(4 downto 0);
		o_wAdd : out std_logic_vector(4 downto 0);
	
		i_ins : in std_logic_vector(N-1 downto 0);
		o_ins : out std_logic_vector(N-1 downto 0);

		i_jal : in std_logic_vector(N-1 downto 0);
		o_jal : out std_logic_vector(N-1 downto 0);

		i_WB   : in std_logic;
		o_WB   : out std_logic;
		i_M    : in std_logic;
		o_M    : out std_logic;
		i_EX   : in std_logic;
		o_EX   : out std_logic;
		i_rs   : in std_logic_vector(4 downto 0);
		o_rs   : out std_logic_vector(4 downto 0);
		i_rt1  : in std_logic_vector(4 downto 0);
		o_rt1  : out std_logic_vector(4 downto 0);
		i_rt2  : in std_logic_vector(4 downto 0);
		o_rt2  : out std_logic_vector(4 downto 0);
		i_rd   : in std_logic_vector(4 downto 0);
		o_rd   : out std_logic_vector(4 downto 0)
	);
end component;

component EXMEM
	port
	(
		i_CLK           : in std_logic;     
      		i_RST           : in std_logic;    
       		i_Wren            : in std_logic;    
      		i_Stall         : in std_logic;
	
		i_ALURes     : in std_logic_vector(N-1 downto 0);
		o_ALURes     : out std_logic_vector(N-1 downto 0);

		i_reg      : in std_logic_vector(N-1 downto 0);
		o_reg      : out std_logic_vector(N-1 downto 0);

		i_ins : in std_logic_vector(N-1 downto 0);
		o_ins : out std_logic_vector(N-1 downto 0);

		i_memtoReg       : in std_logic;
		o_memtoReg       : out std_logic;

		i_memWren : in std_logic;
		o_memWren : out std_logic;

		i_regWrite       : in std_logic;
		o_regWrite       : out std_logic;

		i_wAdd : in std_logic_vector(4 downto 0);
		o_wAdd : out std_logic_vector(4 downto 0);
	
		i_linkCont : in std_logic;
		o_linkCont : out std_logic;
	
		i_jal : in std_logic_vector(N-1 downto 0);
		o_jal : out std_logic_vector(N-1 downto 0);


		i_WB    : in std_logic;
		o_WB    : out std_logic;

		i_M     : in std_logic;
		o_M     : out std_logic;

		i_rs    : in std_logic_vector(4 downto 0);
		o_rs    : out std_logic_vector(4 downto 0);

		i_rt1   : in std_logic_vector(4 downto 0);
		o_rt1   : out std_logic_vector(4 downto 0);

		i_rt2   : in std_logic_vector(4 downto 0);
		o_rt2   : out std_logic_vector(4 downto 0);
	
		i_rd    : in std_logic_vector(4 downto 0);
		o_rd    : out std_logic_vector(4 downto 0)
	);
end component;

component MEMWB
	port
	(
		i_CLK        : in std_logic;     
		i_RST        : in std_logic;    
      		i_Wren         : in std_logic;    
      		i_Stall      : in std_logic;
	
		i_ALURes : in std_logic_vector(N-1 downto 0);
		o_ALURes : out std_logic_vector(N-1 downto 0);

		i_memRead  : in std_logic_vector(N-1 downto 0);
		o_memRead  : out std_logic_vector(N-1 downto 0);

		i_WB       : in std_logic;
		o_WB       : out std_logic;

		i_memtoReg : in std_logic;
		o_memtoReg : out std_logic;

		i_wAdd : in std_logic_vector(4 downto 0);
		o_wAdd : out std_logic_vector(4 downto 0);

		i_regWrite : in std_logic;
		o_regWrite : out std_logic;

		i_linkCont : in std_logic;
		o_linkCont : out std_logic;

		i_jal : in std_logic_vector(N-1 downto 0);
		o_jal : out std_logic_vector(N-1 downto 0);

		i_ins : in std_logic_vector(N-1 downto 0);
		o_ins : out std_logic_vector(N-1 downto 0)
	);
end component;

-- Some signals are commented out since there are some repeat signals. . .

-------------------------------------------------------------------------
-- Stage 1: IF/ID
-------------------------------------------------------------------------
signal s_CLK, s_RST, s_WE, s_Stall     : std_logic;
signal in_instruction1, out_instruction1 : std_logic_vector(N-1 downto 0);
signal in_pc11, out_pc11                 : std_logic_vector(N-1 downto 0);
signal in_pc21, out_pc21                 : std_logic_vector(N-1 downto 0);
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Stage 2: ID/EX
-------------------------------------------------------------------------
--signal s_CLK, s_RST, s_WE, s_Stall           : std_logic;
signal in_regread12, out_regread12               : std_logic_vector(N-1 downto 0);
signal in_regread22, out_regread22               : std_logic_vector(N-1 downto 0);
signal in_pc2, out_pc2                           : std_logic_vector(N-1 downto 0);
signal in_pcjump2, out_pcjump2                   : std_logic_vector(N-1 downto 0);
signal in_imm2, out_imm2                         : std_logic_vector(N-1 downto 0);
signal in_shiftvalue2, out_shiftvalue2           : std_logic_vector(4 downto 0);
signal in_alusrc2, out_alusrc2                   : std_logic;
signal in_upimm2, out_upimm2                     : std_logic;
signal in_vcontrol2, out_vcontrol2               : std_logic;
signal in_branchequal2, out_branchequal2         : std_logic;
signal in_branchnotequal2, out_branchnotequal2   : std_logic;
signal in_regjump2, out_regjump2                      : std_logic;
signal in_jump2, out_jump2                            : std_logic;
signal in_aluorshiftselect2, out_aluorshiftselect2    : std_logic;
signal in_addsubselect2, out_addsubselect2            : std_logic;
signal in_memtoreg2, out_memtoreg2                    : std_logic;
signal in_memwriteenable2, out_memwriteenable2        : std_logic;
signal in_shiftcontrol2, out_shiftcontrol2            : std_logic_vector(1 downto 0);
signal in_regwrite2, out_regwrite2                    : std_logic;
signal in_alucontrol2, out_alucontrol2                : std_logic_vector(2 downto 0);
signal in_uless2, out_uless2                          : std_logic;
signal in_wb2, out_wb2                                : std_logic;
signal in_m2, out_m2                                  : std_logic;
signal in_ex2, out_ex2                                : std_logic;
signal in_rs2, out_rs2                                : std_logic_vector(4 downto 0);
signal in_rt12, out_rt12                              : std_logic_vector(4 downto 0);
signal in_rt22, out_rt22                              : std_logic_vector(4 downto 0);
signal in_rd2, out_rd2                                : std_logic_vector(4 downto 0);
signal in_instruction2, out_instruction2 : std_logic_vector(N-1 downto 0);
signal in_jal2, out_jal2 : std_logic_vector(N-1 downto 0);

signal in_linkcontrol2, out_linkcontrol2             : std_logic;
signal in_wadd2, out_wadd2 : std_logic_vector(4 downto 0);
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Stage 3: EX/MEM
-------------------------------------------------------------------------
--signal s_CLK, s_RST, s_WE, s_Stall             : std_logic;
signal in_aluresult3, out_aluresult3             : std_logic_vector(N-1 downto 0);
signal in_regread23, out_regread23               : std_logic_vector(N-1 downto 0);
signal in_memtoreg3, out_memtoreg3               : std_logic;
signal in_memwriteenable3, out_memwriteenable3   : std_logic;
signal in_regwrite3, out_regwrite3               : std_logic;
signal in_wb3, out_wb3                           : std_logic;
signal in_m3, out_m3                             : std_logic;
signal in_rs3, out_rs3                           : std_logic_vector(4 downto 0);
signal in_rt13, out_rt13                         : std_logic_vector(4 downto 0);
signal in_rt23, out_rt23                         : std_logic_vector(4 downto 0);
signal in_rd3, out_rd3                           : std_logic_vector(4 downto 0);
signal in_wadd3, out_wadd3 : std_logic_vector(4 downto 0);
signal in_instruction3, out_instruction3 : std_logic_vector(N-1 downto 0);
signal in_linkcontrol3, out_linkcontrol3             : std_logic;
signal in_jal3, out_jal3 : std_logic_vector(N-1 downto 0);
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Stage 4: MEM/WB
-------------------------------------------------------------------------
--signal s_CLK, s_RST, s_WE, s_Stall             : std_logic;
signal in_aluresult4, out_aluresult4               : std_logic_vector(N-1 downto 0);
signal in_memread4, out_memread4                   : std_logic_vector(N-1 downto 0);
signal in_wb4, out_wb4                           : std_logic;
signal in_memtoreg4, out_memtoreg4               : std_logic;
signal in_regwrite4, out_regwrite4               : std_logic;
signal in_wadd4, out_wadd4 : std_logic_vector(4 downto 0);
signal in_linkcontrol4, out_linkcontrol4             : std_logic;
signal in_jal4, out_jal4 : std_logic_vector(N-1 downto 0);
signal in_instruction4, out_instruction4 : std_logic_vector(N-1 downto 0);
-------------------------------------------------------------------------

begin

	gate1: IFID
	port map
	(
		i_CLK        => s_CLK,      
		i_RST        => s_RST ,  
      		i_Wren         => s_WE , 
      		i_Stall      => s_Stall,
	
		i_ins 		 => in_instruction1,
		o_ins		 => out_instruction1,

		i_pc1         => in_pc11,
		o_pc1         => out_pc11,

		i_pc2         => in_pc21,
		o_pc2         => out_pc21
	);	



	gate2: IDEX
	port map
	(
		i_CLK        => s_CLK,      
		i_RST        => s_RST ,  
      		i_Wren         => s_WE , 
      		i_Stall      => s_Stall, 

		i_reg1      => in_regread12,
		o_reg1      => out_regread12,
		i_reg2      => in_regread22,
		o_reg2      => out_regread22 ,
		i_pcJump        => in_pcjump2 ,
		o_pcJump        => out_pcjump2 ,
		i_pc            => in_pc2,
		o_pc            => out_pc2 ,
		i_imm           => in_imm2  ,
		o_imm           => out_imm2 ,
		i_sVal    => in_shiftvalue2,
		o_sVal    => out_shiftvalue2,
		i_ALUSRC        => in_alusrc2,
		o_ALUSRC        => out_alusrc2,
		i_UpperI         => in_upimm2,
		o_UpperI         => out_upimm2,
		i_VCont      => in_vcontrol2 ,
		o_VCont      => out_vcontrol2 ,
		i_BEQ   => in_branchequal2,
		o_BEQ   => out_branchequal2,
		i_BNE   => in_branchnotequal2,
		o_BNE   => out_branchnotequal2,
		i_regJump          => in_regjump2,
		o_regJump          => out_regjump2 ,
		i_jump             => in_jump2 ,
		o_jump             => out_jump2,
		i_memtoReg         => in_memtoreg2 ,
		o_memtoReg         => out_memtoreg2 ,
		i_memWren   => in_memwriteenable2,
		o_memWren   => out_memwriteenable2,
		i_sCont     => in_shiftcontrol2,
		o_sCont    => out_shiftcontrol2,
		i_AddSub    => in_addsubselect2,
		o_AddSub     => out_addsubselect2,
		i_ALUShift => in_aluorshiftselect2,
		o_ALUShift => out_aluorshiftselect2,
		i_regWrite         => in_regwrite2 ,
		o_regWrite         => out_regwrite2 ,
		i_ALUCont       => in_alucontrol2,
		o_ALUCont       => out_alucontrol2 ,

		i_uLess => in_uless2,
		o_uLess => out_uless2,

		i_linkCont => in_linkcontrol2,
		o_linkCont => out_linkcontrol2,

		i_wAdd => in_wadd2,
		o_wAdd => out_wadd2,
	
		i_ins => in_instruction2,
		o_ins => out_instruction2,

		i_jal =>in_jal2,
		o_jal => out_jal2,

		i_WB   => in_wb2,
		o_WB   => out_wb2,
		i_M    => in_m2,
		o_M    => out_m2,
		i_EX   => in_ex2,
		o_EX   => out_ex2,
		i_rs   => in_rs2,
		o_rs   => out_rs2,
		i_rt1  => in_rt12,
		o_rt1  => out_rt12,
		i_rt2  => in_rt22,
		o_rt2  => out_rt22,
		i_rd   => in_rd2,
		o_rd   => out_rd2
	);
	gate3: EXMEM
	port map
	(
		i_CLK        => s_CLK,      
		i_RST        => s_RST ,  
      		i_Wren         => s_WE , 
      		i_Stall      => s_Stall,
	
		i_ALURes      => in_aluresult3,
		o_ALURes      => out_aluresult3,

		i_reg       => in_regread23,
		o_reg       => out_regread23,


		i_memtoReg       => in_memtoreg3,
		o_memtoReg       => out_memtoreg3,

		i_memWren => in_memwriteenable3,
		o_memWren => out_memwriteenable3,

		i_regWrite       => in_regwrite3,
		o_regWrite       => out_regwrite3,

		i_ins => in_instruction3,
		o_ins => out_instruction3,

		i_WB   => in_wb3,
		o_WB   => out_wb3,
		i_M    => in_m3,
		o_M    => out_m3,

		i_wAdd => in_wadd3,
		o_wAdd => out_wadd3,
	
		i_linkCont => in_linkControl3,
		o_linkCont => out_linkControl3,
	
		i_jal => in_jal3,
		o_jal => out_jal3,

		i_rs   => in_rs3,
		o_rs   => out_rs3,
		i_rt1  => in_rt13,
		o_rt1  => out_rt13,
		i_rt2  => in_rt23,
		o_rt2  => out_rt23,
		i_rd   => in_rd3,
		o_rd   => out_rd3 
	);
	
	gate4: MEMWB
	port map
	(
		i_CLK        => s_CLK,      
		i_RST        => s_RST ,  
      		i_Wren       => s_WE , 
      		i_Stall      => s_Stall,
	
		i_ALURes  => in_aluresult4 ,
		o_ALURes  => out_aluresult4,

		i_memRead    => in_memread4,
		o_memRead    => out_memread4,

		i_WB         => in_wb4,
		o_WB         => out_wb4,

		i_memtoReg   => in_memtoreg4,
		o_memtoReg   => out_memtoreg4,


		i_regWrite   => in_regwrite4, 
		o_regWrite   => out_regwrite4,

		i_wAdd => in_wadd4,
		o_wAdd => out_wadd4,


		i_linkCont => in_linkControl4,
		o_linkCont => out_linkControl4,

		i_jal => in_jal4,
		o_jal => out_jal4,


		i_ins => in_instruction4,
		o_ins => out_instruction4



	);


P_CLK: process
	begin

	s_CLK <= '0';
	wait for gCLK_HPER;

	s_CLK <= '1';
	wait for gCLK_HPER;
end process;

P_TB: process
	begin
	  
s_RST<= '0';
 s_WE<= '1';
 s_Stall <= '0';
in_instruction1 <= x"FFFFFFFF";
in_pc11<= x"FFFFFFFF";
 in_pc21<= x"FFFFFFFF";
-------------------------------------------------------------------------

in_regread12<= x"FFFFFFFF";
in_regread22<= x"FFFFFFFF";
in_pc2<= x"FFFFFFFF";
in_pcjump2<= x"FFFFFFFF";
 in_imm2<= x"FFFFFFFF";
 in_shiftvalue2<= "11111";
 in_alusrc2<= '1';
 in_upimm2<= '1';
 in_vcontrol2<= '1';
 in_branchequal2<= '1';
 in_branchnotequal2<= '1';
 in_regjump2<= '1';
 in_jump2<= '1';
 in_aluorshiftselect2<= '1';
 in_addsubselect2<= '1';
 in_memtoreg2<= '1';
 in_memwriteenable2<= '1';
 in_shiftcontrol2<= "11";
 in_regwrite2<= '1';
 in_alucontrol2<= "111";
 in_uless2<= '1';
 in_wb2<= '1';
 in_m2<= '1';
 in_ex2<= '1';
 in_rs2<= "11111";
 in_rt12<= "11111";
 in_rt22<= "11111";
 in_rd2<= "11111";
in_instruction2<= x"FFFFFFFF";
 in_jal2<= x"FFFFFFFF";

in_linkcontrol2    <= '1';
in_wadd2<= "11111";
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Stage 3: EX/MEM
-------------------------------------------------------------------------
--signal s_CLK, s_RST, s_WE, s_Stall             : std_logic;
in_aluresult3<= x"FFFFFFFF";
 in_regread23<= x"FFFFFFFF";
 in_memtoreg3<= '1';
 in_memwriteenable3<= '1';
 in_regwrite3<= '1';
 in_wb3<= '1';
 in_m3<= '1';
 in_rs3<= "11111";
 in_rt13<= "11111";
 in_rt23<= "11111";
 in_rd3<= "11111";
in_wadd3<= "11111";
in_instruction3<= x"FFFFFFFF";
in_linkcontrol3<= '1';
 in_jal3<= x"FFFFFFFF";
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Stage 4: MEM/WB
-------------------------------------------------------------------------
--signal s_CLK, s_RST, s_WE, s_Stall             : std_logic;
in_aluresult4<= x"FFFFFFFF";
 in_memread4<= x"FFFFFFFF";
 in_wb4<= '1';
 in_memtoreg4<= '1';
 in_regwrite4<= '1';
 in_wadd4<= "11111";
 in_linkcontrol4<= '1';
 in_jal4<= x"FFFFFFFF";
 in_instruction4<= x"FFFFFFFF";
	wait for 100 ns;
 s_Stall <= '1';
wait for 100 ns;
in_instruction1 <= x"FF0000FF";
wait for 100 ns;
 s_Stall <= '0';
wait for 100 ns;
s_RST<= '1';
wait for 100 ns;

end process;

end behavior;
		