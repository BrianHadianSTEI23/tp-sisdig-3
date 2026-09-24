

library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;


-- this is basically a d flip flop
entity register is
    port (
        clk : in  std_logic;
        d  : in  std_logic_vector(3 downto 0);
        en   : in  std_logic;
        
        -- 7-Segment Displays
        q     : out std_logic_vector(3 downto 0);
    );
end entity register;


architecture behavioral of register is 

begin

    process(clk, en)
    begin
        if rising_edge(clk) and en = 1 then
            d <= q;
        end if;
    end process;


end architecture behavioral;
