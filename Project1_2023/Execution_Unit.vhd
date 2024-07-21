----------------------------------------------------------------------------------
-- Company: TUC 
-- Engineers: Athanasakis Fragkogiannis
-- 
-- Create Date:    18:19:06 03/15/2023 
-- Module Name:    Execution_Unit - Stractural
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Execution_Unit is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end Execution_Unit;

architecture Stractural of Execution_Unit is
--Components========================================================================
    component MUX2in32Bit is
        Port( Sel : in  STD_LOGIC;
              Rin1 : in STD_LOGIC_VECTOR (31 downto 0); 
              Rin2 : in STD_LOGIC_VECTOR (31 downto 0);
              Output : out  STD_LOGIC_VECTOR (31 downto 0));
    end component;

    component ALU is 
        Port(A : in  STD_LOGIC_VECTOR (31 downto 0);
             B : in  STD_LOGIC_VECTOR (31 downto 0);
             Op : in  STD_LOGIC_VECTOR (3 downto 0);
             Output : out  STD_LOGIC_VECTOR (31 downto 0);
             Zero : out  STD_LOGIC;
             Cout : out  STD_LOGIC;
             Ovf : out  STD_LOGIC);
    end component;
--==================================================================================
--Signals===========================================================================
Signal MUX_out : STD_LOGIC_VECTOR (31 downto 0);
--==================================================================================
begin
    Mux:
        MUX2in32Bit Port Map(   Sel => ALU_Bin_Sel,
                                Rin1 => RF_B,
                                Rin2 => Immed,
                                Output => MUX_out
                            );


    ALU_unit:
        ALU Port Map(A => RF_A,
                     B => MUX_out,
                     Op => ALU_func,  
                     Output => ALU_out,
                     Zero => Zero,
                     Cout => Cout,
                     Ovf => Ovf
        );





end Stractural;

