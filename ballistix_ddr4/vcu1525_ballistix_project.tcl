
create_project vcu1525_ballistix ./vcu1525_ballistix -part xcvu9p-fsgd2104-2L-e

set_property board_part xilinx.com:vcu1525:part0:1.2 [current_project]

create_bd_design "design_1"

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4:2.2 ddr4_0
set_property -dict [list CONFIG.C0_CLOCK_BOARD_INTERFACE {default_300mhz_clk0}] [get_bd_cells ddr4_0]
set_property -dict [list CONFIG.C0.DDR4_TimePeriod {833}] [get_bd_cells ddr4_0]
set_property -dict [list CONFIG.C0.DDR4_InputClockPeriod {3332}] [get_bd_cells ddr4_0]
set_property -dict [list CONFIG.C0.DDR4_isCustom {true}] [get_bd_cells ddr4_0]
set_property -dict [list CONFIG.C0.DDR4_MemoryType {UDIMMs} CONFIG.C0.DDR4_MemoryPart {BLS4G4D240FSB} CONFIG.C0.DDR4_DataWidth {64} CONFIG.C0.DDR4_CasLatency {16} CONFIG.C0.DDR4_CasWriteLatency {16} CONFIG.C0.DDR4_AxiDataWidth {512} CONFIG.C0.DDR4_AxiAddressWidth {32} CONFIG.C0.DDR4_CustomParts {./crutial_ballistix_sport_lt_4gb.csv}] [get_bd_cells ddr4_0]
set_property -dict [list CONFIG.C0.DDR4_CLKOUT0_DIVIDE {5}] [get_bd_cells ddr4_0]
set_property -dict [list CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {100}] [get_bd_cells ddr4_0]
make_bd_intf_pins_external  [get_bd_intf_pins ddr4_0/C0_DDR4]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Board_Interface {default_300mhz_clk0 ( 300 MHz System differential clock0 ) } Manual_Source {Auto}}  [get_bd_intf_pins ddr4_0/C0_SYS_CLK]
endgroup

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:xdma:4.1 xdma_0
apply_board_connection -board_interface "pci_express_x1" -ip_intf "xdma_0/pcie_mgt" -diagram "design_1" 
apply_board_connection -board_interface "pcie_perstn" -ip_intf "xdma_0/RST.sys_rst_n" -diagram "design_1"
apply_bd_automation -rule xilinx.com:bd_rule:xdma -config { accel {1} auto_level {IP Level} axi_clk {Maximum Data Width} axi_intf {AXI Memory Mapped} bar_size {1 (Megabytes)} bypass_size {Disable} c2h {1} cache_size {32k} h2c {1} lane_width {X1} link_speed {8.0 GT/s (PCIe Gen 3)}}  [get_bd_cells xdma_0]
set_property -dict [list CONFIG.mode_selection {Basic} CONFIG.axilite_master_size {4} CONFIG.axilite_master_scale {Gigabytes} CONFIG.pciebar2axibar_axil_master {0} CONFIG.pf0_msix_cap_table_bir {BAR_2} CONFIG.pf0_msix_cap_pba_bir {BAR_2} CONFIG.axil_master_64bit_en {true}] [get_bd_cells xdma_0]
endgroup

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0
set_property -dict [list CONFIG.C_SIZE {1} CONFIG.C_OPERATION {not} CONFIG.LOGO_FILE {data/sym_notgate.png}] [get_bd_cells util_vector_logic_0]
connect_bd_net [get_bd_pins util_vector_logic_0/Res] [get_bd_pins ddr4_0/sys_rst]
connect_bd_net [get_bd_ports pcie_perstn] [get_bd_pins util_vector_logic_0/Op1]
endgroup

startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/xdma_0/axi_aclk (125 MHz)} Clk_slave {/ddr4_0/c0_ddr4_ui_clk (300 MHz)} Clk_xbar {Auto} Master {/xdma_0/M_AXI} Slave {/ddr4_0/C0_DDR4_S_AXI} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins ddr4_0/C0_DDR4_S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/xdma_0/axi_aclk (125 MHz)} Clk_slave {/ddr4_0/c0_ddr4_ui_clk (300 MHz)} Clk_xbar {/ddr4_0/c0_ddr4_ui_clk (300 MHz)} Master {/xdma_0/M_AXI_LITE} Slave {/ddr4_0/C0_DDR4_S_AXI} intc_ip {/axi_mem_intercon} master_apm {0}}  [get_bd_intf_pins xdma_0/M_AXI_LITE]
endgroup

add_files -fileset constrs_1 -norecurse ./vcu1525_ballistix_ddr4_c0.xdc
import_files -fileset constrs_1 ./vcu1525_ballistix_ddr4_c0.xdc

make_wrapper -files [get_files ./vcu1525_ballistix/vcu1525_ballistix.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse ./vcu1525_ballistix/vcu1525_ballistix.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v
