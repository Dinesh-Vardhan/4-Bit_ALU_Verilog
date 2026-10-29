# 4-Bit ALU Design and Functional Verification Using Verilog

## Overview

This project implements a 4-bit Arithmetic Logic Unit (ALU) using Verilog HDL. The design supports 11 arithmetic, logical, comparison, shift, and data-transfer operations, along with four status flags.

The ALU was functionally verified using a dedicated Verilog testbench in Xilinx Vivado. Exhaustive simulation covered all combinations of 4-bit input operands for every supported operation.

## Features

- 4-bit input operands (`A` and `B`)
- 4-bit operation selector (`sel`)
- 11 supported ALU operations
- Four status flags: carry, zero, negative, and overflow
- Combinational RTL design
- Exhaustive functional verification across operand combinations
- Verification of arithmetic and non-arithmetic status flags
- Testing of an unsupported operation selector

## Supported Operations

| Operation | Selector | Description |
|---|---|---|
| ADD | `0000` | Addition: `A + B` |
| SUB | `0001` | Subtraction: `A - B` |
| AND | `0010` | Bitwise AND |
| OR | `0011` | Bitwise OR |
| XOR | `0100` | Bitwise XOR |
| SLT | `0101` | Signed less-than comparison |
| SLTU | `0110` | Unsigned less-than comparison |
| NOT_A | `0111` | Bitwise complement of `A` |
| SLL | `1000` | Logical left shift of `A` by one bit |
| SRL | `1001` | Logical right shift of `A` by one bit |
| PASS_A | `1010` | Pass `A` to the output |

Unsupported selector values produce a zero result with the default status flags defined in the RTL.

## Status Flags

The ALU generates four status flags:

- **Carry (`carry`):** For addition, indicates the unsigned carry-out. For subtraction, `1` indicates that no unsigned borrow occurred.
- **Zero (`zero`):** Set to `1` when the 4-bit result is `0000`.
- **Negative (`negative`):** Reflects the most significant bit of the result (`Result[3]`).
- **Overflow (`overflow`):** Indicates signed arithmetic overflow for addition and subtraction. It is set to `0` for non-arithmetic operations.

The signed interpretation of a 4-bit value uses two's-complement representation, with a range from -8 to +7.

## Functional Verification

A dedicated testbench (`tb_alu_4bit.v`) verifies the ALU's outputs and status flags.

### Result Verification

- Tests all 16 × 16 operand combinations for each of the 11 supported operations.
- Checks the result for an unsupported selector.
- Uses case inequality (`!==`) to detect mismatches, including unknown values.

### Status Flag Verification

- Checks all four status flags for every combination of operands during addition and subtraction.
- Verifies flag behavior for all nine non-arithmetic operations.
- Checks the expected status flags for an unsupported selector.

### Simulation Results

| Verification category | Passed | Failed |
|---|---:|---:|
| Result checks | 2,817 | 0 |
| Status flag checks | 2,817 | 0 |

**Simulation outcome:** All recorded result and status flag checks passed with zero failures.

## Simulation Waveforms

The following waveforms illustrate representative ALU behavior during simulation.

### ALU Operations

![ALU operations waveform](waveforms/alu_operations.png)

### Arithmetic Operations and Status Flags

![Arithmetic flags waveform](waveforms/arithmetic_flags.png)

The first waveform shows general ALU activity across multiple operations. The second highlights arithmetic operations and status flag behavior, including signed overflow.

## Tools Used

- Verilog HDL
- Xilinx Vivado
- Vivado behavioral simulation
- Vivado synthesis and implementation

## Repository Structure

```text
4-Bit_ALU_Verilog/
├── src/
│   └── alu_4bit.v
├── testbench/
│   └── tb_alu_4bit.v
├── waveforms/
│   ├── alu_operations.png
│   └── arithmetic_flags.png
└── README.md
```

## Learning Outcomes

- Combinational RTL design using Verilog HDL
- Implementation of arithmetic and logical operations
- Understanding signed and unsigned comparisons
- Status flag generation and verification
- Exhaustive functional testing using a Verilog testbench
- Simulation, synthesis, and implementation workflows in Vivado

## Future Improvements

- Integrate the ALU into a wider processor datapath.
- Extend the design to support wider operands and additional operations.
- Explore timing optimization under clearly defined system constraints.
- Develop a more advanced verification environment using SystemVerilog.

## Conclusion

This project demonstrates the design and functional verification of a multi-operation 4-bit ALU using Verilog HDL. It establishes a foundation for further work in RTL design, digital logic, and processor datapath development.
