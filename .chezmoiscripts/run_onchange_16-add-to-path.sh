#!/usr/bin/env bash

echo "${NOTE} - Running 05-add-to-path.sh"

# Sourcing helper functions and variables
source "$HOME/.local/share/chezmoi/.chezmoiscripts/run_00-helper.sh"

path_to_add=(
    "$HOME/.cargo/bin"
)

# Determine the shell configuration file to update
if [ -n "$ZSH_VERSION" ]; then
    shell_rc="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    shell_rc="$HOME/.bashrc"
else
    echo "Unsupported shell. Please add the paths manually."
    return 1
fi

for path in "${path_to_add[@]}"; do
    if ! grep -q "$path" "$shell_rc"; then
        echo "Adding $path to PATH in $shell_rc"
        echo "export PATH=\"\$PATH:$path\"" >>"$shell_rc"
        export PATH="$PATH:$path" # Update the PATH in the current shell
    else
        echo "$path already in PATH"
    fi
done
