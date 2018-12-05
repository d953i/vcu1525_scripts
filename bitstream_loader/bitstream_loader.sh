#!/bin/bash

source /opt/Xilinx/Vivado/2018.2/settings64.sh

CARD0=12809621t094A
CARD1=13883211t086B
CARD2=2384343a83439
CARD4=101432t0239AB

BITSTREAM0=~/Mining/bitstreams/vcu1525_keccak_21_600.bit
BITSTREAM1=~/Mining/bitstreams/vcu1525_tribus_3_600.bit
BITSTREAM2=~/Mining/bitstreams/vcu1525_tribus_3_650.bit

vivado -mode batch -nojournal -nolog -notrace -source loader.tcl -tclargs $CARD0 $BITSTREAM0
vivado -mode batch -nojournal -nolog -notrace -source loader.tcl -tclargs $CARD1 $BITSTREAM0
vivado -mode batch -nojournal -nolog -notrace -source loader.tcl -tclargs $CARD2 $BITSTREAM1
vivado -mode batch -nojournal -nolog -notrace -source loader.tcl -tclargs $CARD3 $BITSTREAM2

#Remove pcie device if already exists and rescan
sudo sh -c "echo '1' > /sys/bus/pci/devices/0000:05:00.0/remove"
sudo sh -c "echo '1' > /sys/bus/pci/devices/0000:04:00.0/remove"
sudo sh -c "echo '1' > /sys/bus/pci/devices/0000:06:00.0/remove"
sudo sh -c "echo '1' > /sys/bus/pci/devices/0000:07:00.0/remove"

#sleep 1
sudo sh -c "echo '1' > /sys/bus/pci/rescan"
