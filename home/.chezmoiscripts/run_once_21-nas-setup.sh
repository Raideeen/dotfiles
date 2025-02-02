#!/usr/bin/env bash

echo "${NOTE} - Running 19-nas-setup.sh"

ISAUR=$(command -v yay || command -v paru)

# Sourcing helper functions and variables
source "$HOME/.local/share/chezmoi/home/.chezmoiscripts/run_00-helper.sh"
# Create mount point if it doesn't exist
if [ ! -d "/mnt/nas" ]; then
    sudo mkdir -p /mnt/nas || {
        echo "Error: Failed to create /mnt/nas directory"
        exit 1
    }
fi

# Check if credentials file exists and set permissions
if [ -f ~/.config/creds/smb_credentials ]; then
    sudo chmod 600 ~/.config/creds/smb_credentials || {
        echo "Error: Failed to set permissions on credentials file"
        exit 1
    }
else
    echo "Error: Credentials file not found at ~/.config/creds/smb_credentials"
    exit 1
fi

# Mount the NAS
sudo mount -t cifs //192.168.10.88/18To/Adrien /mnt/nas -o credentials=~/.config/creds/smb_credentials || {
    echo "Error: Failed to mount NAS share"
    exit 0
}
