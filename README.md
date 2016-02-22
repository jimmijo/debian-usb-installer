# debian-usb-installer
A simple script used to create a debian bootable usb to install it.

## Install

`debian-usb-installer` has only one dependency. To install, run these commands as *root*:
```bash
# apt-get install jigdo-file
```
 Then you can *clone* the project:
```bash
$ git clone https://github.com/jimmijo/debian-usb-installer.git
$ cd debian-usb-installer
```

## Usage
 
```bash
# ./debian-usb-installer.sh --help
Usage: ./debian-usb-installer [OPTIONS]
OPTIONS:
    -h (--help):
        Display the usage.
    -u (--usb) USB;
        The usb where install the debian iso.
        This option is required.
    -r (--repository) URL:
        The repository where find the debian file.
    -d (--debian) VERSION:
        The debian version what you want.
    -a (--architecture) ARCHITECTURE:
        The architecture of debian what you want.
    -t (--type) TYPE:
        The type (cd or dvd) what you want.
```
 
## Example

Download the *cd* number *1* of debian *8.3.0* for architecture *amd64* and copy it on the usb key */dev/sdb*:
```bash
# fdisk -l | grep FAT
/dev/sdb1 XXXX XXXX XXXX XXXX XXXX FATXXX
# ./debian-usb-installer --usb /dev/sdb
        --repository "http://cdimage.debian.org/debian-cd/"
        --debian "8.3.0"
        --architecture "amd64"
        --type "cd:1"
```

## More

* `jigdo` documentation: http://www.tldp.org/HOWTO/Debian-Jigdo/
* Where find `jigdo` file for debian:
    * cd for *amd64*: http://cdimage.debian.org/debian-cd/current/amd64/jigdo-cd/
    * dvd for *amd64*: http://cdimage.debian.org/debian-cd/current/amd64/jigdo-dvd/
