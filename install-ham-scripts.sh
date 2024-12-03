#!/bin/bash
#
# Author  : Anthony Woodward
# Date    : 1 December 2024
# Updated : 22 November 2024
# Purpose : Main installer for Ham Radio programs

# Variables
REPO_DIR="$HOME/Ham-Scripts" # Directory of your repository
BRANCH="main" # Default branch to pull from

# Check for updates
echo "Checking for updates from the repository..."
cd $REPO_DIR || { echo "Directory $REPO_DIR does not exist. Exiting."; exit 1; }

# Fetch the latest changes
git fetch origin

# Check if there are updates
if [ $(git rev-list HEAD...origin/$BRANCH --count) -gt 0 ]; then
    echo "Updates found. Pulling the latest changes..."
    git pull origin $BRANCH || { echo "Failed to pull updates. Exiting."; exit 1; }
else
    echo "No updates found. Proceeding with the installation..."
fi

#Change back to home directory
cd

# Install programs
echo "Starting installation..."

# Change directory for scripts
mv $REPO_DIR/install-*.sh $HOME/install-*.sh

# Execute scripts
sh ./install-js8spotter.sh || { echo "Failed to install JS8Spotter. Exiting."; exit 1; }
sh ./install-wsjtx.sh || { echo "Failed to install WSJTX. Exiting."; exit 1; }

# Return scripts to original directory
mv $HOME/install-*.sh $REPO_DIR/install-*.sh

echo "Installation complete!"
