#!/usr/bin/bash


echo "Install Packages..."
source packages.sh

sudo xbps-install -S "${PACKAGES[@]}"

