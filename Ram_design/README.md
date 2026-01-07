# Static RAM (SRAM) Design - Verilog Implementation

## 📋 Project Overview

This project implements a **Static Random Access Memory (SRAM)** module using Verilog HDL. The design features a synchronous read/write memory array with configurable word width and memory depth, implementing industry-standard memory interface protocols............

**Author:** Pranesh S  
**Institution:** VIT University, Vellore  
**Language:** Verilog HDL  
**Design Type:** Synchronous Static RAM  
**Memory Architecture:** Single-Port SRAM

---

## 🏗️ System Architecture

### Memory Organization

```
Memory Array Structure:
┌─────────────────────────────────────────┐
│          SRAM Memory Core               │
│  ┌─────┬─────┬─────┬─────┬─────┬─────┐  │
│  │ 0x0 │ 0x1 │ 0x2 │ 0x3 │ ... │0xFF │  │ Word 0
│  ├─────┼─────┼─────┼─────┼─────┼─────┤  │
│  │ 0x0 │ 0x1 │ 0x2 │ 0x3 │ ... │0xFF │  │ Word 1
│  ├─────┼─────┼─────┼─────┼─────┼─────┤  │
│  │ ... │ ... │ ... │ ... │ ... │ ... │  │
│  ├─────┼─────┼─────┼─────┼─────┼─────┤  │
│  │ 0x0 │ 0x1 │ 0x2 │ 0x3 │ ... │0xFF │  │ Word N-1
│  └─────┴─────┴─────┴─────┴─────┴─────┘  │
└─────────────────────────────────────────┘
        ↑                     ↑
    Data Width            Address Space
    (8/16/32 bits)       (256/512/1024 words)
```

### Memory Interface Block Diagram

```
                    ┌─────────────────────────────────────┐
                    │           SRAM Controller           │
                    │                                     │
    clk    ────────→│ Clock Domain                        │
    rst    ────────→│ Reset Logic                         │
                    │                                     │
    addr   ────────→│ Address                             │
           [N:0]    │ Decoder     ┌─────────────────────┐ │
                    │            │                     │ │
    data_in────────→│ Write      │   Memory Array     │ │←── data_out
           [W:0]    │ Buffer     │   [DEPTH-1:0]      │ │    [W:0]
                    │            │   [WIDTH-1:0]      │ │
    we     ────────→│ Write      │                     │ │
    re     ────────→│ Enable     └─────────────────────┘ │
    cs     ────────→│ Logic                               │
                    │                                     │
                    └─────────────────────────────────────┘

Where:
- N = Address Width (log2(DEPTH))
- W = Data Width 
- DEPTH = Memory Depth (number of words)
```

---

## 🔌 Pin Configuration & Interface

### Input Ports
| Signal | Width | Direction | Description |
|--------|--------|-----------|-------------|
| `clk` | 1-bit | Input | System clock (positive edge triggered) |
| `rst` | 1-bit | Input | Asynchronous reset (active high) |
| `cs` | 1-bit | Input | Chip Select (active high) |
| `we` | 1-bit | Input | Write Enable (active high) |
| `re` | 1-bit | Input | Read Enable (active high) |
| `addr` | ADDR_WIDTH | Input | Memory address bus |
| `data_in` | DATA_WIDTH | Input | Data input bus for write operations |

### Output Ports
| Signal | Width | Direction | Description |
|--------|--------|-----------|-------------|
| `data_out` | DATA_WIDTH | Output | Data output bus for read operations |
| `ready` | 1-bit | Output | Memory operation ready flag |

### Parameters
| Parameter | Default | Range | Description |
|-----------|---------|--------|-------------|
| `DATA_WIDTH` | 8 | 8/16/32 | Width of data bus in bits |
| `ADDR_WIDTH` | 8 | 4-16 | Width of address bus in bits |
| `DEPTH` | 256 | 16-65536 | Memory depth (2^ADDR_WIDTH) |

---

## ⚡ Circuit Operation & Timing

### Memory Access Cycles

#### 1. Write Operation Timing
```
Clock Cycle: ___╱‾╲_╱‾╲_╱‾╲_╱‾╲_╱‾╲_
cs:          ______╱‾‾‾‾‾‾‾‾‾‾‾‾╲____
we:          ______╱‾‾‾‾‾‾‾‾‾‾‾‾╲____
addr:        ======<ADDR_VALID>======
data_in:     ======<DATA_VALID>======
ready:       ‾‾‾‾‾‾╲______________╱‾‾‾
             T0    T1    T2    T3    T4
```

