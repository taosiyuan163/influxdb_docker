Version 1.0

FROM influxdb:1.1.4-alpine

MAINTAINER siyuan.tao taosiyuan163@163.com

RUN apk add ipvsadm --update && \
    apk add keepalived && \
    apk add bash && \
    apk add bash-doc && \
    apk add bash-completion && \
    apk add msmtp && \
    apk add mutt

RUN touch /var/log/messages.log
 
ADD KeepalivedEntrypoint.sh /

ADD keepalived.conf /etc/keepalived/

ADD start_influxdb.sh /

ADD chk_influxdb.sh /

ADD chk_local.sh /

ADD exe_chk_local.sh /

ADD link_conf.sh /

ADD master.sh /

ADD touch.sh /

ADD Muttrc /etc/

RUN chmod +x KeepalivedEntrypoint.sh && \
    chmod +x /start_influxdb.sh && \
    chmod +x /chk_influxdb.sh && \
    chmod +x /chk_local.sh && \
    chmod +x /exe_chk_local.sh && \
    chmod +x /link_conf.sh && \
    chmod +x /master.sh && \
    chmod +x /touch.sh
			

ENTRYPOINT ["sh"]
CMD ["KeepalivedEntrypoint.sh"]
