# -----------------------------------------------------------------------------
# blockmove/symcon
#
# docker build -f Dockerfile -t blockmove/symcon .
#
# 2017-03-21 : Update to testing Branch 4.2
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

FROM phusion/baseimage:latest

MAINTAINER Dieter Poesl <doc@poesl-online.de>

# Skip install dialogues
# ENV DEBIAN_FRONTEND noninteractive
# Set Home-Directory
ENV HOME /

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i de_DE -c -f UTF-8 -A /usr/share/locale/locale.alias de_DE.UTF-8
ENV LANG de_DE.utf8

RUN \
    apt-get -y upgrade &&\
    apt-get -y install wget
    
RUN \
    echo "deb [arch=amd64] http://apt.symcon.de/ testing ubuntu" >> /etc/apt/sources.list &&\
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


COPY symcon_start.sh /usr/bin/
RUN \
    chmod 775 /usr/bin/symcon_start.sh

VOLUME \
    /usr/share/symcon \
    /var/lib/symcon \
    /var/log/symcon \
    /root

CMD ["/usr/bin/symcon_start.sh"]
