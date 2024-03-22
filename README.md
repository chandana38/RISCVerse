Aim:
The aim of this project is to design and implement a pipelined RISC-V 32-bit core with the Integer Base Instruction Set (RV32I).

Introduction:
The RISC-V architecture is an open-standard instruction set architecture (ISA) adhering to established reduced instruction set computer (RISC) principles. This project specifically targets the 32-bit variant, RV32I. The "I" standard extension incorporates the integer instruction set, encompassing integer computational instructions, load/store instructions, and control flow instructions. The processor pipeline employs a five-stage design, consisting of fetch, decode, execute, memory access, and writeback stages.

Methodology & Implementation:
The initial phase of the project involved designing hardware capable of executing the integer instructions outlined in the RV32I Base Integer Instruction Set. The design of a dedicated datapath for each instruction within the RV32I set was undertaken. This involved identifying the functional units required for each instruction and connecting them together. The individual datapaths were then combined to form the complete datapath. Additionally, a 5-stage pipelined architecture was adopted to enhance efficiency and throughput.

Datapath Block Diagram of a simple 5-stage pipelined RISC processor
![image](https://github.com/chandana38/RISCVerse/assets/156425665/c20784db-3261-4af6-b87e-e4ba2a0c04bc)

Results:


Conclusion:


References: 


Mentors:
Rehan Nasar,
Sanganabasu Herur (211EC245),
L Chandana (211EE235)

Mentees:
Chinmayee Nagaraj (221EC212),
Suchet Nayak (221EE254)


© 2024 RISC-V Core Implementation Team. All rights reserved.
