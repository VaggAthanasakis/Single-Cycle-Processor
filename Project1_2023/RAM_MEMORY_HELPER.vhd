----------------------------------------------------------------------------------
-- Company: TUC
-- Engineers: Athanasakis Fragkogiannis
-- 
-- Create Date:    17:13:28 04/11/2023 
-- Module Name:    RAM_MEMORY_HELPER - Behavioral 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM_MEMORY_HELPER is
    Port (  MEM_Datain : in  STD_LOGIC_VECTOR (31 downto 0);
            ByteOp : in  STD_LOGIC_VECTOR (1 downto 0);-- defines the proper instraction (sb,lb,sw,lw)
            MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0); 
            RAM_DATA_IN : out STD_LOGIC_VECTOR (31 downto 0); --
            RAM_DATA_OUT : in STD_LOGIC_VECTOR (31 downto 0)            
        );
end RAM_MEMORY_HELPER;

architecture Behavioral of RAM_MEMORY_HELPER is

begin
    -- Byteop table: 
    -- lw -> 00
    -- lb -> 01
    -- sw -> 10
    -- sb -> 11
    
    MEM_DataOut <= RAM_DATA_OUT when ByteOp = "00" else --lw: RF[rd] <- MEM[RF[rs] + SignExtend(Imm)]
                "000000000000000000000000" & RAM_DATA_OUT(7 downto 0) when ByteOp ="01";--lb:RF[rd] <- ZeroFill(31 downto 8) & MEM[RF[rs] + SignExtend(Imm)](7 downto 0)7
                --"--------------------------------";
    RAM_DATA_IN <= MEM_Datain when ByteOp = "10" else --sw: MEM[RF[rs] + SignExtend(Imm)] <- RF[rd]
                "000000000000000000000000" & MEM_DataIn(7 downto 0) when ByteOp = "11"; --sb: MEM[RF[rs] + SignExtend(Imm)] <- ZeroFill(31 downto 8) & RF[rd](7 downto 0)
                --"--------------------------------";
    
                
end Behavioral;  
 
