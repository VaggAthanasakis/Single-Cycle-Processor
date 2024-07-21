----------------------------------------------------------------------------------
-- Company: TUC 
-- Engineers: Atahanasakis Fragkogiannis 
-- 
-- Create Date:    18:33:37 03/09/2023 
-- Module Name:    Register32Bit - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register32Bit is
    Port ( CLK : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           Reset : in STD_LOGIC);
end Register32Bit;

architecture Behavioral of Register32Bit is

begin
    process(CLK) -- This process is triggered by the clock signal
        begin    -- So that clock components are synchronous 

        if(rising_edge(CLK)) then
            if (Reset = '1') then 
                Dout <= "00000000000000000000000000000000";
            elsif(WE = '1') then
                Dout <= Data;
            end if;
        end if;
    end process;  
    
end Behavioral;

