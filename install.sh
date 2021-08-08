#!/usr/bin/env sh
set -e

TAG='v5.13.8-arch1'

download() {
    echo "Downloading $1"
    mkdir -p "$(dirname "$1")"
    curl -s -L "https://raw.githubusercontent.com/archlinux/linux/${TAG}/$1" -o ./"$1"
}

rm -rf sound
download sound/pci/hda/patch_realtek.c
patch -u -b sound/pci/hda/patch_realtek.c -i patches/sound.patch

sudo dkms install .
