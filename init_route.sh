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
echo del old ip from dev
ip addr del 188.120.246.128/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.246.128/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.5 -o ens3 -j SNAT --to-source 188.120.246.128 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.5 -o ens3 -j SNAT --to-source 188.120.246.128 
echo del old ip from dev
ip addr del 188.120.246.127/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.246.127/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.6 -o ens3 -j SNAT --to-source 188.120.246.127 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.6 -o ens3 -j SNAT --to-source 188.120.246.127 
echo del old ip from dev
ip addr del 188.120.246.126/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.246.126/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.7 -o ens3 -j SNAT --to-source 188.120.246.126 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.7 -o ens3 -j SNAT --to-source 188.120.246.126 
echo del old ip from dev
ip addr del 188.120.246.124/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.246.124/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.8 -o ens3 -j SNAT --to-source 188.120.246.124 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.8 -o ens3 -j SNAT --to-source 188.120.246.124 
echo del old ip from dev
ip addr del 188.120.246.121/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.246.121/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.9 -o ens3 -j SNAT --to-source 188.120.246.121 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.9 -o ens3 -j SNAT --to-source 188.120.246.121 
echo del old ip from dev
ip addr del 188.120.241.155/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.155/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.10 -o ens3 -j SNAT --to-source 188.120.241.155 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.10 -o ens3 -j SNAT --to-source 188.120.241.155 
echo del old ip from dev
ip addr del 188.120.241.154/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.154/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.11 -o ens3 -j SNAT --to-source 188.120.241.154 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.11 -o ens3 -j SNAT --to-source 188.120.241.154 
echo del old ip from dev
ip addr del 188.120.241.145/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.145/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.12 -o ens3 -j SNAT --to-source 188.120.241.145 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.12 -o ens3 -j SNAT --to-source 188.120.241.145 
echo del old ip from dev
ip addr del 188.120.241.141/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.141/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.13 -o ens3 -j SNAT --to-source 188.120.241.141 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.13 -o ens3 -j SNAT --to-source 188.120.241.141 
echo del old ip from dev
ip addr del 188.120.241.137/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.137/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.14 -o ens3 -j SNAT --to-source 188.120.241.137 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.14 -o ens3 -j SNAT --to-source 188.120.241.137 
echo del old ip from dev
ip addr del 188.120.241.136/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.136/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.15 -o ens3 -j SNAT --to-source 188.120.241.136 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.15 -o ens3 -j SNAT --to-source 188.120.241.136 
echo del old ip from dev
ip addr del 188.120.241.132/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.132/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.16 -o ens3 -j SNAT --to-source 188.120.241.132 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.16 -o ens3 -j SNAT --to-source 188.120.241.132 
echo del old ip from dev
ip addr del 188.120.241.120/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.120/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.17 -o ens3 -j SNAT --to-source 188.120.241.120 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.17 -o ens3 -j SNAT --to-source 188.120.241.120 
echo del old ip from dev
ip addr del 188.120.239.91/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.239.91/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.18 -o ens3 -j SNAT --to-source 188.120.239.91 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.18 -o ens3 -j SNAT --to-source 188.120.239.91 
echo del old ip from dev
ip addr del 188.120.238.41/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.238.41/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.19 -o ens3 -j SNAT --to-source 188.120.238.41 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.19 -o ens3 -j SNAT --to-source 188.120.238.41 
echo del old ip from dev
ip addr del 188.120.233.16/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.233.16/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.20 -o ens3 -j SNAT --to-source 188.120.233.16 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.20 -o ens3 -j SNAT --to-source 188.120.233.16 
echo del old ip from dev
ip addr del 188.120.229.117/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.229.117/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.21 -o ens3 -j SNAT --to-source 188.120.229.117 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.21 -o ens3 -j SNAT --to-source 188.120.229.117 
echo del old ip from dev
ip addr del 188.120.227.150/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.227.150/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.22 -o ens3 -j SNAT --to-source 188.120.227.150 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.22 -o ens3 -j SNAT --to-source 188.120.227.150 
echo del old ip from dev
ip addr del 188.120.227.83/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.227.83/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.23 -o ens3 -j SNAT --to-source 188.120.227.83 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.23 -o ens3 -j SNAT --to-source 188.120.227.83 
echo del old ip from dev
ip addr del 188.120.225.133/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.225.133/20 dev ens3 
ip link set dev ens3 up
echo delete old  nat 
iptables -t nat -D POSTROUTING -s 192.168.252.24 -o ens3 -j SNAT --to-source 188.120.225.133 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.24 -o ens3 -j SNAT --to-source 188.120.225.133 
iptables -A FORWARD -o tun0 -j ACCEPT 
iptables -A FORWARD -i tun0 -j ACCEPT

iptables -A INPUT -p tcp -m multiport --dports 443,1194 -j ACCEPT 

iptables -A INPUT -p udp -m multiport --dports 443,1194 -j ACCEPT 

iptables -A OUTPUT -p tcp -m multiport --dports 22 -j LOG --log-prefix 'SSH OUTPUT: '

iptables -A OUTPUT -p tcp -m multiport --dports 22 -j DROP

iptables -A OUTPUT -p udp -m multiport --dports 443,80,53 -j ACCEPT

service fail2ban restart 

