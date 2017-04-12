#!/bin/bash
#temp source for cpu cores /sys/devices/platform/coretemp.0/hwmon/hwmon*/
#useful for disk usage: /sys/block/sda/stat
#useful for getting fan speed http://www.tjansson.dk/2008/10/controlling-fanspeeds-in-linux-on-pwm-motherboards-thinkpads-and-asus-eee-pc/

coretemp=0
for cpu in $(ls -1 /sys/devices/platform/ | grep coretemp)
do
    hwmon=$(ls -1 /sys/devices/platform/$cpu/hwmon/ | grep hwmon)
    for sensor in $(ls -1 /sys/devices/platform/$cpu/hwmon/$hwmon/ | grep temp | grep input)
    do
	sensor=$(echo $sensor | cut -f1 -d '_')
	sensor=/sys/devices/platform/$cpu/hwmon/$hwmon/$sensor
	label=$(cat ${sensor}_label)
	temp=$(($(cat ${sensor}_input)/1000))
	if [[ "$label" == "Core"* ]]
	then
	    if [ $temp -gt $coretemp ]
	    then
		coretemp=$temp
	    fi
	fi
    done
done

#fan speed
fan=$(cat /sys/class/hwmon/hwmon1/device/fan1_input)

echo -e '\U1F321 cpu:' $coretemp°c '\U2744' ${fan}rpm
