#cat << 'EOF' > install-js8spotter.sh && chmod +x install-js8spotter.sh && ./install-js8spotter.sh


#!/bin/bash

# Update package list
echo "Updating package list..."
if ! sudo apt-get update; then
  echo "Failed to update package list. Exiting..."
  exit 1
fi

# Install required Python packages
echo "Checking for required Python packages..."
REQUIRED_PACKAGES=(python3-tk python3-pil python3-pil.imagetk python3-requests python3-tksnack)
for PACKAGE in "${REQUIRED_PACKAGES[@]}"; do
  if dpkg -l | grep -q "^ii  $PACKAGE"; then
    echo "$PACKAGE is already installed. Skipping..."
  else
    echo "Installing $PACKAGE..."
    if ! sudo apt install -y "$PACKAGE"; then
      echo "Failed to install $PACKAGE. Exiting..."
      exit 1
    fi
  fi
done

# Check if js8spotter zip is already downloaded
if [ ! -f "js8spotter-112b.zip" ]; then
  echo "Downloading js8spotter zip..."
  if ! wget -q "https://kf7mix.com/files/js8spotter/js8spotter-112b.zip"; then
    echo "Failed to download js8spotter. Exiting..."
    exit 1
  fi
else
  echo "js8spotter zip already downloaded. Skipping..."
fi

# Check if js8spotter is already unzipped
if [ ! -d "$HOME/js8spotter-112b" ]; then
  echo "Unzipping js8spotter..."
  if ! unzip -o js8spotter-112b.zip -d "$HOME"; then
    echo "Failed to unzip js8spotter. Exiting..."
    exit 1
  fi
else
  echo "js8spotter directory already exists. Skipping unzip..."
fi

# Remove zip file
if [ -f "js8spotter-112b.zip" ]; then
  rm js8spotter-112b.zip
fi

# Create desktop shortcut
DESKTOP_SHORTCUT="$HOME/Desktop/JS8Spotter.desktop"
if [ ! -f "$DESKTOP_SHORTCUT" ]; then
  echo "Creating js8spotter desktop shortcut..."
  cat <<EOF > "$DESKTOP_SHORTCUT"
[Desktop Entry]
Version=1.0
Name=JS8Spotter
Comment=JS8Spotter
Exec=python3 $HOME/js8spotter-112b/js8spotter.py
Icon=$HOME/js8spotter-112b/js8spotter.ico
Path=$HOME/js8spotter-112b/
Terminal=false
Type=Application
EOF
  chmod +x "$DESKTOP_SHORTCUT"

  # Enable 'Allow Launching' if supported
  if command -v gio &> /dev/null; then
      gio set "$DESKTOP_SHORTCUT" metadata::trusted true
  else
      echo "gio not found; skipping 'Allow Launching' setup."
  fi
else
  echo "Desktop shortcut already exists. Skipping..."
fi

# Clean up unnecessary files
echo "Cleaning up..."
sudo apt-get autoremove -y && sudo apt-get clean

echo "Installation complete. Enjoy using JS8Spotter!"
#EOF

