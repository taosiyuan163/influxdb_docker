#!/bin/sh
#CHK_INFLUXDB_INTERVAL=`awk '/^CHK_INFLUXDB_INTERVAL/{print $2}' /opt/container_conf/container.conf`
#CHK_LOACAL_INTERVAL=`awk '/^CHK_LOACAL_INTERVAL/{print $2}' /opt/container_conf/container.conf`
#INTERFACE=`awk '/^INTERFACE/{print $2}' /opt/container_conf/container.conf`
#PREEMPTION=`awk '/^PREEMPTION/{print $2}' /opt/container_conf/container.conf`
#PRIORITY=`awk '/^PRIORITY/{print $2}' /opt/container_conf/container.conf`
#VIRTUAL_IP=`awk '/^VIRTUAL_IP/{print $2}' /opt/container_conf/container.conf`
#REAL_SERVER1=`awk '/^REAL_SERVER1/{print $2}' /opt/container_conf/container.conf`
#REAL_SERVER2=`awk '/^REAL_SERVER2/{print $2}' /opt/container_conf/container.conf`
#CHK_IP=`awk '/^CHK_IP/{print $2}' /opt/container_conf/container.conf`
#CHK_GATEWAY=`awk '/^CHK_GATEWAY/{print $2}' /opt/container_conf/container.conf`

echo "=> Configuring Keepalived" >> /var/log/messages.log

sed -i -e "s/<CHK_INFLUXDB_INTERVAL>/${CHK_INFLUXDB_INTERVAL}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<CHK_LOACAL_INTERVAL>/${CHK_LOACAL_INTERVAL}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<TOUCH_INTERVAL>/${TOUCH_INTERVAL}/g" /touch.sh
sed -i -e "s/<INTERFACE>/${INTERFACE}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<PREEMPTION>/${PREEMPTION}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<PRIORITY>/${PRIORITY}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<VIRTUAL_IP>/${VIRTUAL_IP}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<REAL_SERVER1>/${REAL_SERVER1}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<REAL_SERVER2>/${REAL_SERVER2}/g" /etc/keepalived/keepalived.conf

echo "=> Configuring Email-Alert" >> /var/log/messages.log

sed -i -e "s/<EMAIL_FROM>/${EMAIL_FROM}/g" /etc/Muttrc
sed -i -e "s/<NODE_TAG>/${NODE_TAG}/g" /etc/Muttrc
sed -i -e "s/<EMAIL_ADDRESS>/${EMAIL_ADDRESS}/g" /chk_influxdb.sh
sed -i -e "s/<EMAIL_ADDRESS>/${EMAIL_ADDRESS}/g" /master.sh
sed -i -e "s/<EMAIL_ADDRESS>/${EMAIL_ADDRESS}/g" /chk_local.sh

echo "=> Configuring CheckLocalScript" >> /var/log/messages.log

sed -i -e "s/<CHK_IP>/${CHK_IP}/g" /chk_local.sh
sed -i -e "s/<CHK_GATEWAY>/${CHK_GATEWAY}/g" /chk_local.sh

echo "=> Done!" >> /var/log/messages.log
