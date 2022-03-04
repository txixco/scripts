#!/bin/bash

# System update
sudo pacman -Syyu

# Install aura
~/scripts/aura-install.sh

# Installations
sudo pacman -S $(awk '{print $1}' mypcks.lst)
sudo aura -A $(awk '{print $1}'  mypcks-aura.lst)

# Services
sudo systemctl enable teamviewerd

# Others
sudo sed -i '/^txixco/ s/\/bin\/bash/\/usr\/bin\/zsh/g' /etc/passwd
sudo sed -i '/[SSH]/,+3 s/22/486/' /etc/ufw/applications.d/ufw-loginserver
sudo sed -i 's/#Port 22/Port 486/' /etc/ssh/sshd_config

sudo systemctl restart sshd.service