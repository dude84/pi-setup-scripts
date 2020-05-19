#!/bin/bash

# set the path to boot partition on SD card
BOOT_PATH=/tmp/sda1

# Boot partition setup 
echo Setup SSH...
sudo touch $BOOT_PATH/ssh

echo Setup WPA_Supplicant...
sudo cp ./config/wpa_supplicant.conf $BOOT_PATH/

echo Setup g_ether USB device modules...
sudo echo "dtoverlay=dwc2"|sudo tee -a $BOOT_PATH/config.txt>/dev/null
sudo sed 's/\<rootwait\>/& modules-load=dwc2,g_ether/' $BOOT_PATH/cmdline.txt -i
