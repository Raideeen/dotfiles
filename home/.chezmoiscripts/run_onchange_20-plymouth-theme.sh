#!/usr/bin/env bash
echo "${NOTE} - Running 20-plymouth-theme.sh"
ISAUR=$(command -v yay || command -v paru)

# Sourcing helper functions and variables
source "$HOME/.local/share/chezmoi/home/.chezmoiscripts/run_00-helper.sh"

install_plymouth_theme() {
    local theme_name="$1"

    # Ensure required fonts are installed
    echo "Installing required fonts..."
    sudo pacman -S --noconfirm cantarell-fonts ttf-dejavu || {
        echo "Failed to install required fonts"
        return 1
    }

    # Install the theme from AUR
    echo "Installing Plymouth theme: ${theme_name}"
    $ISAUR -S --noconfirm "plymouth-theme-${theme_name}-git" || {
        echo "Failed to install Plymouth theme"
        return 1
    }

    # Set the theme and rebuild initrd
    echo "Setting Plymouth theme and rebuilding initrd..."
    sudo plymouth-set-default-theme -R "${theme_name//-/_}" || {
        echo "Failed to set Plymouth theme"
        return 1
    }

    echo "Plymouth theme ${theme_name} installed successfully!"
}

# Install Plymouth if not already installed
install_plymouth() {
    if ! pacman -Qi plymouth &>/dev/null; then
        echo "Installing Plymouth..."
        sudo pacman -S --noconfirm plymouth || {
            echo "Failed to install Plymouth"
            return 1
        }
    else
        echo "Plymouth is already installed"
    fi
}

# Configure Plymouth
configure_plymouth() {
    # Enable Plymouth in mkinitcpio.conf
    if ! grep -q "plymouth" /etc/mkinitcpio.conf; then
        sudo sed -i 's/^HOOKS=(base/HOOKS=(base plymouth/' /etc/mkinitcpio.conf
    fi

    # Update kernel parameters in GRUB
    if ! grep -q "quiet splash" /etc/default/grub; then
        sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="[^"]*"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/' /etc/default/grub
    fi

    # Regenerate initramfs
    sudo mkinitcpio -P || {
        echo "Failed to regenerate initramfs"
        return 1
    }

    # Update GRUB configuration again
    sudo grub-mkconfig -o /boot/grub/grub.cfg || {
        echo "Failed to update GRUB configuration"
        return 1
    }
}

# Main execution
main() {
    install_plymouth
    configure_plymouth
    install_plymouth_theme "hexagon-dots-alt"

    echo "Installation completed successfully!"
    echo "Please reboot your system for changes to take effect."
}

main
