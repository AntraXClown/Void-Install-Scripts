#!/bin/bash

echo "Enable SDDM service..."

sudo xbps-install -S sddm

sudo ln -s /etc/sv/sddm /var/service

sudo mkdir /etc/sddm.conf.d
sudo cp autologin.conf /etc/sddm.conf.d/

echo "OK"
