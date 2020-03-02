library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;
use work.register_array_type.all;

entity mux32to1 is
  port(i_A  : in registerArray;
       i_B  : in std_logic_vector(4 downto 0);
       o_C  : out std_logic_vector(31 downto 0));

end mux32to1;

architecture dataflow of mux32to1 is

begin

  o_C <= i_A(to_integer(unsigned(i_B)));
  
end dataflow;