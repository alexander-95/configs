#!/bin/bash

output=$(cat /sys/block/sda/stat | awk '{print $9}')
echo -e '\U1F4BD' $output
