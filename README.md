# alpine-mirage
A MirageOS development environment using VBox, Alpine Linux and Xen

## Manual Setup

### Prerequisites

* Virtual Box
* Alpine Xen 3.3.1 iso

### Create via terminal

```sh
# create host only network
VBoxManage hostonlyif create
# build vm from ISO
# attach HON to VM
# change boot order
# launch
```

### Setup VM internals
```sh
setup-xen-dom0
setup-alpine
# ensure ssh is ready http://wiki.alpinelinux.org/wiki/Setting_up_a_ssh-server
apk add bridge-utils git vim dnsmasq
# test xen
xl list
```

Setup network interfaces
```
# /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet manual
    pre-up ifconfig $IFACE up
    post-down ifconfig $IFACE down

auto br0
iface br0 inet static
    bridge_ports eth1
    address {{your host only network ip}}.5
    broadcast {{your host only network ip}}.255
    netmask 255.255.255.0
    # disable ageing (turn bridge into switch)
    up /sbin/brctl setageing br0 0
    # disable stp
    up /sbin/brctl stp br0 off
```

setup dnsmasq
```
# /etc/dnsmasq.conf
interface=br0
dhcp-range={{your host only network ip}}.150,{{your host only network ip}}.200,1h
```

setup ssh
```
# /etc/ssh/sshd_config
PermitRootLogin yes
```

reboot
### SSH in and set-up mirage env
```sh
ssh root@{{your host only network ip}}.5
```

### SSH in and build mirage skeleton, static
```sh
# hello mirage world
```

### Steps

1. Install Alpine Linux, Xen ISO
   ```sh
   setup-xen-dom0
   setup-alpine
   ```
2. Configure Bridge
3. Install and configure dnsmasq
4. Make it possible to ssh into dom0

## Resources

* [Alpine Xen Dom0](http://wiki.alpinelinux.org/wiki/Xen_Dom0)
* [Alpine install to disk](http://wiki.alpinelinux.org/wiki/Install_to_disk)
* [Alpine, getting started](http://alpine-linux.readthedocs.org/en/latest/getting_started.html)
* [Alpine downloads](http://alpinelinux.org/downloads/)
* [Local MirageOS development with Xen and Virtualbox](http://www.skjegstad.com/blog/2015/01/19/mirageos-xen-virtualbox/)
* [Xen Dom0](http://wiki.alpinelinux.org/wiki/Xen_Dom0)
* [configure a network bridge](http://wiki.alpinelinux.org/wiki/Bridge)
* [http://wiki.alpinelinux.org/wiki/Setting_up_a_ssh-server](http://wiki.alpinelinux.org/wiki/Setting_up_a_ssh-server)
* [Creating a virtual machine using the VirtualBox CLI](http://cheznick.net/main/content/creating-a-virtual-machine-using-the-virtualbox-cli)
