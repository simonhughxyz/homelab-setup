#!/bin/sh
#
# Script: public-ip.sh
# Author: Simon H Moore <simon@simonhugh.xyz>
# License: MIT License
# Description: This script checks the public IP address of the machine and
#              compares it with a predefined IP. If they differ, it exits with 1.

ip="217.155.142.212"

curl_ip="$( /usr/bin/curl -s https://ifconfig.me )"

echo "IP = $ip"
echo "Public IP = $curl_ip"

[ "$ip" != "$curl_ip" ] && exit 1
exit 0
