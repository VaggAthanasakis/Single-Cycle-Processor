----------------------------------------------------------------------------------
-- Company: TUC
-- Engineers: Athanasakis Fragkogiannis
-- 
-- Create Date:    14:54:48 03/08/2023 
-- Module Name:    AddSubComp - Behavioral 
-- Project Name: Phase 1
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity AddSubComp is
Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end AddSubComp;

architecture Behavioral of AddSubComp is
    signal tmp : STD_LOGIC_VECTOR (32 downto 0); --A 33 bit helper signal to add or subtract the inputs 
begin                                            -- with an extra bit to handle overflow

    tmp <= ((A(31)&A) + (B(31)&B)) when Op = "0000" else  --Addition Case // -- I append the sign bit at the msb to be able to handle a possible overflow
           ((A(31)&A) - (B(31)&B)) when Op = "0001" else --Subtraction Case // I do the same thing
           "000000000000000000000000000000000";
      
    Zero <= '1' when tmp(31 downto 0) = "00000000000000000000000000000000" else '0';	       
	
    Ovf <= '1' when (A(31) = B(31)) and (tmp(31)/=A(31)) and (Op="0000") else --Overflow conditions when adding
           '1' when (A(31) /= B(31)) and (B(31) = tmp(31)) and (Op = "0001") else
           '0';
           
    Cout <= tmp(32);
    
    Output <= tmp(31 downto 0);

end Behavioral;

