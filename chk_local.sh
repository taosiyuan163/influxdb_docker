#!/bin/bash
#CHK_IP=`awk '/^CHK_IP/{print $2}' /container_conf/container.conf`
#CHK_GATEWAY=`awk '/^CHK_GATEWAY/{print $2}' /container_conf/container.conf`
FAILURES_COUNT=0
for ((i=0;i<3;i++))
do
	if  ping -c 1 <CHK_GATEWAY> > /dev/null
	then
	echo "connection gateway succeed" >> /var/log/messages.log
		break
	else
	sleep 0.4
	echo "=>>cannot connection gateway,try to reconnection " >> /var/log/messages.log
	echo "连接网关异常..尝试重试连接.." |mutt -s "WARNING" <EMAIL_ADDRESS>
		let "FAILURES_COUNT++"
	fi
done

if (( $FAILURES_COUNT >= 2 ))
then
	echo "连接网关失败，执行退出docker容器" |mutt -s "CRIT" <EMAIL_ADDRESS>
	echo "==>>connection gateway false , exit container" >> /var/log/messages.log
	ps -ef | grep keepalived | awk '{print $1}'|xargs kill -9	
fi
