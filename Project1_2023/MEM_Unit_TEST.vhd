--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:14:47 04/11/2023
-- Design Name:   
-- Module Name:   C:/Users/vagga/OneDrive/Desktop/Project1_2023/Project1_2023/MEM_Unit_TEST.vhd
-- Project Name:  Project1_2023
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEM_Unit
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
 
ENTITY MEM_Unit_TEST IS
END MEM_Unit_TEST;
 
ARCHITECTURE behavior OF MEM_Unit_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
  
    COMPONENT MEM_Unit
    PORT(
         CLK : IN  std_logic;
         Mem_WrEn : IN  std_logic_vector(0 downto 0);
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_Datain : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0);
         ByteOp : IN  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Mem_WrEn : std_logic_vector(0 downto 0) := (others => '0');
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_Datain : std_logic_vector(31 downto 0) := (others => '0');
   signal ByteOp : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEM_Unit PORT MAP (
          CLK => CLK,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_Datain => MEM_Datain,
          MEM_DataOut => MEM_DataOut,
          ByteOp => ByteOp
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
      
      Mem_WrEn <= "0";
      ALU_MEM_Addr <= "00000000000000000000000000000000";
                    --"--------------------------------";
      MEM_Datain <=   "11100101010110111000111110000011";
      ByteOp <= "00";  --lw  
      wait for 100 ns;	

      Mem_WrEn <= "0";
      ALU_MEM_Addr <= "00000000000000000000000000001000";
      MEM_Datain <= "11100101010110111000111110000011";
      ByteOp <= "01";  --lb  
      wait for 100 ns;	 

      Mem_WrEn <= "1";
      ALU_MEM_Addr <= "00000000000000000000000000100000"; --write at 8
      MEM_Datain <= "11100101010110111000111110000011"; -- prepei na to parei oloklhro
      ByteOp <= "10";  --sw  
      wait for 100 ns;	

      Mem_WrEn <= "1";
      ALU_MEM_Addr <= "00000000000000000000000000100100";--write at 9
      MEM_Datain <=  "11100101010110111000111110000011";-- prepei na parei mono ta 8 teleutaia bit
      ByteOp <= "11";  --sb     
      wait for 100 ns;	

      -- insert stimulus here 

      wait;
   end process;

END;
