#!/bin/bash
#
# install-nerd-font.sh
#
# Description:
#   A modern script to download and install a specific Nerd Font.
#   It automatically finds the latest release version from the Nerd Fonts repository.
#
# Dependencies:
#   - wget: to download files.
#   - unzip: to extract the font archive.
#   - curl, grep, cut: to fetch the latest version tag from GitHub API.
#
# Usage:
#   ./install-nerd-font.sh <FontName>
#
# Example:
#   ./install-nerd-font.sh FiraCode
#   ./install-nerd-font.sh JetBrainsMono
#

# --- Main Script Logic ---

# Check if a font name was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <FontName>"
  echo "Please provide the name of the Nerd Font to install (e.g., FiraCode, JetBrainsMono, Hack)."
  exit 1
fi

FONT_NAME=$1
INSTALL_DIR="$HOME/.local/share/fonts"

# --- Functions ---

# Function to check for required command-line tools
check_dependencies() {
  for cmd in wget unzip curl grep cut; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "Error: Required command '$cmd' is not installed."
      echo "Please install it using your system's package manager."
      exit 1
    fi
  done
}

# --- Script Execution ---

check_dependencies

echo "==> Searching for the latest Nerd Fonts release..."

# Get the latest version tag (e.g., "v3.2.1") from the GitHub API
LATEST_TAG=$(curl -s "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" | grep '"tag_name":' | cut -d '"' -f 4)

if [ -z "$LATEST_TAG" ]; then
  echo "Error: Could not determine the latest Nerd Fonts release version."
  exit 1
fi

echo "==> Latest version found: $LATEST_TAG"

# Construct the download URL
DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${LATEST_TAG}/${FONT_NAME}.zip"
TEMP_FILE="/tmp/${FONT_NAME}.zip"

echo "==> Downloading ${FONT_NAME} from ${DOWNLOAD_URL}..."

# Download the font zip file
wget -q --show-progress -O "$TEMP_FILE" "$DOWNLOAD_URL"

# Check if the download was successful
if [ $? -ne 0 ]; then
  echo "Error: Download failed. Please check if the font name '${FONT_NAME}' is correct."
  echo "You can find all available font names at: https://github.com/ryanoasis/nerd-fonts/releases/latest"
  exit 1
fi

echo "==> Installing ${FONT_NAME}..."

# Create the installation directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Unzip the font file into the installation directory
# -o: overwrite existing files without prompting
unzip -o "$TEMP_FILE" -d "$INSTALL_DIR"

echo "==> Cleaning up temporary files..."
rm "$TEMP_FILE"

echo "==> Updating font cache..."
fc-cache -fv

echo "✔ Success! Nerd Font '${FONT_NAME}' was installed."
