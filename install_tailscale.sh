#!/bin/ash
# Petit script pour installer Tailscale facilement en semi-automatique
#
# zf230322.1928, zf230920.1501, zf240403.1343

#TAILSCALE_VERSION='tailscale_1.48.2_mipsle'
#TAILSCALE_VERSION='tailscale_1.60.0_mipsle'
TAILSCALE_VERSION='tailscale_1.62.1_mipsle'



echo ""
read -p "Attention il faut se trouver dans le dossier 'tailscale' !"
read -p "Etes-vous certains ?"
echo ""

/etc/init.d/tailscale stop

opkg update
opkg install kmod-tun iptables-nft

cp -r ./etc/ /

mkdir bin
cd bin

wget https://pkgs.tailscale.com/stable/$TAILSCALE_VERSION.tgz
tar -zxvf $TAILSCALE_VERSION.tgz

rm -f /usr/sbin/tailscale
ln -s /mnt/sda1/mango/tailscale/bin/$TAILSCALE_VERSION/tailscale /usr/sbin/tailscale

rm -f /usr/sbin/tailscaled
ln -s /mnt/sda1/mango/tailscale/bin/$TAILSCALE_VERSION/tailscaled /usr/sbin/tailscaled

/etc/init.d/tailscale start
/etc/init.d/tailscale enable

#tailscale up
tailscale up --advertise-routes=192.168.0.0/24 --accept-routes --advertise-exit-node --netfilter-mode=off
#tailscale up --advertise-routes=192.168.0.0/24,192.168.58.0/24 --accept-routes --advertise-exit-node --netfilter-mode=off

echo -e "

Voila, c'est tout fait !
"




exit

echo 'net.ipv4.ip_forward = 1' | sudo tee /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf


