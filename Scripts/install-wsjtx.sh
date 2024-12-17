#!/bin/bash

# Source environment detection
if [ -f $HOME/Ham-Scripts/detect-env.sh ]; then
    source $HOME/Ham-Scripts/detect-env.sh
else
    echo "Error: Environment detection script (detect-env.sh) not found!"
    exit 1
fi

# Define the download path
DOWNLOAD_PATH="$INSTALL_DIR/wsjtx_2.6.1_amd64.deb"

# Check if WSJT-X is already installed
if command -v wsjtx >/dev/null 2>&1; then
    echo "WSJT-X is already installed. Exiting script."
    exit 0
fi

# Update package list
echo "Updating package list..."
if ! sudo apt-get update; then
    echo "Failed to update package list. Exiting..."
    exit 1
fi

# Download WSJT-X package
echo "Downloading WSJT-X..."
if ! wget -O "$DOWNLOAD_PATH" "https://downloads.sourceforge.net/project/wsjt/wsjtx-2.6.1/wsjtx_2.6.1_amd64.deb?viasf=1"; then
    echo "Failed to download WSJT-X. Exiting..."
    exit 1
fi

# Install the package
echo "Installing WSJT-X..."
if ! sudo dpkg -i "$DOWNLOAD_PATH"; then
    echo "Error during WSJT-X installation. Attempting to fix dependencies..."
    sudo apt-get install -f -y
fi

# Reconfigure dpkg in case of errors
echo "Configuring packages..."
sudo dpkg --configure -a

# Reinstall WSJT-X to ensure proper setup
echo "Reinstalling WSJT-X to ensure proper setup..."
sudo dpkg -i "$DOWNLOAD_PATH"

# Clean up unnecessary files
echo "Cleaning up..."
sudo apt-get autoremove -y
sudo apt-get clean

# Verify installation
if command -v wsjtx >/dev/null 2>&1; then
    echo "WSJT-X successfully installed!"
else
    echo "WSJT-X installation failed. Please check the logs."
    exit 1
fi

echo "Installation complete. Enjoy using WSJT-X!"
