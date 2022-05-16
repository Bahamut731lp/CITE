library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity moore is
    Port(
        clk : in  std_logic;
        rst : in  std_logic;
        en  : in  std_logic;
        x   : in  std_logic;
        q   : out std_logic
    );
end moore;

architecture Behavioral of moore is
	
	type fsm_t is (Sxxx, S1xx, S11x, S110);
	signal current_state, next_state : fms_t; 
	
begin
	fsm_mem: process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				current_state <= Sxxx;
			elsif en = '1' then
				current_state <= next_state;
			end if;
		end if;
	end process;
	
	fsm_tf: process(current_state, x)
	begin  
		next_state <= current_state;
		
		case current_state is
			when Sxxx =>	 
				if x = '1' then
					next_state <= S1xx;
				else   
					next_state <= Sxxx;
				end if;	
				
			when S1xx =>
				if x = '1' then
					next_state <= S11x;
				else   
					next_state <= Sxxx;
				end if;	
				
			when S11x =>
				if x = '1' then
					next_state <= S11x;
				else   
					next_state <= S110;
				end if;	
				
			when S110 =>
				if x = '1' then
					next_state <= S1xx;
				else   
					next_state <= Sxxx;
				end if;	
				
			when others =>
				next_state <= Sxxx;
		end case;
	end process;
	
	fsm_out: process(current_state)
	begin
		case current_state is
			when S110 =>
				q <= '1';
			when others =>
				q <= '0';
		end case;
	end;
end Behavioral;
