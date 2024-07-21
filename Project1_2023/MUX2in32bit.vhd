----------------------------------------------------------------------------------
-- Company: TUC
-- Engineer: Athanasakis Fragkogiannis
-- 
-- Create Date:    20:02:07 03/09/2023 
-- Module Name:    MUX2in32bit - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2in32bit is
	port( Sel : in  STD_LOGIC;
	      Rin1 : in STD_LOGIC_VECTOR (31 downto 0); 
		  Rin2 : in STD_LOGIC_VECTOR (31 downto 0);
	      Output : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX2in32bit;

architecture Behavioral of MUX2in32bit is

begin

	Output <= Rin1 when Sel = '0' else
			  Rin2;

end Behavioral; 

 