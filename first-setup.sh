#!/usr/bin/env zsh

# this script should be run as the current interactive user with sudo permission

cd "${0:a:h}"

if [[ `id -u` -eq 0 ]]
then
    echo "Do not run this script as root!"
    exit 1
fi

echo "Customising user preferences ..."
./personalise.sh

echo "Cleaning dock items (current user) ..."
./reset-dock.sh

echo "Customising system preferences ..."
sudo ./system-wide-personalise.sh
