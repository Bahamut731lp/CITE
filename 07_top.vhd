library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    port(
        clk: in std_logic;
        rst : in std_logic; -- Red CPU_RESETN (negative reset)
        enable: in std_logic;
        q1, q2, q3: out std_logic   
    );
end top;

architecture Behavioral of top is
    signal dir : std_logic := '1';
    signal irq1, irq2, irq3 : std_logic := '0';

begin   
    citac_jenda : entity work.counter_generic
        port map (
            clk => clk,
            rst => rst,
            enable => enable,
            up_not_down => dir,
            IRQ => irq1
        );
        
    citac_vlad : entity work.counter_generic
        port map (
            clk => irq1,
            rst => rst,
            enable => enable,
            up_not_down => dir,
            IRQ => irq2
        );
        
    citac_trix : entity work.counter_generic
        port map (
            clk => irq2,
            rst => rst,
            enable => enable,
            up_not_down => dir,
            IRQ => irq3
        );
    
    -- insert counter here
    
end Behavioral;
