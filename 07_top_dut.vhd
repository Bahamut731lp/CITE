library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- typy unsigned a signed

entity top_DUT is
end top_DUT;

architecture Behavioral of top_DUT is
	constant C_WIDTH : integer := 4;
	constant CLK_P : time := 10 ns;
	
	-- Unsigned : Můžou se provádět aritmetické operace
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal enable : std_logic := '0';
    signal up_not_down : std_logic := '1';
    signal Q : std_logic_vector(C_WIDTH - 1 downto 0);
    signal limit : unsigned(C_WIDTH - 1 downto 0) 

begin
	clk <= not clk after CLK_P/2;

	DUT : entity work.counter_generic
		generic map (
			C_WIDTH => C_WIDTH
		);
		port map(
			clk => clk,
			rst => rst,
			enable => enable,
			up_not_down => up_not_down,
			Q => Q
		);

	TB: process
	begin
		rs <= '1';
		wait for CLK_P;
		rst <= '0';
		wait for CLK_P;
		enable <= '1';
		wait for CLK_P;
		wait
	end process;
end Behavioral;