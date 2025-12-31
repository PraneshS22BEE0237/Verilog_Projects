# Johnson Counter - VLSI Design Project

## Introduction

This project implements a **4-bit Johnson Counter** (also known as a **Ring Counter** or **Twisted Ring Counter**) using SystemVerilog. A Johnson counter is a special type of shift register where the output of the last flip-flop is inverted and fed back to the input of the first flip-flop. This creates a unique counting sequence that provides 2n states for an n-bit counter, making it useful in various digital application.......

**Author:** Pranesh S

## Circuit Description

The Johnson counter consists of:
- **4 D flip-flops** connected in a shift register configuration
- **Inverted feedback** from the last stage (Q3) to the first stage (D0)
- **Clock input** for synchronous operation
- **Reset input** for initialization

### Key Features:
- **4-bit output** providing 8 unique states
- **Self-starting** design
- **Symmetric waveforms** - each bit has 50% duty cycle
- **Glitch-free** outputs
- **Simple decoding** for state detection

## Truth Table

The Johnson counter follows this sequence:

| Clock Cycle | Q3 | Q2 | Q1 | Q0 | Decimal |
|-------------|----|----|----|----|---------|
| 0 (Reset)   | 0  | 0  | 0  | 0  | 0       |
| 1           | 0  | 0  | 0  | 1  | 1       |
| 2           | 0  | 0  | 1  | 1  | 3       |
| 3           | 0  | 1  | 1  | 1  | 7       |
| 4           | 1  | 1  | 1  | 1  | 15      |
| 5           | 1  | 1  | 1  | 0  | 14      |
| 6           | 1  | 1  | 0  | 0  | 12      |
| 7           | 1  | 0  | 0  | 0  | 8       |
| 8           | 0  | 0  | 0  | 0  | 0       |

**Note:** The sequence repeats every 8 clock cycles, providing **8 unique states** instead of 16 states that a normal 4-bit counter would have

## State Transition Diagram

```
0000 → 0001 → 0011 → 0111 → 1111 → 1110 → 1100 → 1000 → 0000
  ↑                                                          ↓
  ←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←
```

## Block Diagram

```
        ┌─────────────────────────────────────────────┐
        │                                             │
        │                                             ▼
  ┌─────▼─┐    ┌─────┐    ┌─────┐    ┌─────┐    ┌─────┐
  │  NOT  │    │ DFF │    │ DFF │    │ DFF │    │ DFF │
  │       │    │     │    │     │    │     │    │     │
  └─────┬─┘    │  D  │    │  D  │    │  D  │    │  D  │
CLK ────┼──────┤ CLK │────┤ CLK │────┤ CLK │────┤ CLK │
        │      │  Q  │────┤  Q  │────┤  Q  │────┤  Q  │────┐
RESET ──┼──────┤ RST │    │ RST │    │ RST │    │ RST │    │
        │      └─────┘    └─────┘    └─────┘    └─────┘    │
        │         Q0        Q1        Q2        Q3        │
        └─────────────────────────────────────────────────┘
```

## File Structure

```
Johnson_counter/
├── design.sv          # Main Johnson counter module
├── testbench.sv      # Testbench for simulation
├── run.sh           # Script to run simulation
├── johnson_counter.vcd  # Waveform file (generated)
├── library.cfg      # Library configuration
├── dataset.asdb     # Dataset file
├── work/           # Work directory (simulation files)
└── README.md       # This file
```

## Module Description

### Input Ports:
- `clk`: Clock input (positive edge triggered)
- `reset`: Asynchronous reset (active high)

### Output Ports:
- `q[3:0]`: 4-bit output representing the counter state

### Internal Operation:
```systemverilog
q <= {~q[0], q[3:1]};  // Shift right and complement LSB
```

## Simulation and Testing

### Prerequisites:
- **Riviera-PRO** or compatible SystemVerilog simulator
- **GTKWave** for waveform viewing (optional)

### Running the Simulation:

1. **Using the provided script:**
   ```bash
   chmod +x run.sh
   ./run.sh
   ```

2. **Manual simulation:**
   ```bash
   vlib work
   vlog -timescale 1ns/1ns design.sv testbench.sv
   vsim -c -do "vsim +access+r; run -all; exit"
   ```

3. **View waveforms:**
   ```bash
   gtkwave johnson_counter.vcd
   ```

### Testbench Features:
- **Clock generation** with 10ns period
- **Reset sequence** initialization
- **Monitor output** for terminal display
- **VCD file generation** for waveform analysis
- **100ns simulation** time

## Applications

Johnson counters are widely used in:

1. **Frequency Division**: Each output provides clock/16 frequency
2. **Sequence Generation**: Creating specific bit patterns
3. **State Machines**: Simple state encoding
4. **LED Chasers**: Creating running light effects
5. **Address Generation**: For memory access patterns
6. **Digital Clocks**: As frequency dividers
7. **Control Circuits**: For timing sequence

