# FPGA-Based Digital Filter System

Configurable digital filter system implemented in Verilog HDL for FPGA-based signal processing.

## Overview

This project implements a modular digital filtering system using Verilog HDL. It uses a top-level module to select between different filter outputs through a 4-bit filter selection signal.

The design supports multiple filtering techniques for processing digital input samples and includes a testbench for simulation.

## Features

- Modular Verilog HDL architecture
- Parameterized data width
- Selectable digital filters using a 4-bit control signal
- Clock, reset, and enable support
- Testbench for functional simulation
- Binary input samples for testing
- Designed for FPGA-based signal processing

## Implemented Filters

1. FIR Filter
2. IIR Filter
3. Median Filter
4. Moving Average Filter
5. High-Pass Filter
6. Low-Pass Filter
7. Band-Pass Filter
8. Notch Filter
9. Exponential Moving Average Filter

## Technologies Used


- Verilog HDL
- Xilinx Vivado
- FPGA Design
- Digital Signal Processing

## Project Structure

```text
fpga-digital-filter-system/
├── README.md
├── src/
│   ├── all_filters.v
│   ├── fir_filter.v
│   ├── iir_filter.v
│   ├── median_filter.v
│   ├── moving_average.v
│   ├── high_pass_filter.v
│   ├── low_pass_filter.v
│   ├── band_pass_filter.v
│   ├── notch_filter.v
│   └── exp_moving_avg_filter.v
├── testbench/
│   └── tb_all_filters.v
├── data/
│   └── Input_data.mem
├── constraints/
│   └── basys3.xdc
└── results/
    ├── filter_comparison.txt
    └── output.mem
```

## Filter Selection
The filter_select input determines which filter output is connected to output_data.

Filter Select	Filter
0000	FIR Filter
0001	IIR Filter
0010	Median Filter
0011	Moving Average Filter
0100	High-Pass Filter
0101	Low-Pass Filter
0110	Band-Pass Filter
0111	Notch Filter
1000	Exponential Moving Average Filter

## Simulation
The project includes a Verilog testbench named tb_all_filters.v to apply input samples and capture filter outputs.
Steps to Run
1. Open Xilinx Vivado.
2. Create a new RTL project.
3. Add the Verilog source files to the project.
4. Add tb_all_filters.v as the simulation testbench.
5. Place Input_data.mem in the simulation working directory or configure its correct path.
6. Run behavioral simulation.
7. Inspect the output waveforms and generated result files.
   
## Verification Status
The source code and testbench require compilation, debugging, and functional verification. Simulation results and FPGA implementation details should be documented after successful testing.

## Future Improvements
- Verify and debug individual filter modules.
- Improve the testbench to validate each filter independently.
- Compare filter outputs against reference calculations.
- Correct signed arithmetic and fixed-point coefficient handling where required.
- Perform FPGA synthesis and timing analysis.
- Document FPGA resource utilization and hardware testing results.
  
## Author
Nidhi Gupta
