library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity sdpram is
    Generic(
        C_DWIDTH : integer := 8;
        -- (1,6> will infere distributed mem
        C_AWIDTH : integer := 10
    );
    Port(
        clk    : in  std_logic;
        rden   : in  std_logic;
        wren   : in  std_logic;
        din    : in  std_logic_vector(C_DWIDTH - 1 downto 0);
        dout   : out std_logic_vector(C_DWIDTH - 1 downto 0);
        addrrd : in  std_logic_vector(C_AWIDTH - 1 downto 0);
        addrwr : in  std_logic_vector(C_AWIDTH - 1 downto 0)
    );
end sdpram;

architecture Behavioral of sdpram is
	
	type memory_t is array(0 to 2**C_AWIDTH - 1) of std_logic_vector(C_DWIDTH - 1 downto 0);
begin
		process(clk)  
		variable memory : memory_t := (others => (others => '0'));
	begin
		if rising_edge(clk) then
			
			if wren = '1' then
				memory(to_integer(unsigned(addrwr))) := din;
			end if;
			
			if rden = '1' then
				dout <= memory(to_integer(unsigned(addrrd)));
			end if;
					   
		end if;
	end process;

end Behavioral;
