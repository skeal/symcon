#!/bin/sh

# ---------------
# Start IP-Symcon
#
# 2015-07-05: Added test if configuration in "/usr/share/symcon" exit
# ---------------

#test if configuration in /etc/symcom exits.
#if not -> copy template files
if [ -e /etc/logo.ico ]; then
    echo "Config /etc exists"
else
    echo "Config /etc not exists "
    echo "Copy template files "
    cp -R /etc/symcon.org/* /etc/symcon
fi

#test if configuration in /usr/share/symcom exits.
#if not -> copy template files
if [ -e /usr/share/symcon/settings.json ]; then
    echo "Config /usr/share exists"
else
    echo "Config /usr/share not exists "
    echo "Copy template files "
    cp -R /usr/share/symcon.org/* /usr/share/symcon
fi

echo "Start IP-Symcon"
/usr/bin/symcon
