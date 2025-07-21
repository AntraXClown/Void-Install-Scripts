#!/bin/bash

echo "Install grub theme..."

sudo mkdir -p /boot/grub/themes
sudo tar -xf void-linux.tar -C /boot/grub/themes/
echo 'GRUB_THEME=/boot/grub/themes/void-linux/theme.txt' | sudo tee -a /etc/default/grub

echo "OK"
