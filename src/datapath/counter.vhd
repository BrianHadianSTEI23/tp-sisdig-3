

library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;

entity counter is
    port (
        clk : in  std_logic;
        clr  : in  std_logic;
        en   : in  std_logic;
        
        o       : out std_logic_vector(3 downto 0);
        -- ovf     : out std_logic;
    );
end entity counter;


architecture behavioral of counter is 
    signal counter_reg : unsigned(3 downto 0) := "0000";

begin

    process(clk, clr)
    begin
        if clr = 1 then
            counter_reg <= "0000";
        elsif rising_edge(clk) and en = 1 then
            counter_reg <= counter_reg + 1;
        end if;
    end process;

    o <= std_logic_vector(counter_reg);

end architecture behavioral;
