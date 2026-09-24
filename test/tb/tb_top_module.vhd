library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_top_module is
-- Testbench has no external ports
end entity tb_top_module;

architecture behavior of tb_top_module is

    component top_module is
        port (
            clk     : in  std_logic;
            start   : in  std_logic;
            stp     : in  std_logic;
            a       : in  std_logic_vector(3 downto 0);
            b       : in  std_logic_vector(3 downto 0);
            c_mod   : out std_logic_vector(3 downto 0);
            d       : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Signal declarations
    signal clk     : std_logic := '0';
    signal start   : std_logic := '0';
    signal stp     : std_logic := '0';
    signal a       : std_logic_vector(3 downto 0) := (others => '0');
    signal b       : std_logic_vector(3 downto 0) := (others => '0');

    signal c_mod   : std_logic_vector(3 downto 0);
    signal d       : std_logic_vector(3 downto 0);

    -- Clock period definition (100 MHz clock)
    constant CLK_PERIOD : time := 10 ns;

begin

    uut: top_module
        port map (
            clk     => clk,
            start   => start,
            stp     => stp,
            a       => a,
            b       => b,
            c_mod   => c_mod,
            d       => d
        );

    -- clk for simulation
    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    stim_proc: process
        procedure run_test_case(
            val_a : in std_logic_vector(3 downto 0);
            val_b : in std_logic_vector(3 downto 0)
        ) is
        begin
            -- 1. Apply inputs A and B
            a <= val_a;
            b <= val_b;
            wait for CLK_PERIOD;

            -- 2. Pulse Start signal to initiate FSM computation
            start <= '1';
            wait for CLK_PERIOD;
            start <= '0';

            -- 3. Wait for FSM computation to complete
            wait for 20 * CLK_PERIOD;

            -- 4. Pulse Stop/Reset signal to prepare for next run
            stp <= '1';
            wait for CLK_PERIOD;
            stp <= '0';
            wait for CLK_PERIOD;
        end procedure;

    begin

        -- init reset
        stp <= '1';
        wait for 2 * CLK_PERIOD;
        stp <= '0';
        wait for CLK_PERIOD;

        ------------------------------------------------------------------
        -- Test Cases from Image Table
        ------------------------------------------------------------------
        -- Row 1: A = "0000", B = "1111"
        run_test_case("0000", "1111");

        -- Row 2: A = "0000", B = "1111"
        run_test_case("0000", "1111");

        -- Row 3: A = "0001", B = "1110"
        run_test_case("0001", "1110");

        -- Row 4: A = "0001", B = "1110"
        run_test_case("0001", "1110");

        -- Row 5: A = "0010", B = "1101"
        run_test_case("0010", "1101");

        -- Row 6: A = "0010", B = "1101"
        run_test_case("0010", "1101");

        -- Row 7: A = "0011", B = "1100"
        run_test_case("0011", "1100");

        -- Row 8: A = "0011", B = "1100"
        run_test_case("0011", "1100");

        -- Row 9: A = "0100", B = "1011"
        run_test_case("0100", "1011");

        -- Row 10: A = "0100", B = "1011"
        run_test_case("0100", "1011");

        ------------------------------------------------------------------
        wait; 
    end process;

end architecture behavior;