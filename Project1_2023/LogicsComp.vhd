----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:28:31 03/08/2023 
-- Design Name: 
-- Module Name:    LogicsComp - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LogicsComp is
Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end LogicsComp;

architecture Behavioral of LogicsComp is
    signal tmp : STD_LOGIC_VECTOR (31 downto 0); --A 32 bit helper signal to store the output of the component
                                             
begin
    tmp <= (A and B) when Op = "0010" else
           (A or B) when Op = "0011" else 
           (NOT A) when Op = "0100" else
           "00000000000000000000000000000000";
           
		    
	 
    Zero <= '1' when tmp = "00000000000000000000000000000000" else '0'; 
    Output <= tmp;
    Cout <= '0';
    Ovf <= '0';

end Behavioral;

