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
        saturated       : out std_logic
    );
end entity;

architecture RTL of arith is 
	constant all_zeros : std_logic_vector(result'range) := (others => '0');
begin

	process(clk)
		variable carry_checked_result : std_logic_vector(C_WIDTH downto 0) := (others => '0');
		variable process_result : std_logic_vector(result'range) := (others => '0');
	begin
		
		if rising_edge(clk) then
			-- process_result <= (others => '0');
			
			case opcode is
				when OAdd =>
					if (opcode_signed = '1') then
						carry_checked_result := std_logic_vector(('0' & signed(operandA)) + ('0' & signed(operandB)));
					else
						carry_checked_result := std_logic_vector(('0' & unsigned(operandA)) + ('0' & unsigned(operandB)));
					end if;
				
                when OSub =>
					if (opcode_signed = '1') then
						carry_checked_result := std_logic_vector(('0' & signed(operandA)) - ('0' & signed(operandB)));
					else
						carry_checked_result := std_logic_vector(('0' & unsigned(operandA)) - ('0' & unsigned(operandB)));
					end if;
                        
                when OMulH =>
					null;
                when OMulL =>
					null;				
                when OShiftLeft =>
 					if (opcode_signed = '1') then
						process_result := std_logic_vector(shift_left(signed(operandA), to_integer(signed(operandB))));
					else
						process_result := std_logic_vector(shift_left(unsigned(operandA), to_integer(signed(operandB))));
					end if;
					
                when OShiftRight =>
					if (opcode_signed = '1') then
						process_result := std_logic_vector(shift_right(signed(operandA), to_integer(signed(operandB))));
					else
						process_result := std_logic_vector(shift_right(unsigned(operandA), to_integer(unsigned(operandB))));
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
						process_result := std_logic_vector(rotate_right(unsigned(operandA), to_integer(unsigned(operandB))));
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
					null;
			end case;
		
			if (opcode = OAdd or opcode = OSub) then
				process_result := carry_checked_result(C_WIDTH -1 downto 0);
			end if;
			
			-- Vystup ALU
			result <= process_result;
			
			-- Nastavení carry flagu
			carry <= carry_checked_result( carry_checked_result'high );
			
			-- Nastaveni zero flagu
			if (process_result = all_zeros) then
				zero <= '1';
			end if;
		end if;
	end process;
end architecture RTL;
