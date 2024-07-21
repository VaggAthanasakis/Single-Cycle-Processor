--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:22:24 04/17/2023
-- Design Name:   
-- Module Name:   C:/Users/vagga/OneDrive/Desktop/Project1_2023/Project1_2023/RAM_DESTR_TEST.vhd
-- Project Name:  Project1_2023
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RAM_DESTR
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
 
ENTITY RAM_DESTR_TEST IS
END RAM_DESTR_TEST;
 
ARCHITECTURE behavior OF RAM_DESTR_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAM_DESTR
    PORT(
         a : IN  std_logic_vector(9 downto 0);
         d : IN  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         we : IN  std_logic;
         spo : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(9 downto 0) := (others => '0');
   signal d : std_logic_vector(31 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal we : std_logic := '0';

 	--Outputs
   signal spo : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RAM_DESTR PORT MAP (
          a => a,
          d => d,
          clk => clk,
          we => we,
          spo => spo
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
      --we <= '1';
      --a <= "0000000000";
      --d <= "11111111111111111111111111111111";
      --wait for 100 ns;	

      --we <= '0';
      --a <= "0000000000";
      --d <= "11111111111111111111110000000000";
      --wait for 100 ns;

      a <= "0000000001"; 
      we <= '1';
      d <= "00000000000001111111110000000000";
      wait for 100 ns;

      a <= "0000000000"; 
      we <= '0';
      d <= "00000000000001111000000000000000";

      wait for 100 ns;
      
      a <= "0000000001"; 
      we <= '0';
      d <= "00000000000001111111110000000000";
        
   
      wait for clk_period*10;

      wait;
   end process;

END;
