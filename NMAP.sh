#!/bin/bash
#the purpose of this script is to be used by cron to create the vlans in the event of a system reset


target_vlan="IT"

current_vlans=$(ip netns list | grep "IT" | grep -oP '\bIT\b' )

d=$(date +%Y-%m-%d)

#echo "$current_vlans"

if [ "$current_vlans" = "$target_vlan" ]; then
        echo "running netns.sh"
	bash "/home/nmap/netns.sh"
else
        echo "running Vlan.sh"
	bash "/home/nmap/vlan.sh"
fi


sendemail -f <email address> -t <email address>  -u "nmap ${d}" -m "Scans are ready for pickup in /path/to/file/Networkscans_${d}.zip" -s <smtp server>
