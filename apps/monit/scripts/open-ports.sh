#!/bin/sh
#
# Script: open-ports.sh
# Author: Simon H Moore <simon@simonhugh.xyz>
# License: MIT License
# Description: This script checks open ports on a predefined IP using nmap.
#              If any ports other than 8089/tcp are open, it exits with 1.

ip="217.155.142.212"

ports="$( /usr/bin/nmap "$ip" )"

echo "$ports"

echo "$ports" | grep -v "8089/tcp" \
	| grep -q "open" && exit 1
exit 0
