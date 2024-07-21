--------------------------------------------------------------------------------
-- Company: TUC
-- Engineer: Athanasakis Fragkogiannis
--
-- Create Date:   12:11:39 04/12/2023
-- Module Name:   C:/Users/vagga/OneDrive/Desktop/Project1_2023/Project1_2023/PROCESSOR_TEST.vhd
-- Project Name:  Project1_2023
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PROCESSOR_TEST IS 
END PROCESSOR_TEST; 
 
ARCHITECTURE behavior OF PROCESSOR_TEST IS   
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PROCESSOR       
    PORT(
         CLK : IN  std_logic;   
         RST : IN  std_logic   
        ); 
    END COMPONENT;       
      

   --Inputs   
   signal CLK : std_logic := '0'; 
   signal RST : std_logic := '0'; 

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
  
BEGIN    
  
	-- Instantiate the Unit Under Test (UUT)
   uut: PROCESSOR PORT MAP (
          CLK => CLK,
          RST => RST
        ); 

   -- Clock process definitions
   CLK_process :process 
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
	
      RST <='1';
      wait for CLK_period*5;	
      
      RST <='0';

      wait; 
   end process;

END;
