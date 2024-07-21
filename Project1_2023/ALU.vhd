----------------------------------------------------------------------------------
-- Company: TUC 
-- Engineers: Athanasakis Fragkogiannis 
-- 
-- Create Date:    14:46:33 03/08/2023 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name:   Phase 1
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC; 
           Ovf : out  STD_LOGIC); 
end ALU; 

architecture Stractural of ALU is
--Components-------------------------------------------------

Component AddSubComp is 
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
            B : in  STD_LOGIC_VECTOR (31 downto 0);
            Op : in  STD_LOGIC_VECTOR (3 downto 0);
            Output : out  STD_LOGIC_VECTOR (31 downto 0);
            Zero : out  STD_LOGIC;
            Cout : out  STD_LOGIC;
            Ovf : out  STD_LOGIC);
end Component;

Component LogicsComp is 
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
            B : in  STD_LOGIC_VECTOR (31 downto 0);
            Op : in  STD_LOGIC_VECTOR (3 downto 0);
            Output : out  STD_LOGIC_VECTOR (31 downto 0);
            Zero : out  STD_LOGIC;
            Cout : out  STD_LOGIC;
            Ovf : out  STD_LOGIC);
end Component;

Component ShiftingComp is 
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
            B : in  STD_LOGIC_VECTOR (31 downto 0);
            Op : in  STD_LOGIC_VECTOR (3 downto 0);
            Output : out  STD_LOGIC_VECTOR (31 downto 0);
            Zero : out  STD_LOGIC;
            Cout : out  STD_LOGIC;
            Ovf : out  STD_LOGIC);
end Component;

-------------------------------------------------------------
--Signals----------------------------------------------------
signal add_sub_out, logic_out, shift_out : STD_LOGIC_VECTOR(31 downto 0);

signal add_sub_zero, add_sub_cout, add_sub_ovf : STD_LOGIC;

signal logic_zero, logic_cout, logic_ovf : STD_LOGIC;

signal shift_zero, shift_cout, shift_ovf : STD_LOGIC; 
---------------------------------------------------------------------------------------
signal out_delay : STD_LOGIC_VECTOR(31 downto 0);

signal zero_delay, cout_delay, ovf_delay: STD_LOGIC;
------------------------------------------------------------


begin
	add_sub: AddSubComp
	        port map ( A => A,
			   B => B,
			   Op => Op,
			   Output => add_sub_out,
			   Zero => add_sub_zero,
			   Cout => add_sub_cout,
			   Ovf => add_sub_ovf);
							  
	logic: LogicsComp
		port map ( A => A,
			   B => B,
			   Op => Op,
			   Output => logic_out,
			   Zero => logic_zero,
			   Cout => logic_cout,
			   Ovf => logic_ovf);
							  
	shifting: ShiftingComp 
		port map (A => A,
			  B => B,
			  Op => Op,
			  Output => shift_out,
		          Zero => shift_zero,
			  Cout => shift_cout,
			  Ovf => shift_ovf);
		


out_delay  <= add_sub_out when (Op = "0000" or Op = "0001") else
                logic_out when(Op = "0010" or Op = "0011" or Op = "0100") else
                shift_out when (Op = "1000" or Op = "1001" or Op = "1010" or Op = "1100" or Op = "1101");	


zero_delay <= add_sub_zero when (Op = "0000" or Op = "0001") else
                logic_zero when(Op = "0010" or Op = "0011" or Op = "0100" ) else
                shift_zero when (Op = "1000" or Op = "1001" or Op = "1010" or Op = "1100" or Op = "1101");	


cout_delay <= add_sub_cout when (Op = "0000" or Op = "0001") else 
                logic_cout when(Op = "0010" or Op = "0011" or Op = "0100") else
                shift_cout when (Op = "1000" or Op = "1001" or Op = "1010" or Op = "1100" or Op = "1101");	


ovf_delay <= add_sub_ovf when (Op = "0000" or Op = "0001") else
                logic_ovf when(Op = "0010" or Op = "0011" or Op = "0100" ) else
                shift_ovf when (Op = "1000" or Op = "1001" or Op = "1010" or Op = "1100" or Op = "1101");	

Output <= out_delay after 10ns;
Ovf <= ovf_delay after 10ns;
Cout <= cout_delay after 10ns;
Zero <= zero_delay after 10ns;



end Stractural;


-------------------------------------------------------------------------------------------------------------------------------------

