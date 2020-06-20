#! /bin/bash

loader='\\EFI\\debian\\vmlinuz.efi'
root="UUID=b2585805-4cb4-49de-b92d-f0670bfb7bb0"
initrd='\EFI\debian\initrd.img'
other="ro rootfstype=ext4"

bootorder="1,4,0"

num=$(efibootmgr | grep debian | cut -c5-8)
if [$num -eq ""]
then
	echo "No entry to be removed."
else
	echo "Removing old entry..."
	echo "efibootmgr -b $num -B"
	sudo efibootmgr -q -b $num -B
fi

parameters="'root=$root initrd=$initrd $other'"

echo
echo "Inserting new entry..."
echo "efibootmgr -q -c -p 2 -L debian -l $loader -u $parameters"
sudo efibootmgr -q -c -p 2 -L debian -l $loader -u $parameters

echo
echo "Setting the boot order..."
echo "efibootmgr -q -o $bootorder"
sudo efibootmgr -q -o $bootorder
