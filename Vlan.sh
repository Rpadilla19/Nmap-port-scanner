#!/bin/bash
#ONLY USE IF INTERFACES ARE NOT CREATED SINCE IT COULD CAUSE ISSUES! IF INTERFACES ALREADY CREATED USE /home/nmap/netns.sh

#creates interface with proper ip and subnet

#ip link add link eth0 Netintf type vlan id 500
#ip link set dev Netintf up
ip link add link eth0 Uintf type vlan id 188
ip addr add 192.168.188.0/24 brd 192.168.188.255 dev Uintf
ip link set dev Uintf up
ip link add link eth0 Vintf type vlan id 110
ip addr add 192.168.110.0/24 brd 192.168.110.255 dev Vintf
ip link set dev Vintf up
ip link add link eth0 ITintf type vlan id 194
ip addr add 192.168.194.0/24 brd 192.168.194.255 dev ITintf
ip link set dev ITintf up

echo "interfaces User, VOIP, and IT created" > /home/nmap/log.txt
#creates namespaces
#ip netns add Guest_wireless
ip netns add User
ip netns add VOIP
ip netns add IT

echo "namespaces User, VOIP, IT created" >> /home/nmap/log.txt

#connects interface to namespace
#ip link set dev Netintf netns Guest_wireless
ip link set dev Uintf netns User
ip link set dev ITintf netns IT
ip link set dev Vintf netns VOIP

echo "interfaces attached to proper namespaces" >> /home/nmap/log.txt

#enables dhcp for namespace
#sudo ip netns exec Guest_wireless dhclient Netintf
sudo ip netns exec User dhclient Uintf
sudo ip netns exec IT dhclient ITintf
sudo ip netns exec VOIP dhclient Vintf

echo "dhcp enabled for all interfaces in namespaces" >> /home/nmap/log.txt

#runs script for each namespace
#sudo ip netns exec Guest_wireless bash /home/nmap/csv.sh Guest_wireless >> /home/nmap/log.txt
sudo ip netns exec VOIP bash /home/nmap/csv.sh VOIP >> /home/nmap/log.txt
sudo ip netns exec User bash /home/nmap/csv.sh User >> /home/nmap/log.txt
sudo ip netns exec IT bash /home/nmap/csv.sh IT >> /home/nmap/log.txt



