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


sendemail -f infosecScanner@laccd.edu -t infosec@laccd.edu -cc baiksj@laccd.edu  -u "ESCnmap ${d}" -m "Scans are ready for pickup in /home/nmap/scanneroutputfi/ESC_Networkscans_${d}.zip" -s smtpout.laccd.edu:25
