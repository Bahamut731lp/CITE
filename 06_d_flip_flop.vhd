library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DFlipFlop is
    Port (
        D: in std_logic;
        q : out std_logic;
        clk : in std_logic;
        enable, reset: in std_logic
    );
end DFlipFlop;

architecture Behavioral of DFlipFlop is
    signal reg: std_logic;
begin

	-- q <= D when clk = '1'
	D_FlipFlop : process(clk)
	begin
		if rising_edge(clk) then
			if reset = '1'  then
				reg <= '0';
			elsif enable = '1' then
				reg <= D;
			end if;
		end if;
	end process;

	q <= reg;

end Behavioral;