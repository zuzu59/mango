#!/bin/ash
# Petit script pour installer le réflecteur mDNS
#
# zf240701.1448

# installation du réflecteur mDNS
opkg update
opkg install avahi-utils

# configuration du réflecteur mDNS
sed -i -e "s/enable-reflector\=no/enable-reflector\=yes/g" /etc/avahi/avahi-daemon.conf
/etc/init.d/dbus restart
/etc/init.d/dbus enable
/etc/init.d/avahi-daemon restart
/etc/init.d/avahi-daemon enable

echo -e "

Voila, c'est tout fait !
"
