library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.opcodes.all;

entity arith is
    generic(
        C_WIDTH : integer := 8
    );
    port(
        -- output is registered
        clk             : in  std_logic;
        -- operands
        operandA        : in  std_logic_vector(C_WIDTH - 1 downto 0);
        operandB        : in std_logic_vector(C_WIDTH - 1 downto 0);
        -- opcodes + input flags
        opcode          : in  opcode_t;
        -- input is signed
        opcode_signed   : in  std_logic;
        -- do saturated arithmetic   
        opcode_saturate : in  std_logic;
        -- result of operation
        result          : out std_logic_vector(C_WIDTH - 1 downto 0);
        -- output carry
        carry           : out std_logic;
        -- overflow occured
        overflow        : out std_logic;
        -- output is zero
        zero            : out std_logic;
        -- output was saturated
        saturated       : out std_logic;
		
		testA			: out signed;
		testB			: out signed
    );
end entity;

architecture RTL of arith is 
begin

	process(clk)
		variable process_result : std_logic_vector(C_WIDTH downto 0) := (others => '0');
	begin
		
		if rising_edge(clk) then
			-- process_result <= (others => '0');
			
			case opcode is
				when OAdd =>							
					process_result := std_logic_vector(('0' & unsigned(operandA)) + ('0' & unsigned(operandB)));
				
                when OSub =>
					process_result := std_logic_vector(('0' & unsigned(operandA)) - ('0' & unsigned(operandB)));
                        
                when OMulH =>

                when OMulL =>

                when OShiftLeft =>
 					if (opcode_signed = '1') then
						process_result := std_logic_vector(shift_left(signed(operandA), to_integer(signed(operandB))));
					else
						process_result := std_logic_vector(shift_left(signed(operandA), to_integer(signed(operandB))));
					end if;
					
                when OShiftRight =>
					if (opcode_signed = '1') then
						process_result := std_logic_vector(shift_right(signed(operandA), to_integer(signed(operandB))));
					else
						process_result := std_logic_vector(shift_right(signed(operandA), to_integer(signed(operandB))));
					end if;
					
                when ORotateLeft =>	  			
 					if (opcode_signed = '1') then
						process_result := std_logic_vector(rotate_left(signed(operandA), to_integer(signed(operandB))));
					else
						process_result := std_logic_vector(rotate_left(unsigned(operandA), to_integer(unsigned(operandB))));
					end if;
					
                when ORotateRigth =>
					if (opcode_signed = '1') then
						process_result := std_logic_vector(rotate_right(signed(operandA), to_integer(signed(operandB))));
					else
						process_result := std_logic_vector(rotate_right(signed(operandA), to_integer(signed(operandB))));
					end if;

                when ONot =>
                    process_result := not operandA;

                when OAnd =>
                    process_result := operandA and operandB;
				
                when OOr =>
                    process_result := operandA or operandB;
                
                when OXor =>
                    process_result := operandA xor operandB;

                when others =>
					process_result := (others => '0');
			end case;

            --TODO: Nastaveni flagu.
			
			
			result <= process_result(C_WIDTH - 1 downto 0);
			carry <= process_result( process_result'high );
		end if;
	end process;	
end architecture RTL;
