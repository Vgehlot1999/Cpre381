library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.register_array_type.all;

entity RegisterFile is
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

end RegisterFile;

architecture structure of registerFile is 

component mux32to1 is
	port(i_A  : in registerArray;
       	     i_B  : in std_logic_vector(4 downto 0);
       	     o_C  : out std_logic_vector(31 downto 0));
end component;

component nBitReg is 
 	generic(N : integer := 32);
  	port(i_CLK        : in std_logic;     -- Clock input
       	     i_RST        : in std_logic;     -- Reset input
       	     i_WE         : in std_logic;     -- Write enable input
       	     i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       	     o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
end component;

component Decoder5_32 is
	port(i_A : in std_logic_vector(4 downto 0);
	     o_B : out std_logic_vector(31 downto 0));
end component;

signal decode, load : std_logic_vector(31 downto 0);
signal reg : registerArray;

begin

decoder : Decoder5_32
	port map(i_A => sel_d,
	         o_B => decode);

mux1 : mux32to1
	port map(i_A => reg,
		 i_B => sel_s,
		 o_C => rs);

mux2 : mux32to1
	port map(i_A => reg,
		 i_B => sel_t,
		 o_C => rt);

nReg : nBitReg
	port map(i_CLK => CLK,
		 i_RST => i_RST,
		 i_WE => '0',
		 i_D => x"00000000",
		 o_Q => reg(0));

G1 : for i in 1 to 31 generate
	load(i) <= en and decode(i);
	nReg : nBitReg
	port map(i_CLK => CLK,
		 i_RST => i_RST,
		 i_WE => load(i),
		 i_D => rd,
		 o_Q => reg(i));
end generate;

r2 <= reg(2);
end structure;




