#!/bin/ash
#Petit script pour installer facilement git dans la RAM afin de ne pas utiliser la FLASH
#
#zf230327.1803

#opkg update

opkg install zlib
opkg -d ram install git
ln -s /tmp/usr/bin/git /usr/bin/git

