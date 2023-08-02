#!/bin/bash

release_file=/etc/os-release
logfile=/var/log/updater.log
errorlog=/var/log/updater_error.log

# Creating a function to minimize repeating code
check_exit_status() {
    if [ $? -ne 0 ]
    then
        echo "An error occured, please check the $errorlog file."
    fi
}

if grep -q "Arch" $release_file
then
    # The host is based on Arch, run the pacman update command
    sudo pacman -Syu 1>>$logfile 2>>$errorlog
    if [ $? -ne 0 ]
    then
        echo "An error occured, please check the $errorlog file."
    fi
fi

if grep -q "Debian" $release_file || grep -q "Ubuntu" $release_file
then
    # The host is based on Debian or Ubuntu,
    # Run the apt version of the command
    sudo apt update 1>>$logfile 2>>$errorlog
    sudo apt dist-upgrade 1>>$logfile 2>>$errorlog
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
    sudo dnf distro-sync 1>>$logfile 2>>$errorlog
    sudo yum update 1>>$logfile 2>>$errorlog


fi
