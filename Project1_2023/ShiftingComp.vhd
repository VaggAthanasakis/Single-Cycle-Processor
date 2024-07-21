----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:35:58 03/08/2023 
-- Design Name: 
-- Module Name:    ShiftingComp - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftingComp is
Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ShiftingComp;

architecture Behavioral of ShiftingComp is
--The shifts are performed via functions: shift_left() and shift_right(). 
--The functions take two inputs: the first is the signal to shift, the second is 
--the number of bits to shift. There are two types of shifts: Logical and Arithmetic. 
--A LOGICAL shift means that the new bits are replaced with zeros. ARITHMETIC shift 
--means that the replaced bits are substituted in order to maintain the sign of the original number.
--
--Rotating shift are performed via functions: rotate_left() and rotate_right().
--The functions take two inputs: the first is the signal to rotate, the second is 
--the number of bits to rotate. In this excercise, when rotating left, every bit moves 1 bit to 
--the left and the MSB becomes the LSB. Same thing happens for rotating right where bits move 1 
--bit to the right and the LSB become the MSB
Signal tmp : STD_LOGIC_VECTOR(31 downto 0);
begin
    tmp <= (STD_LOGIC_VECTOR(shift_right(unsigned(A), 1))) when Op = "1000" else -- LOGICAL shift right -> Output = "A[31],A[31],A[30],...,A[1]"
		   (STD_LOGIC_VECTOR(shift_left(unsigned(A), 1))) when Op = "1001" else --LOGICAL shift left -> MSB = '0'
		   (STD_LOGIC_VECTOR(shift_left(signed(A), 1))) when Op = "1010" else --ARITHMETIC shift left -> LSB = '0'
		   (STD_LOGIC_VECTOR(rotate_left(unsigned(A), 1))) when Op = "1100" else--Left rotation
		   (STD_LOGIC_VECTOR(rotate_right(unsigned(A), 1))) when Op = "1101" else-- Right rotation
         "00000000000000000000000000000000";
				 
	Zero <= '1' when tmp = "000000000000000000000000000000000" else '0';
	
   Output <= tmp;	
   Cout <= '0';
   Ovf  <= '0';

end Behavioral;

