cat << 'EOF' > install_wsjtx.sh && chmod +x install_wsjtx.sh && ./install_wsjtx.sh
EOF

#!/bin/bash

# Check if WSJT-X is already installed
if dpkg -l | grep -q "wsjtx"; then
  echo "WSJT-X is already installed. Skipping installation."
  exit 0
fi

# Update package list
echo "Updating package list..."
if ! sudo apt-get update; then
  echo "Failed to update package list. Exiting..."
  exit 1
fi

# Download WSJT-X package
WSJTX_DEB="wsjtx_2.6.1_amd64.deb"
WSJTX_URL="https://downloads.sourceforge.net/project/wsjt/wsjtx-2.6.1/wsjtx_2.6.1_amd64.deb?viasf=1"

if [ ! -f "$WSJTX_DEB" ]; then
  echo "Downloading WSJT-X..."
  if ! wget -O "$WSJTX_DEB" "$WSJTX_URL"; then
    echo "Failed to download WSJT-X. Exiting..."
    exit 1
  fi
else
  echo "WSJT-X package already downloaded. Skipping download..."
fi

# Install the package
echo "Installing WSJT-X..."
if ! sudo dpkg -i "$WSJTX_DEB"; then
  echo "WSJT-X installation encountered issues. Attempting to fix dependencies..."
  sudo apt-get install -f -y
  sudo dpkg -i "$WSJTX_DEB"
fi

# Clean up unnecessary files
echo "Cleaning up..."
sudo apt-get autoremove -y
sudo apt-get clean

# Optional: Verify installation
if command -v wsjtx &> /dev/null; then
  echo "WSJT-X installation verified successfully!"
else
  echo "WSJT-X installation could not be verified. Please check manually."
fi

echo "Installation complete. Enjoy using WSJT-X!"
