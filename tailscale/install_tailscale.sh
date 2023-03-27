#!/bin/ash
#Petit script pour installer Tailscale facilement en semi auto
#
#zf230322.1928, zf230327.1721

echo ""
read -p "Attention il faut se trouver dans le dossier 'tailscale' !"

cp -r ./etc/ /

rm /usr/sbin/tailscale
#ln -s /mnt/sda1/tailscale/tailscale_1.38.1_mipsle/tailscale /usr/sbin/tailscale


exit






opkg update
opkg install tree htop nano sudo

cp -r ./openwrt/etc/ /

rm /usr/sbin/tailscale
ln -s /mnt/sda1/tailscale/tailscale_1.38.1_mipsle/tailscale /usr/sbin/tailscale

rm /usr/sbin/tailscaled
ln -s /mnt/sda1/tailscale/tailscale_1.38.1_mipsle/tailscaled /usr/sbin/tailscaled

echo 'net.ipv4.ip_forward = 1' | sudo tee /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf

/etc/init.d/tailscale stop
/etc/init.d/tailscale start

tailscale up --advertise-routes=192.168.0.0/24 --accept-routes --advertise-exit-nodeâ---netfilter-mode=off

echo -e "

Voila, c'est tout fait !
"

