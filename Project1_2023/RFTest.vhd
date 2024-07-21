--------------------------------------------------------------------------------
-- Company: TUC
-- Engineers: Athanasakis Fragkogiannis
--
-- Create Date:   21:26:09 03/13/2023
-- Module Name:   C:/Users/vagga/OneDrive/Desktop/Project1_2023/Project1_2023/RFTest.vhd
-- Project Name:  Project1_2023
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.all; 
 
ENTITY RFTest IS
END RFTest;
  
ARCHITECTURE behavior OF RFTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Reset : IN  std_logic;
         CLK : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WrEn => WrEn,
          Reset => Reset,
          CLK => CLK
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
   -- Testing that we can not write data at register 0
   -- The value of the regiter must remain the same (zero) after the run of this test
   -- The address of the reading registers need to be different from the one we try to write to
   -- because we do not want compare module to interfere with the final result 
      
      reset <= '1';
      wait for CLK_period;
      
      reset <= '0';
      Ard1 <= "00000";
      Ard2 <= "10101";
      Awr <= "10101";
      WrEn <= '1';
      Din <= "11111111111111111111111111111111";



      wait for CLK_period;

      Reset <= '0';
      Ard1 <= "10101";
      Ard2 <= "10101";
      Awr <= "00000";
      Din <= "11111111111111111111111111111111";
      WrEn <= '1';
      wait for CLK_period;	
      --100ns

      Ard1 <= "00000";
      Awr <= "00001";
      WrEn <= '0';
      wait for CLK_period;	
      --200ns

      Awr<= "00000";
      wait for CLK_period;	
      --300ns

		for i in 1 to 31 loop -- write in all registers
			Ard1 <= "00000";
			Ard2 <= "00000";
			Awr <= Awr + "00001";
	 		Din <= "11111111111111111111111111111111";
			WrEn <= '1';
			wait for 100 ns;		
	  	end loop;
      --3400ns

      Awr <= "00000";
      wait for 100 ns;
      --3500ns	


		-- read all registers in dout1, make sure register write works
      for j in 1 to 31 loop
			Ard1 <= Ard1 + "00001";
			WrEn <= '0';
			wait for 100 ns;
		end loop;
      --6600ns
      --
      -- write into R5 when WrEn is 0 
		Awr <= "00101";
		Din <= "10000000000000000000111000000011";
		WrEn <= '0';
		wait for 100 ns;
      --6700ns

		-- read R5 to make sure its still zeros, thus wren works
		Ard1 <= "00101";
      Ard2 <= "00111";
		Awr <= "00111";
		Din <= "00000000000000000000001000000011";
		WrEn <= '0';
		wait for 100 ns;
      --6800ns
      
      --Check that reset works
      Reset <= '1';
      wait for 100 ns;
      --6900ns

      wait;
   end process;

END;
