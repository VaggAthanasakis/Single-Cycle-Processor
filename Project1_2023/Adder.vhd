----------------------------------------------------------------------------------
-- Company: TUC
-- Engineer: Athanasakis Fragkogiannis
-- 
-- Create Date:    16:36:46 03/12/2023 
-- Module Name:    Adder - Behavioral 
--
----------------------------------------------------------------------------------
library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity Adder is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Adder;

architecture Behavioral of Adder is

begin

    Output <= A + B ;

end Behavioral;

