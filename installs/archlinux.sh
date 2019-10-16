pacstrap /mnt base linux linux-firmware vim grub dhcpcd git
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt <<CHROOT

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

echo "de_DE.UTF-8 UTF-8" > /etc/locale.gen
echo "LANG=de_DE.UTF-8" > /etc/locale.conf
echo "KEYMAP=de-latin1" > /etc/vconsole.conf

locale-gen

echo "archibald" > /etc/hostname
cat <<EOF > /etc/hosts
127.0.0.1 archibald
::1  archibald
EOF
mkinitcpio -P

grub-install /dev/sda --force
grub-mkconfig -o /boot/grub/grub.cfg

CHROOT
