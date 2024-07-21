--------------------------------------------------------------------------------
-- Company: TUC 
-- Engineers: Athanasakis Fragkogiannis
--
-- Create Date:   19:59:56 03/08/2023
-- Design Name:   
-- Module Name:   C:/Users/vagga/OneDrive/Desktop/Project1_2023/Project1_2023/ALU_TEST.vhd
-- Project Name:  Project1_2023
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALU_TEST IS
END ALU_TEST; 
 
ARCHITECTURE behavior OF ALU_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    
 
   --Inputs 
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic; 
   signal Ovf : std_logic; 
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );


   -- Stimulus process
   stim_proc: process
   begin		
   --Add-----------------------------------------------------
         A<="00000000000000000000000000000000";
         B<="00000000000000000000000000000000";
         Op<="0000";
         wait for 100 ns;
   
         A<="00110000000000000000000000000000";
         B<="00110000000110000000000000000000";
         Op<="0000";
         wait for 100 ns;
   
         A<="01010000000000000000000000000000";
         B<="11010000000110000000000000000000";
         Op<="0000";
         wait for 100 ns;
   
         A<="10110000000000000000000000000000";
         B<="10110000000110000000000000000000";
         Op<="0000";
         wait for 100 ns;
   --Sub-----------------------------------------------------
         A<="00110000000000000000000000000000";
         B<="00110000000110000000000000000000";
         Op<="0001";
         wait for 100 ns;
   
         A<="11010000000010000000000000000000";
         B<="01000000000110000000000000000001";
         Op<="0001";
         wait for 100 ns;
   
         A<="01110000000000000000000000000000";
         B<="10110000000110000000000000000000";
         Op<="0001";
         wait for 100 ns;
         
         A<="00000000000000000000000000000000";
         B<="00000000000000000000000000000000";
         Op<="0001";
         wait for 100 ns;
   --Logic---------------------------------------------------
         A<="01010000000000000000000000000000";
         B<="11010000000110000000000000000000";
         Op<="0010";
         wait for 100 ns;

         A<="00000000000000000000000000000000";
         B<="00000000000000000000000000000000";
         Op<="0010";
         wait for 100 ns;

         A<="01010000000000000000000000000000";
         B<="11010000000110000000000000000000";
         Op<="0011";
         wait for 100 ns;
      
         A<="01010000000000000000000000000000";
         B<="11010000000110000000000000000000";
         Op<="0100";
         wait for 100 ns;        
   --Shift---------------------------------------------------
         A<="00000000000001111110000000001111";
         Op<="1000";
         wait for 100 ns;	
   
         A<="11110000000000000000000000011110";
         Op<="1000";
         wait for 100 ns;
   
         A<="00000000000001111110000000001111";
         Op<="1001";
         wait for 100 ns;	
   
         A<="11110000000000000000000000011110";
         Op<="1001";
         wait for 100 ns;
   
         A<="00000000000001111110000000001111";
         Op<="1010";
         wait for 100 ns;	
   
         A<="11110000000000000000000000011110";
         Op<="1010";
         wait for 100 ns;
   
         A<="00000000000001111110000000001111";
         Op<="1100";
         wait for 100 ns;	
   
         A<="11110000000000000000000000011110";
         Op<="1100";
         wait for 100 ns;
   
         A<="00000000000001111110000000001111";
         Op<="1101";
         wait for 100 ns;	
   
         A<="11110000000000000000000000011110";
         Op<="1101";
         wait for 100 ns;
         
         A<="00000000000000000000000000000000";
         B<="00000000000000000000000000000000";
         Op<="1101";
         wait for 100 ns;
               
      wait;
   end process;

END;
