
ip addr del 188.120.241.155/20 dev ens3 
ip rule del from 188.120.241.155/20 dev ens3 table 1000
ip rule del from 192.168.252.5 table 1000 
ip route del default via 188.120.247.254 dev ens3 table 1000 
iptables -t nat -D POSTROUTING -s 192.168.252.5 -o ens3 -j SNAT --to-source 188.120.241.155 
ip addr del 188.120.241.154/20 dev ens3 
ip rule del from 188.120.241.154/20 dev ens3 table 1001
ip rule del from 192.168.252.6 table 1001 
ip route del default via 188.120.247.254 dev ens3 table 1001 
iptables -t nat -D POSTROUTING -s 192.168.252.6 -o ens3 -j SNAT --to-source 188.120.241.154 
ip addr del 188.120.241.145/20 dev ens3 
ip rule del from 188.120.241.145/20 dev ens3 table 1002
ip rule del from 192.168.252.7 table 1002 
ip route del default via 188.120.247.254 dev ens3 table 1002 
iptables -t nat -D POSTROUTING -s 192.168.252.7 -o ens3 -j SNAT --to-source 188.120.241.145 
ip addr del 188.120.241.141/20 dev ens3 
ip rule del from 188.120.241.141/20 dev ens3 table 1003
ip rule del from 192.168.252.8 table 1003 
ip route del default via 188.120.247.254 dev ens3 table 1003 
iptables -t nat -D POSTROUTING -s 192.168.252.8 -o ens3 -j SNAT --to-source 188.120.241.141 
ip addr del 188.120.241.137/20 dev ens3 
ip rule del from 188.120.241.137/20 dev ens3 table 1004
ip rule del from 192.168.252.9 table 1004 
ip route del default via 188.120.247.254 dev ens3 table 1004 
iptables -t nat -D POSTROUTING -s 192.168.252.9 -o ens3 -j SNAT --to-source 188.120.241.137 
ip addr del 188.120.241.136/20 dev ens3 
ip rule del from 188.120.241.136/20 dev ens3 table 1005
ip rule del from 192.168.252.10 table 1005 
ip route del default via 188.120.247.254 dev ens3 table 1005 
iptables -t nat -D POSTROUTING -s 192.168.252.10 -o ens3 -j SNAT --to-source 188.120.241.136 
ip addr del 188.120.241.132/20 dev ens3 
ip rule del from 188.120.241.132/20 dev ens3 table 1006
ip rule del from 192.168.252.11 table 1006 
ip route del default via 188.120.247.254 dev ens3 table 1006 
iptables -t nat -D POSTROUTING -s 192.168.252.11 -o ens3 -j SNAT --to-source 188.120.241.132 
ip addr del 188.120.241.120/20 dev ens3 
ip rule del from 188.120.241.120/20 dev ens3 table 1007
ip rule del from 192.168.252.12 table 1007 
ip route del default via 188.120.247.254 dev ens3 table 1007 
iptables -t nat -D POSTROUTING -s 192.168.252.12 -o ens3 -j SNAT --to-source 188.120.241.120 
ip addr del 188.120.239.91/20 dev ens3 
ip rule del from 188.120.239.91/20 dev ens3 table 1008
ip rule del from 192.168.252.13 table 1008 
ip route del default via 188.120.239.254 dev ens3 table 1008 
iptables -t nat -D POSTROUTING -s 192.168.252.13 -o ens3 -j SNAT --to-source 188.120.239.91 
ip addr del 188.120.238.41/20 dev ens3 
ip rule del from 188.120.238.41/20 dev ens3 table 1009
ip rule del from 192.168.252.14 table 1009 
ip route del default via 188.120.239.254 dev ens3 table 1009 
iptables -t nat -D POSTROUTING -s 192.168.252.14 -o ens3 -j SNAT --to-source 188.120.238.41 
ip addr del 188.120.233.16/20 dev ens3 
ip rule del from 188.120.233.16/20 dev ens3 table 1010
ip rule del from 192.168.252.15 table 1010 
ip route del default via 188.120.239.254 dev ens3 table 1010 
iptables -t nat -D POSTROUTING -s 192.168.252.15 -o ens3 -j SNAT --to-source 188.120.233.16 
ip addr del 188.120.229.117/20 dev ens3 
ip rule del from 188.120.229.117/20 dev ens3 table 1011
ip rule del from 192.168.252.16 table 1011 
ip route del default via 188.120.239.254 dev ens3 table 1011 
iptables -t nat -D POSTROUTING -s 192.168.252.16 -o ens3 -j SNAT --to-source 188.120.229.117 
ip addr del 188.120.227.83/20 dev ens3 
ip rule del from 188.120.227.83/20 dev ens3 table 1012
ip rule del from 192.168.252.17 table 1012 
ip route del default via 188.120.239.254 dev ens3 table 1012 
iptables -t nat -D POSTROUTING -s 192.168.252.17 -o ens3 -j SNAT --to-source 188.120.227.83 
ip addr del 188.120.225.133/20 dev ens3 
ip rule del from 188.120.225.133/20 dev ens3 table 1013
ip rule del from 192.168.252.18 table 1013 
ip route del default via 188.120.239.254 dev ens3 table 1013 
iptables -t nat -D POSTROUTING -s 192.168.252.18 -o ens3 -j SNAT --to-source 188.120.225.133 
