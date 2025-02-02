#!/usr/bin/env bash
echo "${NOTE} - Running 19-grub-theme.sh"
ISAUR=$(command -v yay || command -v paru)

# Sourcing helper functions and variables
source "$HOME/.local/share/chezmoi/home/.chezmoiscripts/run_00-helper.sh"

# Install Tartarus GRUB theme
install_grub_theme() {
    local theme_dir="/usr/share/grub/themes/tartarus"

    # Clone the repository if not already present
    if [ ! -d "tartarus-grub" ]; then
        git clone https://github.com/AllJavi/tartarus-grub.git || {
            echo "Failed to clone Tartarus GRUB theme"
            return 1
        }
    fi

    # Copy theme to GRUB themes directory
    sudo cp -r tartarus-grub/tartarus "${theme_dir}" || {
        echo "Failed to copy theme files"
        return 1
    }

    # Update GRUB configuration
    if ! grep -q "^GRUB_THEME=" /etc/default/grub; then
        # Add theme line if it doesn't exist
        echo 'GRUB_THEME="/usr/share/grub/themes/tartarus/theme.txt"' | sudo tee -a /etc/default/grub
    else
        # Update existing theme line
        sudo sed -i 's|^GRUB_THEME=.*|GRUB_THEME="/usr/share/grub/themes/tartarus/theme.txt"|' /etc/default/grub
    fi

    # Comment out GRUB_TERMINAL_OUTPUT if it exists (for Fedora compatibility)
    sudo sed -i 's/^GRUB_TERMINAL_OUTPUT="console"/#GRUB_TERMINAL_OUTPUT="console"/' /etc/default/grub

    # Update GRUB configuration
    sudo grub-mkconfig -o /boot/grub/grub.cfg || {
        echo "Failed to update GRUB configuration"
        return 1
    }

    # Clean up
    rm -rf tartarus-grub
}

# Main execution
main() {
    install_grub_theme

    echo "Installation completed successfully!"
    echo "Please reboot your system for changes to take effect."
}

main
