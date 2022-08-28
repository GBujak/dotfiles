#!/bin/sh

-set xe

sudo cp -r ./ubuntu-mono /usr/share/fonts
sudo fc-cache -f -v
