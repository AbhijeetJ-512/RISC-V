# 🚀 **RISC-V Processor Implementation**

## 📌**Overview**

This project implements a **pipelined RISC-V processor** using **SystemVerilog**. It follows the standard **five-stage pipeline** architecture:

1. **Fetch** – Fetches instructions from memory.
2. **Decode** – Decodes instructions and reads registers.
3. **Execute** – Performs ALU operations.
4. **Memory Access** – Handles memory read/write operations.
5. **Write Back** – Writes results back to registers.

The processor is designed to support **basic RISC-V instructions** and can be extended for more advanced features like hazard detection and forwarding.

---
