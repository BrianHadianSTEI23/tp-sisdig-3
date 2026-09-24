
library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;

entity top_module is
    port (
        clk             : in  std_logic;
        start           : in  std_logic;
        stp             : in  std_logic;
        a               : in  std_logic_vector(3 downto 0);
        b               : in  std_logic_vector(3 downto 0);
        
        -- out
        c_mod           : out std_logic_vector(3 downto 0);
        d               : out std_logic_vector(3 downto 0)
    );
end entity top_module;

architecture structural of top_module is 

    signal sig_comparator   : std_logic := '0';
    signal sig_en_regA      : std_logic := '0';
    signal sig_en_regB      : std_logic := '0';
    signal sig_selector_regA: std_logic := '0';
    signal sig_rst_counter  : std_logic := '0';
    signal sig_en_counter   : std_logic := '0';

begin

    u_datapath : entity work.datapath 
        port map (
            clk             => clk,
            en_regA         => sig_en_regA,
            selector_regA   => sig_selector_regA,
            en_regB         => sig_en_regB,
            rst_counter     => sig_rst_counter,
            en_counter      => sig_en_counter,
            a               => a,
            b               => b,
            
            c_mod           => c_mod,
            d               => d,
            comp_flag       => sig_comparator
        );

    u_fsm : entity work.fsm 
        port map (
            clk         => clk,
            start      => start,
            stp         => stp,
            comp_less   => sig_comparator,
            
            -- output
            en_regA         => sig_en_regA,
            selector_regA   => sig_selector_regA,
            en_regB         => sig_en_regB,
            rst_counter     => sig_rst_counter,
            en_counter      => sig_en_counter,
        );

end architecture structural;
