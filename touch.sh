#!/bin/sh
echo "---------start touch script------" >> /var/log/messages.log
chk_status=`ip addr | grep ens33 | wc -l`

if [ $chk_status == 3 ]
then
	while [ true ]
	do
		touch /var/log/moniter
		echo "--touch moniter--" >> /var/log/messages.log
		sleep <TOUCH_INTERVAL>
	done
fi
