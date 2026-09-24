

library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;

entity substractor is
    generic (
        b_in    :  std_logic_vector(3 downto 0) := "0000"
    );
    port (
        a       : in  std_logic_vector(3 downto 0);
        b       : in  std_logic_vector(3 downto 0);
        
        -- 7-Segment Displays
        s       : out std_logic_vector(3 downto 0)
        -- c_o     : out std_logic_vector(3 downto 0);
    );
end entity substractor;


architecture behavioral of substractor is 
begin

    s <= ((not b_in) and (a xor b)) or (b_in and (a nand b));
    -- c_o <= ((not a) and b_in) or (b and (a nand b_in));

end architecture behavioral;
