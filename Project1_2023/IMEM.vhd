----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:02:06 04/17/2023 
-- Design Name: 
-- Module Name:    IMEM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity IMEM is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ROM_sel : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           PC_OUT : in STD_LOGIC_VECTOR (31 downto 0);
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));

end IMEM;

architecture Stractural of IMEM is

    Component ROM is    
        port( ADDRA : in STD_LOGIC_VECTOR (9 downto 0); 
            CLKA : in STD_LOGIC;
            DOUTA : out STD_LOGIC_VECTOR (31 downto 0));
    end Component;

    Component Adder is
        Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
               B : in  STD_LOGIC_VECTOR (31 downto 0);
               Output : out  STD_LOGIC_VECTOR (31 downto 0));
    end Component;

    Component MUX2in32bit is
	    port( Sel : in  STD_LOGIC;
              Rin1 : in STD_LOGIC_VECTOR (31 downto 0); 
              Rin2 : in STD_LOGIC_VECTOR (31 downto 0);
              Output : out  STD_LOGIC_VECTOR (31 downto 0));
    end Component;

signal  AdderImmedOut,  Mux_out : STD_LOGIC_VECTOR (31 downto 0);

begin

    AddImmed:
        Adder Port Map (A => PC_OUT,
                        B => PC_IMMED,
                        Output => AdderImmedOut
            
        );

    Multiplexer:
        MUX2in32bit  Port Map ( Sel => ROM_sel,--0 selects PC+4, 1 selects PREVIOUS_PC+4+Immed
                                Rin1 => PC_OUT,
                                Rin2 => AdderImmedOut,
                                Output => Mux_out
        );

    ROM_component:
        ROM port map( ADDRA => Mux_out(11 downto 2),
                      CLKA => CLK,
                      DOUTA => Instr
          );    
                                

end Stractural;

