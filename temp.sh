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

for hwmon in $(ls -1 /sys/class/hwmon/)
do
    name=$(cat /sys/class/hwmon/$hwmon/name)
    if [ $name != 'acpitz' ] && [ $name != 'coretemp' ]
    then
	fan=$(cat /sys/class/hwmon/$hwmon/fan1_input)
    fi
done

echo -e '#[fg=red]\U1F321#[fg=default] cpu:' $coretemp°c '#[fg=blue]\U2744#[fg=default]' ${fan}rpm
