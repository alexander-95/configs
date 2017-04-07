#!/bin/bash
#temp source for cpu cores /sys/devices/platform/coretemp.0/hwmon/hwmon*/
#useful for disk usage: /sys/block/sda/stat
#useful for getting fan speed http://www.tjansson.dk/2008/10/controlling-fanspeeds-in-linux-on-pwm-motherboards-thinkpads-and-asus-eee-pc/
output=""
thermal_zones=$(ls -1a /sys/class/thermal/ | grep thermal_zone)
for zone in $thermal_zones
do
    temp=$(cat /sys/class/thermal/$zone/temp)
    temp=$(($temp/1000))
    output=$output$temp"°c "
done
echo "$output"


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
	    echo "$label $temp°c"
	    if [ $temp -gt $coretemp ]
	    then
		coretemp=$temp
	    fi
	fi
    done
done
echo "cpu: $coretemp°c"
