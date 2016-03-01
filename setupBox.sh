#! /bin/bash

rm -fr ~/VirtualBox\ VMs/alpine-mirage
mkdir ~/VirtualBox\ VMs/alpine-mirage
VBoxManage createhd \
    --filename ~/VirtualBox\ VMs/alpine-mirage/alpine-mirage.vdi --variant Fixed --size 5120
VBoxManage createvm \
    --name alpine-mirage --ostype Linux_64 --register
VBoxManage storagectl \
    alpine-mirage --name "SATA Controller" --add sata  --controller IntelAHCI;
VBoxManage storageattach \
    alpine-mirage --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium ~/VirtualBox\ VMs/alpine-mirage/alpine-mirage.vdi;
VBoxManage storagectl \
    alpine-mirage --name "IDE Controller" --add ide;
VBoxManage storageattach \
    alpine-mirage --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium ~/mirage-downloads/alpine-xen-3.3.1-x86_64.iso;
VBoxManage modifyvm \
    alpine-mirage --memory 1024
vBoxManage startvm \
    alpine-mirage
## THEN do setup in vm
## TEN DISABLE IDE controller


