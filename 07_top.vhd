library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- typy unsigned a signed

entity top is
    port (
        clk : in std_logic;
        rstn : in std_logic;
        btn1, btnr, btnu, btnd, btnc : in std_logic;
        SW : in std_logic_vector(15 downto 0);
        LED: out std_logic_vector(15 downto 0);
    );
end top;

architecture Behavioral of top is
	-- Unsigned : Můžou se provádět aritmetické operace
    signal enable : std_logic;
    signal enable2 : std_logic;
    signal rst : std_logic; 

begin

    enable_button_debounce : entity work.pulse
	    port map(
		    clk => clk,
		    btn => btnl,
		    pulse => enable
	    );
	    
	citac_jenda : entity work.counter_generic
		generic map (
			C_WIDTH => C_WIDTH
		)
		port map (
			clk => clk,
			rst => rst,
			enable => enable,
			up_not_down => SW(0),
			Q => LED(C_WIDTH - 1 downto 0)
		)
	
	enable_button_debounce2 : entity work.pulse
	    port map(
		    clk => clk,
		    btn => btnr,
		    pulse => enable2
	    );
	    
	citac_vlad : entity work.counter_generic
		generic map (
			C_WIDTH => C_WIDTH
		)
		port map (
			clk => clk,
			rst => rst,
			enable => enable2,
			up_not_down => SW(1),
			Q => LED(15 downto C_WIDTH - 1)
		)


end Behavioral;