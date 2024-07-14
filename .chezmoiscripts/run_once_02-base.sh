#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# base devel #

echo "${NOTE} - Running 02-base.sh"

# Sourcing helper functions and variables
source "$HOME/.local/share/chezmoi/.chezmoiscripts/run_00-helper.sh"

base=(
    base-devel
)
# WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##

# Set the name of the log file to include the current date and time
LOG="$HOME/.dotfiles/logs/install-$(date +%d-%H%M%S)_base.log"

# Installation of main components
printf "\n%s - Installing base-devel \n" "${NOTE}"

for PKG1 in "${base[@]}"; do
    sudo pacman -S --noconfirm "$PKG1" | tee -a "$LOG"
done
