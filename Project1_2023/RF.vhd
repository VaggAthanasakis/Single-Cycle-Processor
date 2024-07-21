----------------------------------------------------------------------------------
-- Company: TUC
-- Engineer: Athanasakis Fragkogiannis
-- 
-- Create Date:    19:00:33 03/09/2023 
-- Module Name:    RF - Behavioral 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Work.arrayOfVectors.ALL;  

entity RF is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Reset : in STD_LOGIC;
           CLK : in  STD_LOGIC);
end RF;

architecture Stractural of RF is
--Components-------------------------------------------------
Component Register32Bit is
    Port (  CLK : in  STD_LOGIC;
            Data : in  STD_LOGIC_VECTOR (31 downto 0);
            Dout : out  STD_LOGIC_VECTOR (31 downto 0);
            WE : in  STD_LOGIC;
            Reset : in STD_LOGIC);
end Component;

Component Decoder is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component MUX32in is
    Port ( Sel : in  STD_LOGIC_VECTOR (4 downto 0);
           Rin : in AOV;
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;


Component MUX2in32Bit is
    Port ( Sel : in  STD_LOGIC;
           Rin1 : in STD_LOGIC_VECTOR (31 downto 0); 
           Rin2 : in STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component CompareModule is
    Port ( Ard : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           WrEn : in STD_LOGIC;
           Output : out  STD_LOGIC);
end Component;
-------------------------------------------------------------
--Signals----------------------------------------------------
SIGNAL decoder_out : STD_LOGIC_VECTOR(31 downto 0);
Signal register_outputs: AOV;
Signal WE_Vector : STD_LOGIC_VECTOR (31 downto 0);
Signal CompMod_out1 , CompMod_out2: STD_LOGIC;
Signal MUX32_out1 , MUX32_out2: STD_LOGIC_VECTOR (31 downto 0);
-------------------------------------------------------------

begin

 --Decoder
    decoder5to32:
        Decoder Port Map( 
            AWR => Awr,
            Output => decoder_out         
        );

-- register 0 (R0) has always the zero value
-- So we turn off the WE flag
    register0:
        Register32bit Port Map( CLK => CLK,
                                Data => "00000000000000000000000000000000",
                                Dout => register_outputs(0),
                                Reset => Reset,
                                WE => '1'

        );


    register1_31:
        for i in 1 to 31 generate
            WE_Vector(i)<= decoder_out(i) AND WrEn;

            register_i:
                Register32bit Port Map(CLK => CLK,
                                       Data => Din,
                                       Dout => register_outputs(i),
                                       Reset => Reset,
                                       WE =>  WE_Vector(i)
                );
        end generate;

        
-- Compare Modules
    CompareMod1:
        CompareModule Port Map ( Ard => Ard1,
                                 Awr => Awr,
                                 WrEn => WrEn,
                                 Output => CompMod_out1 
        );

    CompareMod2:
        CompareModule Port Map ( Ard => Ard2,
                                 Awr => Awr,
                                 WrEn => WrEn,
                                 Output => CompMod_out2 
        );
        
-- Multiplexers 32 in

    Multiplexer32A:
        MUX32in Port Map ( Sel => Ard1,
                           Rin => register_outputs,
                           Output => MUX32_out1
        );


    Multiplexer32B:
        MUX32in Port Map ( Sel => Ard2,
                           Rin => register_outputs,
                           Output => MUX32_out2
        );


-- Multiplexers 2 in
--We assign position Rin1 to the output of the multiplexers and Rin2 to the Din input 
    Multiplexer2A:
    MUX2in32bit Port Map ( Sel => CompMod_out1 ,
                           Rin1 => MUX32_out1,
                           Rin2 => Din,
                           Output => Dout1
    );


    Multiplexer2B:
    MUX2in32bit  Port Map ( Sel => CompMod_out2,
                            Rin1 => MUX32_out2,
                            Rin2 => Din,
                            Output => Dout2
    );

        
        
end Stractural;

