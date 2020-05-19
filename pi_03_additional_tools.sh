#!/bin/bash

echo APT update ...
sudo apt update

echo APT upgrade...
sudo apt upgrade -y

echo APT install deluged and deluge-web
sudo apt install -y deluged deluge-web
sudo cp ./systemd/deluged.service /etc/systemd/system/
sudo cp ./systemd/deluge-web.service /etc/systemd/system/
sudo systemctl enable deluged.service
sudo systemctl enable deluge-web.service

#echo APT install additional packages ... 
#sudo apt install -y $(grep -o ^[^#][[:alnum:]-]* "./config/additional_packages.list")
