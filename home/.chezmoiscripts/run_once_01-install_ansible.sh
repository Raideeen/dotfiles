#!/bin/bash

install_on_archlinux() {
    sudo pacman -S ansible-core ansible ansible-lint git python
}

install_on_mac() {
    brew install ansible
}

OS="$(uname -s)"
case "${OS}" in
Linux*)
    if [ -f /etc/os-release ]; then
        install_on_archlinux
    else
        echo "Unsupported Linux distribution"
        exit 1
    fi
    ;;
Darwin*)
    install_on_mac
    ;;
*)
    echo "Unsupported operating system: ${OS}"
    exit 1
    ;;
esac

# Install the ansible collections (aur helper!! :D)
ansible-galaxy install -r $HOME/.local/share/chezmoi/ansible/requirements.yml

# Run all the roles to setup the system :)
ansible-playbook $HOME/.local/share/chezmoi/ansible/setup.yml --diff --ask-become-pass

echo "Ansible installation complete."
