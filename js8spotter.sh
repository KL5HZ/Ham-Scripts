cat << 'EOF' > install_js8spotter.sh && chmod +x install_js8spotter.sh && ./install_js8spotter.sh
#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt-get update

#Install required python packages
echo "Installing python packes..."
sudo apt install python3-tk
sudo apt install python3-pil
sudo apt install python-pil.imagetk
sudo apt install python3-requests
sudo apt install python3-tksnack

# Download js8spotter package
echo "Downloading js8spotter zip..."
wget "https://kf7mix.com/files/js8spotter/js8spotter-112b.zip"

#Unzip js8spotter
echo "Unzipping js8spotter..."
unzip js8spotter-112b.zip

#Move into js8spotter directory
echo "Changing directory..."
cd js8spotter-112b/

#Make js8spotter executable
echo "Making js8spotter executable..."
chmod +x js8spotter.py

# Clean up unnecessary files
echo "Cleaning up..."
sudo apt-get autoremove -y
sudo apt-get clean

# Verify installation
echo "Verifying js8spotter installation..."
js8spotter --version

echo "Installation complete. Enjoy using js8spotter!"
echo "JS8Spotter is an incomplete product, resulting in not being able to make shortcut for program."
echo "To start JS8Spotter, there are two options:
1: Right click and choose to run as a program inside js8spotter-112b directory
2: Run the program in terminal with 'python3 /path/to/js8spotter.py."
EOF
