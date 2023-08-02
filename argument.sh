#!/bin/bash

#ls -lh $1 # script takes one argument as input.
lines=$(ls -lh $1 | wc -l) # this takes one argument as input

if [ $# -ne 1 ]
then
    echo "This script requires exactly one directory path passed to it."
    echo "Please try again."
    exit 1
fi
echo "You have $(($lines-1)) objects in the $1 directory"
