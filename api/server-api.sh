#!/bin/sh

socat \
    -v -d -d \
    TCP-LISTEN:80,crlf,reuseaddr,fork \
    SYSTEM:"
        echo HTTP/1.1 401 Unauthorized; 
        echo Content-Type\: text/plain; 
        echo \"WWW-Authenticate: Basic realm=\"User Visible Realm\"\";
	echo;
        echo;
	cat | parse-api.sh;
	
    "