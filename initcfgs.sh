#!/bin/bash

sudo sed -i '/^txixco/ s/\/bin\/bash/\/usr\/bin\/zsh/g' /etc/passwd
sudo sed -i '/[SSH]/,+3 s/22/486/' /etc/ufw/applications.d/ufw-loginserver
sudo sed -i 's/#Port 22/Port 486/' /etc/ssh/sshd_config

sudo systemctl restart sshd.service

