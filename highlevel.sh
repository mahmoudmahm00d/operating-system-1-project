#!/bin/bash

# add this to suders file
# * ALL=(ALL) NOPASSWD:/home/shared/highlevel.sh

function createGroup(){
    sudo addgroup "$1"
}

function addUserToGroup(){
    sudo usermod -aG "$1" "$2"
}

function changeGroup(){
    sudo chgrp "$1" "$2"
}
