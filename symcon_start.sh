#!/bin/sh

# ---------------
# Start IP-Symcon
# ---------------

#test if configuration in /etc/symcom exits.
#if not -> copy template files
if [ -e /etc/logo.ico ]; then
    echo "Config exists"
else
    echo "Config not exists "
    echo "Copy template files "
    cp -R /etc/symcon.org/* /etc/symcon
fi

echo "Start IP-Symcon"
/usr/bin/symcon
