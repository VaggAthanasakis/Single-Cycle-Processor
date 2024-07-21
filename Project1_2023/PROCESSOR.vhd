----------------------------------------------------------------------------------
-- Company: TUC
-- Engineer: Athanasakis Fragkogiannis
-- 
-- Create Date:    20:17:01 04/11/2023 
-- Module Name:    PROCESSOR - Behavioral 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PROCESSOR is
    Port(CLK : IN std_logic;
         RST : IN std_logic 
        );
end PROCESSOR; 

architecture Stractural of PROCESSOR is

component DATAPATH is
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
            ByteOp : in STD_LOGIC_VECTOR (1 downto 0)
        );
end component;

component CONTROL is
    port(
        --IF stage
        --PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
        --reset : in  STD_LOGIC;
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
end component; 
--Signals
signal Instr_signal: STD_LOGIC_VECTOR (31 downto 0);
signal PC_sel_signal : STD_LOGIC;
signal PC_LdEn_signal : STD_LOGIC;

--DECSTAGE
signal RF_WrEn_signal : STD_LOGIC;
signal RF_WrData_sel_signal :  STD_LOGIC;
signal RF_B_sel_signal :  STD_LOGIC;
signal Option_signal : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL RF_B : STD_LOGIC_VECTOR (31 downto 0);

-- exec
signal ALU_Bin_sel_signal : STD_LOGIC;
signal Zero_signal : STD_LOGIC;
signal ALU_func_signal : STD_LOGIC_VECTOR(3 downto 0);

--mem 
signal Mem_WrEn_signal : STD_LOGIC;
signal MEM_Datain_signal : STD_LOGIC_VECTOR (31 downto 0);
signal ByteOp_signal : STD_LOGIC_VECTOR (1 downto 0);
---------------------------------------------------
    
begin
     
    datapath_component: DATAPATH
        port map(   PC_sel => PC_sel_signal,
                    PC_LdEn => PC_LdEn_signal,
                    Reset => RST,
                    CLK  => CLK,
                    Instr =>Instr_signal,

                    RF_WrEn  => RF_WrEn_signal,
                    RF_WrData_sel  => RF_WrData_sel_signal,
                    RF_B_sel  => RF_B_sel_signal,
                    Option  => Option_signal,
                    
                    ALU_Bin_sel  => ALU_Bin_sel_signal,
                    Zero  => Zero_signal,              
                    ALU_func  => ALU_func_signal,
                    
                    Mem_WrEn  =>Mem_WrEn_signal,
                    ByteOp => ByteOp_signal
                    

        );


    control_component: CONTROL
        port map(Instr => Instr_signal,
                PC_sel => PC_sel_signal,
                PC_LdEn =>PC_LdEn_signal,
                RF_WrEn => RF_WrEn_signal,
                RF_WrData_sel => RF_WrData_sel_signal,
                RF_B_sel => RF_B_sel_signal,
                Option => Option_signal,
                ALU_Bin_sel => ALU_Bin_sel_signal,
                Zero => Zero_signal,
                ALU_func =>ALU_func_signal,
                Mem_WrEn =>Mem_WrEn_signal,
                ByteOp =>ByteOp_signal 
                    
        );
    

end Stractural;

