library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dpram is
    Generic(
        C_DWIDTH : integer := 8;
        C_AWIDTH : integer := 10
    );
    Port(
        clk    : in  std_logic;
        en_A   : in  std_logic;
        wren_A : in  std_logic;
        addr_A : in  std_logic_vector(C_AWIDTH - 1 downto 0);
        din_A  : in  std_logic_vector(C_DWIDTH - 1 downto 0);
        dout_A : out std_logic_vector(C_DWIDTH - 1 downto 0);
        en_B   : in  std_logic;
        wren_B : in  std_logic;
        addr_B : in  std_logic_vector(C_AWIDTH - 1 downto 0);
        din_B  : in  std_logic_vector(C_DWIDTH - 1 downto 0);
        dout_B : out std_logic_vector(C_DWIDTH - 1 downto 0)
    );
end dpram;

architecture Behavioral of dpram is
	type memory_t is array(0 to 2**C_AWIDTH - 1) of std_logic_vector(C_DWIDTH - 1 downto 0);
	shared variable memory : memory_t := (others => (others => '0'));
begin
	
	process(clk)
	begin
		if rising_edge(clk) then
			
			if wren_A = '1' then
				memory(to_integer(unsigned(addrwr_A))) := din_A;
			end if;
			
			if rden_A = '1' then
				dout <= memory(to_integer(unsigned(addrrd_A)));
			end if;	   
		end if;
	end process;
	
	process(clk)  		
	begin
		if rising_edge(clk) then
			
			if wren_A = '1' then
				memory(to_integer(unsigned(addrwr_A))) := din_A;
			end if;
			
			if rden_A = '1' then
				dout <= memory(to_integer(unsigned(addrrd_A)));
			end if;	   
		end if;
	end process;

end Behavioral;
