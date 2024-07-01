#!/bin/ash
# Petit script pour installer un mini routeur MANGO facilement
#
# zf230327.1616, zf230411.1423, zf240701.1433

# installation des outils de base minimum
opkg update
opkg install tree htop nano-full bash diffutils

# installation et configuration du montage de la clef USB automatiquement lors du boot
opkg install block-mount e2fsprogs kmod-fs-ext4 kmod-usb-storage kmod-usb2 kmod-usb3 usbutils gdisk kmod-usb-storage-uas

block detect | uci import fstab
uci set fstab.@mount[0].enabled='1' && uci set fstab.@global[0].anon_mount='1' && uci commit fstab
/etc/init.d/fstab boot

# installation des outils intéressants (SFTP, Relayd, Upgrade Attended Sysupgrade)
# opkg install openssh-sftp-avahi-service luci-proto-relay luci-app-attendedsysupgrade dbus

# installation des outils intéressants (Upgrade Attended Sysupgrade)
opkg install luci-app-attendedsysupgrade

# configuration du réflecteur mDNS
#sed -i -e "s/enable-reflector\=no/enable-reflector\=yes/g" /etc/avahi/avahi-daemon.conf
#/etc/init.d/dbus start
#/etc/init.d/dbus enable
#/etc/init.d/avahi-daemon start
#/etc/init.d/avahi-daemon enable




echo -e "

Voila, c'est tout fait !
"

echo ""
read -p "Attention, il faut encore rebooter maintenant (IMPORTANT) !"
reboot
