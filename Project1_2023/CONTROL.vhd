----------------------------------------------------------------------------------
-- Company: TUC
-- Engineers: Athanasakis Fragkogiannis
-- 
-- Create Date:    13:12:58 04/11/2023 
-- Module Name:    CONTROL - Behavioral 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity CONTROL is
    port(
        --reset : in  STD_LOGIC;
        --IF stage
        --PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
        Instr : in  STD_LOGIC_VECTOR (31 downto 0);
        PC_sel : out  STD_LOGIC;
        PC_LdEn : out  STD_LOGIC;

        --DECSTAGE
        RF_WrEn : out  STD_LOGIC;
        RF_WrData_sel : out  STD_LOGIC;
        RF_B_sel : out  STD_LOGIC;
        Option : out STD_LOGIC_VECTOR(1 downto 0);

        -- exec
        ALU_Bin_sel : out  STD_LOGIC;
        Zero : in  STD_LOGIC;
        ALU_func : out STD_LOGIC_VECTOR(3 downto 0);

        --mem 
        Mem_WrEn : out  STD_LOGIC;
        ByteOp : out STD_LOGIC_VECTOR (1 downto 0)
    );
end CONTROL; 

architecture Behavioral of CONTROL is
    ---type state is (reset_state,working_state);
    --signal CONTROL_state: state;

begin

    process(Instr, Zero)
    begin
        

    if(Instr(31 downto 0) = "00000000000000000000000000000000") then
        PC_sel <= '0';
        PC_LdEn <= '1';
        RF_WrEn <= '-';
        RF_WrData_sel <= '-';
        RF_B_sel <= '-';
        Option  <= "--";
        ALU_Bin_sel <= '-';
        ALU_func <= "----";
        Mem_WrEn <= '-';
        ByteOp <= "--";
        
    else   

        if(Instr(31 downto 26) = "100000") then --Functions in ALU
            ALU_func <= Instr(3 downto 0);  --func is 6bits long but for OpCode="100000" the first 2 are "11"
            PC_LdEn <= '1';					--we can get the apropriate ALU FUNCTION from the last 4 bits
            PC_sel <= '0';
            RF_WrEn <= '1';
            RF_WrData_sel <= '0';
            RF_B_SEL <= '0'; --Instr(15...11)
            ALU_Bin_sel <= '0';
            Mem_WrEn <= '0';		
            --Reset <= '0';		
            Option <= "--"; --Immediate is unused
            --ByteOp <= '-'; -- No load or read from the memory    

        elsif (Instr(31 downto 30) = "11" and Instr(28) = '0') then --Functions in ALU with immediate (without b)
            PC_LdEn <= '1';
            PC_sel <= '0';
            RF_WrEn <= '1';
            RF_WrData_sel <= '0';
            RF_B_SEL <= '1';
            ALU_Bin_sel <= '1'; 
            Mem_WrEn <= '0';
            --Reset <= '0';
            --ByteOp <= '-';	-- No load or read from the memory    

            --cases in alu functions with immediate	
            if(Instr(28 downto 26) = "000") then--|          li               //               addi               | , where li is basically addition with 0, thus:
                Option <= "01"; -- sign-extend   --|RF[rd] <- SignExtend(Imm) // RF[rd] <- RF[rs] + SignExtend(Imm)|
                ALU_func <= "0000"; --addition

            elsif( Instr(28 downto 26) = "001") then --lui: RF[rd] <- Imm << 16 (zero-fill)
                Option <= "10"; -- 16 bit shift
                ALU_func <= "0000"; -- addition

            elsif (Instr(28 downto 26) = "010"  ) then -- andi: RF[rd] <- RF[rs] AND ZeroFill(Imm)
                Option <= "00"; -- zero-fill
                ALU_func <= "0010"; -- and

            elsif(Instr(28 downto 26) = "011"  ) then -- ori: RF[rd] <- RF[rs] | ZeroFill(Imm)
                Option <= "00"; -- zero-fill
                ALU_func <= "0011"; -- or
            end if;

        
        -- branches
        elsif(INSTR(31 DOWNTO 26) = "111111" OR INSTR(31 DOWNTO 26)="010000" OR INSTR(31 DOWNTO 26) = "010001") then-- (b, beq and bne) branching cases
            PC_LdEn <= '1';
            RF_WrEn <= '0';	-- do not write at register file			
            RF_B_SEL <= '1'; -- (immed)
            RF_WrData_sel <= '-'; -- dont mind
            Option <= "11"; --sign extend and shift 2
            Mem_WrEn <= '0';	
            ByteOp <= "--";	 

            --branching cases
            if(Instr(31 DOWNTO 26) = "111111" ) then -- b
                ALU_func <= "----"; 
                ALU_Bin_sel <= '0'; -- mporei na xreiazetai allo gt h alu den kanei kati
                PC_sel <= '1';

            elsif(Instr(31 DOWNTO 26) = "010000") then --beq
                ALU_func <= "0001"; -- sub  if(rs-rd == 0)
                ALU_Bin_sel <= '0'; --choose RF_B in exec module
                if(Zero = '1') then  
                    PC_sel <='1'; -- PC <=  PC + 4 + (SignExtend(Imm) << 2
                else
                    PC_sel <= '0'; -- PC <=  PC + 4
                end if;

            elsif(Instr(31 DOWNTO 26) = "010001") then -- bne
                ALU_func <= "0001"; --sub
                ALU_Bin_sel <= '0';
                if(Zero = '1') then  
                    PC_sel <='0'; -- PC <=  PC + 4
                else
                    PC_sel <= '1'; -- PC <=  PC + 4 + (SignExtend(Imm) << 2
                end if;
            end if;
        
            
        --lw//sw & lb//sb
        elsif(Instr(31 downto 26) = "000011" or Instr(31 downto 26) = "000111" or Instr(31 downto 26) = "001111" or Instr(31 downto 26) = "011111" ) then
            ALU_func <= "0000";
            PC_LdEn <= '1';
            PC_sel <= '0';
            RF_WrData_sel <='1'; --
            Option <= "01"; --sign extend 
            ALU_Bin_sel <= '1';


            if(Instr(31 downto 26) = "000011") then -- lb
                RF_WrEn <= '1';
                RF_B_SEL <= '1';
                ByteOp <= "01";
                Mem_WrEn <= '0';
            elsif (Instr(31 downto 26) = "000111") then--sb
                RF_WrEn <= '0';
                RF_B_SEL <= '1';
                Mem_WrEn <= '1';
                ByteOp <= "11"; 
                
            
            elsif (Instr(31 downto 26) = "001111") then--lw
                RF_WrEn <= '1';
                RF_B_SEL <= '1';
                ByteOp <= "00";
                Mem_WrEn <= '0';

            else --sw
                RF_WrEn <= '0';
                RF_B_SEL <= '1';
                Mem_WrEn <= '1';
                ByteOp <= "10"; 
                
            
            end if;

        end if;
    end if;

    end process;


end Behavioral;

