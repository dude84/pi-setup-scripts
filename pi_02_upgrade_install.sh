#!/bin/bash

echo APT update ...
sudo apt update

echo APT upgrade...
sudo apt upgrade -y

echo APT install packages ...
sudo apt install -y $(grep -o ^[^#][[:alnum:]-]* "./config/packages.list")
