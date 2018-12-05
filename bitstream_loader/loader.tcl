
set CARD_ID [lindex $argv 0]
set BITSTREAM [lindex $argv 1]

#Open hardware device.
open_hw

#Connect to local HW server.
connect_hw_server -url localhost:3121
current_hw_target [get_hw_targets */xilinx_tcf/Xilinx/$CARD_ID]
set_property PARAM.FREQUENCY 15000000 [get_hw_targets */xilinx_tcf/Xilinx/$CARD_ID]
open_hw_target

#Set current device.
current_hw_device [get_hw_devices xcvu9p_0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xcvu9p_0] 0]

#Load bitstream to device.
set_property PROBES.FILE {} [get_hw_devices xcvu9p_0]
set_property FULL_PROBES.FILE {} [get_hw_devices xcvu9p_0]
set_property PROGRAM.FILE $BITSTREAM [get_hw_devices xcvu9p_0]
program_hw_devices [get_hw_devices xcvu9p_0]

#Refresh device.
refresh_hw_device [lindex [get_hw_devices xcvu9p_0] 0]

#Close hardware device.
close_hw

