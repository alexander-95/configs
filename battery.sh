#!/bin/bash

output=''
for battery in $(ls -1 /sys/class/power_supply/ | grep BAT)
do
    output="$output $(cat /sys/class/power_supply/$battery/capacity)%"
done
echo -e '\U1F50B' $output
