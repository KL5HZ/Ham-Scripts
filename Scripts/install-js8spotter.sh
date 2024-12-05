#!/bin/bash

# Define script name and content
SCRIPT_NAME="install-js8spotter.sh"
SCRIPT_CONTENT=$(cat <<'EOF'
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
cat <<DESKTOP > $INSTALL_DIR/Desktop/JS8Spotter.desktop
[Desktop Entry]
Version=1.0
Name=JS8Spotter
Comment=JS8Spotter
Exec=python3 $INSTALL_DIR/js8spotter-112b/js8spotter.py
Icon=$INSTALL_DIR/js8spotter-112b/js8spotter.ico
Path=$INSTALL_DIR/js8spotter-112b/
Terminal=false
Type=Application
DESKTOP

# Set permissions and enable 'Allow Launching'
chmod +x $INSTALL_DIR/js8spotter-112b/js8spotter.py
chmod +x $INSTALL_DIR/Desktop/JS8Spotter.desktop

# Enable 'Allow Launching' if supported
if command -v gio &> /dev/null; then
    gio set $INSTALL_DIR/Desktop/JS8Spotter.desktop metadata::trusted true
else
    echo "gio not found; skipping 'Allow Launching' setup."
fi

# Clean up unnecessary files
echo "Cleaning up..."
sudo apt-get autoremove -y && sudo apt-get clean

echo "Installation complete. Enjoy using JS8Spotter!"
EOF
)

# Determine installation directory
INSTALL_DIR=""
if [ -w /etc/skel ]; then
    echo "Detected Cubic environment."
    INSTALL_DIR="/etc/skel"
else
    echo "Regular user environment detected."
    INSTALL_DIR="$HOME"
fi

# Create script in the appropriate directory
echo "Creating installation script in $INSTALL_DIR..."
echo "$SCRIPT_CONTENT" > "$INSTALL_DIR/$SCRIPT_NAME"
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

echo "Setup complete. Script is located at $INSTALL_DIR/$SCRIPT_NAME."
