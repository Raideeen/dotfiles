#!/usr/bin/env bash

echo "${NOTE} - Running 18-input_group.sh"

# Sourcing helper functions and variables
source "$HOME/.local/share/chezmoi/.chezmoiscripts/run_00-helper.sh"

# 💫 https://github.com/JaKooLit 💫 #
# Adding users into input group #

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##

# Set the name of the log file to include the current date and time
LOG="$HOME/.dotfiles/logs/install-$(date +%d-%H%M%S)_input.log"

while true; do
    echo "${WARN} This script will add your user to the 'input' group."
    echo "${NOTE} Please note that adding yourself to the 'input' group might be necessary for waybar keyboard-state functionality."

    if [[ -z $input_group_choid ]]; then
        read -p "${YELLOW}Do you want to proceed? (y/n): ${RESET}" input_group_choid
    fi

    if [[ $input_group_choid == "y" || $input_group_choid == "Y" ]]; then
        # Check if the 'input' group exists
        if grep -q '^input:' /etc/group; then
            echo "${OK} 'input' group exists."
        else
            echo "${NOTE} 'input' group doesn't exist. Creating 'input' group..."
            sudo groupadd input

            # Log the creation of the 'input' group
            echo "'input' group created" >>"$LOG"
        fi

        # Add the user to the input group
        sudo usermod -aG input "$(whoami)"
        echo "${OK} User added to the 'input' group. Changes will take effect after you log out and log back in."

        # Log the addition of the user to the 'input' group
        echo "User added to 'input' group" >>"$LOG"
        break # Break out of the loop if 'yes' is chosen
    elif [[ $input_group_choid == "n" || $input_group_choid == "N" ]]; then
        echo "${NOTE} No changes made. Exiting the script."
        break # Break out of the loop if 'no' is chosen
    else
        echo "${ERROR} Invalid choice. Please enter 'y' for yes or 'n' for no."
    fi
done

printf "${OK} Input group setup completed successfully\n" | tee -a "$LOG"
