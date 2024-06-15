#!/bin/bash

# Determine the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

printf "${NOTE} Copying Cargo Binaries to /usr/bin...\n"
for BIN in $(find ~/.cargo/bin -type f -executable); do
    sudo cp "$BIN" /usr/bin/
done
