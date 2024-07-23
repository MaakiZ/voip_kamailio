#!/bin/bash
sed -i 's|PRESENCE_IP|'$PRESENCE_IP'|g' /etc/opensips/opensips.cfg
sleep 1
sed -i 's|IMS_DOMAIN|'$IMS_DOMAIN'|g' /etc/opensips/opensipsctlrc
sleep 1
/etc/init.d/syslog-ng restart
sleep 1
/etc/init.d/mysql restart 
sleep 1
opensipsctl start
sleep 1
tail -f /var/log/syslog 
