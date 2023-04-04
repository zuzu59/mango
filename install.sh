#!/bin/ash
# Petit script pour installer un mini routeur MANGO facilement
#
# zf230327.1616, zf230404.1354

# installation des outils de base minimum
opkg update
opkg install tree htop nano-full

# installation et configuration du montage de la clef USB automatiquement lors du boot
opkg install block-mount e2fsprogs kmod-fs-ext4 kmod-usb-storage kmod-usb2 kmod-usb3 usbutils gdisk

block detect | uci import fstab
uci set fstab.@mount[0].enabled='1' && uci set fstab.@global[0].anon_mount='1' && uci commit fstab
/etc/init.d/fstab boot

# installation des outils intéressants (SFTP, Relayd)
opkg install openssh-sftp-avahi-service luci-proto-relay


echo -e "

Voila, c'est tout fait !
"

echo ""
read -p "Attention, il faut encore rebooter maintenant (IMPORTANT) !"
reboot
