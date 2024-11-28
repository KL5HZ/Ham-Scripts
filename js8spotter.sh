cat << 'EOF' > install_js8spotter.sh && chmod +x install_js8spotter.sh && ./install_js8spotter.sh
#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt-get update

#Install required python packages
echo "Installing python packes..."
sudo apt install python3-tk python3-pil python-pil.imagetk python3-requests python3-tksnack

# Download js8spotter package
echo "Downloading js8spotter zip..."
wget "https://kf7mix.com/file/js8spotter/js8spotter-111b.zip"

#Unzip js8spotter
echo "Unzipping js8spotter..."
unzip js8spotter-111b.zip

# Clean up unnecessary files
echo "Cleaning up..."
sudo apt-get autoremove -y
sudo apt-get clean

#Move into js8spotter directory
echo "Changing directory..."
cd js8spotter-111b/

#Make js8spotter executable
echo "Making js8spotter executable..."
chmod +x js8spotter.py

# Verify installation
echo "Verifying js8spotter installation..."
js8spotter --version

echo "Installation complete. Enjoy using js8spotter!"
echo "JS8Spotter is an incomplete product, resulting in not being able to make shortcut for program."
echo "To start JS8Spotter, right click and choose to run as a program inside js8spotter-111b directory."
EOF
