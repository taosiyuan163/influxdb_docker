#!/bin/sh
echo "start KeepalivedEntrypoint script " >> /var/log/messages.log
echo "kill infuxd process at first" >> /var/log/messages.log
ps -ef | grep influxd | awk '{print $1}'|xargs kill -9

#modprobe ip_vs
echo "start link_conf.sh" >> /var/log/messages.log
/link_conf.sh

echo "start keepalived" >> /var/log/messages.log
keepalived -f /etc/keepalived/keepalived.conf --dont-fork --log-console
