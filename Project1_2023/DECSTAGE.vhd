----------------------------------------------------------------------------------
-- Company: TUC 
-- Engineers: Athanasakis Fragkogiannis 
-- 
-- Create Date:    16:22:21 03/14/2023 
-- Module Name:    DECSTAGE - Behavioral 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Option : in STD_LOGIC_VECTOR(1 downto 0);
           Reset : in STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Stractural of DECSTAGE is 
--Components=====================================================================
component  RF is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Reset : in STD_LOGIC;
           CLK : in  STD_LOGIC);
end Component;


Component MUX2in5Bit is
    Port ( Sel : in  STD_LOGIC;
           Rin1 : in STD_LOGIC_VECTOR (4 downto 0); 
           Rin2 : in STD_LOGIC_VECTOR (4 downto 0);
           Output : out  STD_LOGIC_VECTOR (4 downto 0));
end Component;

Component MUX2in32bit is
    Port ( Sel : in  STD_LOGIC;
           Rin1 : in STD_LOGIC_VECTOR (31 downto 0); 
           Rin2 : in STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component InstrToImmed is
    Port ( Instr : in  STD_LOGIC_VECTOR (15 downto 0);
           Option : in  STD_LOGIC_VECTOR (1 downto 0);
           Immed_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;
--===============================================================================
--Signals========================================================================
Signal MUX1_out_5bit : STD_LOGIC_VECTOR(4 downto 0);
Signal MUX2_out_32bit : STD_LOGIC_VECTOR(31 DOWNTO 0);

--===============================================================================
begin

    Mux1:
        MUX2in5Bit Port Map( Sel => RF_B_sel,
                             Rin1 => Instr(15 downto 11), --
                             Rin2 => Instr(20 downto 16), --
                             Output => MUX1_out_5bit
                            );

    Mux2:
        MUX2in32bit Port Map(Sel => RF_WrData_sel,
                             Rin1 => ALU_out,
                             Rin2 => MEM_out,
                             Output => MUX2_out_32bit
                            );

    ImmedComp:
        InstrToImmed Port Map(Instr => Instr(15 downto 0),
                              Option => Option,
                              Immed_out => Immed
                             );

    RegisterFIle:
        RF Port Map(Ard1 => Instr(25 downto 21),
                    Ard2 => MUX1_out_5bit,
                    Awr => Instr(20 downto 16),
                    Dout1 => RF_A,
                    Dout2 => RF_B,
                    Din => MUX2_out_32bit,
                    WrEn => RF_WrEn,
                    Reset => reset,
                    CLK => CLK);
        

        

end Stractural;

