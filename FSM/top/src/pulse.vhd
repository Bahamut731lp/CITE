----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2022 08:56:17
-- Design Name: 
-- Module Name: pulse - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pulse is
    Port (
        clk : in std_logic;
        btn : in std_logic;
        pulse : out std_logic
    );
end pulse;

architecture Behavioral of pulse is

    signal shreg : std_logic_vector(1 downto 0);

begin

    process(clk)
        variable divcnt : unsigned(19 downto 0) := (others => '0');
    begin
        if rising_edge(clk) then
            pulse <= '0';
            divcnt := divcnt + 1;
            if divcnt >= 1_000_000 then
                divcnt := (others => '0');
                shreg <= btn & shreg(1);
                if shreg = "10" then
                    pulse <= '1';
                end if;                 
            end if;
        end if;
    end process;


end Behavioral;
