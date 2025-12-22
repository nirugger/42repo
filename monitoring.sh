#!/bin/bash

# System Monitoring Script
# Displays system information in a formatted way

echo "#Architecture: $(uname -a)"
echo "#CPU physical: $(grep "^physical id" /proc/cpuinfo | sort -u | wc -l)"
echo "#vCPU: $(grep -c "^processor" /proc/cpuinfo)"
echo "#Memory Usage: $(free -m | awk 'NR==2{printf "%d/%dMB (%.2f%%)", $7, $2, $7*100/$2}')"
echo "#Disk Usage: $(df -h --total | awk '{printf "%s/%s (%s)", $3, $2, $5}')"
echo "#CPU load: $(mpstat 1 1 | awk 'NR==4{printf "%.2f%%", 100-$NF}')"
echo "#Last boot: $(TZ='Europe/Rome' date -d @$(grep ^btime /proc/stat | awk '{print $2}') "+%Y-%m-%d %H:%M:%S")"
echo "#LVM use: $(lsblk | grep -q lvm && echo "YUP" || echo "NOPE")"
echo "#Connections TCP: $(ss -ta | grep ESTAB | wc -l) ESTABLISHED"
echo "#User log: $(who | awk '{print $1}' | sort -u | wc -l)"
echo "#Network: IP $(hostname -I | awk '{print $1}')($(cat /sys/class/net/enp0s3/address))"
echo "#Sudo: $(sudo grep "COMMAND=" /var/log/sudo/sudo_log 2>/dev/null | wc -l) cmd"

