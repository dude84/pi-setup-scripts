#!/bin/bash
v=255
if [ $# -lt 1 ];
then
        echo "Please supply parameters [0/1]"
        exit 1
fi
if [ $1 -eq 1 ];
then 
        v=255 
fi
if [ $1 -eq 0 ];
then
        v=0
fi
echo $v|sudo tee /sys/class/leds/led1/brightness>/dev/null
