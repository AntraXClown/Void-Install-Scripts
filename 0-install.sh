#!/usr/bin/env bash

echo "Updating xbps and the System..."
sudo xbps-install -S
sudo xbps-install -S xbps
sudo xbps-install -Syu

sudo xbps-install unzip wget curl nfs-utils sv-netmount mesa-dri xorg-minimal \
  vulkan-loader mesa-vulkan-radeon mesa-vaapi mesa-vdpau void-repo-nonfree dbus seatd

sudo mkdir /NFS
sudo chown -R antrax:antrax /NFS

echo "Write /etc/fstab"
echo "192.168.1.24:/ /NFS nfs rw,hard 0 0" | sudo tee -a /etc/fstab

echo "Enable services statd, rpcbind, dbus and seatd and netmount..."
sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/seatd /var/service
sudo ln -s /etc/sv/statd /var/service
sudo ln -s /etc/sv/rpcbind /var/service
sudo ln -s /etc/sv/netmount /var/service

echo "Install nerd-fonts....."
./nerd-fonts.sh Hack
./nerd-fonts.sh CascadiaCode
./nerd-fonts.sh JetBrainsMono
./nerd-fonts.sh Meslo
./nerd-fonts.sh UbuntuMono
./nerd-fonts.sh FiraCode

pause
echo "Install Packages..."
source packages.sh

sudo xbps-install -S "${PACKAGES[@]}"
