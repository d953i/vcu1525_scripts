#!/bin/bash

#Load bitstream to Card0 using TCL script
vivado -mode batch -nojournal -nolog -notrace -source card0_keccak.tcl

#Remove PCI-E device if already exists
sudo sh -c "echo '1' > /sys/bus/pci/devices/0000:05:00.0/remove"

#Rescan PCI-E
sleep 1
sudo sh -c "echo '1' > /sys/bus/pci/rescan"
