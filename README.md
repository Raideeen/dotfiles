# dotfiles

This is a work in progress and I am still figuring out how to properly maintain my dotfiles with chezmoi. I am still learning and I am open to suggestions and feedback. Please feel free to open an issue or a pull request if you have any suggestions or feedback. I would love to hear from you! 😊

## Installation

Coming soon..! (as I figure out how to do it properly with chezmoi 😂)

## Note

- [Hyprsome](https://github.com/sopa0/hyprsome) is a binary that interacts with Hyprland's Unix socket to make workspaces behave similary to AwesomeWM in a multi-monitor setup. To be usable, the binary has to be placed in `/usr/bin`. This is done automatically in the script by the `move-cargo-binaries.sh` script.

## Things to add

- [ ] Add a proper installation guide
- [ ] Add a proper way to install packages declaratively post installation with an `run_onchange_` prefix script
- [ ] Make sure the scripts are idempotent and can be run multiple times without breaking anything

## Thanks to

- [Chezmoi](https://www.chezmoi.io/) for making it possible to maintain my dotfiles configuration in a proper way.
- [JaKooLi](https://github.com/JaKooLit/Arch-Hyprland/tree/main) for the hyprland installation script that I totally re-used for my own needs (and modified a bit.. I admit! 😊) and also the dotfiles.
- [zDyanTB](https://github.com/zDyanTB/HyprNova) for the HyprNova dotfiles that I borrowed as a base for my own dotfiles. Many thanks! ✨
