# Digital Voting Machine - SystemVerilog Implementation

## 📋 Project Overview

This project implements a **Digital Voting Machine** using SystemVerilog, designed as a finite state machine (FSM) to handle electronic voting processes. The system provides secure, reliable, and efficient vote counting for three candidates with built-in debouncing and state management.

**Author:** Pranesh S  
**Institution:** VIT University, Vellore  
**Language:** SystemVerilog  
**Design Type:** Finite State Machine (FSM)

## 🏗️ System Architecture

### State Machine Design

The voting machine operates on a **4-state finite state machine**:

```
IDLE (00) → VOTE (01) → HOLD (10) → FINISH (11)
    ↑                      ↓           ↓
    └──────────────────────┴───────────┘
```

#### State Descriptions:

1. **IDLE State (2'b00)**: System initialization and reset state
2. **VOTE State (2'b01)**: Active voting mode where votes are registered
3. **HOLD State (2'b10)**: Debouncing state to prevent multiple vote registration
4. **FINISH State (2'b11)**: Vote counting complete, results displayed

### Key Features

- ✅ **Three Candidate Support**: Independent vote counting for 3 candidates
- ✅ **Edge Detection**: Falling edge detection prevents button bounce issues
- ✅ **Debouncing Mechanism**: Hold state with 4-bit counter (16 clock cycles)
- ✅ **Reset Functionality**: Asynchronous reset capability
- ✅ **32-bit Vote Counters**: Support for large vote counts
- ✅ **Real-time Vote Monitoring**: Live vote count updates

## 🔌 Pin Configuration

### Input Ports
| Signal | Width | Description |
|--------|--------|-------------|
| `clk` | 1-bit | System clock input |
| `rst` | 1-bit | Asynchronous reset (active high) |
| `i_candidate_1` | 1-bit | Vote button for Candidate 1 |
| `i_candidate_2` | 1-bit | Vote button for Candidate 2 |
| `i_candidate_3` | 1-bit | Vote button for Candidate 3 |
| `i_voting_over` | 1-bit | Signal to end voting session |

### Output Ports
| Signal | Width | Description |
|--------|--------|-------------|
| `o_count1` | 32-bit | Total votes for Candidate 1 |
| `o_count2` | 32-bit | Total votes for Candidate 2 |
| `o_count3` | 32-bit | Total votes for Candidate 3 |

## ⚡ Circuit Operation

### Voting Process Flow

1. **System Initialization**
   - Apply reset signal to clear all counters
   - System enters IDLE state

2. **Vote Registration**
   - Press candidate button (rising edge)
   - Release button (falling edge triggers vote count)
   - System transitions to HOLD state for debouncing

3. **Debouncing Period**
   - 16 clock cycle hold period prevents multiple registrations
   - Automatic return to VOTE state

4. **Vote Completion**
   - Set `i_voting_over` signal high
   - System transitions to FINISH state
   - Final vote counts displayed on outputs

### Timing Characteristics

- **Clock Period**: User-defined (typically 10ns in testbench)
- **Hold Duration**: 16 clock cycles
- **Reset Recovery**: 1 clock cycle
- **Vote Registration**: Edge-triggered (falling edge)

## 🛠️ File Structure

```
voting_machine/
├── design.sv              # Main voting machine module
├── testbench.sv          # Comprehensive testbench
├── voting_dumpfile.vcd   # Waveform output file
├── run.sh                # Simulation script
├── library.cfg           # Library configuration
├── dataset.asdb          # Dataset file
├── work/                 # Compilation directory
└── README.md             # This documentation
```

## 🔬 Simulation and Testing

### Testbench Features

The included testbench (`testbench.sv`) provides:

- **Comprehensive Test Scenarios**: Multiple voting sequences
- **Reset Testing**: Proper reset functionality verification
- **Edge Case Handling**: Simultaneous button presses
- **Waveform Generation**: VCD file output for analysis
- **Real-time Monitoring**: Vote count tracking

### Running Simulation

```bash
# Make script executable (if needed)
chmod +x run.sh

# Run simulation
./run.sh
```

### Expected Test Results

Sample voting sequence from testbench:
- Candidate 1: 3 votes
- Candidate 2: 3 votes  
- Candidate 3: 2 votes

## 📱 Applications

### Primary Applications

1. **Electronic Voting Systems**
   - Municipal elections
   - Corporate board voting
   - Student council elections

2. **Poll and Survey Systems**
   - Opinion polling
   - Market research
   - Feedback collection

3. **Educational Purposes**
   - Digital logic learning
   - FSM design concepts
   - FPGA implementation projects

### Scalability Options

- **Multi-Candidate Support**: Easily expandable to more candidates
- **Network Integration**: Can be interfaced with communication modules
- **Display Integration**: Compatible with 7-segment or LCD displays
- **Security Enhancements**: Can integrate encryption modules

## 🔧 Implementation Guidelines

### FPGA Implementation

1. **Target Devices**: Compatible with Xilinx, Intel, and other FPGA families
2. **Resource Usage**: Minimal LUT and FF requirements
3. **Clock Constraints**: Typical operation up to 100MHz+

### Synthesis Considerations

- All registers are properly initialized
- No combinational loops present
- Synchronous design throughout
- Reset strategy implemented correctly

## 🚀 Future Enhancements

### Potential Improvements

- [ ] **Voter Authentication**: ID verification system
- [ ] **Encrypted Storage**: Secure vote storage mechanism
- [ ] **Audit Trail**: Comprehensive logging system
- [ ] **Multiple Sessions**: Support for different voting sessions
- [ ] **Network Capability**: Remote voting infrastructure
- [ ] **Battery Backup**: Power failure protection

### Advanced Features

- [ ] **Biometric Integration**: Fingerprint/facial recognition
- [ ] **Blockchain Integration**: Immutable vote recording
- [ ] **Real-time Analytics**: Live result visualization
- [ ] **Multi-language Support**: Internationalization

## 📚 Technical Specifications

### Design Parameters
- **Technology**: Digital CMOS
- **Logic Family**: Synchronous
- **Design Style**: RTL (Register Transfer Level)
- **Verification**: Functional and timing verified

### Performance Metrics
- **Maximum Votes**: 2³² per candidate (4.3 billion)
- **Voting Speed**: 1 vote per 16+ clock cycles
- **Power Consumption**: Depends on implementation technology
- **Area**: Minimal resource utilization

