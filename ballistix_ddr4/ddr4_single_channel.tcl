
set ProjectFolder ./ddr4_single_channel

#Remove unnecessary files.
set file_list [glob -nocomplain webtalk*.*]
foreach name $file_list {
    file delete $name
}

#Delete old project if folder already exists.
if {[file exists .Xil]} { 
    file delete -force .Xil
}

#Delete old project if folder already exists.
if {[file exists "$ProjectFolder"]} { 
    file delete -force $ProjectFolder
}


create_project ddr4_single_channel ./ddr4_single_channel -part xcvu9p-fsgd2104-2L-e

create_bd_design "design_1"

import_files -norecurse ./crutial_ballistix_sport_lt_4gb.csv

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:xdma:4.1 xdma_0
endgroup

startgroup
make_bd_intf_pins_external  [get_bd_intf_pins xdma_0/pcie_mgt]
set_property name pci_express_x1 [get_bd_intf_ports pcie_mgt_0]
make_bd_pins_external  [get_bd_pins xdma_0/sys_rst_n]
set_property name pcie_perstn [get_bd_ports sys_rst_n_0]
endgroup

startgroup
set_property -dict [list CONFIG.mode_selection {Basic}] [get_bd_cells xdma_0]
set_property -dict [list CONFIG.xdma_pcie_64bit_en {true} CONFIG.pf0_msix_cap_table_bir {BAR_1:0} CONFIG.pf0_msix_cap_pba_bir {BAR_1:0}] [get_bd_cells xdma_0]
set_property -dict [list CONFIG.axilite_master_en {true} CONFIG.axil_master_64bit_en {true}] [get_bd_cells xdma_0]
set_property -dict [list CONFIG.axilite_master_size {4} CONFIG.axilite_master_scale {Gigabytes}] [get_bd_cells xdma_0]
set_property -dict [list CONFIG.pciebar2axibar_axil_master {0} CONFIG.pf0_msix_cap_table_bir {BAR_3:2}] [get_bd_cells xdma_0]
set_property -dict [list CONFIG.pf0_msix_cap_pba_bir {BAR_3:2}] [get_bd_cells xdma_0]
endgroup

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf_0
endgroup

startgroup
set_property -dict [list CONFIG.C_BUF_TYPE {IBUFDSGTE}] [get_bd_cells util_ds_buf_0]
#set_property -dict [list CONFIG.DIFF_CLK_IN_BOARD_INTERFACE {pcie_refclk}] [get_bd_cells util_ds_buf_0]
make_bd_intf_pins_external [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]
set_property name pcie_refclk [get_bd_intf_ports CLK_IN_D_0]
connect_bd_net [get_bd_pins util_ds_buf_0/IBUF_DS_ODIV2] [get_bd_pins xdma_0/sys_clk]
connect_bd_net [get_bd_pins util_ds_buf_0/IBUF_OUT] [get_bd_pins xdma_0/sys_clk_gt]
endgroup

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4:2.2 ddr4_0
make_bd_intf_pins_external  [get_bd_intf_pins ddr4_0/C0_DDR4]
endgroup

startgroup
set_property -dict [list CONFIG.C0.DDR4_TimePeriod {833} CONFIG.C0.DDR4_InputClockPeriod {3332} CONFIG.C0.DDR4_CLKOUT0_DIVIDE {5}] [get_bd_cells ddr4_0]
set_property -dict [list CONFIG.C0.DDR4_CustomParts [lindex [get_files */crutial_ballistix_sport_lt_4gb.csv] 0] CONFIG.C0.DDR4_isCustom {true}] [get_bd_cells ddr4_0]
set_property -dict [list CONFIG.C0.DDR4_MemoryType {UDIMMs} CONFIG.C0.DDR4_MemoryPart {BLS4G4D240FSB} CONFIG.C0.DDR4_DataWidth {64} CONFIG.C0.DDR4_CasLatency {16} CONFIG.C0.DDR4_CasWriteLatency {16} CONFIG.C0.DDR4_AxiDataWidth {512} CONFIG.C0.DDR4_AxiAddressWidth {32}] [get_bd_cells ddr4_0]
set_property -dict [list CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {100}] [get_bd_cells ddr4_0]
endgroup

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0
set_property -dict [list CONFIG.C_SIZE {1} CONFIG.C_OPERATION {not} CONFIG.LOGO_FILE {data/sym_notgate.png}] [get_bd_cells util_vector_logic_0]
connect_bd_net [get_bd_ports pcie_perstn] [get_bd_pins util_vector_logic_0/Op1]
connect_bd_net [get_bd_pins util_vector_logic_0/Res] [get_bd_pins ddr4_0/sys_rst]
endgroup

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_smc
set_property -dict [list CONFIG.NUM_MI {1} CONFIG.NUM_SI {2} CONFIG.NUM_CLKS {2}] [get_bd_cells axi_smc]
connect_bd_intf_net [get_bd_intf_pins xdma_0/M_AXI] [get_bd_intf_pins axi_smc/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins xdma_0/M_AXI_LITE] [get_bd_intf_pins axi_smc/S01_AXI]
connect_bd_net [get_bd_pins xdma_0/axi_aclk] [get_bd_pins axi_smc/aclk]
connect_bd_net [get_bd_pins xdma_0/axi_aresetn] [get_bd_pins axi_smc/aresetn]
endgroup

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 ddr4_c0_reset
endgroup

startgroup
set_property -dict [list CONFIG.C_AUX_RESET_HIGH.VALUE_SRC USER] [get_bd_cells ddr4_c0_reset]
set_property -dict [list CONFIG.C_AUX_RESET_HIGH {0}] [get_bd_cells ddr4_c0_reset]

connect_bd_net [get_bd_pins ddr4_0/c0_ddr4_ui_clk] [get_bd_pins ddr4_c0_reset/slowest_sync_clk]
connect_bd_net [get_bd_pins ddr4_0/c0_ddr4_ui_clk_sync_rst] [get_bd_pins ddr4_c0_reset/ext_reset_in]
connect_bd_net [get_bd_pins ddr4_c0_reset/peripheral_aresetn] [get_bd_pins ddr4_0/c0_ddr4_aresetn]
endgroup

startgroup
connect_bd_net [get_bd_pins ddr4_0/c0_ddr4_ui_clk] [get_bd_pins axi_smc/aclk1]
connect_bd_intf_net [get_bd_intf_pins axi_smc/M00_AXI] [get_bd_intf_pins ddr4_0/C0_DDR4_S_AXI]
make_bd_intf_pins_external  [get_bd_intf_pins ddr4_0/C0_SYS_CLK]
set_property name default_300mhz_clk0 [get_bd_intf_ports C0_SYS_CLK_0]
set_property CONFIG.FREQ_HZ 300000000 [get_bd_intf_ports /default_300mhz_clk0]
endgroup

assign_bd_address

add_files -fileset constrs_1 -norecurse ./bcu1525_ballistix_ddr4_c0.xdc
import_files -fileset constrs_1 ./bcu1525_ballistix_ddr4_c0.xdc

make_wrapper -files [get_files ./ddr4_single_channel/ddr4_single_channel.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse ./ddr4_single_channel/ddr4_single_channel.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v

