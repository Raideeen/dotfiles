#!/usr/bin/env bash
# 💫 https://github.com/JaKooLit 💫 #
# Fonts #

echo "${NOTE} - Running 07-fonts.sh"

ISAUR=$(command -v yay || command -v paru)

# Sourcing helper functions and variables
source "$HOME/.local/share/chezmoi/home/.chezmoiscripts/run_00-helper.sh"

# These fonts are minimun required for pre-configured dots to work. You can add here as required
# WARNING! If you remove packages here, dotfiles may not work properly.
# and also, ensure that packages are present in AUR and official Arch Repo

# TODO : Adapt the script to be ran with the correct sourcing of the global functions

fonts=(
    adobe-source-code-pro-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    otf-font-awesome
    ttf-droid
    ttf-firacode-nerd
    ttf-jetbrains-mono
    ttf-jetbrains-mono-nerd
    ttf-iosevka-nerd
    ttf-nerd-fonts-symbols
    ttc-iosevka
    apple-fonts
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##

# Set the name of the log file to include the current date and time
LOG="$HOME/.dotfiles/logs/install-$(date +%d-%H%M%S)_fonts.log"

# Installation of main components
printf "\n%s - Installing necessary fonts.... \n" "${NOTE}"

for PKG1 in "${fonts[@]}"; do
    install_package "$PKG1" 2>&1 | tee -a "$LOG"
    if [ $? -ne 0 ]; then
        echo -e "\e[1A\e[K${ERROR} - $PKG1 Package installation failed, Please check the installation logs"
        exit 1
    fi
done

clear
