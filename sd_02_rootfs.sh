#!/bin/bash

# set the path to root partition on SD card
ROOT_PATH=/tmp/sda2

# set the hostname
HOSTNAME=mypi

# setting to 1 will install a script that will turn off the red PWR LED after booting is finidhed
SET_PWR_LED=1

echo Setup hostname: $HOSTNAME ...
sudo sed -i "s/raspberrypi/$HOSTNAME/g;s/kali/$HOSTNAME/g" $ROOT_PATH/etc/hostname >/dev/null

echo Setup hosts: $HOSTNAME ...
sudo sed -i "s/raspberrypi/$HOSTNAME/g;s/kali/$HOSTNAME/g" $ROOT_PATH/etc/hosts >/dev/null

echo Setup network interfaces ...
sudo cp ./interfaces.d/* $ROOT_PATH/etc/network/interfaces.d/

echo Setup /home/pi/.bash_aliases ...
cat ./config/bash_aliases >> $ROOT_PATH/home/pi/.bash_aliases

echo Clear $ROOT_PATH/etc/motd ...
sudo rm $ROOT_PATH/etc/motd
sudo touch $ROOT_PATH/etc/motd

echo Configure bashrc defaults for user pi...
sed -i "s/HISTSIZE=1000/HISTSIZE=1000000/g" $ROOT_PATH/home/pi/.bashrc>/dev/null
sed -i "s/HISTFILESIZE=2000/HISTFILESIZE=200000/g" $ROOT_PATH/home/pi/.bashrc>/dev/null

#echo Setup authorized_hosts...
#mkdir -p $ROOT_PATH/home/pi/.ssh
#cp ./config/authorized_keys $ROOT_PATH/home/pi/.ssh/

#echo Setup SSH host keys - my defaults for rsa...
#sudo cp ./config/ssh_host_* $ROOT_PATH/etc/ssh/

echo Copy _PISetup scripts to $ROOT_PATH/home/pi ...
cp -r ../_PISetup $ROOT_PATH/home/pi/

echo Copy led_pwr_pi.sh to $ROOT_PATH/usr/local/bin/ ...
sudo cp ./scripts/led_pwr_pi.sh $ROOT_PATH/usr/local/bin/
if [ $SET_PWR_LED -eq 1 ]
then
  echo Setup PWR Led script \(optional - different on Kali\) ...
  sudo sed '/exit 0*$/i /usr/local/bin/led_pwr_pi.sh 0' $ROOT_PATH/etc/rc.local -i
fi

echo Copy usb_gadget_pi.sh to $ROOT_PATH/usr/local/bin ...
sudo cp ./scripts/usb_gadget_pi.sh $ROOT_PATH/usr/local/bin/
echo Add usb_gadget_pi.sh to $ROOT_PATH/etc/rc.local ...
sudo sed '/exit 0*$/i /usr/local/bin/usb_gadget_pi.sh > /tmp/usb_gadet_pi_error.log 2>&1 &' $ROOT_PATH/etc/rc.local -i

echo Setup dhcpcd.d to deny usb0 interface ...
echo "denyinterfaces usb0"|sudo tee -a $ROOT_PATH/etc/dhcpcd.conf>/dev/null

echo Setup dropbox uploader script ...
sudo cp ./scripts/dropbox $ROOT_PATH/usr/local/bin/
cp ./config/.dropbox_uploader $ROOT_PATH/home/pi/
