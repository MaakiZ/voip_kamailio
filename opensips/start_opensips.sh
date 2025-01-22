#!/bin/bash

# Substitute the values for PRESENCE_IP and IMS_DOMAIN in the configuration files
sed -i 's|PRESENCE_IP|'$PRESENCE_IP'|g' /etc/opensips/opensips.cfg
sleep 1
sed -i 's|IMS_DOMAIN|'$IMS_DOMAIN'|g' /etc/opensips/opensipsctlrc
sleep 1

# Restart syslog-ng if necessary (you may modify this depending on your logging setup)
# Not mandatory in Docker, but you can use it to log inside the container
/etc/init.d/syslog-ng restart
sleep 1

# Restart MySQL (in case it was not properly initialized or needs a restart)
# MySQL is required by OpenSIPS for storing registrations, presence, etc.
# Only restart if it's necessary. If OpenSIPS is handling the MySQL server internally, this is fine.
# If you are using Docker and have a separate MySQL container, you may not need to do this.
echo "Restarting MySQL..."
/etc/init.d/mysql restart
sleep 1

# Start OpenSIPS after MySQL is ready
opensipsctl start
sleep 1

# Tail OpenSIPS log for monitoring the process (you can change this to /var/log/opensips.log if that's the correct log file)
tail -f /var/log/opensips.log
