[Main readme](../readme.MD) | [Part one](../part_1) | [Part two](../part_2) | [Part three](../part_3) | [Part four](../part_4)

# Objective of Lab

* Revision of Quartus.
* To learn why Verilog HDL is superior to schematic capture.

# Experiment 1 - Complete the schematic design of a hex to 7 segment decoder

* First programmed FPGA with provided solution - needed to delete the redundant processor entry in the programming chain.
* Implemented out[4] of 7seg_decoder using schematic, leaving optimisation of truth table to Quartus.
* Assigned pins in pin planner manually after running Analysis and Elaboration.
* Compiled project and programmed FPGA with our .sof file, tested the output.

### FPGA Resource Usage
![Resources](./ex_1/resources.png)

### TimeQuest Timing Analyzer Report
Delay difference: 85C is around 0.5ns slower than 0C, this is because at higher temperatures resistance in the circuit increases, slowing down current flow. See [spreadsheet](./ex_1/datasheet_diff.csv)

### Demonstration Video
https://www.youtube.com/watch?v=798pyNVvAus

# Experiment 2 - Create hex to 7-segment decoder using Hardware Design Language (HDL) Verilog.
* [hex_to_7seg.v](./ex_2/hex_to_7seg.v).
* Use `always` block to trigger whenever the input changes `always @ (*)`.
* Use `case(input)` to choose the output depending on the value of the input.
* Note that display is active low.
* Create a [ex2_top.v](./ex_2/ex2_top.v) as Top-Level entity to connect up all the inputs and outputs.
* Copy the pin assignments file into .qsf (Quartus Settings File) - much quicker than manually assigning pins.

# Experiment 3 - display 10-bit binary switch input on the 7-segment displays
* Changed top level Verilog file [ex3_top.v](./ex_3/ex3_top.v) to use three of the hex_to_7seg modules created earlier.
* Used all of the switches as input.
* Compiled and tested.

### Demonstration Video
https://youtu.be/7ECb1tDg4Ck

# Experiment 4 - display 10-bit binary switch input as BCD on the 7-segment displays

* [bin2bcd_10.v](./ex_4/bin2bcd_10.v) implemented from the derived block diagram similar to that shown below from problem sheet 1, where each "An" block performs the "shift and add 3" algorithm.
* Extended top-level design file from previous experiment to create [ex4_top.v](./ex_4/ex4_top.v), compiled all and worked as anticipated.
* Compiling using 16-bit version uses exactly the same resources as compiling using the 10-bit verison of the bin2bcd converter! This is due to optimisation applied by Quartus in eliminating the logic within the block that is unused due to not being connected.

### Demonstration Video
https://youtu.be/DG-BM4EkwcE

### 10-bit BCD Block Diagram
![block](./ex_4/bin2bcd10.png)

### Compiled using 10-bit BCD
![10_bit](./ex_4/10bit.PNG)

### Compiled using 16-bit BCD
![16_bit](./ex_4/16bit.PNG)


