library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port (
        SW: in std_logic(15 downto 0);
        LED : out std_logic(15 downto 0);
        LED_R, LED G, LED_B : out std_logic;
        CPU_RESETN, : in std_logic;
        BTNC, BTNU, CLK, BTNR, BTND: in std_logic; 
    );
end top;

architecture Behavioral of DFlipFlop is
    signal PAR_REG: in std_logic(SW'range);
    signal SER_REG: in std_logic(SW'range);
begin

	-- q <= D when clk = '1'
	PIPO_REG : process(CLK)
	begin
		if rising_edge(CLK) then
			if CPU_RESETN = '0'  then
				PAR_REG <= (others => '0');
			else
				PAR_REG <= SW;
			end if;
		end if;
	end process;
	
-- q <= D when clk = '1'
	SISO_REG : process(CLK)
	begin
		if rising_edge(CLK) then
			if CPU_RESETN = '0'  then
				SER_REG <= (others => '0');
			else
				--& slouží jako concat polí
				SER_REG(14 downto 0) <= SW(0) & SER_REG(SER_REG'high downto 1);
			end if;
		end if;
	end process;

	LED <= PAR_REG;
	
end Behavioral;