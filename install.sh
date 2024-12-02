#!/bin/bash
#
# Author  : Anthony Woodward
# Date    : 1 December 2024
# Updated : 22 November 2024
# Purpose : Main installer for Ham Radio programs

#Check for updates
echo "Checking for updates..."

#Install programs
echo "Starting install..."

#Change directory for scripts
mv $HOME/Ham-Scripts/install-js8spotter.sh $HOME/install-js8spotter.sh
mv $HOME/Ham-Scripts/install-wsjtx.sh $HOME/install-wsjtx.sh

#Programs to install
sh ./install-js8spotter.sh
sh ./install-wsjtx.sh
