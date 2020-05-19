#!/bin/bash

echo Set and update locale to en_US.UTF-8 ...
sudo sed -i "s/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g" /etc/locale.gen>/dev/null
sudo locale-gen en_US.UTF-8
sudo update-locale en_US.UTF-8

echo Set timezone ...
sudo rm /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Singapore /etc/localtime

echo Set 'pi' user password ...
sudo passwd pi

echo APT update ...
sudo apt update

echo APT install base packages ...
sudo apt install -y $(grep -o ^[^#][[:alnum:]-]* "./config/base_packages.list")

echo Setup VNC server...
sudo vncpasswd -service
#sudo sed -i "s/Authentication=SystemAuth/Authentication=VncAuth/g" /root/.vnc/config.d/vncserver-x11>/dev/null
echo "Authentication=VncAuth"|sudo tee -a /root/.vnc/config.d/vncserver-x11>/dev/null
#sudo systemctl enable vncserver-x11-serviced.service &&
#sudo systemctl start vncserver-x11-serviced.service &&

echo Setup dnsmasq for usb0 ...
sudo cp ./config/usb0_dnsmasq.conf /etc/dnsmasq.d/