#### 2. Read Operation Timing
```
Clock Cycle: ___╱‾╲_╱‾╲_╱‾╲_╱‾╲_╱‾╲_
cs:          ______╱‾‾‾‾‾‾‾‾‾‾‾‾╲____
re:          ______╱‾‾‾‾‾‾‾‾‾‾‾‾╲____
addr:        ======<ADDR_VALID>======
data_out:    ========<DATA_OUT>=====
ready:       ‾‾‾‾‾‾╲______________╱‾‾‾
             T0    T1    T2    T3    T4
```

### Timing Specifications
- **Setup Time (tsu)**: 2ns (address/data before clock edge)
- **Hold Time (th)**: 1ns (address/data after clock edge)
- **Clock-to-Output (tco)**: 3ns (clock edge to valid data output)
- **Write Pulse Width**: Minimum 1 clock cycle
- **Read Access Time**: 1 clock cycle

---

## 🔧 Detailed Design Explanation

### 1. Memory Array Implementation

```verilog
// Memory array declaration
reg [DATA_WIDTH-1:0] memory_array [0:DEPTH-1];

// Memory initialization (optional)
initial begin
    integer i;
    for (i = 0; i < DEPTH; i = i + 1) begin
        memory_array[i] = {DATA_WIDTH{1'b0}};
    end
end
```

### 2. Address Decoding Logic

The address decoder ensures that only valid memory locations are accessed

```verilog
// Address validation
wire valid_address = (addr < DEPTH);
wire mem_enable = cs & valid_address;
```

### 3. Write Operation State Machine

```
Write FSM States:
┌─────────┐    cs & we    ┌─────────┐    !cs     ┌─────────┐
│  IDLE   │───────────────→│ WRITE   │───────────→│  IDLE   │
│ (ready) │               │(writing)│            │ (ready) │
└─────────┘               └─────────┘            └─────────┘
     ↑                         │
     └─────────────────────────┘
           write complete
```

### 4. Read Operation State Machine

```
Read FSM States:
┌─────────┐    cs & re    ┌─────────┐    !cs     ┌─────────┐
│  IDLE   │───────────────→│  READ   │───────────→│  IDLE   │
│ (ready) │               │(reading)│            │ (ready) │
└─────────┘               └─────────┘            └─────────┘
     ↑                         │
     └─────────────────────────┘
           read complete
```

### 5. Control Logic Implementation

```verilog
always @(posedge clk or posedge rst) begin
    if (rst) begin
        data_out <= {DATA_WIDTH{1'b0}};
        ready <= 1'b1;
    end else begin
        if (mem_enable) begin
            if (we && !re) begin
                // Write operation
                memory_array[addr] <= data_in;
                ready <= 1'b0;
            end else if (re && !we) begin
                // Read operation
                data_out <= memory_array[addr];
                ready <= 1'b0;
            end
        end else begin
            ready <= 1'b1;
        end
    end
end
```

---

## 📱 Applications & Use Cases

### 1. **Microprocessor Cache Memory**
- **L1/L2 Cache Implementation**: High-speed data storage
- **Instruction Cache**: Fast program instruction access
- **Data Cache**: Temporary data storage for CPU operations

### 2. **Embedded System Buffer Memory**
- **FIFO Buffers**: Data streaming applications
- **Circular Buffers**: Audio/video processing
- **Scratch Pad Memory**: Temporary data storage

### 3. **Digital Signal Processing (DSP)**
- **Sample Storage**: Audio/video sample buffering
- **Coefficient Storage**: Filter coefficient memory
- **Intermediate Results**: Computation buffer memory

### 4. **Communication Systems**
- **Packet Buffers**: Network data storage
- **Protocol Stack Memory**: Communication layer buffers
- **Error Correction**: Temporary code storage

### 5. **Graphics Processing**
- **Frame Buffers**: Image/video frame storage
- **Texture Memory**: 3D graphics texture data
- **Vertex Buffers**: 3D model vertex data

### 6. **FPGA Applications**
- **Block RAM (BRAM)**: On-chip memory implementation
- **Distributed RAM**: LUT-based memory
- **Multi-port Memory**: Concurrent access systems

---

