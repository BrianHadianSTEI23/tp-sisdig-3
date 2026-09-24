

library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;


entity mux is
    port (
        sel : in  std_logic;
        a  : in  std_logic_vector(3 downto 0);
        b   : in  std_logic_vector(3 downto 0);
        
        -- 7-Segment Displays
        o     : out std_logic_vector(3 downto 0)
    );
end entity mux;


architecture behavioral of mux is 

begin

    o <= a when sel = '0' else b;


end architecture behavioral;
