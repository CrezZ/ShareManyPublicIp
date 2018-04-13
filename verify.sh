#!/bin/sh
## format: username:password username:password ...
## you can even have same usernames with different passwords
# USERS='user1:pass1 user2:pass2 user3:pass3'
## you could put username:password in
## a separate file and read it like this
#USERS=`cat /etc/openvpn/user.pass`
vpn_verify() {
if [ ! $1 ] || [ ! $2 ]; then
#echo "No username or password: $*"
exit 1
fi
## it can also be done with grep or sed
for i in $USERS; do
if [ "$i" = "$1:$2" ]; then
## you can add here logging of users
## if you have enough space for log file
#echo `date` $1:$2 >> your_log_file
exit 0
fi
done
}
if [ ! $1 ] || [ ! -e $1 ]; then
#echo "No file"
exit 1
fi
## $1 is file name which contains
## passed username and password
#vpn_verify `cat $1`
#echo "No user with this password found"
exit 0