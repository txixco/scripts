#!/bin/bash

sudo pacman -S base-devel
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg
sudo pacman -U *.zst
cd ..
rm -rf aura-bin

