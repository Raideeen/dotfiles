# 💫 https://github.com/JaKooLit 💫 #
#
# CREDIT to: https://github.com/PostCyberPunk for this Preset function

## -- Make sure you use the right answer or install script will fail ###
# Make sure proper AUR Helper is use NO Upperscript. Either paru or yay only is accepted
# The rest Change to Y for Yes and N for No.

# ========================
# Changeable Parameters
# ========================
# This section contains parameters that you can modify to suit your specific dotfile setup.
# Adjust the values as needed.

# - Type of AUR helper
#   Options: "yay" or "paru"
aur_helper="yay"

# - Do you have any NVIDIA GPU in your system?
#   Options: "Y" or "N"
nvidia="Y"

# -Installing in a Asus ROG Laptops?
#   Options: "Y" or "N"
rog="N"

# -Install XDG-DESKTOP-PORTAL-HYPRLAND? (For proper Screen Share ie OBS)
#   Options: "Y" or "N"
xdph="Y"

# These are the sub-questions of the above choices

# - This script will add your user to the 'input' group.
#   Please note that adding yourself to the 'input' group might be necessary for waybar keyboard-state functionality.
#   Options: "Y" or "N"
input_group_choid="Y"

# - XDG-desktop-portal-KDE & GNOME (if installed) should be manually disabled or removed!
#   Script can't remove nor disable it.
#   Would you like to try to remove other XDG-Desktop-Portal-Implementations?
#   Options: "Y" or "N"
XDPH1="Y"

# - Would you like to blacklist nouveau?
#   Options: "Y" or "N"
blacklist_nouveau="Y"

# ========================

# ========================
# Unchangeable Parameters
# ========================
# This section contains parameters that you should not modify unless you know what you are doing.
# There is a risk to break the dotfile setup if you change these values.

# -Install GTK themes (required for Dark/Light function)?
#   Options: "Y" or "N"
gtk_themes="Y"

# -Do you want to configure Bluetooth?
#   Options: "Y" or "N"
bluetooth="Y"

# -Do you want to install Thunar file manager?
#   Options: "Y" or "N"
thunar="Y"

# -Install & configure SDDM log-in Manager plus (OPTIONAL) SDDM Theme?
#   Options: "Y" or "N"
sddm="Y"

# -Install zsh, oh-my-zsh & (Optional) pokemon-colorscripts?
#   Options: "Y" or "N"
zsh="N"

# -Do you want to download pre-configured Hyprland dotfiles?
#   Options: "Y" or "N"
dots="N"

# These are the sub-questions of the above choices

# - SDDM is already installed. Would you like to manually install sddm-git to remove it?
#   This requires manual intervention.
#   Options: "Y" or "N"
manual_install_sddm="N"

# - OPTIONAL - Would you like to install SDDM themes?
#   Options: "Y" or "N"
install_sddm_theme="N"

# - OPTIONAL - Do you want to add Pokemon color scripts?
#   Options: "Y" or "N"
pokemon_choice="N"

# - Do you want to upgrade to the latest version? (This is for the dotfiles)
#   Options: "Y" or "N"
upgrade_choice="N"

# ========================
