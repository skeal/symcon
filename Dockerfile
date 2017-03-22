# -----------------------------------------------------------------------------
# skeal/symcon
#
# docker build -f Dockerfile -t skeal/symcon .
#
# 
# 2017-02-18 : Update to IP-Symcon Version 4.1
#
# 2015-07-19 : Removed Installation of mc
# 2015-07-16 : Removed EXPOSE use option --net="host" instead 
# 2015-07-05 : Added Volume "/usr/share/symcon"
#              Added Copy "/usr/share/symcon"
#              Changed Volume "/root"
#              Added Copy "/root"
#
# 2015-07-02 : Init Project
# -----------------------------------------------------------------------------

FROM ubuntu:16.04

MAINTAINER Thomas Klupp <daklupp@yahoo.com>

# Skip install dialogues
ENV DEBIAN_FRONTEND noninteractive
# Set Home-Directory
ENV HOME /

RUN \
    apt-get update &&\
    apt-get -y upgrade &&\
    apt-get -y install wget
    
RUN \
    echo "deb [arch=amd64] http://apt.symcon.de/ stable ubuntu" >> /etc/apt/sources.list &&\
    wget -qO - http://apt.symcon.de/symcon.key | apt-key add - &&\
    apt-get update

RUN \
    apt-get -y install mc symcon
    
RUN \
    cp -R /usr/share/symcon /usr/share/symcon.org &&\
    cp -R /var/lib/symcon /var/lib/symcon.org &&\
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

COPY symcon_start.sh /usr/bin/
RUN \
    chmod 775 /usr/bin/symcon_start.sh

VOLUME \
    /usr/share/symcon \
    /var/lib/symcon \
    /var/log/symcon \
    /root

CMD ["/usr/bin/symcon_start.sh"]
