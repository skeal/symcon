# -----------------------------------------------------------------------------
# blockmove/symcon
#
# docker build -f Dockerfile -t blockmove/symcon .
#
#
# 2015-07-05 : Added Volume "/usr/share/symcon"
#              Added Copy "/usr/share/symcon"
#              Changed Volume "/root"
#              Added Copy "/root"
#
# 2015-07-02 : Init Project
# -----------------------------------------------------------------------------

FROM ubuntu:14.04

MAINTAINER Dieter Poesl <doc@poesl-online.de>

# Skip install dialogues
ENV DEBIAN_FRONTEND noninteractive
# Set Home-Directory
ENV HOME /

RUN \
    apt-get update &&\
    apt-get -y upgrade &&\
    apt-get -y install libedit2 php5-cli php5-readline php5-imap wget
    
RUN \
    echo "deb [arch=amd64] http://apt.ip-symcon.de/ stable main" >> /etc/apt/sources.list &&\
    wget -qO - http://apt.ip-symcon.de/symcon.key | apt-key add - &&\
    apt-get update

RUN \
    apt-get -y install symcon

RUN \
    apt-get -y install mc
    
RUN \
    cp -R /etc/symcon /etc/symcon.org &&\
    cp -R /usr/share/symcon /usr/share/symcon.org &&\
    cp -R /root /root.org
    
#Clean-Up    
RUN \
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
    
#Setup locale
#Change to your location
RUN \
    locale-gen de_DE.UTF-8 &&\
    locale-gen en_US.UTF-8 &&\
    dpkg-reconfigure locales

#Setup timezone
#Change for your timezone
RUN echo "Europe/Berlin" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata

COPY symcon_start.sh /usr/bin/
RUN \
    chmod 775 /usr/bin/symcon_start.sh

#Ports for IP-Symcon
#Port 3777  Webinterface and Configuration for IPS
#Port 5544  Homematic
EXPOSE 3777 5544

VOLUME \
    /etc/symcon \
    /usr/share/symcon \
    /root

CMD ["/usr/bin/symcon_start.sh"]
