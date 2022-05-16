library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram_tb is
    --  Port ( );
end ram_tb;

architecture Behavioral of ram_tb is

    type simulation_ram_t is (single_port, simple_dual_port, true_dual_port);
    constant C_WHAT_WILL_BE_SIMULATED_TODAY : simulation_ram_t := simple_dual_port;
    
    constant C_DWIDTH        : integer          := 4;
    constant C_AWIDTH        : integer          := 10;

    constant CLK_P : time := 10 ns;

    -- single port RAM
    signal clk  : std_logic                               := '0';
    signal rst  : std_logic                               := '0';
    signal en   : std_logic                               := '0';
    signal wren : std_logic                               := '0';
    signal din  : std_logic_vector(C_DWIDTH - 1 downto 0) := (others => '0');
    signal dout : std_logic_vector(C_DWIDTH - 1 downto 0);
    signal addr : std_logic_vector(C_AWIDTH - 1 downto 0) := (others => '0');

    -- simple dual port RAM
    signal rden   : std_logic                               := '0';
    signal addrrd : std_logic_vector(C_AWIDTH - 1 downto 0) := (others => '0');
    signal addrwr : std_logic_vector(C_AWIDTH - 1 downto 0) := (others => '0');

    -- true dual port RAM
    signal en_A   : std_logic                               := '0';
    signal wren_A : std_logic                               := '0';
    signal addr_A : std_logic_vector(C_AWIDTH - 1 downto 0) := (others => '0');
    signal din_A  : std_logic_vector(C_DWIDTH - 1 downto 0) := (others => '0');
    signal dout_A : std_logic_vector(C_DWIDTH - 1 downto 0);
    signal en_B   : std_logic                               := '0';
    signal wren_B : std_logic                               := '0';
    signal addr_B : std_logic_vector(C_AWIDTH - 1 downto 0) := (others => '0');
    signal din_B  : std_logic_vector(C_DWIDTH - 1 downto 0) := (others => '0');
    signal dout_B : std_logic_vector(C_DWIDTH - 1 downto 0);

begin
    
    clk <= not clk after CLK_P / 2;

    DUT_SP_G : if C_WHAT_WILL_BE_SIMULATED_TODAY = single_port generate
        DUT_SP : entity work.spram
            generic map(
                C_DWIDTH => C_DWIDTH,
                C_AWIDTH => C_AWIDTH
            )
            port map(
                clk  => clk,
                rst  => rst,
                en   => en,
                wren => wren,
                din  => din,
                dout => dout,
                addr => addr
            );
    end generate;

    DUT_SDP_G : if C_WHAT_WILL_BE_SIMULATED_TODAY = simple_dual_port generate
        DUT_SDP : entity work.sdpram
            generic map(
                C_DWIDTH => C_DWIDTH,
                C_AWIDTH => C_AWIDTH
            )
            port map(
                clk    => clk,
                rden   => rden,
                wren   => wren,
                din    => din,
                dout   => dout,
                addrrd => addrrd,
                addrwr => addrwr
            );
    end generate;

    DUT_TDP_G : if C_WHAT_WILL_BE_SIMULATED_TODAY = true_dual_port generate
        DUT_TPG : entity work.dpram
            generic map(
                C_DWIDTH => C_DWIDTH,
                C_AWIDTH => C_AWIDTH
            )
            port map(
                clk    => clk,
                en_A   => en_A,
                wren_A => wren_A,
                addr_A => addr_A,
                din_A  => din_A,
                dout_A => dout_A,
                en_B   => en_B,
                wren_B => wren_B,
                addr_B => addr_B,
                din_B  => din_B,
                dout_B => dout_B
            );
    end generate;
    
    process
    begin
		rden <= '1';
		wren <= '1';
		
		for i in 0 to 15 loop
			addrwr <= std_logic_vector(to_unsigned(i, addr'length));
			din <= std_logic_vector(to_unsigned(i, din'length));
			
			addrrd <= std_logic_vector(to_unsigned(15 - i, addr'length));
			
			wait for CLK_P;
		end loop; 
		
		en <= '0';
        wren <= '0';
		wait for CLK_P * 5;
		--wait;
    end process;
    

end Behavioral;
