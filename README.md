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
```

Make a note of the name "vboxnet{{n}}".

Modify _setupBox.sh_ to point to your Alpine Xen image.

```sh
./setupBox.sh
```

In VM, login at root (no password).
```sh
setup-xen-dom0
setup-alpine
# follow defaults and add password
# use _sda_
# in _sys_
# say yes, it will write OS to HD
# test xen
xl list
poweroff
```

Open Virtual Box app > virtual-box menu > preferences > network >
host only network

Select the network created in the previous step and edit. Copy the IP
address. Cancel and close.

Open settings on "alpine-mirage" VM > network > adaptor 2 > Enable network adaptor > host only adaptor > vboxnet{{n}}

Then in VirtualBox app, VM settings > system > boot order > disable all but "Hard Disk".

Start VM again and login as root.

```sh
apk add vim git sudo bridge-utils dnsmasq
```

Edit /etc/apk/repositories and uncomment "_edge_" and "testing" repos.

```sh
apk update
apk upgrade --update-cache --available
git clone https://github.com/rudenoise/alpine-mirage.git
cd alpine-mirage
./setupMirageUser.sh
# visudo and uncomment %wheel All...
./alpine
exit
```

Test login as _mirage_ user, exit and back in as root.

Setup network interfaces.

Edit, replacing {{your host only network ip}}. Then put them in place.
```sh
cp interfaces /etc/network/interfaces
cp dnsmasq.conf /etc/dnsmasq.conf
poweroff
```

Start the VM in headless mode and SSH in and set-up mirage env

```sh
ssh mirage@{{your host only network ip}}.5
```

```sh
sudo apk add ocaml
git clone https://github.com/rudenoise/alpine-mirage.git
cd alpine-mirage
./opam.sh
reboot
```

## Delete

In Virtual Box app, make sure VM is stopped and "remove".

Then remove host only network.

```sh
VBoxManage hostonlyif remove "vboxnet{{n}}" 
```

## To Do

1. Work out mirage installation dependency issues
   (via aspcud or PackUP neither available via apk)
2. Add host-only network to VM via VBoxManage
3. Remove VM and HON script
4. Make scripts parameterised and add VMs to host's hosts
5. Create mirage setup script

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
