# UART

The project objective was to write Verilog modules for simple UART transmitter and receiver.

* Transmitter and Receiver were required to work in parallel.
* The program would be able to work in full duplex.
* Alongside with data-byte, the transmitter should send corresponding START_BIT, PARITY_BIT, STOP_BIT.

Repository Guide

* contstraints_cyclone v gx starter kit/ - contains constraint file for cyclone v gx starter kit
* doc/ - contains documantation for the designed UART
* rtl/ - contains design files for UART
* testbenches/ - contains testbenches
