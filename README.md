# Field-Programmable Gate Arrays (FPGAs)
_one non-computer scientist attempts to figure them out!_
_these demonstrations use the GadgetFactory Papilio Duo with LogicStart, GadgetFactory DesignLab, Xilinx ISE 14.7, all running on Ubuntu 16.04 x64 LTS_

### File Structure

**Constraints** contains the User Constraint File (.ucf) for each board.  The .ucf describes how the variables defined and used in the .vhd file are connected to the physical pins on the board.

**Switches_LEDs** folder containing an implementation of the first 'Hello World'–style VHDL programming example in the (Intro to Spartan FPGA eBook)[https://github.com/hamsternz/IntroToSpartanFPGABook] by Mike Field, hamster@snap.net.nz. It requires the Papilio Duo with LogicStart board.  When you have the sketch working, flipping the switches on the LogicStart board cause the corresponding LEDs to light up.  See how very basic .vhd and .ucf files are put together to create a working FPGA sketch!


