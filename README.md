# 2-to-4 and 3-to-8 Decoders (Verilog, Vivado, Basys 3)

This project implements **2-to-4** and **3-to-8** binary decoders in Verilog and
verifies their behavior using simulation and FPGA hardware (Basys-class board).
It is based on a digital systems lab focused on combinational MSI devices.

A decoder acts as a **minterm detector**: for a given binary input code, exactly
one output line is asserted while all others remain inactive.

---

## Project Goals

- Design synthesizable Verilog modules for:
  - A 2-to-4 decoder with enable
  - A 3-to-8 decoder with enable
- Show how larger decoders can be **built from smaller ones**.
- Verify functionality with testbenches that sweep all input combinations.
- Map the design to an FPGA and observe outputs on LEDs using on-board switches
  as inputs.

---

## Design Overview

### 2-to-4 Decoder (`decoder2to4.v`)

- Inputs:
  - `en`  – active-high enable
  - `in[1:0]` – 2-bit binary input
- Outputs:
  - `out[3:0]` – one-hot outputs

Behavior:

- When `en = 1`, `out[k] = 1` for exactly one `k` determined by `in`.
- When `en = 0`, all outputs are forced low.

This module is used both standalone and as a building block for the 3-to-8 decoder.

### 3-to-8 Decoder (`decoder3to8.v`)

- Inputs:
  - `en`  – active-high enable
  - `in[2:0]` – 3-bit binary input
- Outputs:
  - `out[7:0]` – one-hot outputs

Implementation approach:

- The 3-to-8 decoder is constructed **from two 2-to-4 decoders** and an inverter,
  following the classic hierarchical design technique.
- The MSB of `in` selects which 2-to-4 instance is enabled, while the lower bits
  drive both decoders.

This demonstrates how MSI devices can be composed to build wider decoders.

---

## Simulation

Two simple testbenches are provided:

- `tb_decoder2to4.v`  
  - Toggles `en` and sweeps all 2-bit input combinations.
  - Allows inspection of the one-hot output pattern for each input.

- `tb_decoder3to8.v`  
  - Sweeps all 3-bit input combinations with `en = 1`.
  - Verifies that exactly one of the 8 outputs is asserted for each input code.

Both can be run as behavioral simulations in Vivado (or another Verilog simulator).

---

## FPGA Implementation (Basys 3 Example)

In an example top-level design (not included), the decoders can be connected to
board I/O as follows:

- Map input bits to switches:
  - `in[2:0]` → `SW0..SW2`
  - `en`      → `SW3` or a pushbutton
- Map decoder outputs to LEDs:
  - `out[3:0]` or `out[7:0]` → LED bank

After synthesis, implementation, and bitstream generation, flipping the switches
selects which single LED is lit, matching the simulated one-hot behavior.

---

## Concepts Highlighted

- MSI combinational logic design (decoders as minterm detectors).
- Building larger decoders from smaller ones using enable lines.
- Practical FPGA workflow in Vivado:
  - RTL design → Synthesis → Implementation → Bitstream → Hardware.
- Using **testbenches** to exhaustively verify small digital blocks.

---

## Skills Demonstrated

- Verilog RTL for combinational MSI devices.
- Hierarchical design (reusing a 2-to-4 decoder to build a 3-to-8 decoder).
- Vivado project setup, synthesis, implementation, and behavioral simulation.
- FPGA bring-up on Basys-class hardware using switches and LEDs.
