#!/bin/bash

set -xe

for i in fonts/* 
do 
    sudo cp -r "$i" /usr/share/fonts
done

sudo fc-cache -f -v
fc-cache -f -v
