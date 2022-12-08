library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity baud_rate_generator is
    port (Clk: in std_logic;
          TX_baud_rate: out std_logic;
          RX_baud_rate: out std_logic);
end baud_rate_generator;

architecture Behavioral of baud_rate_generator is

begin
    -- ��������� ������� �������� �������� ��� ��������
    -- �� �������� ������ �� �������� 9600 => �� �������� ������� 100��� �� ����������� 10416 ������
    gen_baud_tx: process(clk)
        variable count: integer range 0 to 10415 :=0;
    begin
        if (rising_edge(clk)) then
            if count = 10415 then
                TX_baud_rate <= '1';
                count := 0;
            else 
                TX_baud_rate <= '0';
                count := count + 1;
            end if;
         end if;
    end process gen_baud_tx;
    
    -- ��������� ������� �������� �������� ��� ��������
        -- �������� ������ �������������� �� �������� 9600 ���/� => 
        --����� ������ �������������� �� �������� 16*9600 => �� ������� 100 ��� �� ����������� 651 ����
    gen_baud_rx: process(clk)
        variable count: integer range 0 to 650 := 0;
    begin
        if rising_edge(clk) then
            if count = 650 then 
                RX_baud_rate <= '1';
                count := 0;
             else 
                RX_baud_rate <= '0';
                count := count + 1;
             end if;
        end if;
    end process gen_baud_rx;

end Behavioral;
