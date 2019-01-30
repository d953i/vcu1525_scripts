# Crutial Ballistix Sport LT Vivado support files

- Vivado "custom part" file for Ballistix Sport LT 2400MT/s 4GB and 8GB UDIMMs
- Vivado constraints files for VCU1525 anbd BCU1525 DDR4 interface
- Single channel(DIMM C0) example project TCL script for BCU1525
- Quad channel example project TCL script for BCU1525

# TCL script usage

<b>Warning!</b> VCU1525 and BCU1525 DDR4 pinout different! Use appropriate constraints file!<br><br>

Copy all files in one directory and in Vivado TCL console source script from it. For example:<br>
cd ~/Projects/ballistix_ddr4/<br>
source ./dd4_quad_channel.tcl<br>

# Block Diagram

![Vivado_Block_Diagram](images/vcu1525_ballistix_project.png?raw=true "Vivado Block Diagram")

# DDR4 Controller IP settings

![Vivado_DDR4_Settings](images/vcu1525_ballistix_settings.png?raw=true "Vivado DDR4 Settings")

# Address Map

![Vivado_Address_Map](images/vcu1525_ballistix_address.png?raw=true "Vivado Address Map")

# Implemented design

![Vivado_Implementation](images/vcu1525_ballistix_implementation.png?raw=true "Vivado Implementation")

# Memory Calibration in HW Manager

![Vivado_HWManager](images/vcu1525_ballistix_calibration.png?raw=true "Vivado Manager")

# Related links

UltraScale/UltraScale+ DDR4 IP - Interface Calibration and Hardware Debug Guide:<br>
https://www.xilinx.com/support/answers/68937.html

UltraScale/UltraScale+ DDR4 IP - User addition of pblock might cause skew violations between RIU_CLK and PLL_CLK pins of BITSLICE_CONTROL:<br>
https://www.xilinx.com/support/answers/68976.html
