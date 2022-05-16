library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity spram is
    Generic(
        C_DWIDTH : integer := 4;
        C_AWIDTH : integer := 10
    );
    Port(
        clk  : in  std_logic;
        rst  : in  std_logic;
        en   : in  std_logic;
        wren : in  std_logic;
        din  : in  std_logic_vector(C_DWIDTH - 1 downto 0);
        dout : out std_logic_vector(C_DWIDTH - 1 downto 0);
        addr : in  std_logic_vector(C_AWIDTH - 1 downto 0)
    );
end spram;

architecture Behavioral of spram is

	type array_t is array (0 to 1) of integer;
	type memory_t is array(0 to 2**C_AWIDTH - 1) of std_logic_vector(C_DWIDTH - 1 downto 0);

begin

	process(clk)  
		variable memory : memory_t := (others => (others => '0'));
	begin
		if rising_edge(clk) then
			if rst = '1' then
				--Reset by resetoval kadou buòku zvláš
				dout <= (others => '0');
			elsif en = '1' then

				if wren = '1' then
					memory(to_integer(unsigned(addr))) := din;
				end if;
				
				dout <= memory(to_integer(unsigned(addr)));
			end if;		   
		end if;
	end process;
end Behavioral;
