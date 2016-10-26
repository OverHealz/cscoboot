#!/bin/bash

echo "Enter the filename of the non-bootable ISO e.g. UCSInstall_UCOS_10.5.1.10000-7.sgn.iso"
read -r isoname

if [ ! -f "$isoname" ]; then
echo "This script must be run from the same directory as the ISO or you need to specify the full path name"
exit
else

sudo mkdir /mnt/iso
sudo mkdir /tmp/BootableISO
echo "Mounting non-bootable ISO..."
sudo mount -o loop "$isoname" /mnt/iso

echo "Copying data from ISO to tmp directory..."
rsync -a /mnt/iso /tmp/BootableISO

if [ -d /tmp/BootableISO/iso ]; then
cd /tmp/BootableISO/iso
else
cd /tmp/BootableISO
fi

echo "Creating new bootable ISO using data from tmp directory..."
mkisofs -o /tmp/Bootable_"$isoname" -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R .
sudo umount -l /mnt/iso
rm -rf /tmp/BootableISO

fi
