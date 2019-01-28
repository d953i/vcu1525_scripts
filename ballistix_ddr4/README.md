# BCU1525 DDR4 memory Vivado support files

- Vivado "custom part" file for Ballistix Sport LT 2400MT/s 4GB and 8GB UDIMMs
- Vivado constraints files for VCU1525 anbd BCU1525 DDR4 interfaces
- Vivado TCL script to create test project for VCU1525 board using DIMM0 (DDR4 C0)

# TCL script usage

<b>Warning!</b> VCU1525 and BCU1525 DDR4 pinout different! Use appropriate constraints file!<br><br>

Copy all files in one directory and in Vivado TCL console source script from it. For example:<br>
cd D:/Projects/Hardware-Xilinx-HDL/ballistix_ddr4/<br>
source ./vcu1525_ballistix_project.tcl<br>

# Block Diagram
![Vivado_Block_Diagram](vcu1525_ballistix_project.png?raw=true "Vivado Block Diagram")

# DDR4 Controller IP settings

![Vivado_DDR4_Settings](vcu1525_ballistix_settings.png?raw=true "Vivado DDR4 Settings")

# Address Map

![Vivado_Address_Map](vcu1525_ballistix_address.png?raw=true "Vivado Address Map")

# Implemented design

![Vivado_Implementation](vcu1525_ballistix_implementation.png?raw=true "Vivado Implementation")

# Memory Calibration in HW Manager

![Vivado_HWManager](vcu1525_ballistix_calibration.png?raw=true "Vivado Manager")
