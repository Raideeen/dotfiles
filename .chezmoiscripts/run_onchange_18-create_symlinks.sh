#!/bin/bash

echo "${NOTE} - Running 19-create_symlinks.sh"

# Sourcing helper functions and variables
source "$HOME/.local/share/chezmoi/.chezmoiscripts/run_00-helper.sh"

# Set the name of the log file to include the current date and time
LOG="$HOME/.dotfiles/logs/install-$(date +%d-%H%M%S)_input.log"

# Creating symlinks to find all the scripts in "hypr" folder while being at the
# root of the corresponding application
ln -s "$HOME/.config/waybar/scripts/rose_pine" "$HOME/.config/hypr/scripts/waybar/rose_pine"

printf "${OK} Input group setup completed successfully\n" | tee -a "$LOG"
