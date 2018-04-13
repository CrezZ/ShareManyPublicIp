
ip rule del from 78.24.218.42 dev ens3 table 100
ip rule del from 192.168.255.100 table 100 
ip route del default via 10.0.0.1 dev ens3 table 100 
iptables -t nat -D POSTROUTING -s 192.168.255.100 -o ens3 -j SNAT --to-source 78.24.218.42 
ip rule del from 78.24.218.162 dev ens3 table 101
ip rule del from 192.168.255.101 table 101 
ip route del default via 10.0.0.1 dev ens3 table 101 
iptables -t nat -D POSTROUTING -s 192.168.255.101 -o ens3 -j SNAT --to-source 78.24.218.162 
ip rule del from 78.24.219.237 dev ens3 table 102
ip rule del from 192.168.255.102 table 102 
ip route del default via 10.0.0.1 dev ens3 table 102 
iptables -t nat -D POSTROUTING -s 192.168.255.102 -o ens3 -j SNAT --to-source 78.24.219.237 
ip rule del from 78.24.222.178 dev ens3 table 103
ip rule del from 192.168.255.103 table 103 
ip route del default via 10.0.0.1 dev ens3 table 103 
iptables -t nat -D POSTROUTING -s 192.168.255.103 -o ens3 -j SNAT --to-source 78.24.222.178 
