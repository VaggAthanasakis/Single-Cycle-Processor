----------------------------------------------------------------------------------
-- Company: TUC 
-- Engineers: Athanasakis Fragkogiannis
-- 
-- Create Date:    16:41:27 03/12/2023 
-- Module Name:    IF - Behavioral
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity IFunit is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IFunit;
 
architecture Stractural of IFunit is 
--Components----------------------------------------------------------------------
    Component Adder is
        Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
               B : in  STD_LOGIC_VECTOR (31 downto 0);
               Output : out  STD_LOGIC_VECTOR (31 downto 0));
    end Component;

    Component Register32Bit is 
        Port ( CLK : in  STD_LOGIC;
               Data : in  STD_LOGIC_VECTOR (31 downto 0);
               Dout : out  STD_LOGIC_VECTOR (31 downto 0);
               WE : in  STD_LOGIC;
               Reset : in  STD_LOGIC);
    end Component;
    
    Component MUX2in32bit is
	    port( Sel : in  STD_LOGIC;
              Rin1 : in STD_LOGIC_VECTOR (31 downto 0); 
              Rin2 : in STD_LOGIC_VECTOR (31 downto 0);
              Output : out  STD_LOGIC_VECTOR (31 downto 0));
    end Component;

    COMPONENT IMEM is
        Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
            ROM_sel : in  STD_LOGIC;
            Reset : in  STD_LOGIC;
            CLK : in  STD_LOGIC;
            PC_OUT : in STD_LOGIC_VECTOR (31 downto 0);
            Instr : out  STD_LOGIC_VECTOR (31 downto 0));

    end component;

--================================================================================
--Signals-------------------------------------------------------------------------
Signal Adder4Out, AdderImmedOut, Mux_out, PC_register_out :STD_LOGIC_VECTOR (31 downto 0);
--================================================================================

begin

AddImmed:
    Adder Port Map (A => PC_Immed,
                    B => Adder4Out,
                    Output => AdderImmedOut
        
    );
  
Add4:
    Adder Port Map (A => PC_register_out,
                    B => "00000000000000000000000000000100", --adding +1 to the PC register moves the 
                    Output => Adder4Out                      -- memory pointer by +32 bits (or +4 bytes)

    );                                       


-- Multiplexer
Multiplexer:
    MUX2in32bit  Port Map ( Sel => PC_sel,--0 selects PC+4, 1 selects PC+4+Immed
                            Rin1 => Adder4Out,
                            Rin2 => AdderImmedOut,
                            Output => Mux_out
    );
    
-- PC register    
PC_register:
    Register32bit Port Map( CLK => CLK,
                            Data => Mux_out,
                            Dout => PC_register_out,
                            WE => PC_LdEn,
                            Reset=> Reset

    );

IMEM_comp:
    IMEM  Port Map ( PC_Immed => PC_Immed,
                    ROM_sel => PC_sel,
                    Reset => Reset,
                    CLK => clk,
                    PC_OUT => PC_register_out,
                    Instr => Instr
                    );


end Stractural;

