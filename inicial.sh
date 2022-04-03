#!/bin/bash

# System update
sudo pacman -Syyu

# Install aura
~/scripts/aura-install.sh

# Installations
sudo pacman -S --needed $(awk '{print $1}' mypcks.lst)
sudo aura -A $(awk '{print $1}'  mypcks-aura.lst)

# Services
sudo systemctl enable teamviewerd
