----------------------------------------------------------------------------------
-- Company: TUC
-- Engineer: Athanasakis Fragkogiannis
-- 
-- Create Date:    19:39:05 03/09/2023 
-- Module Name:    Decoder - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder is
    port(
        Awr : in  STD_LOGIC_VECTOR (4 downto 0);        
        Output : out  STD_LOGIC_VECTOR (31 downto 0)
    );
end Decoder;

architecture Behavioral of Decoder is


begin

    Output <= "00000000000000000000000000000001" when Awr = "00000" else
              "00000000000000000000000000000010" when Awr = "00001" else
              "00000000000000000000000000000100" when Awr = "00010" else
              "00000000000000000000000000001000" when Awr = "00011" else
              "00000000000000000000000000010000" when Awr = "00100" else
              "00000000000000000000000000100000" when Awr = "00101" else
              "00000000000000000000000001000000" when Awr = "00110" else
              "00000000000000000000000010000000" when Awr = "00111" else				 
              "00000000000000000000000100000000" when Awr = "01000" else
              "00000000000000000000001000000000" when Awr = "01001" else
              "00000000000000000000010000000000" when Awr = "01010" else
              "00000000000000000000100000000000" when Awr = "01011" else
              "00000000000000000001000000000000" when Awr = "01100" else
              "00000000000000000010000000000000" when Awr = "01101" else
              "00000000000000000100000000000000" when Awr = "01110" else
              "00000000000000001000000000000000" when Awr = "01111" else				 
              "00000000000000010000000000000000" when Awr = "10000" else
              "00000000000000100000000000000000" when Awr = "10001" else
              "00000000000001000000000000000000" when Awr = "10010" else
              "00000000000010000000000000000000" when Awr = "10011" else
              "00000000000100000000000000000000" when Awr = "10100" else
              "00000000001000000000000000000000" when Awr = "10101" else
              "00000000010000000000000000000000" when Awr = "10110" else
              "00000000100000000000000000000000" when Awr = "10111" else
              "00000001000000000000000000000000" when Awr = "11000" else
              "00000010000000000000000000000000" when Awr = "11001" else
              "00000100000000000000000000000000" when Awr = "11010" else
              "00001000000000000000000000000000" when Awr = "11011" else
              "00010000000000000000000000000000" when Awr = "11100" else
              "00100000000000000000000000000000" when Awr = "11101" else
              "01000000000000000000000000000000" when Awr = "11110" else
              "10000000000000000000000000000000" when Awr = "11111" ;


end Behavioral;

