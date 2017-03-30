#!/bin/sh

insepction=`netstat -aln | grep 8088 | wc -l`
if [ $insepction == 0 ]
then
echo "starting influxd process" >> /var/log/messages.log
nohup influxd run &
fi
