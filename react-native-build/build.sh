#!/bin/bash

# check if the project folder is mounted to /temp
if [ ! -d "/temp" ]; then
    echo "the project root is not mounted to '/temp'"
    exit
fi

echo "the project is mounted"

# go to project root
cd /temp

#check for package.json, android/ios/node_modules folder


