#!/bin/bash
#
# Author  : Anthony Woodward
# Date    : 4 December 2024
# Purpose : Environment detection script for Ham-Scripts installer

# Define the default directory for regular users (modify as needed)
USER_INSTALL_DIR="$HOME/ham-scripts"

# Detect if running in Cubic by checking if /etc/skel is writable
if [ -w /etc/skel ]; then
    echo "Detected Cubic environment."
    INSTALL_DIR="/etc/skel"
else
    echo "Detected regular user environment."
    INSTALL_DIR="$USER_INSTALL_DIR"
fi

# Ensure the install directory exists
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Creating install directory: $INSTALL_DIR"
    mkdir -p "$INSTALL_DIR" || { echo "Failed to create directory $INSTALL_DIR. Exiting."; exit 1; }
fi

# Export INSTALL_DIR for use in other scripts
export INSTALL_DIR
