#!/bin/bash

opensipsdbctl create <<EOF

EOF


sleep 1
groupadd opensips
sleep 2
useradd -g opensips opensips
sleep 3
chmod +x /etc/init.d/opensips
sleep 1



