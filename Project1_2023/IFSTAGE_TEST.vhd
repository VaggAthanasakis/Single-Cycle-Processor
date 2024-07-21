--------------------------------------------------------------------------------
-- Company: TUC 
-- Engineers: Athanasakis Fragkogiannis
--
-- Create Date:   16:20:35 04/09/2023
-- Module Name:   C:/Users/vagga/OneDrive/Desktop/Project1_2023/Project1_2023/IFSTAGE_TEST.vhd
-- Project Name:  Project1_2023
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY IFSTAGE_TEST IS
END IFSTAGE_TEST;  
 
ARCHITECTURE behavior OF IFSTAGE_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFunit   
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         CLK : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal Instr : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFunit PORT MAP (
          PC_Immed => PC_Immed,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn, 
          Reset => Reset,
          CLK => CLK,
          Instr => Instr
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
      
      --PC_Immed <= "00000000000000000000000000000000";
      --Reset <= '1';
      --PC_sel <= '0';
      --PC_LdEn <= '0';
      --wait for 100 ns;	

      --PC_Immed <= "00000000000000000000000000001000";
      --Reset <='0';
      --PC_LdEn <= '1';
      --PC_sel <= '0';
      --wait for 100 ns;	
 
      --PC_Immed <= "11111111111111111111111111111000";
     -- Reset <='0';
      --PC_LdEn <= '1';
      --PC_sel <= '1';
      --wait for 100 ns;
      
      

      -- insert stimulus here 

      wait;
   end process;

END;
