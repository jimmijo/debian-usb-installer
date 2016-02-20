#!/usr/bin/env bash

DEFAULT_REPOSITORY_DEBIAN="http://cdimage.debian.org/debian-cd/"
DEFAULT_VERSION_DEBIAN="8.3.0"
DEFAULT_ARCHITECTURE_DEBIAN="amd64"
DEFAULT_TYPE_DEBIAN="dvd1"

function usage {
    cat <<EOF
=============================================================================
debian-usb-installer:
A simple script used to create a debian bootable usb to install it.
-------
Usage: ./debian-usb-installer [OPTIONS] USB
-------
OPTIONS:
    -h (--help):
        Display the usage.
    -r (--repository) URL:
        The repository where find the debian file.
        By default: ${DEFAULT_REPOSITORY_DEBIAN}
    -d (--debian) VERSION:
        The debian version what you want.
        By default: ${DEFAULT_VERSION_DEBIAN}
    -a (--architecture) ARCHITECTURE:
        The architecture of debian what you want.
        By default: ${DEFAULT_ARCHITECTURE_DEBIAN}
    -t (--type) TYPE:
        The type (cd or dvd) what you want.
        By default: ${DEFAULT_TYPE_DEBIAN}
-------
Example:
# fdisk -l | grep FAT
/dev/sdb1 XXXX XXXX XXXX XXXX XXXX FATXXX
# ./debian-usb-installer /dev/sdb
        --repository http://cdimage.debian.org/debian-cd/
        --debian 8.3.0
        --architecture amd64
        --type dvd1
EOF
}

function init {
    # TODO
}

function parseCli {
    # TODO
}

function checkUsb {
    # TODO
}

function downloadDebian {
    # TODO
}

function copyDebianToUsb {
    # TODO
}