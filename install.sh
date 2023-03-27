#!/bin/ash
#Petit script pour installer un mini routeur MANGO facilement
#
#zf230327.1616

# installation des outils de base minimum
opkg update
opkg install tree htop nano-full

# installation du montage de la clef USB automatiquement lros du boot
opkg install block-mount e2fsprogs kmod-fs-ext4 kmod-usb-storage kmod-usb2 kmod-usb3
block detect | uci import fstab
uci set fstab.@mount[0].enabled='1' && uci set fstab.@global[0].anon_mount='1' && uci commit fstab
/etc/init.d/fstab boot




exit






echo ""
read -p "Attention il faut se trouver dans le dossier 'tailscale' !"

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

