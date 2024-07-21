----------------------------------------------------------------------------------
-- Company: TUC
-- Engineer: Athanasakis Fragkogiannis
-- 
-- Create Date:    20:17:49 03/09/2023 
-- Module Name:    CompareModule - Behavioral 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CompareModule is
    Port ( Ard : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           WrEn : in STD_LOGIC;
           Output : out  STD_LOGIC);
end CompareModule;
 
architecture Behavioral of CompareModule is

begin
    PROCESS(Ard,Awr,WrEn) 
        begin
        -- The bypass occurs when read and write addresses are the same AND writing on the registers in enabled (WrEn =1)
        -- When we try to read and write at register 0 the bypass cannot happen, since R0 is always 0 and cannot be overwritten
        -- Output <= '1' when (Ard(4 downto 0) = Awr(4 downto 0)) AND WrEn = '1' AND Awr /= "00000000000000000000000000000000" else
        --'0';
            if((Ard(4 downto 0) = Awr(4 downto 0)) AND WrEn = '1' AND Awr /= "00000") then 
                Output <= '1';        
            end if;
                Output <= '0' after 10 ns;	-- we make output = '0' after 10 ns in order to avoid 
                                            -- problems when reading and writing in the same register
            
		 end process; 
    
end Behavioral;

