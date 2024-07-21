----------------------------------------------------------------------------------
-- Company: TUC
-- Engineer: Athanasakis Fragkogiannis
-- 
-- Create Date:    21:32:20 03/20/2023 
-- Module Name:    MEM_Unit - Behavioral 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 

entity MEM_Unit is
    Port ( CLK : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_Datain : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           ByteOp : in  STD_LOGIC_VECTOR (1 downto 0));
end MEM_Unit;

architecture Stractural of MEM_Unit is  

    component RAM_DESTR is
        Port(a : in STD_LOGIC_VECTOR(9 DOWNTO 0); -- 10 bit
             d : in STD_LOGIC_VECTOR(31 DOWNTO 0); -- 10 bit
             spo : out STD_LOGIC_VECTOR(31 DOWNTO 0);
             WE : in STD_LOGIC;
             CLK : in STD_LOGIC);
    end component;

    component RAM_MEMORY_HELPER is
        Port (  MEM_Datain : in  STD_LOGIC_VECTOR (31 downto 0);
                ByteOp : in  STD_LOGIC_VECTOR (1 downto 0); -- defines the proper instraction (sb,lb,sw,lw)
                MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0); 
                RAM_DATA_IN : out STD_LOGIC_VECTOR (31 downto 0); --
                RAM_DATA_OUT : in STD_LOGIC_VECTOR (31 downto 0)            
            );
    end component;

-- signals
signal ram_in, ram_out : std_logic_vector (31 downto 0);
    
begin
    
    RamCom:
        RAM_DESTR Port Map(a => ALU_MEM_Addr(11 downto 2), -- 10 bit
                     d => ram_in,
                     spo => ram_out,
                     WE => Mem_WrEn,
                     CLK => CLK
                    );

    HelperComp:
        RAM_MEMORY_HELPER Port Map( MEM_Datain => MEM_Datain,
                                    MEM_DataOut => MEM_DataOut,
                                    RAM_DATA_IN => ram_in,
                                    RAM_DATA_OUT =>ram_out,
                                    ByteOp=> ByteOp
                                  );






end Stractural;


