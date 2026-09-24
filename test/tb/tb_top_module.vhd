library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_top_module is
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

    signal clk          : std_logic := '0';
    signal start        : std_logic := '0';
    signal stp          : std_logic := '0';
    signal a            : std_logic_vector(3 downto 0) := (others => '0');
    signal b            : std_logic_vector(3 downto 0) := (others => '0');
    signal c_mod        : std_logic_vector(3 downto 0);
    signal d            : std_logic_vector(3 downto 0);
    
    -- Control signal to end simulation
    signal sim_finished : boolean := false;

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

    -- Clock process stops automatically when sim_finished is true
    clk_process : process
    begin
        while not sim_finished loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    stim_proc: process
        procedure run_test_case(
            val_a : in std_logic_vector(3 downto 0);
            val_b : in std_logic_vector(3 downto 0)
        ) is
        begin
            a <= val_a;
            b <= val_b;
            wait for CLK_PERIOD;

            start <= '1';
            wait for CLK_PERIOD;
            start <= '0';

            wait for 20 * CLK_PERIOD;

            stp <= '1';
            wait for CLK_PERIOD;
            stp <= '0';
            wait for CLK_PERIOD;
        end procedure;

    begin

        stp <= '1';
        wait for 2 * CLK_PERIOD;
        stp <= '0';
        wait for CLK_PERIOD;

        run_test_case("0000", "1111");
        run_test_case("0000", "1111");
        run_test_case("0001", "1110");
        run_test_case("0001", "1110");
        run_test_case("0010", "1101");
        run_test_case("0010", "1101");
        run_test_case("0011", "1100");
        run_test_case("0011", "1100");
        run_test_case("0100", "1011");
        run_test_case("0100", "1011");

        -- simulation for interruption mid calculation
        a <= "0100";
        b <= "0001";
        wait for CLK_PERIOD;

        start <= '1';
        wait for CLK_PERIOD;
        start <= '0';

        wait for 3 * CLK_PERIOD;

        stp <= '1';
        wait for CLK_PERIOD;
        stp <= '0';
        wait for 5 * CLK_PERIOD;

        sim_finished <= true;
        wait;
    end process;

end architecture behavior;