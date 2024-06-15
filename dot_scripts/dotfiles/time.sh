#!/bin/bash

# Determine the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Change the working directory to the parent directory of the script
# PARENT_DIR="$SCRIPT_DIR/.."
# cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

printf "${NOTE} Installing set time to local time (not UTC) to fix dual boot time difference between Linux and Windows...\n"
timedatectl set-local-rtc 1
