#!/bin/bash
#
# Author  : Anthony Woodward
# Date    : 4 December 2024
# Purpose : Environment detection script for Ham-Scripts installer

# Detect if running in Cubic by checking if /etc/skel is writable
if [ -w /etc/skel ]; then
    echo "Detected Cubic environment."
    INSTALL_DIR="/etc/skel"
else
    echo "Detected regular user environment."
    INSTALL_DIR="$HOME"
fi

# Export INSTALL_DIR for use in other scripts
export INSTALL_DIR
