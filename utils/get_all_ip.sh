#!/bin/sh

#GET all ip from providers interface
user_login='unpk@mail.ru'
user_pass='1234qwerR!'
tfile=$(mktemp /tmp/foo.XXXXXXXXX)
#echo $tfile
url="https://my.firstvds.ru/billmgr?authinfo=$user_login:$user_pass&out=xml&func=service.ip&elid=6983939"
#echo $url
curl -k -s $url > $tfile
#GET IP
sed 's/>/>\n/g' $tfile | grep '</name>' | sed 's/<.*>//g' > ip-new.txt
#GET IP
sed 's/>/>\n/g' $tfile | grep '</gateway>' | sed 's/<.*>//g' > ip-gw-new.txt


rm $tfile