#!/bin/sh
echo " =========master.sh=========" >> /var/log/messages.log
echo "正在尝试切换节点状态为master........" |mutt -s "WARNING" <EMAIL_ADDRESS>

sleep 2

	FIRST_CHK_DATE=`stat -c %Y /var/log/moniter | cut -c 9-10`
	sleep 1.4
	SECOND_CHK_DATE=`stat -c %Y /var/log/moniter | cut -c 9-10`
	sleep 1.6
	THIRD_CHK_DATE=`stat -c %Y /var/log/moniter | cut -c 9-10`

	if [[ $FIRST_CHK_DATE == $SECOND_CHK_DATE -a $SECOND_CHK_DATE == $THIRD_CHK_DATE ]]
	then
	echo "==>changed state to master" >> /var/log/messages.log
	echo "master 状态切换成功........" |mutt -s "WARNING" <EMAIL_ADDRESS>
		/start_influxdb.sh
		/touch.sh
	else
	echo "master 状态切换失败，探测到脑裂现象，执行退出docker容器" |mutt -s "CRIT" <EMAIL_ADDRESS>
	echo " ==> find split-brain , kill own keeplaived process" >> /var/log/messages.log
	ps -ef | grep keepalived | awk '{print $1}'|xargs kill -9
	fi
