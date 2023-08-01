#!/bin/bash

release_file=/etc/os-release
logfile=/var/log/updater.log
errorlog=/var/log/updater_error.log

if grep -q "Arch" $release_file
then
    # The host is based on Arch, run the pacman update command
    sudo pacman -Syu
    if [ $? -ne 0 ]
    then
        echo "An error occured, please check the $errorlog file."
    fi
fi

if grep -q "Debian" $release_file || grep -q "Ubuntu" $release_file
then
    # The host is based on Debian or Ubuntu,
    # Run the apt version of the command
    sudo apt update
    sudo apt dist-upgrade
    if [ $? -ne 0 ]
    then
        echo "An error occured, please check the $errorlog file."
    fi
fi

if grep -q "Fedora" $release_file || grep -q "Redhat" $release_file
then
    # The host is based on Redhat,
    # Run the dnf for newer system to update,
    # Run the yum update command for older systems
    sudo dnf distro-sync
    sudo yum update
    if [ $? -ne 0 ]
    then
        echo "An error occured, please check the $errorlog file."
    fi
fi

