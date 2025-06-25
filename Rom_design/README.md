# ROM (Read-Only Memory) Design in SystemVerilog

## Introduction

This project implements a parameterizable Read-Only Memory (ROM) module in SystemVerilog. ROM is a type of non-volatile memory that stores data permanently and allows only read operations. Once programmed, the data stored in ROM cannot be modified during normal operation, making it ideal for storing firmware, boot code, lookup tables, and other constant data.

The design features a 16-location ROM with 8-bit data width, preloaded with the Fibonacci sequence, demonstrating fundamental concepts of digital memory design and SystemVerilog implementation.

## Circuit Diagram

```
                   ┌─────────────────────────────────┐
                   │              ROM                │
    [3:0] addr ────┤ Address Input                   │
                   │  (4-bit Address Bus)            │
                   │                                 │
                   │  ┌─────────────────────────┐    │
                   │  │    Memory Array         │    │
                   │  │  16 x 8-bit locations   │    │
                   │  │                         │    │
                   │  │  addr[3:0]  data[7:0]   │    │
                   │  │    0000  →  00000000     │    │
                   │  │    0001  →  00000001     │    │
                   │  │    0010  →  00000001     │    │
                   │  │    0011  →  00000010     │    │
                   │  │    0100  →  00000011     │    │
                   │  │    0101  →  00000101     │    │
                   │  │    0110  →  00001000     │    │
                   │  │    0111  →  00001101     │    │
                   │  │    1000  →  00000000     │    │
                   │  │     ...  →     ...       │    │
                   │  └─────────────────────────┘    │
                   │                                 │
                   │           Address Decoder       │
                   │               │                 │
    [7:0] data_out ◄──────────── Data Output ────────┤
                   │         (8-bit Data Bus)        │
                   └─────────────────────────────────┘

Memory Organization:
┌─────────┬─────────────┬──────────────┐
│ Address │ Binary Data │ Decimal Value│
├─────────┼─────────────┼──────────────┤
│   0x0   │  0000_0000  │      0       │
│   0x1   │  0000_0001  │      1       │
│   0x2   │  0000_0001  │      1       │
│   0x3   │  0000_0010  │      2       │
│   0x4   │  0000_0011  │      3       │
│   0x5   │  0000_0101  │      5       │
│   0x6   │  0000_1000  │      8       │
│   0x7   │  0000_1101  │     13       │
│ 0x8-0xF │  0000_0000  │      0       │
└─────────┴─────────────┴──────────────┘
```

## Key Features

- **Parameterizable Design**: Configurable data width and address width
- **Preloaded Data**: ROM is initialized with Fibonacci sequence
- **Asynchronous Read**: Data output changes immediately when address changes
- **Synthesizable**: Compatible with FPGA and ASIC design flows
- **Testbench Included**: Complete verification environment with VCD waveform generation

## Basic Idea and Concepts

### ROM Fundamentals

1. **Non-Volatile Storage**: ROM retains data even when power is removed
2. **Read-Only Operation**: Data can only be read, not written during normal operation
3. **Random Access**: Any memory location can be accessed directly using its address
4. **Fixed Content**: Data is programmed during manufacturing or initialization

### Design Architecture

The ROM design consists of:

1. **Memory Array**: A 2D array storing the actual data
2. **Address Decoder**: Decodes the input address to select the correct memory location
3. **Output Buffer**: Drives the selected data to the output pins

### Memory Organization

- **Address Width**: 4 bits (supports 2^4 = 16 memory locations)
- **Data Width**: 8 bits (each location stores 8-bit data)
- **Total Capacity**: 16 × 8 = 128 bits
- **Address Range**: 0x0 to 0xF (hexadecimal)

### Read Operation

```
1. Address is applied to addr[3:0] input
2. Address decoder selects the corresponding memory location
3. Data from selected location appears on data_out[7:0]
4. Output is valid after propagation delay
```

## Applications

### 1. **Firmware Storage**
- BIOS/UEFI code in computers
- Bootloaders in embedded systems
- Device drivers and system initialization code

### 2. **Lookup Tables (LUT)**
- Mathematical function approximations (sin, cos, log)
- Character encoding tables (ASCII, Unicode)
- Color palette tables in graphics systems
- Gamma correction tables

### 3. **Configuration Data**
- Default settings for devices
- Calibration parameters
- Network configuration data
- Hardware configuration registers

### 4. **Program Memory**
- Microcontroller program storage
- Digital Signal Processor (DSP) algorithms
- State machine implementations
- Protocol stack implementations

### 5. **Data Conversion**
- Code conversion tables
- Compression/decompression tables
- Error correction code tables
- Format conversion matrices

### 6. **Graphics and Multimedia**
- Font character bitmaps
- Icon and sprite data
- Audio sample tables
- Video codec coefficients

## File Structure

```
Rom_design/
├── design.sv          # Main ROM module implementation
├── testbench.sv       # Testbench for verification
├── rom_waveform.vcd   # Generated waveform file
├── run.sh            # Simulation script
├── library.cfg       # Library configuration
├── dataset.asdb      # Design database
├── work/             # Compilation workspace
└── README.md         # This documentation
```

## Module Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `DATA_WIDTH` | 8 | Width of data bus in bits |
| `ADDR_WIDTH` | 4 | Width of address bus in bits |

## Port Description

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| `addr` | Input | `ADDR_WIDTH` | Address input to select memory location |
| `data_out` | Output | `DATA_WIDTH` | Data output from selected memory location |


