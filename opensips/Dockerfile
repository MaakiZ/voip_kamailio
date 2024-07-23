FROM biohpc/ubuntudev

ENV DEBIAN_FRONTEND=noninteractive

# Install updates and dependencies
RUN apt-get update && \
	apt-get -y install syslog-ng syslog-ng-core tcpdump screen tmux ntp ntpdate git-core dkms \
					gcc flex bison libmysqlclient-dev make libssl-dev libcurl4-openssl-dev \
					libxml2-dev libpcre3-dev bash-completion g++ autoconf libmnl-dev \
					libsctp-dev libradcli-dev libradcli4 libjson-c-dev pkg-config iproute2 net-tools \
					iputils-ping

#Fix SYSLOG ERROR
RUN echo 'SYSLOGNG_OPTS="--no-caps"' >> /etc/default/syslog-ng

# Install opensips & modules
RUN apt-get -y install mysql-server ca-certificates && \
    apt -y install opensips && \
    apt -y install opensips-mysql-module && \
    apt -y install opensips-cpl-module   && \
    apt -y install opensips-presence-modules  && \
    apt -y install opensips-xmlrpc-module && \
    apt -y install opensips-perl-modules && \
    apt -y install opensips-snmpstats-module && \
    apt -y install opensips-xmpp-module && \
    apt -y install opensips-carrierroute-module && \
    apt -y install opensips-jabber-module 

RUN rm -rf /etc/opensips/*
COPY opensips/ /etc/opensips/

RUN echo "[mysqld]" >> /etc/mysql/my.cnf && \
    echo 'sql-mode="NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"' >> /etc/mysql/my.cnf 

RUN /etc/init.d/mysql stop

RUN rm -rf /etc/default/opensips && \
    rm -rf /etc/init.d/opensips && \
    rm -rf /var/run/opensips

COPY opensips/DEFAULT/ /etc/default/
COPY opensips/init.d/ /etc/init.d

ADD opensips_init.sh /usr/local/opensips_init.sh
RUN chmod 755 /usr/local/opensips_init.sh

RUN /etc/init.d/mysql start && \
    /usr/local/opensips_init.sh

EXPOSE 5065/udp

ADD start_opensips.sh /usr/local/start_opensips.sh
RUN chmod 755 /usr/local/start_opensips.sh

RUN /etc/init.d/mysql restart
    
CMD /usr/local/start_opensips.sh
