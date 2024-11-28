#!/bin/bash

# Download the .deb package
wget -O wsjtx_2.6.1_amd64.deb "https://downloads.sourceforge.net/project/wsjt/wsjtx-2.6.1/wsjtx_2.6.1_amd64.deb?viasf=1"

# Install the package
sudo dpkg -i wsjtx_2.6.1_amd64.deb


#If error when trying to install WSJTX, run the remove command
