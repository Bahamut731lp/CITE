library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity top is
    port(
        clk : in std_logic; -- 100 MHz clock
        rstn : in std_logic; -- Red CPU_RESETN (negative reset)
        btnl, btnr, btnu, btnd, btnc : in std_logic; -- Cross buttons
        SW : in std_logic_vector(15 downto 0); -- Switches
        LED : out std_logic_vector(15 downto 0);
        -- controls cathodes (segments within 7seg display). Negative logic.
        -- sorted A, B, C, D, E, F, G
        display_segments : out std_logic_vector(6 downto 0);
        -- controls anodes (display). Negative logic.
        display_positions  : out std_logic_vector(7 downto 0);
        -- there are two RGB LEDs that can be controlled via PWM
        LED_R, LED_G, LED_B : out std_logic_vector(1 downto 0)
        -- Mono audio out Jack+AMP. Open drain output. 0 for 0, Z for 1
    );
end top;

architecture Behavioral of top is
    
    -- positive reset
    signal rst : std_logic;
    signal en : std_logic;

begin

    -- DO NOT touch
    rst <= not rstn;
    
    debounce : entity work.pulse
        port map(
            clk   => clk,
            btn   => btnl,
            pulse => en
        );    
        
    mealy_inst : entity work.mealy
        port map(
            clk => clk,
            rst => rst,
            en  => en,
            x   => SW(0),
            q   => LED(0)
        );
        
    moore_inst : entity work.moore
        port map(
            clk => clk,
            rst => rst,
            en  => en,
            x   => SW(0),
            q   => LED(1)
        );
    
end Behavioral;
