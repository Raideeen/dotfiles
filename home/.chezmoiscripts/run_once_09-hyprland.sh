#!/usr/bin/env bash
# 💫 https://github.com/JaKooLit 💫 #
# Main Hyprland Package #

echo "${NOTE} - Running 10-hyprland.sh"

ISAUR=$(command -v yay || command -v paru)

# Sourcing helper functions and variables
source "$HOME/.local/share/chezmoi/home/.chezmoiscripts/run_00-helper.sh"

hypr=(
    hyprland
    hyprcursor
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##

# Set the name of the log file to include the current date and time
LOG="$HOME/.dotfiles/logs/install-$(date +%d-%H%M%S)_hyprland.log"

# Removing other Hyprland to avoid conflict
printf "${YELLOW} Checking for other hyprland packages and remove if any..${RESET}\n"
if pacman -Qs hyprland >/dev/null; then
    printf "${YELLOW} Hyprland detected. uninstalling to install Hyprland-git...${RESET}\n"
    for hyprnvi in hyprland-git hyprland-nvidia hyprland-nvidia-git hyprland-nvidia-hidpi-git; do
        sudo pacman -R --noconfirm "$hyprnvi" 2>/dev/null | tee -a "$LOG" || true
    done
fi

# Hyprland
printf "${NOTE} Installing Hyprland .......\n"
for HYPR in "${hypr[@]}"; do
    install_package "$HYPR" 2>&1 | tee -a "$LOG"
    [ $? -ne 0 ] && {
        echo -e "\e[1A\e[K${ERROR} - $HYPR Package installation failed, Please check the installation logs"
        exit 1
    }
done

printf "${OK} Hyprland installed successfully\n" | tee -a "$LOG"
