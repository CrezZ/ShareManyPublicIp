#!/bin/sh

apt update
apt install -y openvpn iptables
tar -xvfz openvpn.tar.gz /etc

./init_route.sh

cp -f  ipp.txt /etc/openvpn
cp -d init_route.sh /etc
cp -f openvpn /etc/default
systemctl daemon-reload
service openvpn restart

cat <<EOF >/etc/rc.local

#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

bash /etc/init_route.sh

exit 0
EOF


