library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seg is
    Port (
        value: in std_logic_vector(3 downto 0);
        position: in std_logic_vector(2 downto 0);
        cathode:  out std_logic_vector(6 downto 0);
        anode: out std_logic_vector(7 downto 0)
    );
end seg;

architecture Behavioral of seg is

begin

    with position select anode <=
        "11111110" when "000",
        "11111101" when "001",
        "11111011" when "010",
        "11110111" when "011",
        "11101111" when "100",
        "11011111" when "101",
        "10111111" when "110",
        "01111111" when others;
        
    with value select cathode <=
        "1000000" when "0000",
        "1111001" when "0001",
        "0100100" when "0010",
        "0011011" when "0100",
        "0010010" when "0101",
        "0000010" when "0110",
        "1111000" when "0111",
        "0000000" when "1000",
        "0011000" when "1001",
        "0001000" when "1010",
        "0000011" when "1011",
        "1000110" when "1100",
        "0100001" when "1101",
        "0000110" when "1110",
        "0001110" when others;      
                
end Behavioral;