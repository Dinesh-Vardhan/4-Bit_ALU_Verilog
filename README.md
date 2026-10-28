# 4-Bit ALU Design and Functional Verification Using Verilog

## Overview

This project implements a 4-bit Arithmetic Logic Unit (ALU) using Verilog HDL and verifies its functionality through a dedicated testbench in Xilinx Vivado 2019.1.

The ALU supports 11 operations, including arithmetic, logical, comparison, shift, and data-transfer operations. It also generates status flags to indicate carry, zero, negative, and signed arithmetic overflow conditions.

## Features

- 4-bit input operands (`A` and `B`)
- 4-bit operation selector (`sel`)
- 11 supported ALU operations
- Carry, zero, negative, and overflow status flags
- Combinational RTL design
- Exhaustive functional testing across operand combinations
- Verification of valid and invalid operation selectors

## Supported Operations

| Operation | Selector | Function |
|---|---|---|
| ADD | `0000` | A + B |
| SUB | `0001` | A − B |
| AND | `0010` | Bitwise AND |
| OR | `0011` | Bitwise OR |
| XOR | `0100` | Bitwise XOR |
| SLT | `0101` | Signed less-than comparison |
| SLTU | `0110` | Unsigned less-than comparison |
| NOT_A | `0111` | Bitwise complement of A |
| SLL | `1000` | Logical left shift of A by one bit |
| SRL | `1001` | Logical right shift of A by one bit |
| PASS_A | `1010` | Pass A to the output |

Unsupported selectors produce a zero result with the default flag behavior defined in the RTL.

## Status Flags

| Flag | Description |
|---|---|
| Carry (`carry`) | Indicates carry-out for addition; for subtraction, 1 indicates no unsigned borrow |
| Zero (`zero`) | Set when the ALU result is zero |
| Negative (`negative`) | Reflects the most significant bit of the result |
| Overflow (`overflow`) | Indicates signed arithmetic overflow for addition and subtraction |

The zero and negative flags are derived from the final result. Overflow is set to zero for non-arithmetic operations.

## Functional Verification

A dedicated Verilog testbench checks the ALU's operations across all 16 × 16 combinations of the input operands for each supported operation.

The testbench also verifies status-flag behavior for arithmetic operations, non-arithmetic operations, and an invalid operation selector.

### Verification Summary

| Verification category | Passed | Failed |
|---|---:|---:|
| Result checks | 2,817 | 0 |
| Flag checks | 2,817 | 0 |

All implemented test cases passed in simulation.

## Tools Used

- Verilog HDL
- Xilinx Vivado 2019.1
- Vivado behavioral simulation
- Vivado synthesis and implementation

## Project Files

- `alu_4bit.v` — ALU RTL implementation
- `tb_alu_4bit.v` — Functional verification testbench
- `alu_4bit_timing.xdc` — Illustrative timing constraints used during timing analysis

## Learning Outcomes

- RTL design of combinational digital logic
- Arithmetic and logical operation implementation
- Signed versus unsigned comparison
- Arithmetic status-flag generation
- Exhaustive functional verification
- Simulation, synthesis, and implementation workflows in Vivado

## Future Improvements

- Integrate the ALU into a 16-bit RISC processor datapath
- Extend the ALU to support wider operands and additional operations
- Explore timing optimization under clearly defined design constraints
- Develop a more advanced verification environment using SystemVerilog

## Conclusion

This project demonstrates the design and functional verification of a multi-operation 4-bit ALU using Verilog HDL. It establishes a foundation for more advanced RTL design and processor datapath development.
