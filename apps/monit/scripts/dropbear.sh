#!/bin/sh
#
# Script: dropbear.sh
# Author: Simon H Moore <simon@simonhugh.xyz>
# License: MIT License
# Description: This script starts or stops the Dropbear SSH server.
#              When started, it listens on port 8022 and updates firewall rules to allow incoming connections
#              When stopped, it kills the Dropbear service and resets the firewall

case "$1" in
	start)
		/usr/sbin/dropbear -R -p 8022
		iptables -I INPUT 1 -p tcp --dport 8022 -j ACCEPT
		;;
	stop)
		/bin/kill `cat /var/run/dropbear.pid`
		/etc/rc.d/rc.firewall start
		;;
esac
