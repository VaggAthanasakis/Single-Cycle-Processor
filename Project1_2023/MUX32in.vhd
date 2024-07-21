----------------------------------------------------------------------------------
-- Company: TUC
-- Engineers: Athanasakis Fragkogiannis
-- 
-- Create Date:    19:50:33 03/09/2023 
-- Module Name:    MUX32in - Behavioral 
----------------------------------------------------------------------------------
--I need to create a 2D array (array of vectors), in order to get the 32-bit input
--from each of the 32 registers that i have created. Thus I need to decalre a Package
--where i can declare a type of array of vectors which I can use when decalring the input.
--================================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Package arrayOfVectors is 
	type AOV is array(31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
End Package;
--=================================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Work.arrayOfVectors.ALL;

entity MUX32in is
    Port ( Sel : in  STD_LOGIC_VECTOR (4 downto 0);
           Rin : in AOV;
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX32in;

architecture Behavioral of MUX32in is


begin
    Output <=   Rin(0) when Sel = "00000" else
                Rin(1) when Sel = "00001" else
                Rin(2) when Sel = "00010" else
                Rin(3) when Sel = "00011" else
                Rin(4) when Sel = "00100" else
                Rin(5) when Sel = "00101" else
                Rin(6) when Sel = "00110" else
                Rin(7) when Sel = "00111" else
                Rin(8) when Sel = "01000" else
                Rin(9) when Sel = "01001" else
                Rin(10) when Sel = "01010" else
                Rin(11) when Sel = "01011" else
                Rin(12) when Sel = "01100" else
                Rin(13) when Sel = "01101" else
                Rin(14) when Sel = "01110" else
                Rin(15) when Sel = "01111" else			
                Rin(16) when Sel = "10000" else
                Rin(17) when Sel = "10001" else
                Rin(18) when Sel = "10010" else
                Rin(19) when Sel = "10011" else
                Rin(20) when Sel = "10100" else
                Rin(21) when Sel = "10101" else
                Rin(22) when Sel = "10110" else
                Rin(23) when Sel = "10111" else			 
                Rin(24) when Sel = "11000" else
                Rin(25) when Sel = "11001" else
                Rin(26) when Sel = "11010" else
                Rin(27) when Sel = "11011" else
                Rin(28) when Sel = "11100" else
                Rin(29) when Sel = "11101" else
                Rin(30) when Sel = "11110" else
                Rin(31) when Sel = "11111" ;
    
end Behavioral;

