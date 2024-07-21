--------------------------------------------------------------------------------
-- Company: TUC 
-- Engineers: Athanasakis Fragkogiannis
--
-- Create Date:   11:38:35 04/10/2023
-- Module Name:   C:/Users/vagga/OneDrive/Desktop/Project1_2023/Project1_2023/DATAPATH_TEST.vhd
-- Project Name:  Project1_2023
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DATAPATH_TEST IS 
END DATAPATH_TEST;
 
ARCHITECTURE behavior OF DATAPATH_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         CLK : IN  std_logic;
         RF_WrEn : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         Option : IN  std_logic_vector(1 downto 0);
         ALU_Bin_sel : IN  std_logic;
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic;
         Mem_WrEn : IN  std_logic_vector(0 downto 0);
         MEM_Datain : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal Option : std_logic_vector(1 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal Mem_WrEn : std_logic_vector(0 downto 0) := (others => '0');
   signal MEM_Datain : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          CLK => CLK,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          Option => Option,
          ALU_Bin_sel => ALU_Bin_sel,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf,
          Mem_WrEn => Mem_WrEn,
          MEM_Datain => MEM_Datain
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
   
      --PC_sel <= '0';
      --PC_LdEn <= '0';
      --RF_WrEn <= '0';
      --RF_WrData_sel <= '0';
      --RF_B_sel <= '0';
      --Option <= "00";
      --ALU_Bin_sel <= '0';
      --Mem_WrEn <= "0";
      --MEM_Datain <= "00000000000000000000000000000000";
      --reset <= '1';
      --wait for 100 ns;	
      -- hold reset state for 100 ns.

      --IF
      --reset <= '0';
      --PC_sel <= '0'; -- select +4
      --PC_LdEn <= '0';  --  pc gives the same address
      --DEC
      --RF_WrEn <= '1';
      --RF_WrData_sel <= '1'; -- writes at R2 data from memory(0)
      --RF_B_sel <= '0'; -- Choosing Instr(15..11)
      --Option <= "00";

      --Exec
      --ALU_Bin_sel <= '0'; --Choosing RF_B

      --Mem
      --Mem_WrEn <= "0";--Write in RAM
      --MEM_Datain <= "00000000000000000000000000000000";
      
      --wait for 100 ns;	

      -- addi $R5,$R4,0000000000011111
      --PC_LdEn <= '0';

      --RF_B_sel <= '1';
      --Option <= "01"; -- signExtend
      --ALU_Bin_sel <= '1';
      
      --Mem_WrEn <= "1";
      --MEM_Datain <= "11111111111111111111111111111111";

      --wait for 800 ns;

      reset<='1';
      wait for 100 ns;  

      
      PC_sel <= '0';
      PC_LdEn <= '0';
      RF_WrEn <= '1';
      RF_WrData_sel <= '0';
      RF_B_sel <= '1';
      Option <= "01";
      ALU_Bin_sel <= '1';
      Mem_WrEn <= "1";
      MEM_Datain <= "11111111111111111111111111111111";
      reset <= '0';
     wait for 100 ns;




      

      -- insert stimulus here 

      wait;
   end process;

END;
