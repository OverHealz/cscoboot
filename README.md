# cscoboot

A very simple bash script that converts non-bootable Cisco UC ISO files to bootable ISO files e.g. CUCM, CUPS, CUC and UCCX.

## Dependencies

* rsync
* mkisofs

## How it works

This script mounts the non bootable ISO and rsync's it to a temporary directory. It then uses mkisofs to generate and ISO with the El Torito boot image and boot catalog.
