#!/bin/bash

echo "${NOTE} - Running 09-move-binaries.sh"

# Sourcing helper functions and variables
source "$HOME/.local/share/chezmoi/.chezmoiscripts/run_00-helper.sh"

printf "${NOTE} Copying Cargo Binaries to /usr/bin...\n"
for BIN in $(find ~/.cargo/bin -type f -executable); do
    sudo cp "$BIN" /usr/bin/
done
