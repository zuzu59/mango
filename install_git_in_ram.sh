#!/bin/ash
# Petit script pour installer facilement git dans la RAM afin de ne pas utiliser la FLASH
# Utilie surtout après un reboot quand on veut pusher un commit !
#zf230327.1803, zf230423.2050

echo ""
read -p "Attention il faut faire source ./install_git_in_ram.sh !"
read -p "Etes-vous certains ?"
echo ""

opkg update
opkg install zlib
opkg -d ram install git
ln -s /tmp/usr/bin/git /usr/bin/git

source ./alias
ash ./env_git_a_zuzu.sh

