cat << 'EOF' > install-js8spotter.sh && chmod +x install-js8spotter.sh && ./install-js8spotter.sh
EOF

#!/bin/bash

# Update package list
echo "Updating package list..."
if ! sudo apt-get update; then
  echo "Failed to update package list. Exiting..."
  exit 1
fi

# Install required Python packages
echo "Installing Python packages..."
if ! sudo apt install -y python3-tk python3-pil python3-pil.imagetk python3-requests python3-tksnack; then
  echo "Failed to install Python packages. Exiting..."
  exit 1
fi

# Download js8spotter package
echo "Downloading js8spotter zip..."
if ! wget -q "https://kf7mix.com/files/js8spotter/js8spotter-112b.zip"; then
  echo "Failed to download js8spotter. Exiting..."
  exit 1
fi

# Unzip js8spotter
echo "Unzipping js8spotter..."
if ! unzip -o js8spotter-112b.zip; then
  echo "Failed to unzip js8spotter. Exiting..."
  exit 1
fi

# Remove zip file
rm js8spotter-112b.zip

# Create desktop shortcut
echo "Creating js8spotter desktop shortcut..."
cat <<EOF > $HOME/Desktop/JS8Spotter.desktop
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

# Set permissions and enable 'Allow Launching'
chmod +x $HOME/js8spotter-112b/js8spotter.py
chmod +x $HOME/Desktop/JS8Spotter.desktop

# Enable 'Allow Launching' if supported
if command -v gio &> /dev/null; then
    gio set $HOME/Desktop/JS8Spotter.desktop metadata::trusted true
else
    echo "gio not found; skipping 'Allow Launching' setup."
fi

# Clean up unnecessary files
echo "Cleaning up..."
sudo apt-get autoremove -y && sudo apt-get clean

echo "Installation complete. Enjoy using JS8Spotter!"
