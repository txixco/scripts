#! /bin/bash

# Script to chroot
#   $1: Boot partition
#   $2: EFI partition

sudo mount $1 /mnt
sudo mount $2 /mnt/boot/efi
for i in /dev /dev/pts /proc /sys; do sudo mount -B $i /mnt$i; done
sudo cp /etc/resolv.conf /mnt/etc/ #makes the network available after chrooting
modprobe efivars

sudo chroot /mnt

