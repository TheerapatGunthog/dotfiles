# My Dotfiles

This repository contains my personal configuration files (dotfiles) for various development tools. These configs help me maintain a consistent environment across different machines.

## What's Included

- **Neovim**: Text editor configuration
- **Zsh**: Shell configuration
- **Alacritty**: Terminal emulator settings
- **Tmux**: Terminal multiplexer configuration

## Prerequisites

- [GNU Stow](https://www.gnu.org/software/stow/): Used for managing symlinks
- Git: For cloning this repository

## Installation

```bash
# Install required tools
sudo apt install stow git

# Clone the repository
git clone https://github.com/TheerapatGunthog/dotfiles.git
cd dotfiles
```

## Usage

```bash
# To install the configuration files
stow <folder-name> # e.g. stow, nvim or zsh
```

## Uninstallation

```bash
# To uninstall the configuration files
stow -D <folder-name> # e.g. stow, nvim or zsh
```
