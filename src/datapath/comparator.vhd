
library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;

entity comparator is
    port (
        a       : in  std_logic_vector(3 downto 0);
        b       : in  std_logic_vector(3 downto 0);        

        flag     : out std_logic
    );
end entity comparator;

architecture behavioral of comparator is
begin
    
    flag <= ((not a(3)) and b(3)) or ((not a(2)) and b(2)) or ((not a(1)) and b(1)) or ((not a(0)) and b(0));

end architecture behavioral;