mkdir $1
mount -t drvfs \\\\$1\\C$ $1
mkdir -p $1/$2
umount $1
rmdir $1
