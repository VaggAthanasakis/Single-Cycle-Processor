--------------------------------------------------------------------------------
-- Company: TUC
-- Engineer: Athanasakis Fragkogiannis
--
-- Create Date:   18:26:24 03/14/2023
-- Design Name:   
-- Module Name:   C:/Users/vagga/OneDrive/Desktop/Project1_2023/Project1_2023/DECSTAGE_Test.vhd
-- Project Name:  Project1_2023
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECSTAGE
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
 
ENTITY DECSTAGE_Test IS
END DECSTAGE_Test;
 
ARCHITECTURE behavior OF DECSTAGE_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         CLK : IN  std_logic;
         Option : IN  std_logic_vector(1 downto 0);
         Reset : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal CLK : std_logic := '0';
   signal Option : std_logic_vector(1 downto 0) := (others => '0');
   signal Reset : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          CLK => CLK,
          Option => Option,
          Reset => Reset,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
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
	-- Since register file module has been tested previously i expect RF
	-- to work correctly, thus I will be testing decstage mainly in the R2 register (random register I chose)
	
	
		--Start by resetting registers
      Reset <= '1'; 
      wait for 100 ns;		
      --Instr(31-26) -> unused in decstage
		-- (25-21) -> Read register 1
		-- (20-16) -> Write register//Read register 2
		-- (15-11) -> Read register 2
		-- (15-0) -> InstrToImmed
		--Instr <= "100000 00000 00010 00000 0000000000"

      -- We write Data from ALU to register R2
		Instr   <= "10000000000000100000000000000000";--(20-16) -> Write register, WRITE IN R2(00010)
      RF_WrEn <= '1'; 
      ALU_out <= "11111111111111111111111111111111"; -- Mux 32bit input 1 (RF_WrData_sel:'0')
      MEM_out <= "00000000000000000000000000000000"; -- Mux 32bit input 2 (RF_WrData_sel:'1')
      RF_WrData_sel <= '0'; --ALU_out selected
      RF_B_sel <= '1'; --MUX 5bit selector: '0'-> Instr(15-11) // '1'-> Instr(20-16)
      Reset<='0';--Register file reset
      wait for 100 ns;	
		
      --Instr <= "100011 00010 00010 00000 00000000000"
		Instr   <= "10001100010000100000000000000000";--Read R2 in rf_a and rf_b// Overwrite R2 with MEM_out
      RF_WrEn <= '1'; 
      ALU_out <= "11111111111111111111111111111111"; 
      MEM_out <= "01010101101010101010101101010101"; 
      RF_WrData_sel <= '1'; --MEM_out selected
      RF_B_sel <= '1'; --'1'-> Instr(20-16)->Read Register 2   
      wait for 100 ns;
		
		--Instr(31-26) -> unused in decstage
		-- (25-21) -> Read register 1
		-- (20-16) -> Write register//Read register 2
		-- (15-11) -> Read register 2
		-- (15-0) -> InstrToImmed      
		--Instr <= "101111 00010 00010 00010 00000000000"
		Instr   <= "10111100010000100001000000000000";--Read R2 in rf_a and rf_b// read register 2 from Instr(15-11) // Dont Overwrite R2 
      RF_WrEn <= '1'; 
      ALU_out <= "11111111111111111111111111111111"; 
      MEM_out <= "01010101101010101011111111111111"; 
      RF_WrData_sel <= '1'; --MEM_out selected
      RF_B_sel <= '0'; --'0'-> Instr(15-11)   
      wait for 100 ns;
		--400ns
      
		--I consider the rf and multiplexers tested
		--testing the InstrToImmed module, there are 4 cases:
		
		--SEL = "00" -> zero-fill
		--Instr <= "1011110001000010 1001011111111101"
		Instr   <= "10111100010000101001011111111101";
      Option <= "00";
      wait for 100 ns;
      --500ns
		
		--SEL = "01" -> sign-extend
      --Instr <= "1011110001000010 1001011111111101"
		Instr   <= "10111100010000101001011111111101";
      Option <= "01";
      wait for 100 ns;
		
      -- 600ns
		--SEL = "10" -> 16-bit shift
      --Instr <= "1011110001000010 1001011111111101"
		Instr   <= "10111100010000101001011111111101";
      Option <= "10";
      wait for 100 ns;
		
      -- 700ns
		--SEL = "11" -> Sign-Extend and shift 2
      --Instr <= "1011110001000010 1001011111111101"
		Instr   <= "10111100010000101001011111111101";
      Option <= "11";
      wait for 100 ns;
      wait;
   end process;

END;
