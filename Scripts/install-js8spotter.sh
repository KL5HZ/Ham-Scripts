#!/bin/bash

# Source environment detection
if [ -f ./detect-env.sh ]; then
    source ./detect-env.sh
else
    echo "Error: Environment detection script (detect-env.sh) not found!"
    exit 1
fi

# Define the working directory for js8spotter
WORK_DIR="$INSTALL_DIR/js8spotter-112b"

# Update package list
echo "Updating package list..."
if ! sudo apt-get update; then
    echo "Failed to update package list. Exiting..."
    exit 1
fi

# Install required Python packages and utilities
echo "Installing required packages..."
if ! sudo apt install -y python3-tk python3-pil python3-pil.imagetk python3-requests python3-tksnack unzip wget; then
    echo "Failed to install required packages. Exiting..."
    exit 1
fi

# Download js8spotter package
echo "Downloading js8spotter zip..."
if ! wget -q "https://kf7mix.com/files/js8spotter/js8spotter-112b.zip" -O "$INSTALL_DIR/js8spotter-112b.zip"; then
    echo "Failed to download js8spotter. Exiting..."
    exit 1
fi

# Unzip js8spotter
echo "Unzipping js8spotter..."
if ! unzip -o "$INSTALL_DIR/js8spotter-112b.zip" -d "$INSTALL_DIR"; then
    echo "Failed to unzip js8spotter. Exiting..."
    exit 1
fi
rm "$INSTALL_DIR/js8spotter-112b.zip"

# Create desktop shortcut
echo "Creating js8spotter desktop shortcut..."
cat <<EOF > "$INSTALL_DIR/Desktop/JS8Spotter.desktop"
[Desktop Entry]
Version=1.0
Name=JS8Spotter
Comment=JS8Spotter
Exec=python3 $WORK_DIR/js8spotter.py
Icon=$WORK_DIR/js8spotter.ico
Path=$WORK_DIR
Terminal=false
Type=Application
EOF

# Set permissions
chmod +x "$WORK_DIR/js8spotter.py"
chmod +x "$INSTALL_DIR/Desktop/JS8Spotter.desktop"

# Enable 'Allow Launching' if supported
if command -v gio &> /dev/null; then
    gio set "$INSTALL_DIR/Desktop/JS8Spotter.desktop" metadata::trusted true
else
    echo "gio not found; skipping 'Allow Launching' setup."
fi

echo "JS8Spotter installation completed successfully!"
echo "Files are installed in: $INSTALL_DIR"
