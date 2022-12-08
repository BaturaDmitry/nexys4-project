
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity TX_FSM is
    port(Clk: in std_logic;
         TX_data : in std_logic_vector(7 downto 0);
         TX_en: in std_logic;
         Baud_en: in std_logic;
         Rst: in std_logic;
         TX: out std_logic;
         TX_ready: out std_logic);
end TX_FSM;

architecture Behavioral of TX_FSM is

type TX_STATE is (idle, start, data, stop);
signal state: TX_STATE := idle;
signal bit_cnt: integer := 0;

begin
    process (Clk, Rst, Baud_en, TX_en)
	begin
		if RST ='1' then
			state <= idle;
			bit_cnt <= 0;
		elsif rising_edge(Clk) then
			if Baud_en = '1' then
			case state is
				when idle => 
					if TX_en = '1' then
						bit_cnt <= 0;
						state <= start;
					else
						bit_cnt <= 0;
						state <= idle;
					end if;
				when start => 
					bit_cnt <= 0;
					state <= data;
				when data => 
					if bit_cnt = 7 then
						state <= stop;
					else
						bit_cnt <= bit_cnt + 1;
						state <= data;
					end if;
				when stop => 
					bit_cnt <= 0;
					state <= idle;
			 end case;
			 end if;
		end if;
	end process;

    TX_ready <= '1' when state = idle else '0'; 
    TX <= '1' when state = idle or state = stop else
          '0' when state = start else
          TX_data(bit_cnt);
    
end Behavioral;
