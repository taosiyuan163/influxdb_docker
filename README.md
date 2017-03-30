# 时序数据库influxdb双机热备，包含 HA高可用，脑裂判定，邮件预警等功能
任务提交脚本：
docker run  --privileged=true \
            --net=host \
            --name influxdb_activated \
            -e CHK_INFLUXDB_INTERVAL=2 \
            -e CHK_LOACAL_INTERVAL=5 \
            -e TOUCH_INTERVAL=1 \
            -e INTERFACE=ens33 \
            -e PREEMPTION=nopreempt \
            -e PRIORITY=100 \
            -e VIRTUAL_IP=192.168.190.100 \
            -e REAL_SERVER1=192.168.190.16 \
            -e REAL_SERVER2=192.168.190.17 \
            -e CHK_IP=www.baidu.com \
            -e CHK_GATEWAY=192.168.190.2 \
            -e EMAIL_FROM=NODE_1.COM \
            -e NODE_TAG=NODE_1 \
            -e EMAIL_ADDRESS=taosiyuan163@163.com \
            -v /opt/influxdb_data:/var/lib/influxdb \
            -v /opt/influxdb_log:/var/log \
            -d taosiyuan/influxdb:1.0
