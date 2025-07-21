#!/bin/bash

echo "Install spice-vdagent..."
sudo xbps-install -S spice-vdagent
sudo ln -s /etc/sv/spice-vdagent /var/service

echo "OK"
