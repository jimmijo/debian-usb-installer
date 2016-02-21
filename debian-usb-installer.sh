#!/usr/bin/env bash

USB="no"
REPOSITORY_DEBIAN="http://cdimage.debian.org/debian-cd/"
VERSION_DEBIAN="8.3.0"
ARCHITECTURE_DEBIAN="amd64"
TYPE_DEBIAN="cd:1"

function usage {
    cat <<EOF
=============================================================================
debian-usb-installer:
A simple script used to create a debian bootable usb to install it.
-------
Usage: ./debian-usb-installer [OPTIONS]
-------
OPTIONS:
    -h (--help):
        Display the usage.
    -u (--usb) USB;
        The usb where install the debian iso.
        This option is required.
    -r (--repository) URL:
        The repository where find the debian file.
        By default: ${REPOSITORY_DEBIAN}
    -d (--debian) VERSION:
        The debian version what you want.
        By default: ${VERSION_DEBIAN}
    -a (--architecture) ARCHITECTURE:
        The architecture of debian what you want.
        By default: ${ARCHITECTURE_DEBIAN}
    -t (--type) TYPE:
        The type (cd or dvd) what you want.
        By default: ${TYPE_DEBIAN}
-------
Example:
# fdisk -l | grep FAT
/dev/sdb1 XXXX XXXX XXXX XXXX XXXX FATXXX
# ./debian-usb-installer --usb /dev/sdb
        --repository ${REPOSITORY_DEBIAN}
        --debian ${VERSION_DEBIAN}
        --architecture ${ARCHITECTURE_DEBIAN}
        --type ${TYPE_DEBIAN}
EOF
}

function init {
    if [ "$(id -u)" != "0" ]
    then
        echo "This script must be run as root" 1>&2
        exit 1
    fi
}

# $@: Argv
function parseCli {
    local shortOpts="hu:r:d:a:t:"
    local longOpts="help,usb:,repository:,debian:,architecture:,type:"
    local opts=`getopt -o ${shortOpts} --long ${longOpts} -n 'parse-options' -- "$@"`
    while true; do
        case "$1" in
            -h | --help) usage && exit ;;
            -u | --usb) USB="$2"; shift; shift ;;
            -r | --repoitory) REPOSITORY_DEBIAN="$2"; shift; shift ;;
            -d | --debian) VERSION_DEBIAN="$2"; shift; shift ;;
            -a | --architecture) ARCHITECTURE_DEBIAN="$2"; shift; shift ;;
            -t | --type) TYPE_DEBIAN="$2"; shift; shift ;;
            --) shift; break ;;
            *) break ;;
        esac
    done
    if [ ${USB} = "no" ]
    then
        echo "You must define the option --usb"
        exit 2
    fi
}

# $1: Version.
# $2: Architecture.
# $3: Type.
# $4: Extension.
function dataToFile {
    local type=$(echo "${3}"  | cut -d':' -f1)
    local numb=$(echo "${3}"  | cut -d':' -f2)
    local typeUper=$(echo "${type}" | tr a-z A-Z)
    echo "debian-${1}-${2}-${typeUper}-${numb}${4}"
}

# $1: Repository.
# $2: Version.
# $3: Architecture.
# $4: Type.
function dataToUrl {
    local type=$(echo "${4}"  | cut -d':' -f1)
    echo "${1}${2}/${3}/jigdo-${type}/$(dataToFile $2 $3 $4 .jigdo)"
}

# $1: The online debian jigdo file.
function downloadDebian {
    jigdo-lite --noask $1
}

# $1: The usb output.
function checkUsb {
    fdisk -l | grep "${1}"
    while true; do
        read -p "Are you sure to copy the files on ${1} ? [Yes/No]: " yn
        case ${yn} in
            "Yes") break;;
            "No") exit;;
            *) echo "Please answer Yes or No.";;
        esac
    done
}

# $1: ISO file
# $2: USB key.
function copyDebianToUsb {
    cp $1 $2 && sync
}

#### MAIN ####

init && \
parseCli "$@" && \
downloadDebian "$(dataToUrl ${REPOSITORY_DEBIAN} ${VERSION_DEBIAN} ${ARCHITECTURE_DEBIAN} ${TYPE_DEBIAN})" && \
checkUsb "$USB" && \
copyDebianToUsb "$(dataToFile ${VERSION_DEBIAN} ${ARCHITECTURE_DEBIAN} ${TYPE_DEBIAN} .iso)" "${USB}"