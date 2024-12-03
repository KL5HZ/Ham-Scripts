cat << 'EOF' > install-js8spotter.sh && chmod +x install-js8spotter.sh && ./install-js8spotter.sh
EOF

#!/bin/bash

# Define variables
ZIP_FILE="js8spotter-112b.zip"
JS8_DIR="$HOME/js8spotter-112b"
JS8_URL="https://kf7mix.com/files/js8spotter/$ZIP_FILE"
DESKTOP_SHORTCUT="$HOME/Desktop/JS8Spotter.desktop"
LOG_FILE="install-js8spotter.log"

# Log output
exec > >(tee -i "$LOG_FILE")
exec 2>&1

# Trap cleanup
trap "rm -f $ZIP_FILE; echo 'Installation interrupted. Cleaning up.'; exit 1" ERR

echo "Starting JS8Spotter installation..."

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
if [ ! -f "$ZIP_FILE" ]; then
  echo "Downloading js8spotter zip..."
  if ! wget -q "$JS8_URL"; then
    echo "Failed to download js8spotter. Exiting..."
    exit 1
  fi
else
  echo "js8spotter zip already downloaded. Skipping..."
fi

# Check if js8spotter is already unzipped
if [ ! -d "$JS8_DIR" ]; then
  echo "Unzipping js8spotter..."
  if ! unzip -o "$ZIP_FILE" -d "$HOME"; then
    echo "Failed to unzip js8spotter. Exiting..."
    exit 1
  fi
else
  echo "js8spotter directory already exists. Skipping unzip..."
fi

# Remove zip file
if [ -f "$ZIP_FILE" ]; then
  rm "$ZIP_FILE"
fi

# Create desktop shortcut
if [ ! -f "$DESKTOP_SHORTCUT" ]; then
  echo "Creating js8spotter desktop shortcut..."
  cat <<EOF > "$DESKTOP_SHORTCUT"
[Desktop Entry]
Version=1.0
Name=JS8Spotter
Comment=JS8Spotter
Exec=python3 $JS8_DIR/js8spotter.py
Icon=$JS8_DIR/js8spotter.ico
Path=$JS8_DIR/
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
