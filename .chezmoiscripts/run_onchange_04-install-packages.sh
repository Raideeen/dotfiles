#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Hyprland Packages #

echo "${NOTE} - Running 04-install-packages.sh"

# Sourcing helper functions and variables
source "$HOME/.local/share/chezmoi/.chezmoiscripts/run_00-helper.sh"

# WARNING! If you remove packages here, dotfiles may not work properly.
# and also, ensure that packages are present in AUR and official Arch Repo

# add packages wanted here
extra_hypr=(
    python-pywall # Temporary package to be removed after I convert zDyanTB dotfiles to use wallust-git
    flatpak
    proton-pass            # My password manager but you can change !
    visual-studio-code-bin # Yes proprietary ...
    gnome-keyring          # For VSCode Keyring
    mangal                 # Manga reader for Linux
    zathura                # Nice and minimal PDF reader
)

extra_cargo=(

)

hypr_package=(
    aylurs-gtk-shell
    cliphist
    curl
    grim
    udisk2 # to mount disk
    gvfs
    gvfs-mtp
    gvfs-smb           # To mount networks
    gvfs-gphotos2      # To mount disk
    ntfs-3g            # To mount ntfs disk
    exfat-utils        # To mount exfat disk
    gnome-disk-utility # To mount with a GUI all the disk
    hypridle
    hyprlock
    hyprpicker
    imagemagick
    inxi
    jq
    kitty
    kvantum
    nano
    network-manager-applet
    pamixer
    pavucontrol
    pipewire-alsa
    playerctl
    polkit-gnome
    python-requests
    python-pyquery
    pyprland
    qt5ct
    qt6ct
    qt6-svg
    rofi-wayland
    slurp
    swappy
    swaync
    swww
    wallust-git
    waybar
    wget
    wl-clipboard
    wlogout
    xdg-user-dirs
    xdg-utils
    yad
)

# the following packages can be deleted. however, dotfiles may not work properly
hypr_package_2=(
    brightnessctl
    btop
    cava
    eog
    fastfetch
    gnome-system-monitor
    mousepad
    mpv
    mpv-mpris
    nvtop
    nwg-look
    pacman-contrib
    vim
    yt-dlp
    man-db          # For the man pages, obviously!
    go              # For building nwg-dock-hyprland
    gtk3            # For building nwg-dock-hyprland
    gtk-layer-shell # For building nwg-dock-hyprland
)

# List of packages to uninstall as it conflicts with swaync or causing swaync to not function properly
uninstall=(
    dunst
    mako
    proton-pass-debug # Conflict with Visual Studio Code
)

# List of cargo packages to uninstall
uninstall_cargo=(

)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##

# ------------------------------------------------------------------------------------------
#  _    _                  _                 _   _____           _
# | |  | |                | |               | | |  __ \         | |
# | |__| |_   _ _ __  _ __| | __ _ _ __   __| | | |__) |_ _  ___| | ____ _  __ _  ___  ___
# |  __  | | | | '_ \| '__| |/ _` | '_ \ / _` | |  ___/ _` |/ __| |/ / _` |/ _` |/ _ \/ __|
# | |  | | |_| | |_) | |  | | (_| | | | | (_| | | |  | (_| | (__|   < (_| | (_| |  __/\__ \
# |_|  |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_| |_|   \__,_|\___|_|\_\__,_|\__, |\___||___/
#          __/ | |                                                          __/ |
#         |___/|_|                                                         |___/
# ------------------------------------------------------------------------------------------
# Installation of main components

# Set the name of the log file to include the current date and time
LOG="$HOME/.dotfiles/logs/install-$(date +%d-%H%M%S)_hypr-pkgs.log"

printf "\n%s - Installing hyprland packages.... \n" "${NOTE}"

for PKG1 in "${hypr_package[@]}" "${hypr_package_2[@]}" "${extra_hypr[@]}"; do
    install_package "$PKG1" 2>&1 | tee -a "$LOG"
    if [ $? -ne 0 ]; then
        echo -e "\e[1A\e[K${ERROR} - $PKG1 Package installation failed, Please check the installation logs"
        exit 1
    fi
done

# Checking if mako or dunst is installed for swaync to work properly
printf "\n%s - Checking if mako or dunst are installed and removing for swaync to work properly \n" "${NOTE}"
for PKG in "${uninstall[@]}"; do
    uninstall_package "$PKG" 2>&1 | tee -a "$LOG"
    if [ $? -ne 0 ]; then
        echo -e "\e[1A\e[K${ERROR} - $PKG uninstallation failed, please check the log"
        exit 1
    fi
done

# ------------------------------------------------------------------------------------------
#   _____                        _____           _
#  / ____|                      |  __ \         | |
# | |     __ _ _ __ __ _  ___   | |__) |_ _  ___| | ____ _  __ _  ___  ___
# | |    / _` | '__/ _` |/ _ \  |  ___/ _` |/ __| |/ / _` |/ _` |/ _ \/ __|
# | |___| (_| | | | (_| | (_) | | |  | (_| | (__|   < (_| | (_| |  __/\__ \
#  \_____\__,_|_|  \__, |\___/  |_|   \__,_|\___|_|\_\__,_|\__, |\___||___/
#                   __/ |                                   __/ |
#                  |___/                                   |___/
# ------------------------------------------------------------------------------------------

# Set the name of the log file to include the current date and time
LOG="$HOME/.dotfiles/logs/install-$(date +%d-%H%M%S)_cargo-pkgs.log"

printf "\n%s - Installing cargo packages.... \n" "${NOTE}"

for PKG2 in "${extra_cargo[@]}"; do
    install_package_cargo "$PKG2" 2>&1 | tee -a "$LOG"
    if [ $? -ne 0 ]; then
        echo -e "\e[1A\e[K${ERROR} - $PKG2 Package installation failed, Please check the installation logs"
        exit 1
    fi
done

for PKG3 in "${uninstall_cargo[@]}"; do
    uninstall_package_cargo "$PKG3" 2>&1 | tee -a "$LOG"
    if [ $? -ne 0 ]; then
        echo -e "\e[1A\e[K${ERROR} - $PKG3 uninstallation failed, Please check the installation logs"
        exit 1
    fi
done

clear
