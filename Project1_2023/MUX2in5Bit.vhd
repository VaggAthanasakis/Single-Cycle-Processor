----------------------------------------------------------------------------------
-- Company: TUC
-- Engineers: Athanasakis Fragkogiannis
-- 
-- Create Date:    17:54:31 03/14/2023  
-- Module Name:    MUX2in5Bit - Behavioral 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2in5Bit is
    Port ( Rin1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Rin2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Output : out  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC);
end MUX2in5Bit;

architecture Behavioral of MUX2in5Bit is

begin  

	Output <= Rin1 when sel = '0' else
			  Rin2;
 
end Behavioral;

