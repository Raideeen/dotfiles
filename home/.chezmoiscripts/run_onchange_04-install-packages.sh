#!/usr/bin/env bash
# 💫 https://github.com/JaKooLit 💫 #
# Hyprland Packages #

echo "${NOTE} - Running 04-install-packages.sh"

ISAUR=$(command -v yay || command -v paru)

# Sourcing helper functions and variables
source "$HOME/.local/share/chezmoi/home/.chezmoiscripts/run_00-helper.sh"

# WARNING! If you remove packages here, dotfiles may not work properly.
# and also, ensure that packages are present in AUR and official Arch Repo

# add packages wanted here
extra_hypr=(
    # Desktop App
    vesktop-bin         # Discord!
    notion-app-electron # Notion for organizing my life lol

    # Image viewer
    eog # Eye of GNOME, an image viewer for the GNOME Desktop

    # Package management
    flatpak
    pacman-contrib # Contributed scripts and tools for pacman systems

    # Password management
    proton-pass   # My password manager but you can change !
    gnome-keyring # For VSCode Keyring

    # Mailing
    proton-mail

    # Development tools
    visual-studio-code-bin # Yes proprietary ...

    # Entertainment
    mangal  # Manga reader for Linux
    zathura # Nice and minimal PDF reader
    yt-dlp  # A youtube-dl fork with additional features and fixes

    # Files manager
    yazi     # Blazingly fast CLI file manager
    nautilus # Default GNOME file manager

    # Browser
    firefox
)

extra_cargo=(

)

hypr_package=(
    # Hyprland requirements
    mako         # Notification daemon that can be easily styled!
    kitty        # Default terminal for Hyprland
    rofi-wayland # Rofi but wayland
    qt5-wayland  # Dependency
    qt6-wayland  # Dependency
    grim         # To take screenshots
    polkit-gnome # Authentication agent
    slurp        # External chooser to select the shared monito
    swappy       # Post-capture screenshot editing and drawing tool

    # Addons of Hyprland
    hyprpicker   # Wayland compatible color picker
    wl-clipboard # Wayland clipboard utilities (dependency for )
    wlogout      # wlogout is a logout menu for wayland environment
    waybar       # The famous waybar :sunglasses:
    swww-git     # Change wallpaper for wayland but with style :)

    # Themes
    bibata-cursor-git     # Bibata cursor ! :)
    gruvbox-gtk-theme-git # GTK theme using gruvbox, nice!

    # CLI tools
    curl        # Classic GNU tool for transferring data :)
    wget2       # GNU Wget2 is the successor of GNU Wget, a file and recursive website downloader
    imagemagick # Allow to manipulate images through the CLI
    nano        # Classic nano text editor
    vim         # Plain-old vim :)
    neovim-git  # The cooler vim :sunglasses:
    jq          # Command-line JSON processor
    man-db      # Utilities for reading man pages
    age         # Encrypt file using chezmoi

    # Monitoring tools
    btop      # Resource monitor that shows usage and stats for processor, memory, disks, network and processes
    nvtop     # An htop like monitoring tool for NVIDIA GPUs
    fastfetch # Neofetch-like tool for displaying system information
    inxi      # Full featured system information script (simpler than FastFetch)

    # Music and audio
    playerctl   # CLI tool to send commands to MPRIS clients (VLC, Spotify...)
    mpc         # Command-line client for MPD (Music Player Daemon)
    mpd         # Music Player Daemon, a flexible, powerful, server-side application for playing music
    pamixer     # CLI tools for managing sound - compatible with pipewire!
    pwvucontrol # Pipewire volume control - alternative to pavucontrol
    cava        # Console-based Audio Visualizer for Alsa
    mpv         # Media player based on MPlayer and mplayer2
    mpv-mpris   # MPRIS plugin for mpv

    # Customization apps
    kvantum                # App to style Qt applications
    nwg-look               # GTK theme switcher for sway and other wlroots-based compositors
    network-manager-applet # Provide a system-tray button for managing the network

    # Languages
    go # The Go programming language

    # Files manager dependencies
    gvfs          # Virtual filesystem implementation for GIO
    gvfs-afc      # Virtual filesystem implementation for GIO - AFC backend (Apple mobile devices)
    gcfs-dnssd    # Virtual filesystem implementation for GIO - DNS-SD and WebDAV backend (macOS file sharing)
    gvfs-gphoto2  # Virtual filesystem implementation for GIO - gphoto2 backend (PTP camera, MTP media player)
    gvfs-mtp      # Virtual filesystem implementation for GIO - MTP backend (Android, media player)
    gvfs-nfs      # Virtual filesystem implementation for GIO - NFS backend
    gvfs-onedrive # Virtual filesystem implementation for GIO - Microsoft OneDrive backend
    gvfs-smb      # Virtual filesystem implementation for GIO - SMB/CIFS backend (Windows file sharing)
    gvfs-wsdd     # Virtual filesystem implementation for GIO - Web Services Dynamic Discovery backend (Windows discovery)
    cfis-utils    # Library and tools for package installs and system configuration

    # Libraries
    python-requests
    python-pyquery
    yad
    qt5ct
    qt6ct
    gtk3
    gtk-layer-shell
    gtk-engine-murrine
    gnome-shell
    libfido2 # Allow my yubikey to be used for SSH authentification
)

# List of packages to uninstall as it conflicts with swaync or causing swaync to not function properly
uninstall=(
    proton-pass-debug        # Conflict with Visual Studio Code
    visual-studio-code-debug # Nuke that shit
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

for PKG1 in "${hypr_package[@]}" "${extra_hypr[@]}"; do
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
