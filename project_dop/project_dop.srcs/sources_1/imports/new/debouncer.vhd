library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debouncer is
    port(Clk: in std_logic;
         Btn_in: in std_logic;
         Btn_out: out std_logic);
end debouncer;

architecture Behavioral of debouncer is

signal Q1, Q2, Q3 : std_logic;

begin

    process(Clk)
    begin
        if rising_edge(clk) then
            Q1 <= Btn_in;
            Q2 <= Q1;
            Q3 <= Q2;            
        end if;
    end process;

    Btn_out <= Q1 and Q2 and (not Q3);

end Behavioral;
