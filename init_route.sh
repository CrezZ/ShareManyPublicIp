#!/bin/sh

iptables -F
iptables -X
iptables -P FORWARD DROP
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports 22,80,443 -j ACCEPT
iptables -A INPUT -i tun0 -j ACCEPT
ip addr del 188.120.238.41/28 dev ens3 
ip addr add 188.120.238.41/28 dev ens3 
ip link set dev ens3 up
ip rule del from 188.120.238.41 dev ens3 table 1000
ip rule add from 188.120.238.41 dev ens3 table 1000
ip rule del from 192.168.252.5 table 1000 
ip rule add from 192.168.252.5 table 1000 
ip route del default via 188.120.239.254 dev ens3 table 1000 
ip route add default via 188.120.239.254 dev ens3 table 1000 
iptables -t nat -D POSTROUTING -s 192.168.252.5 -o ens3 -j SNAT --to-source 188.120.238.41 
iptables -t nat -A POSTROUTING -s 192.168.252.5 -o ens3 -j SNAT --to-source 188.120.238.41 
ip addr del 188.120.229.117/28 dev ens3 
ip addr add 188.120.229.117/28 dev ens3 
ip link set dev ens3 up
ip rule del from 188.120.229.117 dev ens3 table 1001
ip rule add from 188.120.229.117 dev ens3 table 1001
ip rule del from 192.168.252.6 table 1001 
ip rule add from 192.168.252.6 table 1001 
ip route del default via 188.120.239.254 dev ens3 table 1001 
ip route add default via 188.120.239.254 dev ens3 table 1001 
iptables -t nat -D POSTROUTING -s 192.168.252.6 -o ens3 -j SNAT --to-source 188.120.229.117 
iptables -t nat -A POSTROUTING -s 192.168.252.6 -o ens3 -j SNAT --to-source 188.120.229.117 
ip addr del 188.120.227.150/28 dev ens3 
ip addr add 188.120.227.150/28 dev ens3 
ip link set dev ens3 up
ip rule del from 188.120.227.150 dev ens3 table 1002
ip rule add from 188.120.227.150 dev ens3 table 1002
ip rule del from 192.168.252.7 table 1002 
ip rule add from 192.168.252.7 table 1002 
ip route del default via 188.120.239.254 dev ens3 table 1002 
ip route add default via 188.120.239.254 dev ens3 table 1002 
iptables -t nat -D POSTROUTING -s 192.168.252.7 -o ens3 -j SNAT --to-source 188.120.227.150 
iptables -t nat -A POSTROUTING -s 192.168.252.7 -o ens3 -j SNAT --to-source 188.120.227.150 
iptables -A FORWARD -o tun0 -j ACCEPT 
iptables -A FORWARD -i tun0 -j ACCEPT

iptables -A INPUT -p tcp -m multiport --dports 443,1194 -j ACCEPT 

iptables -A INPUT -p udp -m multiport --dports 443,1194 -j ACCEPT 

iptables -A OUTPUT -p tcp -m multiport --dports 22 -j LOG --log-prefix 'SSH OUTPUT: '

iptables -A OUTPUT -p tcp -m multiport --dports 22 -j DROP

iptables -A OUTPUT -p udp -m multiport --dports 443,80,53 -j ACCEPT

service fail2ban restart 

