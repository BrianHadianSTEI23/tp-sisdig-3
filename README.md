# Prerequsite Task 3 before Labwork for EL2102 Digital Systems

## Brief Intro
This repository contains the VHDL implementation of a digital system consisting of a Control Unit (FSM) and a Datapath, designed as part of the EL2102 Digital Systems labwork preparation. The system performs iterative arithmetic/comparison operations using a registered datapath, comparator, subtractor, and counter module.

## Architecture
The system follows a classic **FSM + Datapath** structural architecture:

1. **FSM (Control Unit):** Coordinates operational stages (`s1`, `s2`, `s3`) based on external control signals (`start`, `stp`) and datapath feedback (`comp_less`). It generates control signals to enable registers, route multiplexers, and reset/enable the counter.
2. **Datapath:** Consists of hardware components:
   - **Mux:** Selects between raw input `A` and arithmetic feedback.
   - **Registers (RegA & RegB):** Stores input values/intermediate results on clock cycles when enabled.
   - **Subtractor:** Computes the arithmetic difference between loaded values.
   - **Comparator:** Evaluates comparison conditions and feeds the boolean flag (`comp_less`) back to the FSM.
   - **Counter:** Keeps track of execution iterations/cycles and outputs state `D`.

## Specs
- **Data Width:** 4-bit (`std_logic_vector(3 downto 0)`)
- **Clock:** Synchronous active-high clock edge driving FSM and datapath registers
- **Reset/Stop:** Active-high `stp` signal to clear states and reset the iteration counter
- **Target Toolchain:** Standard IEEE VHDL 1993/2008 compliant (compatible with GHDL)

## Prerequisites
1. ghdl
2. GTKWave

## How to test
```shell
# 1. Analyze VHDL source files
ghdl -a fsm.vhd datapath.vhd top_module.vhd tb/tb_top_module.vhd

# 2. Elaborate testbench entity
ghdl -e tb_top_module

# 3. Run simulation and dump waveforms to a VCD file
ghdl -r tb_top_module --vcd=tb_top_module.vcd

# 4. View waveform output in GTKWave
gtkwave tb_top_module.vcd
```

## Testbenches
> See further in the tb/ folder
The testbench (tb/tb_top_module.vhd) simulates the complete circuit using systematic input pairs for A and B across multiple standard execution cycles with clock generation, automated start pulsing, and stop reset routines.

## Author 
> Brian A. Hadian (A final-year undergraduate computer science student at Bandung Institute of Technology)
