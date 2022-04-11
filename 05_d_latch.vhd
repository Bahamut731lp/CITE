library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Dlatch is
    Port (
        D: in std_logic;
        q : out std_logic;
        clk : in std_logic;
        enable, reset: in std_logic
    );
end Dlatch;

architecture Behavioral of Dlatch is
    signal a, b, v, u : std_logic;
begin

    q <= D when clk = '1';

end Behavioral;