#!/bin/bash

echo "20 : run_20-end_installation.sh"

printf "\n${OK} Yey! Installation Completed.\n"
printf "\n"
sleep 2
printf "\n${NOTE} You can start Hyprland by typing Hyprland (IF SDDM is not installed) (note the capital H!).\n"
printf "\n"
printf "\n${NOTE} It is highly recommended to reboot your system.\n\n"

read -rp "${CAT} Would you like to reboot now? (y/n): " HYP

if [[ "$HYP" =~ ^[Yy]$ ]]; then
    systemctl reboot
fi
