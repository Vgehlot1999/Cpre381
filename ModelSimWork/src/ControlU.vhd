library IEEE;
use IEEE.std_logic_1164.all;

entity ControlU is
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

end ControlU;

architecture dataflow of ControlU is 

begin
	process(i_Opcode,i_Funct)
	begin
	case i_Opcode is	
		when "001000" =>		--addi
		o_ALUSrc	<= '1';	   	
		o_ALUCont	<= "101";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '0';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '1';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "001001" =>		--addiu
		o_ALUSrc	<= '1';	   	
		o_ALUCont	<= "101";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '0';
		o_AddSub	<= '0';
		--o_ShiftFunct	<= 'x';
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '1';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "001100" =>		--andi
		o_ALUSrc	<= '1';	   	
		o_ALUCont	<= "000";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '0';
		--o_AddSub	<= 'x';
		--o_ShiftFunct	<= 'x';
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "001111" =>		--lui
		o_ALUSrc	<= '1';	   	
		--o_ALUCont	<= 'xxx';
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '0';
		--o_AddSub	<= 'x';
		o_ShiftFunct	<= "01";
		o_ALUShiftSel	<= '1';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '1';
		
		when "100011" =>		--lw
		o_ALUSrc	<= '1';	   	
		o_ALUCont	<= "101";
		o_MemtoReg	<= '1';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '0';
		o_AddSub	<= '0';
		--o_ShiftFunct	<= 'x';
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '1';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "001110" =>		--xori
		o_ALUSrc	<= '1';	   	
		o_ALUCont	<= "100";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '0';
		--o_AddSub	<= 'x';
		--o_ShiftFunct	<= 'x';
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "001101" =>		--ori
		o_ALUSrc	<= '1';	   	
		o_ALUCont	<= "001";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '0';
		--o_AddSub	<= 'x';
		--o_ShiftFunct	<= 'x';
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "001010" =>		--slti
		o_ALUSrc	<= '1';	   	
		o_ALUCont	<= "110";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '0';
		o_AddSub	<= '1';
		--o_ShiftFunct	<= 'x';
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '1';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "001011" =>		--sltiu
		o_ALUSrc	<= '1';	   	
		o_ALUCont	<= "110";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '0';
		o_AddSub	<= '1';
		--o_ShiftFunct	<= 'x';
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '1';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "101011" =>		--sw
		o_ALUSrc	<= '1';	  
		o_ALUCont	<= "101";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '1';
		o_RegWr		<= '0';
		o_RegDst	<= '0';
		o_AddSub	<= '0';
		--o_ShiftFunct	<= 'x';
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '1';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "000100" =>		--beq
		o_ALUSrc	<= '0';	   	
		o_ALUCont	<= "101";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '0';
		o_RegDst	<= '1';
		o_AddSub	<= '1';
		--o_ShiftFunct	<= 'x';
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '1';
		o_LinkCont	<= '0';
		o_BEQ		<= '1';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "000101" =>		--bne
		o_ALUSrc	<= '0';	   	
		o_ALUCont	<= "101";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '0';
		o_RegDst	<= '1';
		o_AddSub	<= '1';
		--o_ShiftFunct	<= 'x';
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '1';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '1';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "000010" =>		--j
		o_ALUSrc	<= '0';	   	
		o_ALUCont	<= "000";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '0';
		o_RegDst	<= '1';
		--o_AddSub	<= 'x';
		--o_ShiftFunct	<= 'x';
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '1';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '1';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "000011" => 		--jal
		o_ALUSrc	<= '0';
		o_ALUCont	<= "000";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		--o_AddSub	<= 'x';
		--o_ShiftFunct	<= 'x';
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '1';
		o_LinkCont	<= '1';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '1';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "000000" =>
		case i_Funct is
		when "100000" =>		--add
		o_ALUSrc	<= '0';
		o_ALUCont	<= "101";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
	
		when "100001" =>		--addu
		o_ALUSrc	<= '0';
		o_ALUCont	<= "101";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "100100" =>	 	--and
		o_ALUSrc	<= '0';
		o_ALUCont	<= "000";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "100111" =>		--nor
		o_ALUSrc	<= '0';
		o_ALUCont	<= "011";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "100110" =>		--xor
		o_ALUSrc	<= '0';
		o_ALUCont	<= "100";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "100101" =>		--or
		o_ALUSrc	<= '0';
		o_ALUCont	<= "001";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "101010" =>		--slt
		o_ALUSrc	<= '0';
		o_ALUCont	<= "110";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '1';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "101011" =>		--sltu
		o_ALUSrc	<= '0';
		o_ALUCont	<= "110";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '1';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '1';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "000000" =>		--sll
		o_ALUSrc	<= '0';
		o_ALUCont	<= "000";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "01";
		o_ALUShiftSel	<= '1';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "000010" =>    		--srl
		o_ALUSrc	<= '0';
		o_ALUCont	<= "101";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '1';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "000011" =>		--addu
		o_ALUSrc	<= '0';
		o_ALUCont	<= "000";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "10";
		o_ALUShiftSel	<= '1';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "000100" =>		--sllv
		o_ALUSrc	<= '0';
		o_ALUCont	<= "000";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "01";
		o_ALUShiftSel	<= '1';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '1';
		o_UpperI	<= '0';
		
		when "000110" =>		--srlv
		o_ALUSrc	<= '0';
		o_ALUCont	<= "000";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '1';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '1';
		o_UpperI	<= '0';
		
		when "000111" =>		--srav
		o_ALUSrc	<= '0';
		o_ALUCont	<= "000";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "10";
		o_ALUShiftSel	<= '1';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '1';
		o_UpperI	<= '0';
		
		when "100010" =>		--sub
		o_ALUSrc	<= '0';
		o_ALUCont	<= "101";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '1';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		
		when "100011" =>		--subu
		o_ALUSrc	<= '0';
		o_ALUCont	<= "101";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '1';
		o_RegDst	<= '1';
		o_AddSub	<= '1';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
	
		when "001000" =>		--jr
		o_ALUSrc	<= '0';
		o_ALUCont	<= "000";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '0';
		o_RegDst	<= '1';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '1';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '1';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';

		when others =>		--accounts for all other cases of i_Funct
		o_ALUSrc	<= '0';
		o_ALUCont	<= "000";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '0';
		o_RegDst	<= '0';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		end case;

		when others =>		--accounts for all other cases of i_Opcode
		o_ALUSrc	<= '0';
		o_ALUCont	<= "000";
		o_MemtoReg	<= '0';
		o_DMemWr	<= '0';
		o_RegWr		<= '0';
		o_RegDst	<= '0';
		o_AddSub	<= '0';
		o_ShiftFunct	<= "00";
		o_ALUShiftSel	<= '0';		
		o_SignedI	<= '0';
		o_LinkCont	<= '0';
		o_BEQ		<= '0';	
		o_BNE		<= '0';
		o_RegJumpCont	<= '0';
		o_JumpCont	<= '0';
		o_uLess		<= '0';
		o_vControl	<= '0';
		o_UpperI	<= '0';
		end case;
	end process;
end dataflow;