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
ip addr del 188.120.241.155/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.155/20 dev ens3 
ip link set dev ens3 up
echo del old route dev rule from table
ip rule del from 188.120.241.155 dev ens3 table 1000
echo  add route dev rule from table
ip rule add from 188.120.241.155 dev ens3 table 1000
echo del old route rule from table
ip rule del from 192.168.252.5 table 1000 
echo add route rule from table
ip rule add from 192.168.252.5 table 1000 
echo del old route in table
ip route del default via 188.120.247.254 dev ens3 table 1000 
echo add route in table
ip route add default via 188.120.247.254 dev ens3 table 1000 
echo delete old  nat 1
iptables -t nat -D POSTROUTING -s 192.168.252.5 -o ens3 -j SNAT --to-source 188.120.241.155 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.5 -o ens3 -j SNAT --to-source 188.120.241.155 
echo del old ip from dev
ip addr del 188.120.241.154/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.154/20 dev ens3 
ip link set dev ens3 up
echo del old route dev rule from table
ip rule del from 188.120.241.154 dev ens3 table 1001
echo  add route dev rule from table
ip rule add from 188.120.241.154 dev ens3 table 1001
echo del old route rule from table
ip rule del from 192.168.252.6 table 1001 
echo add route rule from table
ip rule add from 192.168.252.6 table 1001 
echo del old route in table
ip route del default via 188.120.247.254 dev ens3 table 1001 
echo add route in table
ip route add default via 188.120.247.254 dev ens3 table 1001 
echo delete old  nat 1
iptables -t nat -D POSTROUTING -s 192.168.252.6 -o ens3 -j SNAT --to-source 188.120.241.154 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.6 -o ens3 -j SNAT --to-source 188.120.241.154 
echo del old ip from dev
ip addr del 188.120.241.145/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.145/20 dev ens3 
ip link set dev ens3 up
echo del old route dev rule from table
ip rule del from 188.120.241.145 dev ens3 table 1002
echo  add route dev rule from table
ip rule add from 188.120.241.145 dev ens3 table 1002
echo del old route rule from table
ip rule del from 192.168.252.7 table 1002 
echo add route rule from table
ip rule add from 192.168.252.7 table 1002 
echo del old route in table
ip route del default via 188.120.247.254 dev ens3 table 1002 
echo add route in table
ip route add default via 188.120.247.254 dev ens3 table 1002 
echo delete old  nat 1
iptables -t nat -D POSTROUTING -s 192.168.252.7 -o ens3 -j SNAT --to-source 188.120.241.145 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.7 -o ens3 -j SNAT --to-source 188.120.241.145 
echo del old ip from dev
ip addr del 188.120.241.141/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.141/20 dev ens3 
ip link set dev ens3 up
echo del old route dev rule from table
ip rule del from 188.120.241.141 dev ens3 table 1003
echo  add route dev rule from table
ip rule add from 188.120.241.141 dev ens3 table 1003
echo del old route rule from table
ip rule del from 192.168.252.8 table 1003 
echo add route rule from table
ip rule add from 192.168.252.8 table 1003 
echo del old route in table
ip route del default via 188.120.247.254 dev ens3 table 1003 
echo add route in table
ip route add default via 188.120.247.254 dev ens3 table 1003 
echo delete old  nat 1
iptables -t nat -D POSTROUTING -s 192.168.252.8 -o ens3 -j SNAT --to-source 188.120.241.141 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.8 -o ens3 -j SNAT --to-source 188.120.241.141 
echo del old ip from dev
ip addr del 188.120.241.137/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.137/20 dev ens3 
ip link set dev ens3 up
echo del old route dev rule from table
ip rule del from 188.120.241.137 dev ens3 table 1004
echo  add route dev rule from table
ip rule add from 188.120.241.137 dev ens3 table 1004
echo del old route rule from table
ip rule del from 192.168.252.9 table 1004 
echo add route rule from table
ip rule add from 192.168.252.9 table 1004 
echo del old route in table
ip route del default via 188.120.247.254 dev ens3 table 1004 
echo add route in table
ip route add default via 188.120.247.254 dev ens3 table 1004 
echo delete old  nat 1
iptables -t nat -D POSTROUTING -s 192.168.252.9 -o ens3 -j SNAT --to-source 188.120.241.137 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.9 -o ens3 -j SNAT --to-source 188.120.241.137 
echo del old ip from dev
ip addr del 188.120.241.136/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.136/20 dev ens3 
ip link set dev ens3 up
echo del old route dev rule from table
ip rule del from 188.120.241.136 dev ens3 table 1005
echo  add route dev rule from table
ip rule add from 188.120.241.136 dev ens3 table 1005
echo del old route rule from table
ip rule del from 192.168.252.10 table 1005 
echo add route rule from table
ip rule add from 192.168.252.10 table 1005 
echo del old route in table
ip route del default via 188.120.247.254 dev ens3 table 1005 
echo add route in table
ip route add default via 188.120.247.254 dev ens3 table 1005 
echo delete old  nat 1
iptables -t nat -D POSTROUTING -s 192.168.252.10 -o ens3 -j SNAT --to-source 188.120.241.136 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.10 -o ens3 -j SNAT --to-source 188.120.241.136 
echo del old ip from dev
ip addr del 188.120.241.132/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.132/20 dev ens3 
ip link set dev ens3 up
echo del old route dev rule from table
ip rule del from 188.120.241.132 dev ens3 table 1006
echo  add route dev rule from table
ip rule add from 188.120.241.132 dev ens3 table 1006
echo del old route rule from table
ip rule del from 192.168.252.11 table 1006 
echo add route rule from table
ip rule add from 192.168.252.11 table 1006 
echo del old route in table
ip route del default via 188.120.247.254 dev ens3 table 1006 
echo add route in table
ip route add default via 188.120.247.254 dev ens3 table 1006 
echo delete old  nat 1
iptables -t nat -D POSTROUTING -s 192.168.252.11 -o ens3 -j SNAT --to-source 188.120.241.132 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.11 -o ens3 -j SNAT --to-source 188.120.241.132 
echo del old ip from dev
ip addr del 188.120.241.120/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.241.120/20 dev ens3 
ip link set dev ens3 up
echo del old route dev rule from table
ip rule del from 188.120.241.120 dev ens3 table 1007
echo  add route dev rule from table
ip rule add from 188.120.241.120 dev ens3 table 1007
echo del old route rule from table
ip rule del from 192.168.252.12 table 1007 
echo add route rule from table
ip rule add from 192.168.252.12 table 1007 
echo del old route in table
ip route del default via 188.120.247.254 dev ens3 table 1007 
echo add route in table
ip route add default via 188.120.247.254 dev ens3 table 1007 
echo delete old  nat 1
iptables -t nat -D POSTROUTING -s 192.168.252.12 -o ens3 -j SNAT --to-source 188.120.241.120 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.12 -o ens3 -j SNAT --to-source 188.120.241.120 
echo del old ip from dev
ip addr del 188.120.239.91/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.239.91/20 dev ens3 
ip link set dev ens3 up
echo del old route dev rule from table
ip rule del from 188.120.239.91 dev ens3 table 1008
echo  add route dev rule from table
ip rule add from 188.120.239.91 dev ens3 table 1008
echo del old route rule from table
ip rule del from 192.168.252.13 table 1008 
echo add route rule from table
ip rule add from 192.168.252.13 table 1008 
echo del old route in table
ip route del default via 188.120.239.254 dev ens3 table 1008 
echo add route in table
ip route add default via 188.120.239.254 dev ens3 table 1008 
echo delete old  nat 1
iptables -t nat -D POSTROUTING -s 192.168.252.13 -o ens3 -j SNAT --to-source 188.120.239.91 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.13 -o ens3 -j SNAT --to-source 188.120.239.91 
echo del old ip from dev
ip addr del 188.120.238.41/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.238.41/20 dev ens3 
ip link set dev ens3 up
echo del old route dev rule from table
ip rule del from 188.120.238.41 dev ens3 table 1009
echo  add route dev rule from table
ip rule add from 188.120.238.41 dev ens3 table 1009
echo del old route rule from table
ip rule del from 192.168.252.14 table 1009 
echo add route rule from table
ip rule add from 192.168.252.14 table 1009 
echo del old route in table
ip route del default via 188.120.239.254 dev ens3 table 1009 
echo add route in table
ip route add default via 188.120.239.254 dev ens3 table 1009 
echo delete old  nat 1
iptables -t nat -D POSTROUTING -s 192.168.252.14 -o ens3 -j SNAT --to-source 188.120.238.41 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.14 -o ens3 -j SNAT --to-source 188.120.238.41 
echo del old ip from dev
ip addr del 188.120.233.16/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.233.16/20 dev ens3 
ip link set dev ens3 up
echo del old route dev rule from table
ip rule del from 188.120.233.16 dev ens3 table 1010
echo  add route dev rule from table
ip rule add from 188.120.233.16 dev ens3 table 1010
echo del old route rule from table
ip rule del from 192.168.252.15 table 1010 
echo add route rule from table
ip rule add from 192.168.252.15 table 1010 
echo del old route in table
ip route del default via 188.120.239.254 dev ens3 table 1010 
echo add route in table
ip route add default via 188.120.239.254 dev ens3 table 1010 
echo delete old  nat 1
iptables -t nat -D POSTROUTING -s 192.168.252.15 -o ens3 -j SNAT --to-source 188.120.233.16 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.15 -o ens3 -j SNAT --to-source 188.120.233.16 
echo del old ip from dev
ip addr del 188.120.229.117/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.229.117/20 dev ens3 
ip link set dev ens3 up
echo del old route dev rule from table
ip rule del from 188.120.229.117 dev ens3 table 1011
echo  add route dev rule from table
ip rule add from 188.120.229.117 dev ens3 table 1011
echo del old route rule from table
ip rule del from 192.168.252.16 table 1011 
echo add route rule from table
ip rule add from 192.168.252.16 table 1011 
echo del old route in table
ip route del default via 188.120.239.254 dev ens3 table 1011 
echo add route in table
ip route add default via 188.120.239.254 dev ens3 table 1011 
echo delete old  nat 1
iptables -t nat -D POSTROUTING -s 192.168.252.16 -o ens3 -j SNAT --to-source 188.120.229.117 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.16 -o ens3 -j SNAT --to-source 188.120.229.117 
echo del old ip from dev
ip addr del 188.120.227.83/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.227.83/20 dev ens3 
ip link set dev ens3 up
echo del old route dev rule from table
ip rule del from 188.120.227.83 dev ens3 table 1012
echo  add route dev rule from table
ip rule add from 188.120.227.83 dev ens3 table 1012
echo del old route rule from table
ip rule del from 192.168.252.17 table 1012 
echo add route rule from table
ip rule add from 192.168.252.17 table 1012 
echo del old route in table
ip route del default via 188.120.239.254 dev ens3 table 1012 
echo add route in table
ip route add default via 188.120.239.254 dev ens3 table 1012 
echo delete old  nat 1
iptables -t nat -D POSTROUTING -s 192.168.252.17 -o ens3 -j SNAT --to-source 188.120.227.83 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.17 -o ens3 -j SNAT --to-source 188.120.227.83 
echo del old ip from dev
ip addr del 188.120.225.133/20 dev ens3 
echo add new ip from dev
ip addr add 188.120.225.133/20 dev ens3 
ip link set dev ens3 up
echo del old route dev rule from table
ip rule del from 188.120.225.133 dev ens3 table 1013
echo  add route dev rule from table
ip rule add from 188.120.225.133 dev ens3 table 1013
echo del old route rule from table
ip rule del from 192.168.252.18 table 1013 
echo add route rule from table
ip rule add from 192.168.252.18 table 1013 
echo del old route in table
ip route del default via 188.120.239.254 dev ens3 table 1013 
echo add route in table
ip route add default via 188.120.239.254 dev ens3 table 1013 
echo delete old  nat 1
iptables -t nat -D POSTROUTING -s 192.168.252.18 -o ens3 -j SNAT --to-source 188.120.225.133 
echo install nat 2
iptables -t nat -A POSTROUTING -s 192.168.252.18 -o ens3 -j SNAT --to-source 188.120.225.133 
iptables -A FORWARD -o tun0 -j ACCEPT 
iptables -A FORWARD -i tun0 -j ACCEPT

iptables -A INPUT -p tcp -m multiport --dports 443,1194 -j ACCEPT 

iptables -A INPUT -p udp -m multiport --dports 443,1194 -j ACCEPT 

iptables -A OUTPUT -p tcp -m multiport --dports 22 -j LOG --log-prefix 'SSH OUTPUT: '

iptables -A OUTPUT -p tcp -m multiport --dports 22 -j DROP

iptables -A OUTPUT -p udp -m multiport --dports 443,80,53 -j ACCEPT

service fail2ban restart 

