#!/bin/bash
# https://github.com/JaKooLit
# https://github.com/Raideeen

# Check if running as root. If root, script will exit
if [[ $EUID -eq 0 ]]; then
    echo "This script should not be executed as root! Exiting......."
    exit 1
fi

clear

# Define variables
script_directory=.scripts/dotfiles # Define the directory where your scripts are located

# Ensuring all in the scripts folder are made executable
chmod +x $script_directory/*

printf "\n%.0s" {1..3}
echo "   |  _.   |/  _   _  |  o _|_ "
echo " \_| (_| o |\ (_) (_) |_ |  |_ "
echo "And Raiden dotfiles !"
printf "\n%.0s" {1..2}

# Welcome message
echo "$(tput setaf 6)Welcome to JaKooLit's Arch-Hyprland Install Script!$(tput sgr0)"
echo
echo "$(tput setaf 166)ATTENTION: Run a full system update and Reboot first!! (Highly Recommended) $(tput sgr0)"
echo
echo "$(tput setaf 3)NOTE: You will be required to answer some questions during the installation! $(tput sgr0)"
echo
echo "$(tput setaf 3)NOTE: If you are installing on a VM, ensure to enable 3D acceleration else Hyprland wont start! $(tput sgr0)"
echo

echo "$(tput bold)$(tput setaf 166)ATTENTION: Choosing Y will install also nvidia stuff! $(tput sgr0)"
echo "$(tput bold)$(tput setaf 3)CTRL C to cancel and edit the file dot_scripts/dotfiles/00-preset.sh (see what can be modified, and what shouldn't!) $(tput sgr0)"

read -p "$(tput setaf 6)Would you like to proceed? (y/n): $(tput sgr0)" proceed

printf "\n%.0s" {1..2}

if [ "$proceed" != "y" ]; then
    echo "Installation aborted."
    printf "\n%.0s" {1..2}
    exit 1
fi

printf "\n%.0s" {1..2}

# Use of Preset Settings
echo "$(tput setaf 3)Sourcing preset settings...$(tput sgr0)"
source $script_directory/00-preset.sh

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
WARN="$(tput setaf 166)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
ORANGE=$(tput setaf 166)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Set the name of the log file to include the current date and time
LOG="install-$(date +%d-%H%M%S).log"

# Create Directory for Install Logs
if [ ! -d Install-Logs ]; then
    mkdir Install-Logs
fi

# Function to execute a script if it exists and make it executable
execute_script() {
    local script="$1"
    local script_path="$script_directory/$script"
    if [ -f "$script_path" ]; then
        chmod +x "$script_path"
        if [ -x "$script_path" ]; then
            env USE_PRESET=$use_preset "$script_path"
        else
            echo "Failed to make script '$script' executable."
        fi
    else
        echo "Script '$script' not found in '$script_directory'."
    fi
}

# Ensuring base-devel is installed
execute_script "00-base.sh"
sleep 0.5
execute_script "pacman.sh"
sleep 0.5
# Execute AUR helper script based on user choice
if [ "$aur_helper" == "paru" ]; then
    execute_script "paru.sh"
elif [ "$aur_helper" == "yay" ]; then
    execute_script "yay.sh"
fi

# Install hyprland packages
execute_script "00-hypr-pkgs.sh"

# Add paths to PATH for binaries and stuff...
execute_script "01-add-to-path.sh"

# Install pipewire and pipewire-audio
execute_script "pipewire.sh"

# Install necessary fonts
execute_script "fonts.sh"

# Set time to local time (not UTC)
if [ "$time" == "Y" ]; then
    execute_script "time.sh"
fi

# Install hyprland
execute_script "hyprland.sh"

if [ "$nvidia" == "Y" ]; then
    execute_script "nvidia.sh"
fi

if [ "$gtk_themes" == "Y" ]; then
    execute_script "gtk_themes.sh"
fi

if [ "$bluetooth" == "Y" ]; then
    execute_script "bluetooth.sh"
fi

if [ "$thunar" == "Y" ]; then
    execute_script "thunar.sh"
fi

if [ "$sddm" == "Y" ]; then
    execute_script "sddm.sh"
fi

if [ "$xdph" == "Y" ]; then
    execute_script "xdph.sh"
fi

if [ "$zsh" == "Y" ]; then
    execute_script "zsh.sh"
fi

execute_script "InputGroup.sh"

if [ "$rog" == "Y" ]; then
    execute_script "rog.sh"
fi

if [ "$dots" == "Y" ]; then
    execute_script "dotfiles.sh"
fi

printf "\n${OK} Yey! Installation Completed.\n"
printf "\n"
sleep 2
printf "\n${NOTE} You can start Hyprland by typing Hyprland (IF SDDM is not installed) (note the capital H!).\n"
printf "\n"
printf "\n${NOTE} It is highly recommended to reboot your system.\n\n"

read -rp "${CAT} Would you like to reboot now? (y/n): " HYP

if [[ "$HYP" =~ ^[Yy]$ ]]; then
    if [[ "$nvidia" == "Y" ]]; then
        echo "${NOTE} NVIDIA GPU detected. Rebooting the system..."
        systemctl reboot
    else
        systemctl reboot
    fi
fi
