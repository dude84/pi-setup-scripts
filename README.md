# pi-setup
New PI setup scripts

# Quick start - SD card
1) Download latest version of Raspabian https://www.raspberrypi.org/downloads/raspbian/ (Buster is the available version at the time of writing this guide) - preferable the standard version (neither full nor lite) - https://downloads.raspberrypi.org/raspbian_latest

2a) Mount your SD card in linux and flash the image using _copy_image.sh (ensure you have the proper device names, usually it should be /dev/sda, but you can check using 
lsblk command), or by issuing command below:
dd if='2020-raspabian/2020-02-13-raspbian-buster.img' of=/dev/<sdcard> bs=4M conv=fsync status=progress

2b) Alternatively you can use the standard method using raspberry imager tools - https://www.raspberrypi.org/downloads/

3) Mount the sd card partiitons (you can use _mount_sda.sh) or issue the following commands:
mkdir /tmp/sda1
mkdir /tmp/sda2
sudo mount /dev/sda1 /tmp/sda1
sudo mount /dev/sda2 /tmp/sda2

# Quick start - PI Setup configuration
1) sd_01_boot.sh
 - ensure that BOOT_PATH is properly configured in the script
 - ensure that config/wpa_supplicant.conf has the right details

2) sd_02_root.sh
- ensure that ROOT_PATH is properly configured in the script
- set the hostname -> HOSTNAME=mypi
- SET_PWR_LED - setting to 1 will install a script that will turn off the red PWR LED after booting is finidhed

3) pi_01_setup_base.sh
- ensure that the timezone is set properly

# Quick start - PI Setup execution
1) both sd_*.sh scripts need to be executed on a mounted SD card - they will prepare the insallation, configure basic system settings and copy the PI_Setup cripts to the card
2) once booted into the PI you can execute the pi_*.sh scripts as required - usually *additional_tools.sh is optional
 - run sudo raspi-config for standard configuration and to enable realvnc service in interfaces, cameras, etc.
 - the passwords will be changed interactively

# Dropbox uploader:
Original source https://github.com/andreafabrizi/Dropbox-Uploader

1) Obtain OAUTH token - http://99rabbits.com/get-dropbox-access-token/
2) OAUTH token needs to be added in config/.dropbox_uploader

You can then use:
dropbox upload <filename> /upload_folder/