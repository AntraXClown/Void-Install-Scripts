#!/usr/bin/env bash

pause() {
  read -n 1 -s -r -p "Pressione qualquer tecla para continuar..."
}

echo "Installing applications and drivers..."
sudo xbps-install nfs-utils sv-netmount vsv

pause

echo "NFS on fstab..."
sudo mkdir /NFS
sudo chown -R antrax:antrax /NFS

echo "Write /etc/fstab"
echo "192.168.1.24:/ /NFS nfs rw,hard 0 0" | sudo tee -a /etc/fstab

# Secondary
echo "UUID=d03e61af-12c6-46c7-9ac6-216a8661ff93 /home/antrax/Secondary ext4 defaults,noatime 0 2" | sudo tee -a /etc/fstab
mkdir ~/Secondary

pause

echo "Enable services statd, rpcbind, dbus and seatd and netmount..."
sudo ln -s /etc/sv/statd /var/service
sudo ln -s /etc/sv/rpcbind /var/service
sudo ln -s /etc/sv/netmount /var/service

pause
echo "Install Packages..."
source packages.sh

sudo xbps-install -S "${PACKAGES[@]}"

echo "Install nerd-fonts....."
./nerd-fonts.sh Hack
./nerd-fonts.sh CascadiaCode
./nerd-fonts.sh JetBrainsMono
./nerd-fonts.sh Meslo
./nerd-fonts.sh UbuntuMono
./nerd-fonts.sh FiraCode

pause

echo "Install oh-my-posh..."
curl -s https://ohmyposh.dev/install.sh | bash -s

echo "Enable cronie..."
sudo ln -s /etc/sv/cronie /var/service
