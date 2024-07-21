----------------------------------------------------------------------------------
-- Company: TUC
-- Engineer: Athanasakis Fragkogiannis
-- 
-- Create Date:    17:10:18 03/14/2023 
-- Module Name:    InstrToImmed - Behavioral 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstrToImmed is
    Port ( Instr : in  STD_LOGIC_VECTOR (15 downto 0);
           Option : in  STD_LOGIC_VECTOR (1 downto 0);
           Immed_out : out  STD_LOGIC_VECTOR (31 downto 0));
end InstrToImmed;

architecture Behavioral of InstrToImmed is
--00 -> zero-fill
--01 -> sign-extend
--10 -> 16-bit shift (in order to get 32-bit output)
--11 -> sign extend and shift 2
    
begin
    Immed_out(31 downto 18) <= "00000000000000" when Option = "00" else 
                            (others => Instr(15)) when Option = "01" else 
                            Instr(15 downto 2)    when Option = "10" else 
                            (others => Instr(15)) when Option = "11";    
            
    Immed_out(17 downto 16)<= "00" when Option = "00" else
                            (others => Instr(15)) when Option = "01" else
                            Instr(1 downto 0)     when Option = "10" else
                            Instr(15 downto 14)   when Option = "11";							 
            
        Immed_out(15 downto 0) <= Instr when Option = "00" else
                            Instr when Option = "01" else
                            "0000000000000000" when Option = "10" else
                            (STD_LOGIC_VECTOR(shift_left(unsigned(Instr),2))) when Option = "11" ;



end Behavioral;

