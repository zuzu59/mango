#!/bin/ash
#Petit script pour installer Tailscale facilement en semi auto
#
#zf230322.1928, zf230327.1826

echo ""
read -p "Attention il faut se trouver dans le dossier 'tailscale' !"
read -p "Vous êtes sûr ?"
echo ""

opkg install kmod-tun iptables-nft

cp -r ./etc/ /

mkdir bin
cd bin

wget https://pkgs.tailscale.com/stable/tailscale_1.38.2_mipsle.tgz
tar -zxvf tailscale_1.38.2_mipsle.tgz

rm -f /usr/sbin/tailscale
ln -s /mnt/sda1/mango/tailscale/bin/tailscale_1.38.2_mipsle/tailscale /usr/sbin/tailscale

rm -f /usr/sbin/tailscaled
ln -s /mnt/sda1/mango/tailscale/bin/tailscale_1.38.2_mipsle/tailscaled /usr/sbin/tailscaled

/etc/init.d/tailscale stop
/etc/init.d/tailscale start

tailscale up --advertise-routes=192.168.0.0/24 --accept-routes --advertise-exit-node --netfilter-mode=off

echo -e "

Voila, c'est tout fait !
"




exit


echo 'net.ipv4.ip_forward = 1' | sudo tee /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf


