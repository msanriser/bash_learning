#!/bin/bash

command=htop

if command -v $command
then
    echo "$command is available, lets run it..."
else
    echo "$command is  Not available, installing it..."
    sudo apt update && apt install -y $command
fi

$command