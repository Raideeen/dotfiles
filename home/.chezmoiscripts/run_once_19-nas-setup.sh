#!/usr/bin/env bash

echo "${NOTE} - Running 19-nas-setup.sh"

ISAUR=$(command -v yay || command -v paru)

# Sourcing helper functions and variables
source "$HOME/.local/share/chezmoi/home/.chezmoiscripts/run_00-helper.sh"

sudo mkdir /mnt/nas
sudo chmod 600 ~/.config/creds/smb_credentials
sudo mount -t cifs //192.168.10.88/18To/Adrien /mnt/nas -o credentials=~/.config/creds/smb_credentials
