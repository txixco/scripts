#! /bin/bash

# Detects the machine's distro and does an update accordingly
# I know these are not the only package managers, but they are the ones 
# I work with
#
# Needs notify-send

update_and_notify() {
    sudo "$1" "$2" -y \
        && notify-send "Update" "The update has been successfully performed" \
                       -i dialog-information

    exit
}

if command -v apt &>/dev/null; then
    sudo apt update
    update_and_notify apt upgrade
fi

if command -v dnf &>/dev/null; then
    update_and_notify dnf upgrade
fi

printf "Distro '%s' is not being considered\n" $distro
exit 1