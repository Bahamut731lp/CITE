library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- typy unsigned a signed
use IEEE.NUMERIC_STD.ALL;


entity counter_generic is
	-- Generic nám umožňuje nastavit "parametry" obvodu
	-- V tomhle případě to je šířka čítače, která je defaultně 4
    generic (
        C_WIDTH : integer := 4
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        enable : in std_logic;
        up_not_down : in std_logic;
        Q : out std_logic_vector(C_WIDTH - 1 downto 0)
    );
end counter_generic;

architecture Behavioral of counter_generic is
	-- Unsigned : Můžou se provádět aritmetické operace
    signal counter_reg : unsigned(Q'range); 

begin

    cyclic_counter : process(clk)
	    variable inc : integer := 1;
    begin
        if rising_edge(clk) then
            if rst = '1' then
                counter_reg <= (others => '0');
            elsif enable = '1' then
                if up_not_down = '1' then
	                inc := 1;
	            else
		            inc := -1;
                end if;
	            
	            counter_reg <= counter_reg + inc;
            end if;
        end if;
    end process;

    Q <= std_logic_vector(counter_reg);

end Behavioral;