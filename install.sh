#!/bin/bash
#
# Author  : Anthony Wodoward
# Date    : 1 December 2024
# Updated : 22 November 2024
# Purpose : Main installer for Ham Radio programs

#Check for updates
echo "Checking for updates..."

#Install programs
echo "Starting install..."

#Programs to install
sh ./$HOME/Ham-Scripts/install-js8spotter.sh
sh ./$HOME/Ham-Scripts/install-wsjtx.sh
