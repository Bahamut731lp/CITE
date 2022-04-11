library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux41 is
    Port (
        a, b, c, d : in std_logic;
        s: in std_logic_vector(1 downto 0);
        q: out std_logic
    );
end mux41;

architecture Behavioral of mux41 is

--    constant cc : std_logic_vector(s'range) := "00";
--    constant c2 : std_logic_vector(2*s'length - 1 downto 0) := "0000";
    
--    VHDL pole jsou inclusive na oba konce
--    signal a : std_logic_vector(7 downto 0);
--    signal b : std_logic_vector(7 downto 0);
--    signal c : std_logic_vector(15 downto 0);
    
begin
      
    -- a <= X"80"; -- 1000 0000, X je pro označení decimálního zápisu
    -- a <= ('1', others => '0'); -- Udělá to samý, jako nahoře.
    
    -- c <= '0' &  "10" & a(7 downto 2) & b; -- Musí to sedět do délky pole (v tomhle případě 16)
    
    -- Tohle je sice pěkný, ale dá ty multiplexory za sebou, tedy tam vzniká zpoždění jako prase.
--    q <= a when s = "00"
--         else b when s = "01"
--         else c when s = "10"
--         else d; 

--    Mnohem lepší.
      with s select q <=
        a when "00",
        b when "01",
        c when "10",
        d when others;

end Behavioral;