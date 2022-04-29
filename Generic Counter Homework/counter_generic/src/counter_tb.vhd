library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- typy unsigned a signed

entity top is
end top;

architecture Behavioral of top is
	constant C_WIDTH : integer := 4;
	constant NUMBER_OF_COUNTERS : integer := 4;
	constant CLK_P : time := 10 ns;
	constant LIMIT : std_logic_vector(3 downto 0) := "1001";
	
	type segments_array is array (NUMBER_OF_COUNTERS - 1 downto 0) of std_logic_vector(6 downto 0);
	type counter_data is array (NUMBER_OF_COUNTERS - 1 downto 0) of  std_logic_vector(C_WIDTH - 1 downto 0);
	
	signal clk : std_logic := '0';
	signal rst : std_logic := '0';	-- Reset
	signal enable : std_logic := '0';	-- Pole enable flagù
--	signal SEG : segments_array; 	-- Pole std_logic vektorù, které drží informace o zobrazovaných èíslicích
	signal CT : counter_data := (others => (others => '0'));		-- Pole std_logic vektorù, které drží informace o èíslech v èítaèích 
	signal CARRY : std_logic_vector(NUMBER_OF_COUNTERS - 1 downto 0) := (others => '0');
	signal sig2, sig3, sig4: std_logic := '0';
begin
	clk <= not clk after CLK_P/2;
	
	CTN1 : entity work.counter_generic
		generic map (
			C_WIDTH => C_WIDTH
		)
		port map (
			clk => clk,
			rst => rst,
			enable => enable,
			limit => "1001",
			Q => CT(0),
			C => CARRY(1)
		);
	
	CTN2 : entity work.counter_generic
		generic map (
			C_WIDTH => C_WIDTH
		)
		port map (
			clk => clk,
			rst => rst,
			enable => CARRY(1),
			limit => "1001",
			Q => CT(1),
			C => CARRY(2)
		);					  
		
	sig3 <= CARRY(1) and CARRY(2);
	
	CTN3 : entity work.counter_generic
		generic map (
			C_WIDTH => C_WIDTH
		)
		port map (
			clk => clk,
			rst => rst,
			enable => sig3,
			limit => "1001",
			Q => CT(2),
			C => CARRY(3)
		);
		
	sig4 <= CARRY(1) and CARRY(2) and CARRY(3);
	
	CTN4 : entity work.counter_generic
		generic map (
			C_WIDTH => C_WIDTH
		)
		port map (
			clk => clk,
			rst => rst,
			enable => sig4,
			limit => "1001",
			Q => CT(3),
			C => open
		);
		
	TB: process
    begin 
		wait for CLK_P;
		rst <= '1';
		wait for CLK_P;
		rst <= '0';
		wait for CLK_P;
        enable <= '1';		
        wait;
    end process;

end Behavioral;