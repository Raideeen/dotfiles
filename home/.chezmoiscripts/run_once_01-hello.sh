#!/usr/bin/env bash
# Welcome message

echo "${NOTE} - Running 01-hello.sh"

echo "$(tput setaf 6)Welcome to JaKooLit's Arch-Hyprland (and Raiden d(⌒-⌒)) Install Script!$(tput sgr0)"
echo
echo "$(tput setaf 166)ATTENTION: Run a full system update and Reboot first!! (Highly Recommended) $(tput sgr0)"
echo "$(tput setaf 3)NOTE: For this do "sudo pacman -Syu" and then "sudo reboot" $(tput sgr0)"
echo "$(tput setaf 3)NOTE: It is a good idea to create a backup of your system using Timeshift before proceeding! $(tput sgr0)"
echo
echo "$(tput setaf 3)NOTE: If you are installing on a VM, ensure to enable 3D acceleration else Hyprland wont start! $(tput sgr0)"
echo

read -p "$(tput setaf 6)Would you like to proceed? (y/n): $(tput sgr0)" proceed
