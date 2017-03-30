#!/bin/bash
echo "start chk_influxdb script" >> /var/log/messages.log
chk_status=`ip addr | grep ens33 | wc -l`
if (( $chk_status == 3 ))
then
echo "VIP is activated" >> /var/log/messages.log
   inspection=`netstat -aln | grep 8088 | wc -l`
	if (( $inspection == 0 ))
	then
	echo "inluxdb is dead" >> /var/log/messages.log
		chk_count=0
             	while (( $chk_count < 3 ))
                	do
			echo "influxdb进程已挂掉，正在尝试重启..." |mutt -s "WARNING" <EMAIL_ADDRESS>
                        	/start_influxdb.sh
				echo "restarting influxdb process " >> /var/log/messages.log
                        	sleep 1
#echo "====chk_count++前====" >> /var/log/tt
#echo $chk_count >> /var/log/tt
                        	inspection=`netstat -aln | grep 8088 | wc -l`
        			if (( $inspection ==0 ))
                        	then
                        		((chk_count++))
#echo "====chk_count++后====" >> /var/log/tt
#echo $chk_count >> /var/log/tt
						if (( $chk_count ==2 ))
						then
							echo "influxdb进程无法正常运行,执行退出docker容器" |mutt -s "CRIT" <EMAIL_ADDRESS>
                        				echo "stop keepalived process" >> /var/log/messages.log
							ps -ef | grep keepalived | awk '{print $1}'|xargs kill -9
						fi		
                        	else
                        			echo "the influxdb is restarted" >> /var/log/messages.log
						break
                        	fi
                	done
	else
	echo "the influxdb is steady running" >> /var/log/messages.log
	fi
fi
