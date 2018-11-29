
#Open hardware device
open_hw

#Connect to local HW server
connect_hw_server -url localhost:3121
current_hw_target [get_hw_targets */xilinx_tcf/Xilinx/12809621t094A]
set_property PARAM.FREQUENCY 15000000 [get_hw_targets */xilinx_tcf/Xilinx/12809621t094A]
open_hw_target

#Set current device
current_hw_device [get_hw_devices xcvu9p_0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xcvu9p_0] 0]

#Load bitstream to device
set_property PROBES.FILE {} [get_hw_devices xcvu9p_0]
set_property FULL_PROBES.FILE {} [get_hw_devices xcvu9p_0]
set_property PROGRAM.FILE {/home/d9/bitstreams/vcu1525_keccak_21_600.bit} [get_hw_devices xcvu9p_0]
program_hw_devices [get_hw_devices xcvu9p_0]

#Refresh device
refresh_hw_device [lindex [get_hw_devices xcvu9p_0] 0]

#Close hardware device
close_hw

