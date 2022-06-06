#! /bin/bash

for i in /sys /proc /dev/pts /dev; do sudo umount /mnt$i; done
sudo umount /mnt/boot/efi
sudo umount /mnt

