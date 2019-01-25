# BCU1525 DDR4 memory Vivado support files

- Vivado "custom part" file for Ballistix Sport LT 2400MT/s 4GB and 8GB UDIMMs
- Vivado constraints files for VCU/BCU DDR4 interfaces
- Vivado TCL script to create test project using Xilinx PCIe DMA IP

# TCL script usage

In Vivado TCL console source script from directory with all files:<br>
cd path_to_directory_with_files<br>
source ./vcu1525_ballistix_project.tcl<br>

# Block Diagram
![Vivado_Block_Diagram](vcu1525_ballistix_project.png?raw=true "Vivado Block Diagram")

# Address Map

![Vivado_Address_Map](vcu1525_ballistix_address.png?raw=true "Vivado Address Map")

# Implemented design

![Vivado_Implementation](vcu1525_ballistix_implementation.png?raw=true "Vivado Implementation")

# Memory Calibration in HW Manager

![Vivado_HWManager](vcu1525_ballistix_hwmanager.png?raw=true "Vivado Manager")
