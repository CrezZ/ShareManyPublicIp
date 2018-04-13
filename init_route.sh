#!/bin/sh

iptables -F
iptables -X
iptables -P FORWARD DROP
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports 22,80 -j ACCEPT

ip addr del 78.24.218.42 dev ens3 
ip addr add 78.24.218.42 dev ens3 
ip link set dev ens3 up
ip rule del from 78.24.218.42 dev ens3 table 100
ip rule add from 78.24.218.42 dev ens3 table 100
ip rule del from 192.168.255.100 table 100 
ip rule add from 192.168.255.100 table 100 
ip route del default via 10.0.0.1 dev ens3 table 100 
ip route add default via 10.0.0.1 dev ens3 table 100 
iptables -t nat -D POSTROUTING -s 192.168.255.100 -o ens3 -j SNAT --to-source 78.24.218.42 
iptables -t nat -A POSTROUTING -s 192.168.255.100 -o ens3 -j SNAT --to-source 78.24.218.42 
ip addr del 78.24.218.162 dev ens3 
ip addr add 78.24.218.162 dev ens3 
ip link set dev ens3 up
ip rule del from 78.24.218.162 dev ens3 table 101
ip rule add from 78.24.218.162 dev ens3 table 101
ip rule del from 192.168.255.101 table 101 
ip rule add from 192.168.255.101 table 101 
ip route del default via 10.0.0.1 dev ens3 table 101 
ip route add default via 10.0.0.1 dev ens3 table 101 
iptables -t nat -D POSTROUTING -s 192.168.255.101 -o ens3 -j SNAT --to-source 78.24.218.162 
iptables -t nat -A POSTROUTING -s 192.168.255.101 -o ens3 -j SNAT --to-source 78.24.218.162 
ip addr del 78.24.219.237 dev ens3 
ip addr add 78.24.219.237 dev ens3 
ip link set dev ens3 up
ip rule del from 78.24.219.237 dev ens3 table 102
ip rule add from 78.24.219.237 dev ens3 table 102
ip rule del from 192.168.255.102 table 102 
ip rule add from 192.168.255.102 table 102 
ip route del default via 10.0.0.1 dev ens3 table 102 
ip route add default via 10.0.0.1 dev ens3 table 102 
iptables -t nat -D POSTROUTING -s 192.168.255.102 -o ens3 -j SNAT --to-source 78.24.219.237 
iptables -t nat -A POSTROUTING -s 192.168.255.102 -o ens3 -j SNAT --to-source 78.24.219.237 
ip addr del 78.24.222.178 dev ens3 
ip addr add 78.24.222.178 dev ens3 
ip link set dev ens3 up
ip rule del from 78.24.222.178 dev ens3 table 103
ip rule add from 78.24.222.178 dev ens3 table 103
ip rule del from 192.168.255.103 table 103 
ip rule add from 192.168.255.103 table 103 
ip route del default via 10.0.0.1 dev ens3 table 103 
ip route add default via 10.0.0.1 dev ens3 table 103 
iptables -t nat -D POSTROUTING -s 192.168.255.103 -o ens3 -j SNAT --to-source 78.24.222.178 
iptables -t nat -A POSTROUTING -s 192.168.255.103 -o ens3 -j SNAT --to-source 78.24.222.178 
iptables -A FORWARD -o tun0 -j ACCEPT 
iptables -A FORWARD -i tun0 -j ACCEPT

iptables -A INPUT -p tcp -m multiport --dports 443,1194 -j ACCEPT 

iptables -A INPUT -p udp -m multiport --dports 443,1194 -j ACCEPT 

