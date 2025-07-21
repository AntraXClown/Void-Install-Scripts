#!/bin/bash

echo "Install grub theme..."

sudo mkdir -p /boot/grub/themes/void-linux
sudo tar -xf void-linux.tar -C /boot/grub/themes/void-linux
echo 'GRUB_THEME=/boot/grub/themes/void-linux/theme.txt' | sudo tee -a /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "OK"
