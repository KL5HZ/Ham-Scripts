cat << 'EOF' > install_wsjtx.sh
#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt-get update

# Download WSJT-X package
echo "Downloading WSJT-X..."
wget -O wsjtx_2.6.1_amd64.deb "https://downloads.sourceforge.net/project/wsjt/wsjtx-2.6.1/wsjtx_2.6.1_amd64.deb?viasf=1"

# Install the package
echo "Installing WSJT-X..."
sudo dpkg -i wsjtx_2.6.1_amd64.deb

# Fix dependencies if required
echo "Fixing dependencies..."
sudo apt-get install -f -y

# Reconfigure dpkg in case of errors
echo "Configuring packages..."
sudo dpkg --configure -a

# Reinstall WSJT-X if necessary
echo "Reinstalling WSJT-X to ensure proper setup..."
sudo dpkg -i wsjtx_2.6.1_amd64.deb

# Clean up unnecessary files
echo "Cleaning up..."
sudo apt-get autoremove -y
sudo apt-get clean

# Verify installation
echo "Verifying WSJT-X installation..."
wsjtx --version

echo "Installation complete. Enjoy using WSJT-X!"
EOF

chmod +x install_wsjtx.sh && ./install_wsjtx.sh
