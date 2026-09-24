library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;

entity fsm is
    port (
        clk         : in  std_logic;
        start       : in  std_logic;
        stp         : in  std_logic;
        comp_less   : in  std_logic; 
        
        -- output
        en_regA        : out std_logic;
        selector_regA  : out std_logic;
        en_regB        : out std_logic;
        rst_counter    : out std_logic;
        en_counter     : out std_logic
    );
end entity fsm;

architecture behavioral of fsm is

    type executionStage is (s1, s2, s3);
    signal currentstate, nextstate : executionStage;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if stp = '1' then
                currentstate <= s1;
            else
                currentstate <= nextstate;
            end if;
        end if;
    end process;

    process(currentstate, start, comp_less)
    begin

        en_regA       <= '0';
        selector_regA <= '0';
        en_regB       <= '0';
        rst_counter   <= '0';
        en_counter    <= '0';
        nextstate     <= currentstate;

        case currentstate is
            when s1 =>
                rst_counter <= '1';
                if start = '1' then
                    en_regA   <= '1';
                    en_regB   <= '1';
                    nextstate <= s2;
                else
                    nextstate <= s1;
                end if;

            when s2 =>
                selector_regA <= '1';
                if comp_less = '1' then
                    en_counter <= '1';
                    nextstate  <= s2;
                else
                    en_counter <= '0';
                    nextstate  <= s3;
                end if;

            when s3 =>
                nextstate <= s3;

            when others =>
                nextstate <= s1;
        end case;
    end process;

end architecture behavioral;