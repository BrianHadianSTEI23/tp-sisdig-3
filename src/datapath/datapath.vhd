library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;

entity datapath is
    port (
        clk             : in  std_logic;
        en_regA         : in  std_logic;
        selector_regA   : in  std_logic;
        en_regB         : in  std_logic;
        rst_counter     : in  std_logic;
        en_counter      : in  std_logic;
        a               : in  std_logic_vector(3 downto 0);
        b               : in  std_logic_vector(3 downto 0);
        
        c_mod           : out std_logic_vector(3 downto 0);
        d               : out std_logic_vector(3 downto 0);
        comp_flag       : out std_logic
    );
end entity datapath;

architecture structural of datapath is

    signal mux_reg_a : std_logic_vector(3 downto 0);
    signal mem_reg_a : std_logic_vector(3 downto 0);
    signal mem_reg_b : std_logic_vector(3 downto 0);
    signal reg_sub   : std_logic_vector(3 downto 0);

begin

    mux : entity work.mux 
        port map (
            sel => selector_regA,
            a   => a,
            b   => reg_sub,         
            o   => mux_reg_a 
        );

    register_a : entity work.reg 
        port map (
            clk => clk,
            d   => mux_reg_a,
            en  => en_regA,         
            q   => mem_reg_a 
        );

    register_b : entity work.reg 
        port map (
            clk => clk,
            d   => b,
            en  => en_regB,         
            q   => mem_reg_b 
        );

    comparator : entity work.comparator
        port map (
            a    => mem_reg_a,
            b    => mem_reg_b,
            flag => comp_flag
        );

    substractor : entity work.substractor
        port map (
            a => mem_reg_a,
            b => mem_reg_b,
            s => reg_sub
        );

    counter_inst : entity work.counter
        port map (
            clk => clk,
            clr => rst_counter,
            en  => en_counter,
            o   => d
        );

    c_mod <= mem_reg_a;

end architecture structural;