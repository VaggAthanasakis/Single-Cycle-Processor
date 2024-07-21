--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:30:19 03/15/2023
-- Design Name:   
-- Module Name:   C:/Users/vagga/OneDrive/Desktop/Project1_2023/Project1_2023/Execution_Unit_Test.vhd
-- Project Name:  Project1_2023
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Execution_Unit
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.all; 
 
ENTITY Execution_Unit_Test IS
END Execution_Unit_Test;
 
ARCHITECTURE behavior OF Execution_Unit_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Execution_Unit
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Execution_Unit PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

   

   -- Stimulus process
   stim_proc: process
   begin		   -- Initialise by resetting
    RF_A <= "00000000000000000000000000000000";
	RF_B <= "00000000000000000000000000000000";
	Immed<= "00000000000000000000000000000000";
	ALU_Bin_sel <= '0';
	ALU_func <= "0000";
	wait for 100 ns;	


	--ALU component should work correctly, since its been tested in ALU_test
	--Checking behavior for alu inputs RF_A and RF_B
	--Addition
	RF_A <= "01010000000000000000000000000000";
	RF_B <= "11010000000110000000000000000000";
	ALU_Bin_sel <= '0';
	ALU_func <= "0000";
	wait for 100 ns;	
	--Subtraction/AND/OR/NOT
	for i in 0 to 3 loop 
		RF_A <= "10110000000000000000000000000000";
		RF_B <= "10110000000000000000000011000000";
		ALU_Bin_sel <= '0';
		ALU_func <= ALU_func + "0001";
		wait for 100 ns;	
	end loop;

	--Repeat for Immed as input(ALU_Bin_sel = '1')
	RF_A <= "10110000000000000000000000000000";
	Immed <= "10110000000000000000000000000000";
	ALU_func <= "0000";
	ALU_Bin_sel <= '1';
	wait for 100 ns;
	
	for i in 0 to 3 loop 
		RF_A <= "10110000000000000000000000000000";
		Immed <= "10110000000000000000000000000000";
		ALU_Bin_sel <= '1';
		ALU_func <= ALU_func + "0001";
		wait for 100 ns;	
	end loop;

	--Subtraction with Cout and overflow
	RF_A<="01111111111111111111111111111111";
	Immed<="11110000000110000000000000000000";
	ALU_Bin_sel <= '1';
	ALU_func <= "0001"; 
	wait for 100 ns;	


	--Cheking the shift component
	--Arithmetic shift right
	RF_A <= "10000000000000011111111111111111";
	ALU_func <= "1000";
	wait for 100 ns;

	--Logic Shift Right
	ALU_func <= "1001";
	wait for 100 ns;

	--Logic Shift Left
	ALU_func <= "1010";
	wait for 100 ns;

	--Rotate left by 1
	ALU_func <= "1100";
	wait for 100 ns;

	--Rotate right by 1
	ALU_func <= "1101";
	wait for 100 ns;


      wait;
   end process;

END;
