
set ProjectFolder ./zcu104_ddr4

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


create_project zcu104_ddr4 ./zcu104_ddr4 -part xczu7ev-ffvc1156-2-e
set_property board_part xilinx.com:zcu104:part0:1.1 [current_project]

create_bd_design "design_1"

import_files -norecurse ./crutial_ballistix_sport_lt.csv

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4:2.2 ddr4_0
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Board_Interface {clk_300mhz ( Programmable Differential Clock (300MHz) ) } Manual_Source {Auto}}  [get_bd_intf_pins ddr4_0/C0_SYS_CLK]
endgroup
        
startgroup
set_property -dict [list CONFIG.C0.DDR4_CustomParts [lindex [get_files */crutial_ballistix_sport_lt.csv] 0] CONFIG.C0.DDR4_isCustom {true}] [get_bd_cells ddr4_0]
set_property -dict [list CONFIG.C0.DDR4_MemoryType {SODIMMs} CONFIG.C0.DDR4_MemoryPart {BLS4G4S26BFSD} CONFIG.C0.DDR4_DataWidth {64} CONFIG.C0.DDR4_CasLatency {16} CONFIG.C0.DDR4_CasWriteLatency {16} CONFIG.C0.DDR4_AxiDataWidth {512} CONFIG.C0.DDR4_AxiAddressWidth {32}] [get_bd_cells ddr4_0]
set_property -dict [list CONFIG.C0.DDR4_InputClockPeriod {3334} CONFIG.C0.DDR4_CLKOUT0_DIVIDE {3}] [get_bd_cells ddr4_0]
make_bd_intf_pins_external  [get_bd_intf_pins ddr4_0/C0_DDR4]
endgroup

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.2 zynq_ultra_ps_e_0
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e_0]
endgroup

startgroup
set_property -dict [list CONFIG.PSU__USE__M_AXI_GP0 {1} CONFIG.PSU__USE__M_AXI_GP1 {0} CONFIG.PSU__USE__M_AXI_GP2 {0}] [get_bd_cells zynq_ultra_ps_e_0]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Board_Interface {reset ( FPGA Reset ) } Manual_Source {New External Port (ACTIVE_HIGH)}}  [get_bd_pins ddr4_0/sys_rst]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {/ddr4_0/c0_ddr4_ui_clk (333 MHz)} Clk_xbar {Auto} Master {/zynq_ultra_ps_e_0/M_AXI_HPM0_FPD} Slave {/ddr4_0/C0_DDR4_S_AXI} intc_ip {Auto} master_apm {0}}  [get_bd_intf_pins ddr4_0/C0_DDR4_S_AXI]
endgroup



assign_bd_address
set_property range 4G [get_bd_addr_segs {zynq_ultra_ps_e_0/Data/SEG_ddr4_0_C0_DDR4_ADDRESS_BLOCK}]

add_files -fileset constrs_1 -norecurse ./zcu104_ddr4_c0.xdc
import_files -fileset constrs_1 ./zcu104_ddr4_c0.xdc

make_wrapper -files [get_files ./zcu104_ddr4/zcu104_ddr4.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse ./zcu104_ddr4/zcu104_ddr4.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v
update_compile_order -fileset sources_1

