#!/bin/bash

set -xe

for i in fonts/* 
do 
    sudo cp -r "$i" ~/.local/share/fonts
done

sudo fc-cache -f -v
fc-cache -f -v
