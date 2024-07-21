--------------------------------------------------------------------------------
-- Company: TUC
-- Engineers: Athanasakis Fragkogiannis
--
-- Create Date:   19:45:01 04/11/2023
-- Module Name:   C:/Users/vagga/OneDrive/Desktop/Project1_2023/Project1_2023/CONTROL_TEST.vhd
-- Project Name:  Project1_2023
--------------------------------------------------------------------------------
LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY CONTROL_TEST IS 
END CONTROL_TEST;
 
ARCHITECTURE behavior OF CONTROL_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         PC_sel : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         Reset : OUT  std_logic;
         RF_WrEn : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         Option : OUT  std_logic_vector(1 downto 0);
         ALU_Bin_sel : OUT  std_logic;
         Zero : IN  std_logic;
         Cout : IN  std_logic;
         Ovf : IN  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         Mem_WrEn : OUT  std_logic_vector(0 downto 0);
         MEM_Datain : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal Zero : std_logic := '0';
   signal Cout : std_logic := '0';
   signal Ovf : std_logic := '0';

 	--Outputs
   signal PC_sel : std_logic;
   signal PC_LdEn : std_logic;
   signal Reset : std_logic;
   signal RF_WrEn : std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_B_sel : std_logic;
   signal Option : std_logic_vector(1 downto 0);
   signal ALU_Bin_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal Mem_WrEn : std_logic_vector(0 downto 0);
   signal MEM_Datain : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          Instr => Instr,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          Option => Option,
          ALU_Bin_sel => ALU_Bin_sel,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf,
          ALU_func => ALU_func,
          Mem_WrEn => Mem_WrEn,
          MEM_Datain => MEM_Datain
        );

   

   -- Stimulus process
   stim_proc: process
   begin		
      
   
--Checking that every operation works
                    --"Opcode/--rs-/--rd-/--rt-/     /-func-"                  
             Instr <= "100000/00001/00111/00001/0000011/0000"; -- ADD
             wait for 100 ns;
             Instr <= "100000/00011/00111/00001/0000011/0001"; --SUB
             wait for 100 ns;
             Instr <= "100000/10101/00111/10110/0000011/0010"; --AND
             wait for 100 ns;
             Instr <= "10000010101001110000000000110011"; --OR
             wait for 100 ns;
             Instr <= "10000000001001110000000000110100"; --NOT
             wait for 100 ns;
             Instr <= "10000000010001000000000000111000"; --SRL
             wait for 100 ns;
             Instr <= "10000000010001000000000000111001"; --SLL
             wait for 100 ns;
             Instr <= "10000000010001000000000000111010"; --SLA
             wait for 100 ns;
             Instr <= "10000010011001000000000000111100"; --ROL
             wait for 100 ns;
             Instr <= "10000010011001000000000000111101"; --ROR
             wait for 100 ns;
             
                    --"OpcodeRs---rd---Immediate-------"
             Instr <= "11100000000001000000000000111100"; --LI
             wait for 100 ns;
             Instr <= "11100100000001000000000000111100"; --LUI
             wait for 100 ns;
             Instr <= "11000000000001000000000000111100"; --ADDI
             wait for 100 ns;
             Instr <= "11001000000001000000000000111100"; --ANDI
             wait for 100 ns;
             Instr <= "11001100000001000000000000111100"; --ORI
             wait for 100 ns;     
             Instr <= "11111100000001000000000000000100"; --B
             Zero <= '0';
             wait for 100 ns;      
             Instr <= "01000000001001000000000000000100"; --BEQ FALSE
             Zero <= '0';
             wait for 100 ns;      
             Instr <= "00000000100001000000000000000100"; --BEQ TRUE
             Zero <= '1';
             wait for 100 ns;      
             Instr <= "01000100101001000000000000000100"; --BNE
             Zero <= '0';
             wait for 100 ns;
             Instr <= "00001100101001000000000000000100"; --LB
             wait for 100 ns;
             Instr <= "00011100101001000000000000000100"; --SB
             wait for 100 ns;
             Instr <= "00111100101001000110000000000100"; --LW
             wait for 100 ns;
             Instr <= "01111100101001000110000000000100"; --SW
             wait for 100 ns;
       
       
      -- insert stimulus here 

      wait;
   end process;

END;
