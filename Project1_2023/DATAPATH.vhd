----------------------------------------------------------------------------------
-- Company: TUC
-- Engineer: Athanasakis Fragkogiannis
-- 
-- Create Date:    19:26:30 04/08/2023 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity DATAPATH is
Port (  
    --IF stage
    --PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
    PC_sel : in  STD_LOGIC;
    PC_LdEn : in  STD_LOGIC;
    Reset : in  STD_LOGIC;
    CLK : in  STD_LOGIC;  
    Instr : out  STD_LOGIC_VECTOR (31 downto 0);
    
 
    --DECSTAGE
    RF_WrEn : in  STD_LOGIC;
    RF_WrData_sel : in  STD_LOGIC;
    RF_B_sel : in  STD_LOGIC;
    Option : in STD_LOGIC_VECTOR(1 downto 0);

    -- exec
    ALU_Bin_sel : in  STD_LOGIC; 
    Zero : out  STD_LOGIC; 
    ALU_func : in STD_LOGIC_VECTOR(3 downto 0);

    --mem
    Mem_WrEn : in  STD_LOGIC;
    ByteOp : in STD_LOGIC_VECTOR(1 DOWNTO 0)
);
    
end DATAPATH;

architecture Stractural of DATAPATH is

    Component IFunit is
        Port(PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
             PC_sel : in  STD_LOGIC;
             PC_LdEn : in  STD_LOGIC;
             Reset : in  STD_LOGIC;
             CLK : in  STD_LOGIC;
             Instr : out  STD_LOGIC_VECTOR (31 downto 0));
    end Component;

    Component DECSTAGE is
        Port (  Instr : in  STD_LOGIC_VECTOR (31 downto 0);
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
    end Component;

    Component Execution_Unit is
        Port (  RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
                RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
                Immed : in  STD_LOGIC_VECTOR (31 downto 0);
                ALU_Bin_sel : in  STD_LOGIC;
                ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
                ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
                Zero : out  STD_LOGIC;
                Cout : out  STD_LOGIC;
                Ovf : out  STD_LOGIC);
    end Component;

    Component MEM_Unit is
        Port (  CLK : in  STD_LOGIC;
                Mem_WrEn : in  STD_LOGIC;
                ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
                MEM_Datain : in  STD_LOGIC_VECTOR (31 downto 0);
                MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
                ByteOp : in STD_LOGIC_VECTOR(1 DOWNTO 0));
    end Component;

--================================================================================
--Signals-------------------------------------------------------------------------
SIGNAL immed_signal, DEC_RFA, DEC_RFB :  STD_LOGIC_VECTOR (31 downto 0);
SIGNAL ALU_out_signal, MEM_out_signal:  STD_LOGIC_VECTOR (31 downto 0);
signal instr_signal:  STD_LOGIC_VECTOR (31 downto 0);
--================================================================================
begin

    IF_component:
        IFunit Port Map(PC_Immed => immed_signal,
                        PC_sel => PC_sel,
                        PC_LdEn =>PC_LdEn,
                        Reset => Reset,
                        CLK => CLK,
                        Instr =>instr_signal
                        );

    
    DEC_component:
        DECSTAGE Port Map(Instr => instr_signal,
                          RF_WrEn => RF_WrEn,
                          ALU_out =>  ALU_out_signal,
                          MEM_out => MEM_out_signal,
                          RF_WrData_sel => RF_WrData_sel,
                          RF_B_sel => RF_B_sel,
                          CLK => CLK,
                          Option => Option,
                          Reset => Reset,
                          Immed => immed_signal,
                          RF_A => DEC_RFA, 
                          RF_B => DEC_RFB
                        );


    Exec_component:
        Execution_unit Port Map(RF_A => DEC_RFA,
                                RF_B => DEC_RFB,
                                Immed => immed_signal,
                                ALU_Bin_sel => ALU_Bin_sel,
                                ALU_func => ALU_func,
                                ALU_out => ALU_out_signal,
                                Zero => Zero
                                --Cout => Cout,
                                --Ovf => Ovf
                                );

    MEM_component: 
        MEM_UNIT Port Map( CLK => CLK,
                           Mem_WrEn => Mem_WrEn,
                           ALU_MEM_Addr =>ALU_out_signal,
                           MEM_Datain => DEC_RFB,
                           MEM_DataOut => MEM_out_signal,
                           ByteOp => ByteOp
                         );

    Instr <= instr_signal;
                        

end Stractural;

