#!/bin/bash

echo "Enter the filename of the non-bootable ISO e.g. UCSInstall_UCOS_10.5.1.10000-7.sgn.iso"
read -r isoname

if [ ! -f "$isoname" ]; then
echo "This script must be run from the same directory as the ISO or you need to specify the full path name"
exit
else


sudo mkdir -p ~/mnt/iso
sudo mkdir -p ~/tmp/BootableISO/iso
echo "Mounting non-bootable ISO..."
# sudo mount -o loop "$isoname" ~/mnt/iso
sudo hdiutil attach "$isoname" -mountroot ~/mnt/iso

echo "Copying data from ISO to tmp directory..."
sudo rsync -a ~/mnt/iso ~/tmp/BootableISO

if [ -d ~/tmp/BootableISO/iso ]; then
	cd ~/tmp/BootableISO/iso/CDROM
else
	cd ~/tmp/BootableISO
fi

echo "Creating new bootable ISO using data from tmp directory..."
sudo mkisofs -o ~/tmp/Bootable_"$isoname" -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R .

echo "Unmouting and removing data. File will be in /tmp/BootableISO folder."
sudo hdiutil unmount ~/mnt/iso/CDROM
cd ~/tmp/
sudo rm -rf ~/tmp/BootableISO
sudo rm -rf ~/mnt

fi
