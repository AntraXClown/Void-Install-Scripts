#!/bin/bash

source packages.sh

sudo xbps-install -S "${PACKAGES[@]}"
