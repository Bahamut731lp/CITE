library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.opcodes.all;

entity arith_tb is
end entity arith_tb;

architecture RTL of arith_tb is
    constant C_WIDTH : integer := 8;

    signal clk     : std_logic := '0';
    constant CLK_P : time      := 10 ns;

    signal operandA        : std_logic_vector(C_WIDTH - 1 downto 0) := (others => '0');
    signal operandB        : std_logic_vector(C_WIDTH - 1 downto 0) := (others => '0');
    signal opcode          : opcode_t := OAdd;
    signal opcode_signed   : std_logic := '0';
    signal opcode_saturate : std_logic := '0';
    signal result          : std_logic_vector(C_WIDTH - 1 downto 0);
    signal carry           : std_logic;
    signal overflow        : std_logic;
    signal zero            : std_logic;
    signal saturated       : std_logic;

begin

    process
    begin
        clk <= '1';
        wait for CLK_P / 2;
        clk <= '0';
        wait for CLK_P / 2;
    end process;

    DUT : entity work.arith
        generic map(
            C_WIDTH => C_WIDTH
        )
        port map(
            clk             => clk,
            operandA        => operandA,
            operandB        => operandB,
            opcode          => opcode,
            opcode_signed   => opcode_signed,
            opcode_saturate => opcode_saturate,
            result          => result,
            carry           => carry,
            overflow        => overflow,
            zero            => zero,
            saturated       => saturated
        );

    process
    begin
        --loop example lin sim	<=
        operandB <= (operandB'low => '1', others => '0');
        for a in 0 to 2 ** C_WIDTH - 1 loop
            operandA <= std_logic_vector(to_unsigned(a, C_WIDTH));
            for opcode_iter in opcode_t'left to opcode_t'right loop
                opcode <= opcode_iter;
                wait for CLK_P;
            end loop;
		end loop;
		
		wait for CLK_P;

    end process;

end architecture RTL;
