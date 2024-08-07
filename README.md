# dotfiles

This is a work in progress and I am still figuring out how to properly maintain my dotfiles with chezmoi. I am still learning and I am open to suggestions and feedback. Please feel free to open an issue or a pull request if you have any suggestions or feedback. I would love to hear from you! 😊

## Installation

> This script is meant to be ran on a fresh install of Arch Linux. It will install all the necessary packages and configure the system to my liking. Please make sure to read the script before running it to make sure it fits your needs.

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Raideeen
```

## Features

- [x] Zsh with [Antidote](https://getantidote.github.io/) for managing zsh plugins
- [ ] [Mangal](https://github.com/metafates/mangal) as manga reader

## Note

- [zsh](https://www.zsh.org/) is the default shell. I am using [Antidote](https://getantidote.github.io/) to manage my zsh plugins. It features nice plugins like *zsh-autosuggestions*, *zsh-syntax-highlighting*, *zoxide*, *thefuck*. I'm also using *starship* as the prompt to make it look pretty, and also fast !

## Things to add

- [ ] Add a proper installation guide
- [x] Add a proper way to install packages declaratively post installation with an `run_onchange_` prefix script
- [ ] Make sure the scripts are idempotent and can be run multiple times without breaking anything
- [ ] Create a convenient way to change wallapper
- [ ] Configure waybar to be pretty and functional
- [ ] Configure pywall to work with the current setup (rofi, waybar)

## How to customize

### Zsh plugins

You can add plugins to your zsh setup using [Antidode](https://getantidote.github.io/) by editing `~/.config/zsh/.zsh_plugins.txt` and adding either the Github URL repo or the name of plugin. You can add plugins from *oh-my-zsh* individually using this syntax `ohmyzsh/ohmyzsh path:plugins/NameOfThePlugin`. You can find the list all the plugins of `oh-my-zsh` [here](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins)

## Thanks to

- [Chezmoi](https://www.chezmoi.io/) for making it possible to maintain my dotfiles configuration in a proper way.
- [JaKooLi](https://github.com/JaKooLit/Arch-Hyprland/tree/main) for the hyprland installation script that I totally re-used for my own needs (and modified a bit.. I admit! 😊) and also the dotfiles.
- [zDyanTB](https://github.com/zDyanTB/HyprNova) for the HyprNova dotfiles that I borrowed as a base for my own dotfiles. Many thanks! ✨
- [mooncoffee1](https://github.com/mooncoffee1/MyHyprBackup/tree/main) for the dotfiles that also inspired me heavily to create my own dotfiles. Thank you!
- [plasmoduck](https://github.com/plasmoduck/hypr-dots/tree/main/dope) for the waybar configuration and this clean look that I totally borrowed for my own setup. Thank you! 🙏
- [Antidode](https://github.com/mattmc3/antidote) for managing my zsh plugins easily and blazingly fast ([link to documentation](https://getantidote.github.io/))! 🚀
