library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- typy unsigned a signed
use IEEE.NUMERIC_STD.ALL;


entity counter_generic is
	-- Generic nám umožòuje nastavit "parametry" obvodu
	-- V tomhle pøípadì to je šíøka èítaèe, která je defaultnì 4
    generic (
        C_WIDTH : integer := 4
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        enable : in std_logic;
		limit: in std_logic_vector(C_WIDTH - 1 downto 0);
		C: out std_logic;
        Q : out std_logic_vector(C_WIDTH - 1 downto 0)
    );
end counter_generic;

architecture Behavioral of counter_generic is
	-- Unsigned : Mùžou se provádìt aritmetické operace
    signal counter_reg : unsigned(Q'range);
begin
    
	cnt : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                counter_reg <= (others => '0');
            elsif enable = '1' then
				if (counter_reg = unsigned(limit)) then
					counter_reg <= (others => '0');
				else
					counter_reg <= counter_reg + 1;
				end if;							   
            end if;
        end if;

    end process;
	
	C <= '1' when counter_reg = unsigned(limit) else '0';
    Q <= std_logic_vector(counter_reg);

end Behavioral;